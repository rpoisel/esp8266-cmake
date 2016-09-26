add_custom_target(
    firmware_binary ALL
    COMMAND ${ESP8266_ESPTOOL} -eo ${CMAKE_CURRENT_LIST_DIR}/../../bootloaders/eboot/eboot.elf -bo firmware.bin -bf 40 -bz ${ESP8266_FLASH_SIZE} -bs .text -bp 4096 -ec -eo $<TARGET_FILE:firmware> -bs .irom0.text -bs .text -bs .data -bs .rodata -bc -ec
)

set_directory_properties(PROPERTIES ADDITIONAL_MAKE_CLEAN_FILES firmware.bin)

add_dependencies(firmware_binary firmware)

add_custom_target(
    flash COMMAND
    ${ESP8266_ESPTOOL} -vv -cd ck -cb 115200 -cp ${ESP8266_ESPTOOL_COM_PORT} -ca 0x00000 -cf firmware.bin
)

add_dependencies(flash firmware_binary)
