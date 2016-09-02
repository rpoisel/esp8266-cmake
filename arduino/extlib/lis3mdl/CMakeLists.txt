file(GLOB LIS3MDL_SRC
    ${CMAKE_CURRENT_SOURCE_DIR}/lis3mdl-arduino/*.cpp
)

target_sources(arduino PRIVATE
    ${LIS3MDL_SRC}
)

target_include_directories(arduino PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/lis3mdl-arduino
)

file(GLOB LIS3MDL_HDR
    ${CMAKE_CURRENT_SOURCE_DIR}/lis3mdl-arduino/*.h
)

install(FILES ${LIS3MDL_HDR}
    DESTINATION h/extlib/lis3mdl
)
