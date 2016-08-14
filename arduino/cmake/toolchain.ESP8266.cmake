include(CMakeForceCompiler)

set(CMAKE_SYSTEM_NAME ESP8266)
set(CMAKE_SYSTEM_VERSION 1)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/Modules")

set (ESP8266_FLASH_SIZE "512k0" CACHE STRING "Size of flash")

if(CMAKE_HOST_SYSTEM_NAME MATCHES "Linux")
    set(HOST_EXECUTABLE_PREFIX "")
elseif(CMAKE_HOST_SYSTEM_NAME MATCHES "Windows")
    set(HOST_EXECUTABLE_SUFFIX ".exe")
else()
    message(FATAL_ERROR Unsupported build platform.)
endif()

CMAKE_FORCE_C_COMPILER(xtensa-lx106-elf-gcc${HOST_EXECUTABLE_SUFFIX} GNU_C)
CMAKE_FORCE_CXX_COMPILER(xtensa-lx106-elf-g++${HOST_EXECUTABLE_SUFFIX} GNU_CXX)

set(CMAKE_C_FLAGS "-Os -g -std=gnu99 -Wpointer-arith -Wno-implicit-function-declaration -Wundef -pipe -D__ets__ -DICACHE_FLASH -fno-inline-functions -ffunction-sections -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -fdata-sections" CACHE STRING "C compiler flags")
set(CMAKE_CXX_FLAGS "-Os -g -D__ets__ -DICACHE_FLASH -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections" CACHE STRING "CXX compiler flags")
set(CMAKE_EXE_LINKER_FLAGS "-nostdlib -Wl,--no-check-sections -Wl,-static -Wl,--gc-sections -Wl,--no-relax -L${CMAKE_CURRENT_LIST_DIR}/../ld -Teagle.flash.${ESP8266_FLASH_SIZE}.ld -u call_user_start -Wl,-wrap,system_restart_local -Wl,-wrap,register_chipv6_phy" CACHE STRING "linker flags")

set(CMAKE_C_LINK_EXECUTABLE "<CMAKE_C_COMPILER> <FLAGS> <CMAKE_C_LINK_FLAGS> <LINK_FLAGS> -o <TARGET> -Wl,--start-group <OBJECTS> <LINK_LIBRARIES> -Wl,--end-group" CACHE STRING "C linker invocation")
set(CMAKE_CXX_LINK_EXECUTABLE "<CMAKE_CXX_COMPILER> <FLAGS> <CMAKE_CXX_LINK_FLAGS> <LINK_FLAGS> -o <TARGET> -Wl,--start-group <OBJECTS> <LINK_LIBRARIES> -Wl,--end-group" CACHE STRING "CXX linker invocation")

