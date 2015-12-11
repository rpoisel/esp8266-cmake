add_library(ESP8266_SDK INTERFACE)

if (ESP8266_SDK_VARIANT MATCHES "RTOS")
    set_property(TARGET ESP8266_SDK
        PROPERTY INTERFACE_INCLUDE_DIRECTORIES
        ${ESP8266_SDK_BASE}/include
        ${ESP8266_SDK_BASE}/include/espressif
        ${ESP8266_SDK_BASE}/include/lwip
        ${ESP8266_SDK_BASE}/include/lwip/ipv4
        ${ESP8266_SDK_BASE}/include/lwip/ipv6
        ${ESP8266_SDK_BASE}/extra_include
    )
    set_property(TARGET ESP8266_SDK
        PROPERTY INTERFACE_LINK_LIBRARIES
        minic
        gcc
        hal
        pp
        phy
        net80211
        lwip
        wpa
        main
        crypto
        freertos
        lwip
    )
elseif (ESP8266_SDK_VARIANT MATCHES "NONOS")
    set_property(TARGET ESP8266_SDK
        PROPERTY INTERFACE_INCLUDE_DIRECTORIES
        ${ESP8266_SDK_BASE}/include
        ${ESP8266_SDK_BASE}/include/json
    )
    set_property(TARGET ESP8266_SDK
        PROPERTY INTERFACE_LINK_LIBRARIES
        gcc
        hal
        pp
        phy
        net80211
        lwip
        wpa
        main
    )
endif()
