function(create_deployment_rules binary_file_name)
    add_custom_command(
        TARGET ${binary_file_name}
        POST_BUILD
        COMMAND export PATH=$ENV{PATH}:${ESP8266_XTENSA_COMPILER_HOME}
        COMMAND ${ESP8266_ESPTOOL} elf2image -o ${CMAKE_BINARY_DIR}/ firmware${CMAKE_EXECUTABLE_SUFFIX}
        BYPRODUCTS ${CMAKE_BINARY_DIR}/${FW_ADDR_1}.bin ${CMAKE_BINARY_DIR}/${FW_ADDR_2}.bin
    )

    add_custom_target(
        flash
        COMMAND export PATH=$ENV{PATH}:${ESP8266_XTENSA_COMPILER_HOME}
        COMMAND ${ESP8266_ESPTOOL} --port ${ESP8266_ESPTOOL_COM_PORT} write_flash ${FW_ADDR_1} ${CMAKE_BINARY_DIR}/${FW_ADDR_1}.bin ${FW_ADDR_2} ${CMAKE_BINARY_DIR}/${FW_ADDR_2}.bin
        DEPENDS ${CMAKE_BINARY_DIR}/${FW_ADDR_1}.bin ${CMAKE_BINARY_DIR}/${FW_ADDR_2}.bin
    )
endfunction()
