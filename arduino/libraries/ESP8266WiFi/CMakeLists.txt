file(GLOB WIFI_LIB_SRC
    ${ARDUINO_ESP8266_DIR}/libraries/ESP8266WiFi/src/*.cpp
)

target_sources(arduino PRIVATE
    ${WIFI_LIB_SRC}
)

target_include_directories(arduino PUBLIC
    ${ARDUINO_ESP8266_DIR}/tools/sdk/lwip/include
    ${ARDUINO_ESP8266_DIR}/libraries/ESP8266WiFi/src
    ${ARDUINO_ESP8266_DIR}/libraries/ESP8266WiFi/src/include
)

install(DIRECTORY ${ARDUINO_ESP8266_DIR}/tools/sdk/lwip/include/
    DESTINATION h/tools/sdk/lwip/include
    FILES_MATCHING PATTERN "*.h"
)

install(DIRECTORY ${ARDUINO_ESP8266_DIR}/libraries/ESP8266WiFi/src/
    DESTINATION h/libraries/ESP8266WiFi
    FILES_MATCHING PATTERN "*.h"
)

install(DIRECTORY ${ARDUINO_ESP8266_DIR}/libraries/ESP8266WiFi/src/include/
    DESTINATION h/libraries/ESP8266WiFi/include
    FILES_MATCHING PATTERN "*.h"
)

