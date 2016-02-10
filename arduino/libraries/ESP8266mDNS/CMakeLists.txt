file(GLOB MDNS_LIB_SRC
    ${ARDUINO_ESP8266_DIR}/libraries/ESP8266mDNS/*.cpp
)

add_library(esp8266mdns STATIC
    ${MDNS_LIB_SRC}
)

target_include_directories(esp8266mdns PUBLIC
    ${ARDUINO_ESP8266_DIR}/libraries/ESP8266mDNS
)

target_link_libraries(esp8266mdns PUBLIC
    arduino
    esp8266wifi
)





