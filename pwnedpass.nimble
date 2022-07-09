# Package based on pwned by "Dominik Picheta"

version       = "2.0.5"
author        = "Sultan AlIsaee"
description   = "A client and api for the Pwned passwords API."
license       = "MIT"
srcDir        = "src"
bin           = @["pwnedpass"]
installExt    = @["nim"]

# Dependencies

requires "nim >= 1.6.0"
requires "puppy"
requires "termui"
