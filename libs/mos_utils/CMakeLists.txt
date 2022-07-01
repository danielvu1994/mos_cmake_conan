cmake_minimum_required(VERSION 3.0.0)

project(MosUtils VERSION 1.0.0)

include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup()

set(CMAKE_INSTALL_RPATH ${CONAN_LIB_DIRS})
set(CMAKE_BUILD_WITH_INSTALL_RPATH ON)

FILE(GLOB MySources "src/*.cpp")
add_library(mos_utils SHARED ${MySources})

target_include_directories(mos_utils PUBLIC
$<INSTALL_INTERFACE:include>
$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>)

target_link_libraries(mos_utils LINK_PUBLIC ${CONAN_LIBS})

FILE(GLOB MyHeaders "include/mos_utils/*.h")
install(TARGETS mos_utils LIBRARY DESTINATION lib)
install(FILES ${MyHeaders} DESTINATION include/mos_utils)
