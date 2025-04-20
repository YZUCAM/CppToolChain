# Vcpkg Tutorial 
<div align="right">
By Dr.Yi Zhu 19-Apr-2025
</div>

## install Vcpkg
check web:<br>
https://learn.microsoft.com/en-us/vcpkg/get_started/get-started?pivots=shell-bash

## Tell CMake to use vcpkg
In the CMakeLists.txt, need write command to let CMake know it will use vcpkg<br>
eg part of CMakeLists.txt content:<br>
```
cmake_minimum_required(VERSION 3.20)

set(CMAKE_TOOLCHAIN_FILE $ENV{VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake)

project(Dependencies) 
```

## configure vcpkg.json
Create a vcpkg.json in the same directory of your main CMakeLists.txt<br>
eg:<br>
```
{
    "name": "manageApp",
    "version-string": "0.1.0",
    "dependencies: [
        "eigen3",
        "fmt",
        "fftw3"
    ]
}
```

## Edit CMakeLists.txt to find package
In CMakeLists.txt, you need commands:<br>
```
find_package(Eigen3 CONFIG REQUIRED)
find_package(fmt CONFIG REQUIRED)
find_package(fftw3 CONFIG REQUIRED)
```

## Link against the packages
Link this package to your cpp file and generate executable file:<br>
```
add_executable(useeigen useeigen.cpp)
target_link_libraries(useeigen PRIVATE Eigen3::Eigen)

```

## CMakePresets.json for Vscode
check web:<br>
https://learn.microsoft.com/en-us/vcpkg/get_started/get-started-vscode?pivots=shell-bash

---
# Project Template
Typical project composites:
```
library modules ----> Core -------> main (program entry)
Before main, everything is modulized and can be compiled to libraries and test individually.

Code Editting 
Dependencies 
Formatting      (good habit to organize code unit)
Documentation   (good habit for future distribution)
Testing         
Editor Intergration
```
A good C++ project layout:<br>
https://joholl.github.io/pitchfork-website/

