target_sources(arduino PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/Adafruit-ST7735-Library/Adafruit_ST7735.cpp
)

target_include_directories(arduino PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/Adafruit-ST7735-Library
)

install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/Adafruit-ST7735-Library/Adafruit_ST7735.h
    DESTINATION h/extlib/adafruit_st7735
)
