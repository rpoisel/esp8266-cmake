file(GLOB SPI_LIB_SRC
    ${ARDUINO_ESP8266_DIR}/libraries/SPI/*.cpp
)

add_library(esp8266spi STATIC
    ${SPI_LIB_SRC}
)

target_include_directories(esp8266spi PUBLIC
    ${ARDUINO_ESP8266_DIR}/libraries/SPI
)

target_link_libraries(esp8266spi PUBLIC
    arduino
)



