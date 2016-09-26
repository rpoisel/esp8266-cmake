file(GLOB LSM6_SRC
    ${CMAKE_CURRENT_SOURCE_DIR}/lsm6-arduino/*.cpp
)

target_sources(arduino PRIVATE
    ${LSM6_SRC}
)

target_include_directories(arduino PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/lsm6-arduino
)

file(GLOB LSM6_HDR
    ${CMAKE_CURRENT_SOURCE_DIR}/lsm6-arduino/*.h
)

install(FILES ${LSM6_HDR}
    DESTINATION h/extlib/lsm6
)
