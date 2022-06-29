cmake_minimum_required(VERSION 3.0.0)

project(MosCallBack VERSION 1.0.0)

include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup()

find_package(my_print REQUIRED PATHS $ENV{INSTALL_PATH})
set(CMAKE_INSTALL_RPATH $ENV{INSTALL_PATH})
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)

if(my_print_FOUND)
        message("Found my_print lib")
else()
        message(FATAL_ERROR "my_print lib is not found")
        EXIT()
endif()

FILE(GLOB MySources "src/*.cpp")

add_library(mos_utils SHARED ${MySources})

target_include_directories(mos_utils PUBLIC
$<INSTALL_INTERFACE:include>
$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>)

target_link_libraries(mos_utils LINK_PUBLIC  my_print ${CONAN_LIBS})

set(CMAKE_INSTALL_PREFIX $ENV{INSTALL_PATH})
FILE(GLOB MyHeaders "include/mos_utils/*.h")
install(TARGETS mos_utils EXPORT mos_utils_export LIBRARY DESTINATION lib/mos_utils)
install(EXPORT mos_utils_export FILE mos_utils-config.cmake DESTINATION lib/mos_utils)
install(FILES ${MyHeaders} DESTINATION include/mos_utils)
