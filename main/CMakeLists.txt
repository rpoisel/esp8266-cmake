include(ESP8266-Deployment)

add_library(USER_CODE INTERFACE)

link_directories(
    ${ESP8266_SDK_BASE}/lib
)

file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/null.c)

add_executable(firmware
    ${CMAKE_CURRENT_BINARY_DIR}/null.c
)

target_link_libraries(firmware
    ${BUILD_LINK_PREFIX}
    $<TARGET_PROPERTY:USER_CODE,INTERFACE_LINK_LIBRARIES>
    $<TARGET_PROPERTY:ESP8266_SDK,INTERFACE_LINK_LIBRARIES>
    ${BUILD_LINK_SUFFIX}
)

create_deployment_rules(firmware)
