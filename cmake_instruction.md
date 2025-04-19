# CMake Tutorial
<div align="right">
By Dr.Yi Zhu 19-Apr-2025
</div>

## Install cmake in your os system

## Manage your C++ project file directory
```
In a c++ project,
project folder
|____ build
|____ source
        |____ include
                |____ header.h
        |____ src
                |____ implementation.cpp
        |____ main.cpp
        |____ CMakeLists.txt
```
## Write CMakeLists.txt
```
cmake_minimum_required(VERSION 3.5)
project(employee_system
        VERSION 0.0.1 
        DESCRIPTION "first employee managerment system for practice CMake tool"
        LANGUAGES CXX)

# # Globing feature (Second way to do it)
# file(GLOB_RECURSE SOURCE_FILES src/*.cpp)
# add_executable(EmpManApp employee_management.cpp ${SOURCE_FILES})

# Target
add_executable(EmpManApp employee_management.cpp src/boss.cpp src/employee.cpp 
                src/manager.cpp src/workerManager.cpp)
target_compile_features(EmpManApp PRIVATE cxx_std_17)
target_include_directories(EmpManApp PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/include)

```

## CMake common used commands
cd to build folder directory<br> 
Build files can store in this folder<br>
1. cmake generate default builder<br>
   `cmake ../source`

2. cmake generate specific builder<br>
   `cmake -G Ninja ../source`

After generated builder in build folder, use command build project (compile)
1. cmake default build<br>
   `make`<br> 
   or <br>
   `ninja`
2. cmake unitary build operation (general to any builder, it will automatically find build command for different builder)<br>
cd to build folder directory<br>
`cmake --build . `

## CMake choose specific compiler
In different system, there might be different c++ compiler you want to use. CMake can assign specific compiler for the job.<br>
`cmake -G Ninja -D CMAKE_CXX_COMPILER=g++ ../source`

### Above are info of building project as a single excutable target
 ---
 ## Library Targets
 