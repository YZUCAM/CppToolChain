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
 add three lines in CMakeLists.txt
 ```
add_library(libraryname STATIC src/libraryname.cpp)
target_include_directories(libraryname PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)
target_compile_features(libraryname PUBLIC cxx_std_17)
 ```
add link library when you compile main.cpp
```
target_link_libraries(EmpManApp PUBLIC libraryname)
```
compile split into two steps. 1. compile the library file from cpp. 2. compile main.cpp by link library. 

you can even add more library targets. For example, you can add another directory call logger under source. eg: /source/logger/include/ and /source/logger/src/. Then build them seperately.
```
In a c++ project,
project folder
|____ build
|____ source
        |____ include
                |____ header.h
        |____ src
                |____ implementation.cpp
        |____ logger
                |____ include/
                |____ src/
        |____ main.cpp
        |____ CMakeLists.txt
```
```
add_library(logger STATIC logger/src/log.cpp)
target_include_directories(libraryname PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/logger/include)
```
## CMake Variables and Target properities
### you can set cxx standard globally
```
set(CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 17)
```
In this case, you can remove<br>
`target_compile_features(libraryname PUBLIC cxx_std_17)`<br>
from your local target section. 

### build specific target only
Once you use cmake generator your project builder. You can choose only build specific target only by enter target name.<br>
Eg: in your build directory:<br>
`cmake --build . --target logger`

## CMake Target Dependencies
One big project can have multiple .cpp files. A good way is to classify them into different logic block. Even compile them into a library. Assume a library #include some properties (essentially some .cpp files): <br>
- PUBLIC: this library use this properity and other logic block who links this library can have access to this library too.<br>
- PRIVATE: this properity only used by this library.<br>
- INTERFACE: this properity is not used by this library, but this properity can propagate to other logic blick who links to this library.<br>

 eg: math_lib, stats_lib, app
 ```
target_include_directories(math_lib PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/src/maths/include)

target_include_directories(stats_lib PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/src/stats/include)
target_link_libraries(stats_lib PRIVATE math_lib)

target_link_libraries(app PUBLIC stats_lib)
 ```
Both math_lib and stats_lib include themselves from include directory. PUBLIC: they want anyone who use them can inherit all properities from itself.

Now stats_lib link math_lib PRIVATE. Means anyone who use stats_lib can not access anything from math_lib. Stats_Lib only provide interface for app. It avoid app directly access underline function in math_lib.

## Organizing CMake Code 
### include command
CMake file can include other CMake files. So it allows to split big project into smaller ones and then generate builder for cpp compiler.<br>
CMake file has extension '.cmake'. Eg: template of a small cmake file.
```
add_libraries(stats_lib src/stats/stats.cpp)
target_include_directories(stats_lib PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/src/stats/include)
target_link_libraries(stats_lib PRIVATE math_lib)
```
In the main CMakeLists.txt
```
cmake_minimum_required(VERSION 3.5)
project(employee_system
        VERSION 0.0.1 
        DESCRIPTION "first employee managerment system for practice CMake tool"
        LANGUAGES CXX)

# The math library
include(src/maths/maths.cmake)

# The stats library
include(src/stats/stats.cmake)

# The main excutable target
add_executable(app src/main.cpp)
target_link_libraires(app PUBLIC stats_lib)
``` 

### add_subdirectory command


