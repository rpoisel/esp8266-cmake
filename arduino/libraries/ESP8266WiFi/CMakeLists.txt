file(GLOB WIFI_LIB_SRC
    ${ARDUINO_DIR}/libraries/ESP8266WiFi/src/*.cpp
)

add_library(esp8266wifi STATIC
    ${WIFI_LIB_SRC}
)

target_include_directories(esp8266wifi PUBLIC
    ${ARDUINO_DIR}/libraries/ESP8266WiFi/src
)

target_link_libraries(esp8266wifi PUBLIC
    arduino
)



