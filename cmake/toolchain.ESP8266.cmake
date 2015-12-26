include(CMakeForceCompiler)

# Name of the target platform
set(CMAKE_SYSTEM_NAME ESP8266)
set(CMAKE_SYSTEM_VERSION 1)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/Modules")

# specify the cross compiler
if(CMAKE_HOST_SYSTEM_NAME MATCHES "Linux")
    set(HOST_EXECUTABLE_PREFIX "")
    set(ESP8266_OPEN_SDK_BASE $ENV{HOME}/git/esp-open-sdk CACHE PATH "Path to esp-open-sdk")
    set(ESP8266_ESPTOOL $ENV{HOME}/git/esptool-ck/esptool CACHE PATH "Path to the directory containing esptool.py")
    set(ESP8266_ESPTOOL_COM_PORT /dev/ttyUSB0 CACHE STRING "COM port to be used by esptool")
    set(ESP8266_XTENSA_COMPILER_HOME ${ESP8266_OPEN_SDK_BASE}/xtensa-lx106-elf/bin CACHE PATH "Directory containing the xtensa toolchain binaries")
elseif(CMAKE_HOST_SYSTEM_NAME MATCHES "Windows")
    set(HOST_EXECUTABLE_SUFFIX ".exe")
    set(ESP8266_XTENSA_COMPILER_HOME $ENV{USERPROFILE}/dev/tools/xtensa-lx106-elf/bin CACHE PATH "Directory containing the xtensa toolchain binaries")
    set(ESP8266_ESPTOOL $ENV{USERPROFILE}/dev/tools/esptool-ck/esptool CACHE FILEPATH "Path to the directory containing esptool.py")
    set(ESP8266_ESPTOOL_COM_PORT COM1 CACHE STRING "COM port to be used by esptool")
else()
    message(FATAL_ERROR Unsupported build platform.)
endif()

CMAKE_FORCE_C_COMPILER(${ESP8266_XTENSA_COMPILER_HOME}/xtensa-lx106-elf-gcc${HOST_EXECUTABLE_SUFFIX} GNU)

set(CMAKE_C_FLAGS "-Os -g -O2 -std=c99 -Wpointer-arith -pipe -Wundef -Wl,-EL -fno-inline-functions -ffunction-sections -nostdlib -mlongcalls -mtext-section-literals  -D__ets__ -DICACHE_FLASH")
set(CMAKE_EXE_LINKER_FLAGS "-nostdlib -Wl,--no-check-sections -u call_user_start -Wl,-static -Wl,--gc-sections")

set(BUILD_LINK_PREFIX "-Wl,--start-group")
set(BUILD_LINK_SUFFIX "-Wl,--end-group")
