---
sidebar_label: 'C 语言调用 Python'
sidebar_position: 2
slug: /c-call-python-code
draft: true
---

# C 语言调用 Python

我们知道 Python 的解析器 CPython 就是使用 C 语言实现的，因此 C 程序天生就可以调用 Python 代码。

## C 调用 Python 的方法

实际上，在 C 程序中调用 Python 有多种方式，比较常见的方法包括：

- **使用 Python C API**：Python 提供了一个 C API，允许你在C程序中嵌入和扩展Python。你可以使用这个API来调用Python函数、操作Python对象和与Python交互。这是一种强大的方式，但也需要一定的C编程经验。
- **使用 ctypes 库**：ctypes 是一个 Python 标准库，允许你在 C 程序中调用动态链接库（dll 或 so 文件）中的函数。你可以使用 ctypes 来调用 Python 的 C 扩展模块，这些模块通常以共享库的形式存在。这种方法比较简单，不需要深入了解 Python C API 即可实现 C 与 Python 的交互。
- **使用 SWIG**（Simplified Wrapper and Interface Generator）：SWIG 是一个工具，可以自动生成 C/C++ 和其他编程语言之间的封装代码。你可以使用 SWIG 来生成 C 代码，使你能够在 C 程序中调用 Python 代码。
- **使用 Boost.Python**：Boost.Python 是一个 C++ 库，允许你将 C++ 代码与 Python 集成得更加紧密。虽然它主要针对 C++，但也可以在 C 程序中使用。
- **使用 Python 的 subprocess 模块**：你可以使用 Python 的 subprocess 模块在 C 程序中启动 Python 解释器，并通过标准输入和输出与 Python 交互。这是一种相对简单的方法，但不够高效，因为它涉及到了进程间通信。
- **使用 IPC 机制**：你可以使用 IPC（Inter-Process Communication）机制，如管道、套接字或共享内存，实现在 C 程序和 Python 程序之间传递数据和命令。这需要你编写额外的通信代码，但可以实现高度的自定义和控制，[ROS](/ros/)（机器人操作系统）就是采用这种方式实现跨语言编程的。

选择哪种方法取决于你的具体需求和技能水平。如果你需要紧密集成 C 和 Python，那么 Python C API 可能是最强大的方式。而如果你只需要在 C 程序中调用一些 Python 函数，那么 ctypes 或 subprocess 等方法可能更简单。

本文将以 Python C API 为例，介绍如何在 C 程序中调用 Python 代码，包括直接嵌入 Python 代码、导入 Python 函数以及导入 Python 脚本等多种方法。



## 直接执行 Python 代码

In this Article, we will discuss the following topics:

- Getting the Python C/C++ API for working.
- Initialize and Destroy a Python environment.
- Running a Simple inline Python code from C/C++.
- Running a Simple Python program from file from C/C++ program.
- Call a Python method from C/C++.
- Call a C/C++ function from Python code.
- Why are we doing this???? (Points of Interest)

```c showLineNumbers title="c_run_python.c"
#define PY_SSIZE_T_CLEAN
#include <Python.h>

int main(void)
{
    Py_Initialize();

    /* run the python code */
    PyRun_SimpleString("from time import time,ctime\n"
                       "print('Today is', ctime(time()))\n");

    Py_Finalize();
    return 0;
}
```

运行结果：

```bash
$ ./c_run_python 
Today is Wed Oct 25 17:43:59 2023
```



## 导入 Python 函数调用

```c showLineNumbers title="c_call_python.c"
#define PY_SSIZE_T_CLEAN
#include <Python.h>

int main(int argc, char *argv[])
{
    float num = 100;

    if (argc > 1) {
        num = atof(argv[1]);
    }

    // 初始化 Python 解释器
    Py_Initialize();

    // 导入 math 模块
    PyObject* pModule = PyImport_ImportModule("math");

    if (pModule == NULL) {
        PyErr_Print();
        printf("Failed to import module\n");
    }

    // 获取 math.sqrt() 函数
    PyObject* pFunc = PyObject_GetAttrString(pModule, "sqrt");

    if (pFunc == NULL) {
        PyErr_Print();
        printf("Failed to import function\n");
    }

    // 创建 Python 参数
    PyObject* pArgs = PyTuple_New(1);
    PyTuple_SetItem(pArgs, 0, PyFloat_FromDouble(num));

    // 调用 Python 函数
    PyObject* pResult = PyObject_CallObject(pFunc, pArgs);

    // 处理 Python 函数返回值
    if (pResult != NULL) {
        float result = PyFloat_AsDouble(pResult);
        printf("Result from Python function: %0.2f\n", result);
        Py_DECREF(pResult);
    }

    // 释放 Python 对象
    Py_DECREF(pArgs);
    Py_DECREF(pFunc);
    Py_DECREF(pModule);

    // 清理 Python 解释器
    Py_Finalize();

    return 0;
}
```

运行结果：

```bash
$ ./c_call_python 200
Result from Python function: 14.14
```



## 调用 Python 脚本





## 多线程调用 Python



## 参考

- [Embedding Python program in a C/C++ code](https://www.codeproject.com/Articles/820116/Embedding-Python-program-in-a-C-Cplusplus-code)
- [Embedding Python in Your C Programs](https://www.linuxjournal.com/article/8497)
- [Extending Python with C or C++](https://docs.python.org/3/extending/extending.html)

