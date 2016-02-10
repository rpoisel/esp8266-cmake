file(GLOB WIRE_LIB_SRC
    ${ARDUINO_ESP8266_DIR}/libraries/Wire/*.cpp
)

add_library(esp8266wire STATIC
    ${WIRE_LIB_SRC}
)

target_include_directories(esp8266wire PUBLIC
    ${ARDUINO_ESP8266_DIR}/libraries/Wire
)

target_link_libraries(esp8266wire PUBLIC
    arduino
)




