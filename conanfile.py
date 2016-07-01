from conans import ConanFile, CMake
from conans import tools


class Nnd32Conan(ConanFile):
    name = "Nnd32"
    version = "0.0.4.0"
    requires = ("Boost/1.60.0@lasote/stable",
                "Lp3-Engine/0.0.4.0@TimSimpson/testing")
    settings = "os", "compiler", "build_type", "arch"
    generators = "cmake"

    def imports(self):
       self.copy("*.mh", "", "./")

    def build(self):
        root = self.conanfile_directory
        cmd =  'cavatappi {root} --generate'.format(root=root)

        self.run("cd %s && %s" % (self.conanfile_directory, cmd))
        cmake = CMake(self.settings)
        self.run('cmake %s %s' % (self.conanfile_directory, cmake.command_line))
        self.run("cmake --build . %s" % cmake.build_config)
