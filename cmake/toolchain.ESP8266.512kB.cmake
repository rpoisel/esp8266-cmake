include(${CMAKE_CURRENT_LIST_DIR}/toolchain.ESP8266.cmake)

set(ESP8266_LINKER_SCRIPT "${ESP8266_SDK_BASE}/ld/eagle.app.v6.ld")
set(FW_FILE_1 0x00000.bin)
set(FW_FILE_2 0x40000.bin)
set(FW_ADDR_1 0x00000)
set(FW_ADDR_2 0x40000)
