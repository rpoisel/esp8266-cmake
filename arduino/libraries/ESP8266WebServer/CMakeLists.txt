file(GLOB WEBSERVER_LIB_SRC
    ${ARDUINO_ESP8266_DIR}/${ARDUINO_ESP8266_VERSION}/libraries/ESP8266WebServer/src/*.cpp
)

add_library(esp8266webserver STATIC
    ${WEBSERVER_LIB_SRC}
)

target_include_directories(esp8266webserver PUBLIC
    ${ARDUINO_ESP8266_DIR}/${ARDUINO_ESP8266_VERSION}/libraries/ESP8266WebServer/src
)

target_link_libraries(esp8266webserver PUBLIC
    arduino
    esp8266wifi
)



