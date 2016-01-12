include(CMakeForceCompiler)

set(CMAKE_SYSTEM_NAME ESP8266)
set(CMAKE_SYSTEM_VERSION 1)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/Modules")

set (ESP8266_FLASH_SIZE "512K" CACHE STRING "Size of flash")

if(CMAKE_HOST_SYSTEM_NAME MATCHES "Linux")
    set(USER_HOME $ENV{HOME})
    set(HOST_EXECUTABLE_PREFIX "")
    set(ESP8266_OPEN_SDK_BASE ${USER_HOME}/git/esp-open-sdk CACHE PATH "Path to esp-open-sdk")
    set(ESP8266_ESPTOOL ${USER_HOME}/git/esptool-ck/esptool CACHE PATH "Path to the directory containing esptool")
    set(ESP8266_ESPTOOL_COM_PORT /dev/ttyUSB0 CACHE STRING "COM port to be used by esptool")
    set(ESP8266_XTENSA_COMPILER_HOME ${USER_HOME}/git/esp-open-sdk/xtensa-lx106-elf/bin CACHE PATH "Directory containing the xtensa toolchain binaries")
elseif(CMAKE_HOST_SYSTEM_NAME MATCHES "Windows")
    set(USER_HOME $ENV{USERPROFILE})
    set(HOST_EXECUTABLE_SUFFIX ".exe")
    set(ESP8266_XTENSA_COMPILER_HOME ${USER_HOME}/dev/tools/xtensa-lx106-elf/bin CACHE PATH "Directory containing the xtensa toolchain binaries")
    set(ESP8266_ESPTOOL ${USER_HOME}/dev/tools/esptool-ck/esptool CACHE FILEPATH "Path to the directory containing esptool")
    set(ESP8266_ESPTOOL_COM_PORT COM1 CACHE STRING "COM port to be used by esptool")
else()
    message(FATAL_ERROR Unsupported build platform.)
endif()

CMAKE_FORCE_C_COMPILER(${ESP8266_XTENSA_COMPILER_HOME}/xtensa-lx106-elf-gcc${HOST_EXECUTABLE_SUFFIX} GNU_C)
CMAKE_FORCE_CXX_COMPILER(${ESP8266_XTENSA_COMPILER_HOME}/xtensa-lx106-elf-g++${HOST_EXECUTABLE_SUFFIX} GNU_CXX)

set(CMAKE_C_FLAGS "-Os -g -std=gnu99 -Wpointer-arith -Wno-implicit-function-declaration -Wundef -pipe -D__ets__ -DICACHE_FLASH -fno-inline-functions -ffunction-sections -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -fdata-sections")
set(CMAKE_CXX_FLAGS "-Os -g -D__ets__ -DICACHE_FLASH -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections")
set(CMAKE_EXE_LINKER_FLAGS "-nostdlib -Wl,--no-check-sections -Wl,-static -Wl,--gc-sections")
