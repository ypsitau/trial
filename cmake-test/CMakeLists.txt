cmake_minimum_required(VERSION 2.6)

project(cmake-test)

#add_subdirectory(${PROJECT_SOURCE_DIR}/lib)
#add_subdirectory(${PROJECT_SOURCE_DIR}/bin)

install(FILES CMakeLists.txt
  PERMISSIONS OWNER_READ GROUP_READ WORLD_READ
  DESTINATION /Users/ypsitau)
