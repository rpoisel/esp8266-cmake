file(GLOB GDBSTUB_LIB_SRC
    ${ARDUINO_ESP8266_DIR}/libraries/GDBStub/src/internal/*.c
    ${ARDUINO_ESP8266_DIR}/libraries/GDBStub/src/internal/*.S
)

file(GLOB GDBSTUB_LIB_SRC_ASM
    ${ARDUINO_ESP8266_DIR}/libraries/GDBStub/src/internal/*.S
)

set_source_files_properties(${GDBSTUB_LIB_SRC_ASM} PROPERTIES
    LANGUAGE ASM
    COMPILE_FLAGS ${CMAKE_C_FLAGS}
)

add_library(esp8266gdbstub STATIC
    ${GDBSTUB_LIB_SRC}
    ${GDBSTUB_LIB_SRC_ASM}
)

target_include_directories(esp8266gdbstub PUBLIC
    ${ARDUINO_ESP8266_DIR}/libraries/GDBStub/src
    ${ARDUINO_ESP8266_DIR}/libraries/GDBStub/src/internal
    ${ARDUINO_ESP8266_DIR}/libraries/GDBStub/src/xtensa
    ${ARDUINO_ESP8266_DIR}/libraries/GDBStub/src/xtensa/config
)

target_compile_definitions(esp8266gdbstub PUBLIC
    -DGDBSTUB_REDIRECT_CONSOLE_OUTPUT
    -DGDBSTUB_CTRLC_BREAK
    -DGDBSTUB_BREAK_ON_INIT
)

target_link_libraries(esp8266gdbstub
    arduino
)
