function(create_deployment_rules binary_file_name)
    add_custom_command(
        TARGET ${binary_file_name}
        POST_BUILD
        COMMAND ${ESP8266_ESPTOOL} -bz ${ESP8266_FLASH_SIZE} -eo firmware${CMAKE_EXECUTABLE_SUFFIX} -bo ${CMAKE_BINARY_DIR}/firmware_${FW_ADDR_1}.bin -bs .text -bs .data -bs .rodata -bc -ec -eo firmware${CMAKE_EXECUTABLE_SUFFIX} -es .irom0.text ${CMAKE_BINARY_DIR}/firmware_${FW_ADDR_2}.bin -ec
        BYPRODUCTS ${CMAKE_BINARY_DIR}/firmware_${FW_ADDR_1}.bin ${CMAKE_BINARY_DIR}/firmware_${FW_ADDR_2}.bin
    )

    add_custom_target(
        flash
        COMMAND ${ESP8266_ESPTOOL} -cp ${ESP8266_ESPTOOL_COM_PORT} -cf ${CMAKE_BINARY_DIR}/firmware_${FW_ADDR_1}.bin -ca 0x40000 -cf ${CMAKE_BINARY_DIR}/firmware_${FW_ADDR_2}.bin
        DEPENDS ${CMAKE_BINARY_DIR}/firmware_${FW_ADDR_1}.bin ${CMAKE_BINARY_DIR}/firmware_${FW_ADDR_2}.bin
    )
endfunction()
