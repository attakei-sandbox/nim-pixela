# Package

version       = "0.1.0"
author        = "Kazuya Takei"
description   = "Pixe.la client (cli and library)"
license       = "Apache-2.0"
srcDir        = "src"
installExt    = @["nim"]
binDir        = "bin"
bin           = @["pit"]


# Dependencies

requires "nim >= 1.2.0"
requires "cligen >= 1.2.2"
