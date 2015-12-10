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

