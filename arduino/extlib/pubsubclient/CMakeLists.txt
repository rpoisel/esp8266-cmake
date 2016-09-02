target_sources(arduino PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/pubsubclient/src/PubSubClient.cpp
)

target_include_directories(arduino PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}/pubsubclient/src
)

install(FILES ${CMAKE_CURRENT_LIST_DIR}/pubsubclient/src/PubSubClient.h
    DESTINATION h/extlib/pubsubclient
)
