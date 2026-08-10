-- .luacheckrc
std = "max+love"

-- Ignore all files in the lib and build directories
exclude_files = {
  "lib/",
  "build/"
}

-- Allow the use of the global variable LUA_VERSION, which is defined in main.lua
globals = {
  "LUA_VERSION",
  "Game"
}

-- Silence warnings about unused arguments in LÖVE callbacks (e.g., dt)
ignore = {
  "611", -- Blank lines at the end of a file
  "612", -- Spaces at the end of a line of code
  "614", -- Spaces at the end of a comment
  "631", -- LLines of code that are too long
  "211", -- Variables created but never used
  "241", -- Variables modified but never read
  "311", -- Assigned values that are never used
  "212", -- Unused arguments in LÖVE callbacks (e.g., dt)
}