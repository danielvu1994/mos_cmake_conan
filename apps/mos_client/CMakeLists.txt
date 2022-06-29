cmake_minimum_required(VERSION 3.0.0)

project(SampleApp VERSION 1.0.0)

include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup()

find_package(mos_utils REQUIRED PATHS $ENV{INSTALL_PATH})
find_package(my_print PATHS $ENV{INSTALL_PATH})

if(mos_utils_FOUND)
else()
        message(FATAL_ERROR "mos_utils is not found")
        EXIT()
endif()
set(CMAKE_INSTALL_RPATH "/home/daniel/cmake_conan/build_dir/")
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)

FILE(GLOB MySources "src/*.cpp")
add_executable(mos_client ${MySources})

target_link_libraries(mos_client PUBLIC mos_utils)

set(CMAKE_INSTALL_PREFIX $ENV{INSTALL_PATH})
install(TARGETS mos_client DESTINATION bin)
