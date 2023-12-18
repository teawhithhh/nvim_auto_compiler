# nvim_auto_compiler
cxx / py auto compiler plugin

example config for cxx + py

```cpp
local auto_compiler = require('auto_compiler')


local cxx_command_template = 'C:\\msys64\\ucrt64\\bin\\g++.exe -std=c++23 -fmodules-ts -Wall -Wextra -Wpedantic %s -g %s -o %s/%s.exe'
local cxx_flags = '-Wctor-dtor-privacy -Wnon-virtual-dtor -Wold-style-cast -Woverloaded-virtual -Wsign-promo -Wduplicated-branches -Wduplicated-cond -Wfloat-equal -Wshadow=compatible-local -Wcast-qual -Wconversion -Wzero-as-null-pointer-constant -Wextra-semi -Wsign-conversion -Wlogical-op'
local cxx_build_bat = 'build.bat'

local py_command_template = 'C:\\Users\\240821\\scoop\\apps\\python\\current\\python.exe %s'

auto_compiler.setup(
	cxx_command_template,
	cxx_flags,
	cxx_build_bat,
	py_command_template
)
```
