if(CMAKE_HOST_SYSTEM_NAME MATCHES "Linux")
    set(ESP8266_SDK_BASE ${USER_HOME}/git/ESP8266_RTOS_SDK CACHE PATH "Path to the ESP8266 SDK")
elseif(CMAKE_HOST_SYSTEM_NAME MATCHES "Windows")
    set(ESP8266_SDK_BASE ${USER_HOME}/dev/projects/ESP8266_RTOS_SDK CACHE PATH "Path to the ESP8266 SDK")
else()
    message(FATAL_ERROR "Unsupported build platforom.")
endif()

if (ESP8266_FLASH_SIZE MATCHES "512K")
    set_target_properties(firmware PROPERTIES
        LINK_FLAGS "-L${ESP8266_SDK_BASE}/ld -Teagle.app.v6.ld"
    )
    set(FW_ADDR_1 0x00000)
    set(FW_ADDR_2 0x40000)
elseif (ESP8266_FLASH_SIZE MATCHES "1M")
    set_target_properties(firmware PROPERTIES
        LINK_FLAGS "-L${ESP8266_SDK_BASE}/ld -Teagle.app.v6.new.1024.app1.ld"
    )
    set(FW_ADDR_1 0x00000)
    set(FW_ADDR_2 0x01010)
else()
    message(FATAL_ERROR "Unsupported flash size")
endif()
set_property(TARGET ESP8266_SDK
    PROPERTY INTERFACE_INCLUDE_DIRECTORIES
    ${ESP8266_SDK_BASE}/include/lwip
    ${ESP8266_SDK_BASE}/include/lwip/ipv4
    ${ESP8266_SDK_BASE}/include/lwip/ipv6
    ${ESP8266_SDK_BASE}/include/espressif
    ${ESP8266_SDK_BASE}/extra_include
    ${ESP8266_SDK_BASE}/include
    ${ESP8266_SDK_BASE}/include/json
    ${ESP8266_SDK_BASE}/examples/driver_lib/include
)
find_library(ESP8266_SDK_LIB_CRYPTO crypto ${ESP8266_SDK_BASE}/lib)
find_library(ESP8266_SDK_LIB_ESPCONN espconn ${ESP8266_SDK_BASE}/lib)
find_library(ESP8266_SDK_LIB_ESPNOW espnow ${ESP8266_SDK_BASE}/lib)
find_library(ESP8266_SDK_LIB_FREERTOS freertos ${ESP8266_SDK_BASE}/lib)
find_library(ESP8266_SDK_LIB_JSON json ${ESP8266_SDK_BASE}/lib)
find_library(ESP8266_SDK_LIB_LWIP lwip ${ESP8266_SDK_BASE}/lib)
find_library(ESP8266_SDK_LIB_MAIN main ${ESP8266_SDK_BASE}/lib)
find_library(ESP8266_SDK_LIB_MESH mesh ${ESP8266_SDK_BASE}/lib)
find_library(ESP8266_SDK_LIB_MINIC minic ${ESP8266_SDK_BASE}/lib)
find_library(ESP8266_SDK_LIB_NET80211 net80211 ${ESP8266_SDK_BASE}/lib)
find_library(ESP8266_SDK_LIB_NOPOLL nopoll ${ESP8266_SDK_BASE}/lib)
find_library(ESP8266_SDK_LIB_PHY phy ${ESP8266_SDK_BASE}/lib)
find_library(ESP8266_SDK_LIB_PP pp ${ESP8266_SDK_BASE}/lib)
find_library(ESP8266_SDK_LIB_PWM pwm ${ESP8266_SDK_BASE}/lib)
find_library(ESP8266_SDK_LIB_SMARTCONFIG smartconfig ${ESP8266_SDK_BASE}/lib)
find_library(ESP8266_SDK_LIB_SPIFFS spiffs ${ESP8266_SDK_BASE}/lib)
find_library(ESP8266_SDK_LIB_SSC ssc ${ESP8266_SDK_BASE}/lib)
find_library(ESP8266_SDK_LIB_SSL ssl ${ESP8266_SDK_BASE}/lib)
find_library(ESP8266_SDK_LIB_WPA wpa ${ESP8266_SDK_BASE}/lib)
find_library(ESP8266_SDK_LIB_WPS wps ${ESP8266_SDK_BASE}/lib)

set_property(TARGET ESP8266_SDK
    PROPERTY INTERFACE_LINK_LIBRARIES
    gcc
    hal
    ${ESP8266_SDK_LIB_CRYPTO}
    ${ESP8266_SDK_LIB_ESPCONN}
    ${ESP8266_SDK_LIB_ESPNOW}
    ${ESP8266_SDK_LIB_FREERTOS}
    ${ESP8266_SDK_LIB_JSON}
    ${ESP8266_SDK_LIB_LWIP}
    ${ESP8266_SDK_LIB_MAIN}
    ${ESP8266_SDK_LIB_MESH}
    ${ESP8266_SDK_LIB_MINIC}
    ${ESP8266_SDK_LIB_NET80211}
    ${ESP8266_SDK_LIB_NOPOLL}
    ${ESP8266_SDK_LIB_PHY}
    ${ESP8266_SDK_LIB_PP}
    ${ESP8266_SDK_LIB_PWM}
    ${ESP8266_SDK_LIB_SMARTCONFIG}
    ${ESP8266_SDK_LIB_SPIFFS}
    ${ESP8266_SDK_LIB_SSC}
    ${ESP8266_SDK_LIB_SSL}
    ${ESP8266_SDK_LIB_WPA}
    ${ESP8266_SDK_LIB_WPS}
)

add_custom_target(
    firmware_binary ALL
    COMMAND ${ESP8266_ESPTOOL} -bz ${ESP8266_FLASH_SIZE} -eo $<TARGET_FILE:firmware> -bo firmware_${FW_ADDR_1}.bin -bs .text -bs .data -bs .rodata -bc -ec -eo $<TARGET_FILE:firmware> -es .irom0.text firmware_${FW_ADDR_2}.bin -ec
)
set_directory_properties(PROPERTIES ADDITIONAL_MAKE_CLEAN_FILES "firmware_${FW_ADDR_1}.bin firmware_${FW_ADDR_2}.bin")

add_dependencies(firmware_binary firmware)

add_custom_target(flash COMMAND ${ESP8266_ESPTOOL} -cp ${ESP8266_ESPTOOL_COM_PORT} -cf firmware_${FW_ADDR_1}.bin -ca 0x40000 -cf firmware_${FW_ADDR_2}.bin)

add_dependencies(flash firmware_binary)
