file(GLOB WIRE_LIB_SRC
    ${ARDUINO_ESP8266_DIR}/libraries/Wire/*.cpp
)

target_sources(arduino PRIVATE
    ${WIRE_LIB_SRC}
)

target_include_directories(arduino PRIVATE
    ${ARDUINO_ESP8266_DIR}/libraries/Wire
)

install(DIRECTORY ${ARDUINO_ESP8266_DIR}/libraries/Wire/
    DESTINATION h/libraries/Wire
    FILES_MATCHING PATTERN "*.h"
)

