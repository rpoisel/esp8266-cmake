add_library(ESP8266_SDK INTERFACE)

find_library(ESP8266_SDK_LIB_AT at ${ARDUINO_DIR}/tools/sdk/lib)
find_library(ESP8266_SDK_LIB_AXTLS axtls ${ARDUINO_DIR}/tools/sdk/lib)
find_library(ESP8266_SDK_LIB_CRYPTO crypto ${ARDUINO_DIR}/tools/sdk/lib)
find_library(ESP8266_SDK_LIB_ESPNOW espnow ${ARDUINO_DIR}/tools/sdk/lib)
find_library(ESP8266_SDK_LIB_HAL hal ${ARDUINO_DIR}/tools/sdk/lib)
find_library(ESP8266_SDK_LIB_JSON json ${ARDUINO_DIR}/tools/sdk/lib)
find_library(ESP8266_SDK_LIB_LWIP lwip ${ARDUINO_DIR}/tools/sdk/lib)
find_library(ESP8266_SDK_LIB_MAIN main ${ARDUINO_DIR}/tools/sdk/lib)
find_library(ESP8266_SDK_LIB_MESH mesh ${ARDUINO_DIR}/tools/sdk/lib)
find_library(ESP8266_SDK_LIB_NET80211 net80211 ${ARDUINO_DIR}/tools/sdk/lib)
find_library(ESP8266_SDK_LIB_PHY phy ${ARDUINO_DIR}/tools/sdk/lib)
find_library(ESP8266_SDK_LIB_PP pp ${ARDUINO_DIR}/tools/sdk/lib)
find_library(ESP8266_SDK_LIB_PWM pwm ${ARDUINO_DIR}/tools/sdk/lib)
find_library(ESP8266_SDK_LIB_SMARTCONFIG smartconfig ${ARDUINO_DIR}/tools/sdk/lib)
find_library(ESP8266_SDK_LIB_SSL ssl ${ARDUINO_DIR}/tools/sdk/lib)
find_library(ESP8266_SDK_LIB_UPGRADE upgrade ${ARDUINO_DIR}/tools/sdk/lib)
find_library(ESP8266_SDK_LIB_WPA wpa ${ARDUINO_DIR}/tools/sdk/lib)
find_library(ESP8266_SDK_LIB_WPA2 wpa2 ${ARDUINO_DIR}/tools/sdk/lib)
find_library(ESP8266_SDK_LIB_WPS wps ${ARDUINO_DIR}/tools/sdk/lib)

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
    ${ESP8266_SDK_LIB_MESH}
    ${ESP8266_SDK_LIB_NET80211}
    ${ESP8266_SDK_LIB_PHY}
    ${ESP8266_SDK_LIB_PP}
    ${ESP8266_SDK_LIB_PWM}
    ${ESP8266_SDK_LIB_SMARTCONFIG}
    ${ESP8266_SDK_LIB_SSL}
    ${ESP8266_SDK_LIB_UPGRADE}
    ${ESP8266_SDK_LIB_WPA}
    ${ESP8266_SDK_LIB_WPA2}
    ${ESP8266_SDK_LIB_WPS}
)

set(ARDUINO_DIR "${CMAKE_SOURCE_DIR}/external/Arduino" CACHE PATH "Path to the directory containing the Arduino sources")

if (ARDUINO_DIR STREQUAL "")
    message(FATAL_ERROR "ARDUINO_DIR has not been set.")
endif ()

file(GLOB ARDUINO_SRC
    ${ARDUINO_DIR}/cores/esp8266/*.c
    ${ARDUINO_DIR}/cores/esp8266/spiffs/*.c
    ${ARDUINO_DIR}/cores/esp8266/*.cpp
)

list(REMOVE_ITEM ARDUINO_SRC ${ARDUINO_DIR}/cores/esp8266/base64.cpp)

file(GLOB ARDUINO_ASM_SRC
    ${ARDUINO_DIR}/cores/esp8266/*.S
)

set_source_files_properties(${ARDUINO_ASM_SRC} PROPERTIES
    LANGUAGE ASM
)

add_library(arduino STATIC
    ${ARDUINO_SRC}
    ${ARDUINO_ASM_SRC}
)

target_include_directories(arduino PUBLIC
    ${ARDUINO_DIR}/tools/sdk/include
    ${ARDUINO_DIR}/cores/esp8266
    ${ARDUINO_DIR}/variants/generic
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

set_target_properties(firmware PROPERTIES
    LINK_FLAGS "-L${ARDUINO_DIR}/tools/sdk/ld -Teagle.flash.512k0.ld -u call_user_start -Wl,-wrap,system_restart_local -Wl,-wrap,register_chipv6_phy"
)

add_custom_target(
    firmware_binary ALL
    COMMAND ${ESP8266_ESPTOOL} -eo ${ARDUINO_DIR}/bootloaders/eboot/eboot.elf -bo firmware.bin -bf 40 -bz ${ESP8266_FLASH_SIZE} -bs .text -bp 4096 -ec -eo $<TARGET_FILE:firmware> -bs .irom0.text -bs .text -bs .data -bs .rodata -bc -ec
)
set_directory_properties(PROPERTIES ADDITIONAL_MAKE_CLEAN_FILES firmware.bin)

add_dependencies(firmware_binary firmware)

add_custom_target(flash COMMAND ${ESP8266_ESPTOOL} -vv -cd ck -cb 115200 -cp ${ESP8266_ESPTOOL_COM_PORT} -ca 0x00000 -cf firmware.bin)

add_dependencies(flash firmware_binary)
