# Compute the installation prefix relative to this file.
get_filename_component(_IMPORT_PREFIX "${CMAKE_CURRENT_LIST_FILE}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)

find_library(ESP8266_SDK_LIB_AT at ${_IMPORT_PREFIX}/lib)
find_library(ESP8266_SDK_LIB_AXTLS axtls ${_IMPORT_PREFIX}/lib)
find_library(ESP8266_SDK_LIB_CRYPTO crypto ${_IMPORT_PREFIX}/lib)
find_library(ESP8266_SDK_LIB_ESPNOW espnow ${_IMPORT_PREFIX}/lib)
find_library(ESP8266_SDK_LIB_HAL hal ${_IMPORT_PREFIX}/lib)
find_library(ESP8266_SDK_LIB_JSON json ${_IMPORT_PREFIX}/lib)
find_library(ESP8266_SDK_LIB_LWIP lwip ${_IMPORT_PREFIX}/lib)
find_library(ESP8266_SDK_LIB_MAIN main ${_IMPORT_PREFIX}/lib)
find_library(ESP8266_SDK_LIB_NET80211 net80211 ${_IMPORT_PREFIX}/lib)
find_library(ESP8266_SDK_LIB_PHY phy ${_IMPORT_PREFIX}/lib)
find_library(ESP8266_SDK_LIB_PP pp ${_IMPORT_PREFIX}/lib)
find_library(ESP8266_SDK_LIB_PWM pwm ${_IMPORT_PREFIX}/lib)
find_library(ESP8266_SDK_LIB_SMARTCONFIG smartconfig ${_IMPORT_PREFIX}/lib)
find_library(ESP8266_SDK_LIB_SSL ssl ${_IMPORT_PREFIX}/lib)
find_library(ESP8266_SDK_LIB_UPGRADE upgrade ${_IMPORT_PREFIX}/lib)
find_library(ESP8266_SDK_LIB_WPA wpa ${_IMPORT_PREFIX}/lib)
find_library(ESP8266_SDK_LIB_WPS wps ${_IMPORT_PREFIX}/lib)

add_library(arduino STATIC IMPORTED)

set(ARDUINO_INC_DIRS
    ${_IMPORT_PREFIX}/h
    ${_IMPORT_PREFIX}/h/variants/generic
    ${_IMPORT_PREFIX}/h/tools/sdk/include
    ${_IMPORT_PREFIX}/h/libraries/SPI
    ${_IMPORT_PREFIX}/h/libraries/Wire
    ${_IMPORT_PREFIX}/h/tools/sdk/lwip/include
    ${_IMPORT_PREFIX}/h/libraries/ESP8266WiFi
    ${_IMPORT_PREFIX}/h/libraries/ESP8266WiFi/include
    ${_IMPORT_PREFIX}/h/libraries/ESP8266Webserver
)

set(ARDUINO_DEP_LIBS
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
    m
    gcc
)

set(ARDUINO_DEFINITIONS
    F_CPU=80000000L
    ARDUINO=10606
    ARDUINO_ESP8266_ESP01
    ARDUINO_ARCH_ESP8266
    ESP8266
)

set(ARDUINO_OPTIONS
    -U__STRICT_ANSI__
)

set_target_properties(arduino PROPERTIES
    IMPORTED_LOCATION ${_IMPORT_PREFIX}/lib/libarduino.a
    INTERFACE_LINK_LIBRARIES "${ARDUINO_DEP_LIBS}"
    INTERFACE_INCLUDE_DIRECTORIES "${ARDUINO_INC_DIRS}"
    INTERFACE_COMPILE_DEFINITIONS "${ARDUINO_DEFINITIONS}"
    INTERFACE_COMPILE_OPTIONS "${ARDUINO_OPTIONS}"
)
