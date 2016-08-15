file(GLOB WEBSERVER_LIB_SRC
    ${ARDUINO_ESP8266_DIR}/libraries/ESP8266WebServer/src/*.cpp
)

target_sources(arduino PRIVATE
    ${WEBSERVER_LIB_SRC}
)

target_include_directories(arduino PUBLIC
    ${ARDUINO_ESP8266_DIR}/libraries/ESP8266WebServer/src
)

install(DIRECTORY ${ARDUINO_ESP8266_DIR}/libraries/ESP8266WebServer/src/
    DESTINATION h/libraries/ESP8266Webserver
    FILES_MATCHING PATTERN "*.h"
)

