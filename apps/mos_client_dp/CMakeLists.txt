cmake_minimum_required(VERSION 3.0.0)

project(SampleApp VERSION 1.0.0)

include(build/conanbuildinfo.cmake)
conan_basic_setup()

set(CMAKE_INSTALL_RPATH ${CONAN_LIB_DIRS})
set(CMAKE_BUILD_WITH_INSTALL_RPATH ON)

FILE(GLOB MySources "src/*.cpp")
add_executable(mos_client ${MySources})

target_link_libraries(mos_client PUBLIC ${CONAN_LIBS})

install(TARGETS mos_client DESTINATION bin)
