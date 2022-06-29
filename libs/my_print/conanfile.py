from conans import ConanFile, CMake

class RecipeConan(ConanFile):
    settings = "os", "arch", "compiler", "build_type"
    generators = "cmake", "gcc", "txt"

    def build(self):
        cmake = CMake(self)
        cmake.configure()
        cmake.build()
        cmake.install()
