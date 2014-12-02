add_executable(main main.c)

target_link_libraries(main sub)

install(TARGETS main DESTINATION bin)
