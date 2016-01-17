local Path = require "Macaroni.IO.Path"

import("Lp3", "Lp3Project", "DEV")
require "Lp3Project"

Lp3Project{
  group="Lp3",
  project="NND32",
  version="DEV",
  src="src",
  target="target",
  libShortName="Lp3NND32",
  dependencies = {
    load("Lp3", "Lp3.Engine.Core", "DEV"):Target("lib"),
    load("Lp3", "Lp3.Engine.Gfx", "DEV"):Target("lib"),
    load("Lp3", "Lp3.Engine.Input", "DEV"):Target("lib"),
  },
};
