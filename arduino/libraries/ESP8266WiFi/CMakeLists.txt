file(GLOB WIFI_LIB_SRC
    ${ARDUINO_ESP8266_DIR}/${ARDUINO_ESP8266_VERSION}/libraries/ESP8266WiFi/src/*.cpp
)

add_library(esp8266wifi STATIC
    ${WIFI_LIB_SRC}
)

target_include_directories(esp8266wifi PUBLIC
    ${ARDUINO_ESP8266_DIR}/${ARDUINO_ESP8266_VERSION}/libraries/ESP8266WiFi/src
    ${ARDUINO_ESP8266_DIR}/${ARDUINO_ESP8266_VERSION}/libraries/ESP8266WiFi/src/include
)

target_link_libraries(esp8266wifi PUBLIC
    arduino
)



