from conans import ConanFile, CMake

class RecipeConan(ConanFile):
    name = "mos_utils"
    version = "0.0.1"

    settings = "os", "arch", "compiler", "build_type"
    requires = "mosquitto/2.0.14", "my_print/0.0.1@daniel/sample"
    generators = "cmake", "gcc", "txt"
    exports_sources = "CMakeLists.txt", "src/*", "include/*"

    def build(self):
        cmake = CMake(self)
        cmake.configure()
        cmake.build()

    def package(self):
        cmake = CMake(self)
        cmake.install()
    
    def package_info(self):
        self.cpp_info.libs = ["mos_utils"]

