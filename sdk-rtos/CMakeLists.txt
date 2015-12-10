SET(ESP8266_SDK_BASE $ENV{HOME}/git/ESP8266_RTOS_SDK CACHE PATH "Path to the ESP8266 SDK")
SET(ESP8266_LINKER_SCRIPT "${ESP8266_SDK_BASE}/ld/eagle.app.v6.new.1024.app1.ld" CACHE FILEPATH "Path to the linker script")

add_library(ESP8266_SDK_HDR INTERFACE)
set_property(TARGET ESP8266_SDK_HDR
    PROPERTY INTERFACE_INCLUDE_DIRECTORIES
    ${ESP8266_SDK_BASE}/include
    ${ESP8266_SDK_BASE}/include/espressif
    ${ESP8266_SDK_BASE}/include/lwip
    ${ESP8266_SDK_BASE}/include/lwip/ipv4
    ${ESP8266_SDK_BASE}/include/lwip/ipv6
    ${ESP8266_SDK_BASE}/extra_include
    )
