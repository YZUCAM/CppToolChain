# C++ tool chains ---- CMake + Vcpkg

## Introduction
The year is now 2025, and Python has become the trendy programming language. For many people, Python is their very first language. However, it seems that the C++ wave is making a comeback. In fact, C++ is still dominated in the industry environment which requires high performance, such as quantitative finance in New York and London. In the comptitive finance field, fast developing risk and pricing model in python and then deploying it using C++ for ultrafast performance is a modern trend. Therefore, C++ is still a highly required skill for quant researcher and quant analyst. 

Unlike interpreted language of Python, C++ is a static compiled language. How to compile cpp and hpp file whatever for your own code or other beautiful third party libraries becomes a very first challenge for every new beginners. Thus, it indirecly causes learner choose other easier language like python. However, if you get used to C++ compiling operations, you will immediately love this language. If you want to me say why choose C++. I would say: Fast is nothing, but it is everything. I have been working in the research environment, for anything needs real time data processing, trust me, C++ performs way better than Python.

To help overcome the barrier of C++ compiling diffculty, we choose CMake for build makefile for compiler and Vcpkg for c++ external libraries management. 

## Usage
cmake_instruction.md document records template for writing a standard cmake file. It has been splitted into two sections.<br><br> The first basic section quickly guides how to write a cmake file. For people who are dealing with their small c++ project, it is enough for quick get your file compiled.<br><br>
The second advanced section introduced building blocks when you use cmake as script mode. This mode could provide you more flexibility when you are dealing with super large project.<br><br>

## Acknowlegement
I appreciate the Daniel Gakwaya for providing a very inspiring tutorial series for CMake-Episode on YouTube. Most of contents in this instruction are summarized from his YouTube Series. Strongly recommend to take a look on his original videos. There are much more explanations on CMake and other interesting topics. <br>
https://www.youtube.com/watch?v=rHjZrJmFyBQ&list=PLQMs5svASiXOraccrnEbkd_kVHbAdC2mp&index=1