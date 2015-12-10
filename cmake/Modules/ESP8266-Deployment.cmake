function(create_deployment_rules binary_file_name fw_file_1 fw_file_2 fw_addr_1 fw_addr_2)
    add_custom_command(
        TARGET ${binary_file_name}
        POST_BUILD
        COMMAND export PATH=$ENV{PATH}:${ESP8266_XTENSA_COMPILER_HOME}
        COMMAND ${ESP8266_ESPTOOL} elf2image -o ${CMAKE_BINARY_DIR}/ firmware${CMAKE_EXECUTABLE_SUFFIX}
        BYPRODUCTS ${CMAKE_BINARY_DIR}/${fw_file_1} ${CMAKE_BINARY_DIR}/${fw_file_2}
    )

    add_custom_target(
        flash
        COMMAND export PATH=$ENV{PATH}:${ESP8266_XTENSA_COMPILER_HOME}
        COMMAND ${ESP8266_ESPTOOL} --port ${ESP8266_ESPTOOL_COM_PORT} write_flash ${fw_addr_1} ${CMAKE_BINARY_DIR}/${fw_file_1} ${fw_addr_2} ${CMAKE_BINARY_DIR}/${fw_file_2}
        DEPENDS ${CMAKE_BINARY_DIR}/${fw_file_1} ${CMAKE_BINARY_DIR}/${fw_file_2}
    )
endfunction()
