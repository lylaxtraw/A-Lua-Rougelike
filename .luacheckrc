-- .luacheckrc
std = "max+love"

-- Ignore all files in the lib and build directories
exclude_files = {
  "lib/",
  "build/"
}

-- Allow the use of the global variable LUA_VERSION, which is defined in main.lua
globals = {
  "LUA_VERSION"
}

-- Silence warnings about unused arguments in LÖVE callbacks (e.g., dt)
ignore = {
  "212", -- Argumentos no usados en callbacks de LÖVE (ej. dt)
}