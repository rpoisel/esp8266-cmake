file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/null.c)

add_executable(firmware
    ${CMAKE_CURRENT_BINARY_DIR}/null.c
)

target_link_libraries(firmware
    user_code
    ESP8266_SDK
)

set_target_properties(firmware PROPERTIES
    LINKER_LANGUAGE C
)

