set(CMAKE_SYSTEM_NAME ESP8266)
set(CMAKE_SYSTEM_VERSION 1)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/Modules")

set (ESP8266_FLASH_SIZE "512k0" CACHE STRING "Size of flash")
set (ESP8266_LINKER_SCRIPT "eagle.flash.512k0.ld" CACHE STRING "Name of linker script")

if(CMAKE_HOST_SYSTEM_NAME MATCHES "Linux")
    set(USER_HOME $ENV{HOME})
    set(HOST_EXECUTABLE_PREFIX "")
    set(ESP8266_ESPTOOL_COM_PORT /dev/ttyUSB0 CACHE STRING "COM port to be used by esptool")
elseif(CMAKE_HOST_SYSTEM_NAME MATCHES "Windows")
    set(USER_HOME $ENV{USERPROFILE})
    set(HOST_EXECUTABLE_SUFFIX ".exe")
    set(ESP8266_ESPTOOL_COM_PORT COM1 CACHE STRING "COM port to be used by esptool")
else()
    message(FATAL_ERROR Unsupported build platform.)
endif()

set(ARDUINO_DIR "${USER_HOME}/.arduino15" CACHE PATH "Path to the directory containing the Arduino package files")
if (ARDUINO_DIR STREQUAL "")
    message(FATAL_ERROR "ARDUINO_DIR has not been set.")
endif ()

set(ARDUINO_ESP8266_DIR ${ARDUINO_DIR}/packages/esp8266/hardware/esp8266/2.3.0 CACHE PATH "Path to the directory containing ESP8266 specific arduino files")
if (ARDUINO_ESP8266_DIR STREQUAL "")
    message(FATAL_ERROR "ARDUINO_ESP8266_DIR has not been set.")
endif ()

file(GLOB_RECURSE ESP8266_XTENSA_C_COMPILERS ${ARDUINO_DIR}/packages/esp8266/tools/xtensa-lx106-elf-gcc FOLLOW_SYMLINKS xtensa-lx106-elf-gcc${HOST_EXECUTABLE_SUFFIX})
list(GET ESP8266_XTENSA_C_COMPILERS 0 ESP8266_XTENSA_C_COMPILER)
file(GLOB_RECURSE ESP8266_XTENSA_CXX_COMPILERS ${ARDUINO_DIR}/packages/esp8266/tools/xtensa-lx106-elf-gcc FOLLOW_SYMLINKS xtensa-lx106-elf-g++${HOST_EXECUTABLE_SUFFIX})
list(GET ESP8266_XTENSA_CXX_COMPILERS 0 ESP8266_XTENSA_CXX_COMPILER)
file(GLOB_RECURSE ESP8266_ESPTOOLS ${ARDUINO_DIR}/packages/esp8266/tools/esptool FOLLOW_SYMLINKS esptool${HOST_EXECUTABLE_NAME})
list(GET ESP8266_ESPTOOLS 0 ESP8266_ESPTOOL)

message("Using " ${ESP8266_XTENSA_C_COMPILER} " C compiler.")
message("Using " ${ESP8266_XTENSA_CXX_COMPILER} " C++ compiler.")

set(CMAKE_C_COMPILER ${ESP8266_XTENSA_C_COMPILER})
set(CMAKE_CXX_COMPILER ${ESP8266_XTENSA_CXX_COMPILER})

set(CMAKE_C_FLAGS "-Os -g -std=gnu99 -Wpointer-arith -Wno-implicit-function-declaration -Wundef -pipe -D__ets__ -DICACHE_FLASH -fno-inline-functions -ffunction-sections -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -fdata-sections" CACHE STRING "C compiler flags")
set(CMAKE_CXX_FLAGS "-Os -g -D__ets__ -DICACHE_FLASH -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections" CACHE STRING "CXX compiler flags")
set(CMAKE_EXE_LINKER_FLAGS "-nostdlib -Wl,--no-check-sections -Wl,-static -Wl,--gc-sections -Wl,--no-relax -L${ARDUINO_ESP8266_DIR}/tools/sdk/ld -Teagle.flash.${ESP8266_FLASH_SIZE}.ld -u call_user_start -Wl,-wrap,system_restart_local -Wl,-wrap,register_chipv6_phy" CACHE STRING "linker flags")

set(CMAKE_C_LINK_EXECUTABLE "<CMAKE_C_COMPILER> <FLAGS> <CMAKE_C_LINK_FLAGS> <LINK_FLAGS> -o <TARGET> -Wl,--start-group <OBJECTS> <LINK_LIBRARIES> -Wl,--end-group" CACHE STRING "C linker invocation")
set(CMAKE_CXX_LINK_EXECUTABLE "<CMAKE_CXX_COMPILER> <FLAGS> <CMAKE_CXX_LINK_FLAGS> <LINK_FLAGS> -o <TARGET> -Wl,--start-group <OBJECTS> <LINK_LIBRARIES> -Wl,--end-group" CACHE STRING "CXX linker invocation")

