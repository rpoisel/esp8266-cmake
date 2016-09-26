cmake_minimum_required(VERSION 3.5)

cmake_policy(SET CMP0048 NEW)
project(ArduinoBuild VERSION 0.9.0 LANGUAGES C CXX ASM)

add_subdirectory(arduino)

if (EXISTS "${ARDUINO_ESP8266_DIR}/platform.txt")
    file(STRINGS "${ARDUINO_ESP8266_DIR}/platform.txt" VERSION_LINES REGEX "^version=")
    if (VERSION_LINES)
        string(REGEX MATCH "[0-9]+\.[0-9]+\.[0-9]+" ARDUINO_VERSION ${VERSION_LINES})
    endif ()
endif ()

install(DIRECTORY cmake/Modules DESTINATION cmake)
install(DIRECTORY ${ARDUINO_ESP8266_DIR}/tools/sdk/ld/ DESTINATION ld FILES_MATCHING PATTERN "*.ld")
install(FILES ${ARDUINO_ESP8266_DIR}/bootloaders/eboot/eboot.elf DESTINATION bootloaders/eboot)

set(CPACK_GENERATOR "ZIP")
set(CPACK_PACKAGE_FILE_NAME Arduino-${ARDUINO_VERSION})
set(CPACK_INCLUDE_TOPLEVEL_DIRECTORY FALSE)

include(CPack)
