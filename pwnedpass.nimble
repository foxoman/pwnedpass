# Package based on pwned by "Dominik Picheta"

version       = "1.0.0"
author        = "Sultan AlIsaee"
description   = "A client for the Pwned passwords API."
license       = "MIT"
srcDir        = "src"
bin           = @["pwnedpass"]

skipExt = @["nim"]

# Dependencies

requires "nim >= 1.6.0"
requires "puppy"
requires "termui"
