INCLUDE(CMakeForceCompiler)

# Name of the target platform
SET(CMAKE_SYSTEM_NAME ESP8266)
SET(CMAKE_SYSTEM_VERSION 1)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/Modules")

# specify the cross compiler
IF(CMAKE_HOST_SYSTEM_NAME MATCHES "Linux")
    SET(ESP8266_OPEN_SDK_BASE $ENV{HOME}/git/esp-open-sdk CACHE PATH "Path to esp-open-sdk")
    SET(ESP8266_ESPTOOL ${ESP8266_OPEN_SDK_BASE}/esptool/esptool.py CACHE PATH "Path to the directory containing esptool.py")
    SET(ESP8266_ESPTOOL_COM_PORT /dev/ttyUSB0 CACHE STRING "COM port to be used by esptool.py")
    SET(ESP8266_XTENSA_COMPILER_HOME ${ESP8266_OPEN_SDK_BASE}/xtensa-lx106-elf/bin CACHE PATH "Directory containing the xtensa toolchain binaries")
    SET(ESP8266_SDK_BASE $ENV{HOME}/git/ESP8266_RTOS_SDK CACHE PATH "Path to the ESP8266 SDK")
    SET(ESP8266_LINKER_SCRIPT "${ESP8266_SDK_BASE}/ld/eagle.app.v6.new.1024.app1.ld" CACHE FILEPATH "Path to the linker script")
    CMAKE_FORCE_C_COMPILER(${ESP8266_XTENSA_COMPILER_HOME}/xtensa-lx106-elf-gcc GNU)
ELSE()
    MESSAGE(FATAL_ERROR Unsupported build platform.)
ENDIF()

SET(CMAKE_C_FLAGS "-I${ESP8266_SDK_BASE}/include -I${ESP8266_SDK_BASE}/include/json -Os -D__ESP8266__ -std=c99 -pedantic -Wall -Wextra -Wpointer-arith -pipe -Wno-unused-parameter -Wno-unused-variable -Os -Wpointer-arith -Wundef -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals  -D__ets__ -DICACHE_FLASH -ffunction-sections -fdata-sections")
SET(CMAKE_EXE_LINKER_FLAGS "-T${ESP8266_LINKER_SCRIPT} -nostdlib -Wl,--no-check-sections -u call_user_start -Wl,-static -Wl,--gc-sections")

SET(BUILD_LINK_PREFIX "-Wl,--start-group")
SET(BUILD_LINK_SUFFIX "-Wl,--end-group")
