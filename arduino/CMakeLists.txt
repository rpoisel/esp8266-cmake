set(ARDUINO_ESP8266_DIR ${ARDUINO_DIR}/packages/esp8266/hardware/esp8266/2.0.0 CACHE PATH "Path to the directory containing ESP8266 specific arduino files")
if (ARDUINO_ESP8266_DIR STREQUAL "")
    message(FATAL_ERROR "ARDUINO_ESP8266_DIR has not been set.")
endif ()

add_library(ESP8266_SDK INTERFACE)

find_library(ESP8266_SDK_LIB_AT at ${ARDUINO_ESP8266_DIR}/tools/sdk/lib)
find_library(ESP8266_SDK_LIB_AXTLS axtls ${ARDUINO_ESP8266_DIR}/tools/sdk/lib)
find_library(ESP8266_SDK_LIB_CRYPTO crypto ${ARDUINO_ESP8266_DIR}/tools/sdk/lib)
find_library(ESP8266_SDK_LIB_ESPNOW espnow ${ARDUINO_ESP8266_DIR}/tools/sdk/lib)
find_library(ESP8266_SDK_LIB_HAL hal ${ARDUINO_ESP8266_DIR}/tools/sdk/lib)
find_library(ESP8266_SDK_LIB_JSON json ${ARDUINO_ESP8266_DIR}/tools/sdk/lib)
find_library(ESP8266_SDK_LIB_LWIP lwip ${ARDUINO_ESP8266_DIR}/tools/sdk/lib)
find_library(ESP8266_SDK_LIB_MAIN main ${ARDUINO_ESP8266_DIR}/tools/sdk/lib)
find_library(ESP8266_SDK_LIB_NET80211 net80211 ${ARDUINO_ESP8266_DIR}/tools/sdk/lib)
find_library(ESP8266_SDK_LIB_PHY phy ${ARDUINO_ESP8266_DIR}/tools/sdk/lib)
find_library(ESP8266_SDK_LIB_PP pp ${ARDUINO_ESP8266_DIR}/tools/sdk/lib)
find_library(ESP8266_SDK_LIB_PWM pwm ${ARDUINO_ESP8266_DIR}/tools/sdk/lib)
find_library(ESP8266_SDK_LIB_SMARTCONFIG smartconfig ${ARDUINO_ESP8266_DIR}/tools/sdk/lib)
find_library(ESP8266_SDK_LIB_SSL ssl ${ARDUINO_ESP8266_DIR}/tools/sdk/lib)
find_library(ESP8266_SDK_LIB_UPGRADE upgrade ${ARDUINO_ESP8266_DIR}/tools/sdk/lib)
find_library(ESP8266_SDK_LIB_WPA wpa ${ARDUINO_ESP8266_DIR}/tools/sdk/lib)
find_library(ESP8266_SDK_LIB_WPS wps ${ARDUINO_ESP8266_DIR}/tools/sdk/lib)

target_link_libraries(ESP8266_SDK INTERFACE
    m
    gcc
    ${ESP8266_SDK_LIB_AT}
    ${ESP8266_SDK_LIB_AXTLS}
    ${ESP8266_SDK_LIB_CRYPTO}
    ${ESP8266_SDK_LIB_ESPNOW}
    ${ESP8266_SDK_LIB_HAL}
    ${ESP8266_SDK_LIB_JSON}
    ${ESP8266_SDK_LIB_LWIP}
    ${ESP8266_SDK_LIB_MAIN}
    ${ESP8266_SDK_LIB_NET80211}
    ${ESP8266_SDK_LIB_PHY}
    ${ESP8266_SDK_LIB_PP}
    ${ESP8266_SDK_LIB_PWM}
    ${ESP8266_SDK_LIB_SMARTCONFIG}
    ${ESP8266_SDK_LIB_SSL}
    ${ESP8266_SDK_LIB_UPGRADE}
    ${ESP8266_SDK_LIB_WPA}
    ${ESP8266_SDK_LIB_WPS}
)

file(GLOB_RECURSE ARDUINO_SRC
    ${ARDUINO_ESP8266_DIR}/cores/esp8266/*.c
    ${ARDUINO_ESP8266_DIR}/cores/esp8266/spiffs/*.c
    ${ARDUINO_ESP8266_DIR}/cores/esp8266/*.cpp
)

file(GLOB ARDUINO_ASM_SRC
    ${ARDUINO_ESP8266_DIR}/cores/esp8266/*.S
)

set_source_files_properties(${ARDUINO_ASM_SRC} PROPERTIES
    LANGUAGE ASM
)

add_library(arduino STATIC
    ${ARDUINO_SRC}
    ${ARDUINO_ASM_SRC}
)

target_include_directories(arduino PUBLIC
    ${ARDUINO_ESP8266_DIR}/tools/sdk/include
    ${ARDUINO_ESP8266_DIR}/cores/esp8266
    ${ARDUINO_ESP8266_DIR}/variants/generic
)

target_compile_definitions(arduino PUBLIC
    -DF_CPU=80000000L
    -DARDUINO=10606
    -DARDUINO_ESP8266_ESP01
    -DARDUINO_ARCH_ESP8266
    -DESP8266
)

target_compile_options(arduino PUBLIC
    -U__STRICT_ANSI__
)

target_link_libraries(arduino PUBLIC
    ESP8266_SDK
)

add_subdirectory(libraries)

set_target_properties(firmware PROPERTIES
    LINK_FLAGS "-L${ARDUINO_ESP8266_DIR}/tools/sdk/ld -Teagle.flash.512k0.ld -u call_user_start -Wl,-wrap,system_restart_local -Wl,-wrap,register_chipv6_phy"
)

add_custom_target(
    firmware_binary ALL
    COMMAND ${ESP8266_ESPTOOL} -eo ${ARDUINO_ESP8266_DIR}/bootloaders/eboot/eboot.elf -bo firmware.bin -bf 40 -bz ${ESP8266_FLASH_SIZE} -bs .text -bp 4096 -ec -eo $<TARGET_FILE:firmware> -bs .irom0.text -bs .text -bs .data -bs .rodata -bc -ec
)
set_directory_properties(PROPERTIES ADDITIONAL_MAKE_CLEAN_FILES firmware.bin)

add_dependencies(firmware_binary firmware)

add_custom_target(flash COMMAND ${ESP8266_ESPTOOL} -vv -cd ck -cb 115200 -cp ${ESP8266_ESPTOOL_COM_PORT} -ca 0x00000 -cf firmware.bin)

add_dependencies(flash firmware_binary)
