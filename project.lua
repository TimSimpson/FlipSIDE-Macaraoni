local Path = require "Macaroni.IO.Path"
local cmfw = require "Macaroni.Generators.CMake.CMakeFileWriter"


project = context:Group("Lp3"):Project("NND32"):Version("DEV")

lp3Nnd32 = project:Library{
    name="Lp3NND32",
    shortName="Lp3NND32",
    headers=pathList{"src", "target"},
    sources=pathList{"src", "build/macaroni"},
    usesBoost=true,
}

function generate()
  local cpp = plugins:Get("Cpp")
  cpp:Run("Generate",
          { projectVersion=project, path=filePath("target"), output=output})

  local root = Path.New(getWorkingDirectory());
  cmfw.ProjectInfo(
      project,
      root:NewPathForceSlash("target/macaroni.cmake"))
end
