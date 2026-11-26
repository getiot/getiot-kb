---
sidebar_position: 12
authors: [luhuadong]
---

# RT-Thread C++ 编程



网络上讲RT-Thread 是C 语言编写的，但是应用程序可以使用C++ 来开发。但是网络上好像找不到说明和例子。只能自己测试：

1. 使用RT-Thread studio 开发工具
2. 在RT-thread Settings 中勾选 C++ 特性支持。支持 libc。
3. 项目中的所以程序必须使用cpp和hpp 后缀。当判别到cpp时，studio 才会使用g++ 编译器编译C++，要不然连class 都不认识。特别是main.c 要改成main.cpp







