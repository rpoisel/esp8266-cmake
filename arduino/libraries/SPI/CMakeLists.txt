file(GLOB SPI_LIB_SRC
    ${ARDUINO_ESP8266_DIR}/libraries/SPI/*.cpp
)

target_sources(arduino PRIVATE
    ${SPI_LIB_SRC}
)

target_include_directories(arduino PRIVATE
    ${ARDUINO_ESP8266_DIR}/libraries/SPI
)

install(DIRECTORY ${ARDUINO_ESP8266_DIR}/libraries/SPI/
    DESTINATION h/libraries/SPI
    FILES_MATCHING PATTERN "*.h"
)

