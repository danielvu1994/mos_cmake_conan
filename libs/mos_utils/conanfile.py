from conans import ConanFile, CMake

class RecipeConan(ConanFile):
    settings = "os", "arch", "compiler", "build_type"
    requires = "mosquitto/2.0.14"
    generators = "cmake", "gcc", "txt"
    default_options = {"mosquitto:shared": True, "openssl:shared": True}

    def build(self):
        cmake = CMake(self)
        cmake.configure()
        cmake.build()
        cmake.install()
