cmake_minimum_required(VERSION 3.0.0)

project(MyPrintLib VERSION 0.0.1)

FILE(GLOB MySources "src/*.cpp")
add_library(my_print SHARED ${MySources})

target_include_directories(my_print PUBLIC $<INSTALL_INTERFACE:include> $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>)

set(CMAKE_INSTALL_PREFIX $ENV{INSTALL_PATH})
FILE(GLOB MyHeaders "include/my_print/*.h")
install(TARGETS my_print  LIBRARY DESTINATION lib)
install(FILES ${MyHeaders} DESTINATION include/my_print)
