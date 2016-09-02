target_sources(arduino PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/Adafruit-GFX-Library/Adafruit_GFX.cpp
)

target_include_directories(arduino PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/Adafruit-GFX-Library
)

install(FILES
    ${CMAKE_CURRENT_SOURCE_DIR}/Adafruit-GFX-Library/Adafruit_GFX.h
    ${CMAKE_CURRENT_SOURCE_DIR}/Adafruit-GFX-Library/gfxfont.h
    DESTINATION h/extlib/adafruit_gfx
)

file(GLOB ADAFRUIT_GFX_HDR
    ${CMAKE_CURRENT_SOURCE_DIR}/Adafruit-GFX-Library/Fonts/*.h
)

install(FILES ${ADAFRUIT_GFX_HDR}
    DESTINATION h/extlib/adafruit_gfx/Fonts
)
