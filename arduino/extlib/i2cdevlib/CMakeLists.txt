### i2cdevlib
target_sources(arduino PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/i2cdevlib/Arduino/I2Cdev/I2Cdev.cpp
)

target_include_directories(arduino PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}/i2cdevlib/Arduino/I2Cdev
)

install(FILES ${CMAKE_CURRENT_LIST_DIR}/i2cdevlib/Arduino/I2Cdev/I2Cdev.h
    DESTINATION h/extlib/i2cdevlib
)

### MPU6050
target_sources(arduino PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/i2cdevlib/Arduino/MPU6050/MPU6050.cpp
)

target_include_directories(arduino PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}/i2cdevlib/Arduino/MPU6050
)

file(GLOB MPU6050_HDR ${CMAKE_CURRENT_LIST_DIR}/i2cdevlib/Arduino/MPU6050/*.h)
install(FILES ${MPU6050_HDR}
    DESTINATION h/extlib/MPU6050
)

### MPU9150
target_sources(arduino PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/i2cdevlib/Arduino/MPU9150/MPU9150.cpp
)

target_include_directories(arduino PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}/i2cdevlib/Arduino/MPU9150
)

file(GLOB MPU9150_HDR ${CMAKE_CURRENT_LIST_DIR}/i2cdevlib/Arduino/MPU9150/*.h)
install(FILES ${MPU9150_HDR}
    DESTINATION h/extlib/MPU9150
)

