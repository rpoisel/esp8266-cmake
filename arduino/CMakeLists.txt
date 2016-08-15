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

install(FILES 
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
    DESTINATION lib
)

file(GLOB_RECURSE ARDUINO_SRC
    ${ARDUINO_ESP8266_DIR}/cores/esp8266/*.c
    ${ARDUINO_ESP8266_DIR}/cores/esp8266/spiffs/*.c
    ${ARDUINO_ESP8266_DIR}/cores/esp8266/*.cpp
)

file(GLOB ARDUINO_SRC_ASM
    ${ARDUINO_ESP8266_DIR}/cores/esp8266/*.S
)

set_source_files_properties(${ARDUINO_SRC_ASM} PROPERTIES
    LANGUAGE ASM
    COMPILE_FLAGS "${CMAKE_C_FLAGS} ${CMAKE_C_FLAGS_DEBUG}"
)

add_library(arduino STATIC
    ${ARDUINO_SRC}
    ${ARDUINO_SRC_ASM}
)

target_include_directories(arduino PUBLIC
    $<INSTALL_INTERFACE:h>
    $<INSTALL_INTERFACE:h/tools/sdk/include>
    $<INSTALL_INTERFACE:h/variants/generic>
    $<BUILD_INTERFACE:${ARDUINO_ESP8266_DIR}/cores/esp8266>
    $<BUILD_INTERFACE:${ARDUINO_ESP8266_DIR}/tools/sdk/include>
    $<BUILD_INTERFACE:${ARDUINO_ESP8266_DIR}/variants/generic>
)

install(DIRECTORY ${ARDUINO_ESP8266_DIR}/cores/esp8266/
    DESTINATION h
    FILES_MATCHING PATTERN "*.h"
)

install(DIRECTORY ${ARDUINO_ESP8266_DIR}/tools/sdk/include/
    DESTINATION h/tools/sdk/include
    FILES_MATCHING PATTERN "*.h"
)

install(DIRECTORY ${ARDUINO_ESP8266_DIR}/variants/generic/
    DESTINATION h/variants/generic
    FILES_MATCHING PATTERN "*.h"
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

install(DIRECTORY cmake/ DESTINATION cmake/Modules FILES_MATCHING PATTERN "Find*.cmake")
install(DIRECTORY cmake/ DESTINATION cmake FILES_MATCHING PATTERN "toolchain.*.cmake")
