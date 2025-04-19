message("the current directory is: ${CMAKE_CURRENT_SOURCE_DIR}")

message(${CMAKE_CURRENT_LIST_FILE};"Alice";"James")

set(VAR1 TRUE)
if(${VAR1})
    message("VAR1 is True")
else()
    message("VAR1 is FALSE")
endif()


