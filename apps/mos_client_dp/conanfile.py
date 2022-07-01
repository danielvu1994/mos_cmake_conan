from conans import ConanFile, CMake
from conan.tools.cmake import  cmake_layout

class HelloConan(ConanFile):
        name = "mos_client"
        version = "0.0.1"
        requires = "mos_utils/0.0.1@daniel/sample"

        # Binary configuration
        settings = "os", "compiler", "build_type", "arch"
        options = {"shared": [True, False], "fPIC": [True, False]}
        default_options = {"shared": True, "fPIC": True}
        generators = "cmake"

        # Sources are located in the same place as this recipe, copy them to the recipe
        exports_sources = "CMakeLists.txt", "src/*"

        def config_options(self):
            if self.settings.os == "Windows":
                del self.options.fPIC
        
        def layout(self):
            cmake_layout(self) 
    
        def build(self):
            cmake = CMake(self)
            cmake.configure()
            cmake.build()

        def package(self):
            cmake = CMake(self)
            cmake.install()

        def package_info(self):                                                                                                                                                                                
            self.cpp_info.libs = ["mos_client"]
