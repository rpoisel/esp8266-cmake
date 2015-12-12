include(CMakeForceCompiler)

# Name of the target platform
set(CMAKE_SYSTEM_NAME ESP8266)
set(CMAKE_SYSTEM_VERSION 1)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/Modules")

# specify the cross compiler
if(CMAKE_HOST_SYSTEM_NAME MATCHES "Linux")
    set(ESP8266_OPEN_SDK_BASE $ENV{HOME}/git/esp-open-sdk CACHE PATH "Path to esp-open-sdk")
    set(ESP8266_ESPTOOL ${ESP8266_OPEN_SDK_BASE}/esptool/esptool.py CACHE PATH "Path to the directory containing esptool.py")
    set(ESP8266_ESPTOOL_COM_PORT /dev/ttyUSB0 CACHE STRING "COM port to be used by esptool.py")
    set(ESP8266_XTENSA_COMPILER_HOME ${ESP8266_OPEN_SDK_BASE}/xtensa-lx106-elf/bin CACHE PATH "Directory containing the xtensa toolchain binaries")
    CMAKE_FORCE_C_COMPILER(${ESP8266_XTENSA_COMPILER_HOME}/xtensa-lx106-elf-gcc GNU)
else()
    message(FATAL_ERROR Unsupported build platform.)
endif()

set (ESP8266_SDK_VARIANT "" CACHE STRING "Variant of the SDK to use")
if (ESP8266_SDK_VARIANT MATCHES "RTOS")
    set(ESP8266_SDK_BASE $ENV{HOME}/git/ESP8266_RTOS_SDK CACHE PATH "Path to the ESP8266 SDK")
elseif(ESP8266_SDK_VARIANT MATCHES "NONOS")
    set(ESP8266_SDK_BASE ${ESP8266_OPEN_SDK_BASE}/sdk CACHE PATH "Path to the ESP8266 SDK")
else()
    message(FATAL_ERROR "SDK variant not supported.")
endif()

set (ESP8266_FLASH_SIZE "512" CACHE STRING "Size of flash in kB")
if (ESP8266_FLASH_SIZE MATCHES "512")
    set(ESP8266_LINKER_SCRIPT "eagle.app.v6.ld")
    set(FW_ADDR_1 0x00000)
    set(FW_ADDR_2 0x40000)
elseif (ESP8266_FLASH_SIZE MATCHES "1024")
    set(ESP8266_LINKER_SCRIPT "eagle.app.v6.new.1024.app1.ld")
    set(FW_ADDR_1 0x00000)
    set(FW_ADDR_2 0x01010)
else()
    message(FATAL_ERROR "Unsupported flash size")
endif()
set(ESP8266_LINKER_SCRIPT_PATH ${ESP8266_SDK_BASE}/ld/${ESP8266_LINKER_SCRIPT})

set(CMAKE_C_FLAGS "-Os -g -O2 -std=c99 -Wpointer-arith -pipe -Wundef -Wl,-EL -fno-inline-functions -ffunction-sections -nostdlib -mlongcalls -mtext-section-literals  -D__ets__ -DICACHE_FLASH")
set(CMAKE_EXE_LINKER_FLAGS "-T${ESP8266_LINKER_SCRIPT_PATH} -nostdlib -Wl,--no-check-sections -u call_user_start -Wl,-static -Wl,--gc-sections")

set(BUILD_LINK_PREFIX "-Wl,--start-group")
set(BUILD_LINK_SUFFIX "-Wl,--end-group")
