file(GLOB GDBSTUB_LIB_SRC
    ${ARDUINO_ESP8266_DIR}/libraries/GDBStub/src/internal/*.c
    ${ARDUINO_ESP8266_DIR}/libraries/GDBStub/src/internal/*.S
)

add_library(esp8266gdbstub STATIC
    ${GDBSTUB_LIB_SRC}
)

target_include_directories(esp8266gdbstub PUBLIC
    ${ARDUINO_ESP8266_DIR}/libraries/GDBStub/src
    ${ARDUINO_ESP8266_DIR}/libraries/GDBStub/src/internal
    ${ARDUINO_ESP8266_DIR}/libraries/GDBStub/src/xtensa
    ${ARDUINO_ESP8266_DIR}/libraries/GDBStub/src/xtensa/config
)

target_link_libraries(esp8266gdbstub PUBLIC
    arduino
)



