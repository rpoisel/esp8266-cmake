file(GLOB ARDUINO_OTA_LIB_SRC
    ${ARDUINO_ESP8266_DIR}/libraries/ArduinoOTA/*.cpp
)

add_library(esp8266arduino_ota STATIC
    ${ARDUINO_OTA_LIB_SRC}
)

target_include_directories(esp8266arduino_ota PUBLIC
    ${ARDUINO_ESP8266_DIR}/libraries/ArduinoOTA
)

target_link_libraries(esp8266arduino_ota PUBLIC
    arduino
    esp8266wifi
    esp8266mdns
)





