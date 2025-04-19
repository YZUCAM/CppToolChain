# CMake Tutorial (Basic)
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
In include command, the .cmake file directory and ${CMAKE_CURRENT_SOURCE_DIR} are not unified, which may polute CMakeLists.txt variables.<br>

add_subdirectory command can unify the path and let program itself looking for CMakeLists.txt files in each directory. <br>
Example of stats_lib, in stats_lib folder, create CMakeLists.txt:
```
add_libraries(stats_lib stats.cpp)
target_include_directories(stats_lib PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)
target_link_libraries(stats_lib PRIVATE math_lib)
```
In this case, you don't need trace back to our Main CMakeLists.txt diretcory and start traversal path. You can directly add path in current directory. 
```
cmake_minimum_required(VERSION 3.5)
project(employee_system
        VERSION 0.0.1 
        DESCRIPTION "first employee managerment system for practice CMake tool"
        LANGUAGES CXX)

# The math library
add_subdirectory(src/maths)

# The stats library
add_subdirectory(src/stats)

# The main excutable target
add_executable(app src/main.cpp)
target_link_libraires(app PUBLIC stats_lib)
```
---
# CMake Tutorial (Advanced)
Previous content is all about using cmake in project level and help to generate builder files. Later use this builder files quickly compile your c++ project.

The next section, it will use cmake in script mode. 

## message commands and arguments
you can print the string when you run CMake, simple application is check cmake ${Variables}.<br>
When use cmake script mode, the file extension is .cmake. It won't generate project file. <br>

Single line:<br>
`message("The text you want to print")`

The script can be run with command:<br>
`cmake -P <script_name>.cmake`

 Multiple lines:
 ```
 message([=[the first line
            the second line
            the third line
            ]=])
```

Multiple arguments:<br>
`message(first_arg;second_arg;third_arg)`

## Variables
Like other script language, you can define your vairable and use it later in the script.

`set(var1 "Text1")`
```
1. variables reference

set(one abc)            #abc
set(two ${one}de)       #abcde
set(three ${two} fg)    #abcde;fg
set(four thre)          #thre
set(five ${${four}e})   #abcde;fg
```
```
2. environment variables
environment variables only affect your local cmake files. It won't affect your global system environment variables

set(ENV{MY_PATH} "/path to directory")
message($ENV{MY_PATH})

but you can read your system environment variable:
message(${MACRO_NAME})
```
```
3. catch variables
set(catch_var "This value" CACHE STRING)
messgae(${catch_var})
```

## List
```
set(stu_lst elem1 elem2 elem3)
set(stu_lst2 elem1;elem2;elem3)

#the first LENGTH indicate calculate how many element
list(LENGTH stu_lst stu_lst_LENGTH)    
message("stu_lst has ${stu_lst_LENGTH} elements)

list(APPEND stu_lst elem4)

#get third element of list stu_lst and store it in ELEMENT
list(GET stu_lst 2 ELEMENT)  

#bool variables
option(<option_variable> "description" [initial_value])
option(OPTIMIZE "need optimization?" ON)
```

## If condition
```
if(VAR1)
    message("VAR1 is True")
else()
    message("VAR1 is FALSE")
endif()

#if variable is not explicity state FALSE, variable is seen as True.
#Do not directly pass TRUE or FALSE to if(). eg:
set(VAR TRUE)
if(${VAR})
    messgae("VAR1 is True")
else()
    message("VAR1 is FALSE")
endif()
#That will give you FALSE result !


# you can use other conditions
eg:
if (2 EQUAL 3)
if (2 LESS 1)
if (2 STRLESS_EQUAL 1)  # equivalent to <=
```

## LOOP
### foreach
```
set(sports "S1" "S2" "S3" "S4" "S5" "S6" "S7")

foreach(item ${sports})
    message("Sport: ${item}")
endforeach()
```

### while
```
set(sports "S1" "S2" "S3" "S4" "S5" "S6" "S7")

list(LENGTH sports num)
set(counter 0)

while(counter LESS num)
    list(GET sports $(counter) item)
    message("Sport:  ${item}")

    math(EXPR counter "${counter} + 1")

endwhile()
```

## functions
```
#passing parameter by value
function(ModifyVariables V1 V2)
    set(${v1} "New value")
    set(${v2} "New value")
endfunction()

#passing parameter by reference (global variable will be changed)
function(ModifyVariables V1 V2)
    set(${v1} "New value" PARENT_SCOPE)
    set(${v2} "New value" PARENT_SCOPE)
endfunction()

#Increment variable
function(IncreVariables V3)
    math(EXPR ${V3} "${${V3}} + 1")
    set(${V3} ${${V3}} PARENT_SCOPE)
endfunction()
```

## macro()
macro() is similar like function. But in macro, all passing parameters or macros will be changed globally.<br>
```
#global variable will be changed

macro(ModifyGlobalVariable V)
    set(${V} "New value")
endmacro()
```

