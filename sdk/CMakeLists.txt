add_library(ESP8266_SDK INTERFACE)

set (ESP8266_FLASH_SIZE "512" CACHE STRING "Size of flash in kB")
set (ESP8266_SDK_VARIANT "" CACHE STRING "Variant of the SDK to use")

if (ESP8266_SDK_VARIANT MATCHES "RTOS")
    include(rtos.cmake)
elseif (ESP8266_SDK_VARIANT MATCHES "NONOS")
    include(nonos.cmake)
else()
    message(FATAL_ERROR "SDK variant not supported.")
endif()
