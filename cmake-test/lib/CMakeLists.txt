add_library(sub SHARED sub.c)

#set(CMAKE_SKIP_BUILD_RPATH            FALSE)
#set(CMAKE_BUILD_WITH_INSTALL_RPATH    TRUE)
#set(CMAKE_INSTALL_RPATH               "@loader_path/../lib")
#set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)

set_target_properties(sub PROPERTIES
  BUILD_WITH_INSTALL_RPATH 1
  INSTALL_NAME_DIR "@loader_path/../lib")

install(TARGETS sub DESTINATION lib)
