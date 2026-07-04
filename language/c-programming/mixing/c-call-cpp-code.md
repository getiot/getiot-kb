---
sidebar_position: 1
slug: /c-call-cpp-code
---

# C 语言调用 C++



## 基本概念

在实际应用中，在 C 语言中调用 C++ 代码并是不很常见的做法，更常见的是 C++ 调用 C 函数库。虽然 C 和 C++ 是近亲关系，但实际上，在 C 语言中并不能直接调用 C++ 函数库，需要先将 C++ 库转换成 C 接口输出，才可以被 C 程序调用。

主要原因是 C 编译器编译函数时不带参数的类型信息，只包含函数的符号名字，而 C++ 编译器为了实现函数重载，会在编译时带上函数的参数信息，因此 C++ 导出的符号在 C 中无法识别。



## 调用 C++ 函数

下面通过一个简单的示例演示如何在 C 中调用 C++ 函数，完整示例代码可在 [GitHub](https://github.com/getiot/linux-c/tree/main/mixing/cpp/simple) 找到。

### 示例代码

在这个示例中，一共包含 3 个文件，example.cpp、example.h 和 main.c。

在 example.cpp 文件中定义一个 C++ 函数 printMessage，它会通过 C++ 的标准输出接口打印一句话。

```cpp showLineNumbers title="example.cpp"
#include <iostream>

void printMessage()
{
    std::cout << "Hello from C++ function!" << std::endl;
}
```

example.h 文件用于声明 printMessage 函数。

```cpp showLineNumbers title="example.h"
#ifndef __EXAMPLE_H__
#define __EXAMPLE_H__

void printMessage();

#endif /* __EXAMPLE_H__ */
```

然后在 main.c 中包含 example.h 文件，调用 C++ 的 printMessage 函数。

```c showLineNumbers title="main.c"
#include "example.h"

int main()
{
    printMessage();
    return 0;
}
```

### 编译运行

先使用 g++ 将 example.cpp 编译成 .o 文件，命令如下：

```bash
g++ -c example.cpp
```

再使用 gcc 编译 main.c，并链接 example.o 目标文件和 stdc++ 库。

```bash
gcc main.c -o example example.o -lstdc++
```

但此时未能编译成功，出现类似下面的错误：

```bash
/usr/bin/ld: /tmp/ccqtqdmv.o: in function `main':
main.c:(.text+0xe): undefined reference to `printMessage'
collect2: error: ld returned 1 exit status
```

原因是 C++ 导出的函数符号在 C 中无法识别，你可以使用 [`nm`](/linux-command/nm/) 命令来查看 example.o 的符号：

```bash {2-3}
$ nm example.o | grep printMessage
0000000000000080 t _GLOBAL__sub_I__Z12printMessagev
0000000000000000 T _Z12printMessagev
```

可以看到，函数名 `printMessage` 被扩展成了 `_Z12printMessagev`。解决办法是在 C++ 中使用 `extern "C"` 声明 printMessage 函数。

在 example.cpp 文件中增加如下一行代码：

```cpp showLineNumbers title="example.cpp"
#include <iostream>

// highlight-next-line
extern "C" void printMessage();

void printMessage()
{
    std::cout << "Hello from C++ function!" << std::endl;
}
```

修改后重新编译目标文件：

```bash
g++ -c example.cpp
```

再次查看 example.o 的符号表信息：

```bash {2-3}
$ nm example.o | grep printMessage
0000000000000080 t _GLOBAL__sub_I_printMessage
0000000000000000 T printMessage
```

可以看到，函数符号发生了变化。现在，可以编译 main.c 文件了！

```bash
gcc main.c -o example example.o -lstdc++
```

编译成功后会生成 example 可执行文件，运行结果如下：

```bash
$ ./example 
Hello from C++ function!
```




## 调用 C++ 类成员函数

下面我们创建一个类，演示如何在 C 中调用 C++ 的类成员函数。和前面的例子不同，如果你想要在 C 中调用 C++ 的成员函数（包括虚函数），需要提供一个简单的包装（wrapper）。

下面我们一起来看看如何达到这一目的，完整示例代码可在 [GitHub](https://github.com/getiot/linux-c/tree/main/mixing/cpp/class) 找到。

### 示例代码

首先还是创建 example.h 文件中定义一个 C++ 类函数 MyClass，它有一个成员函数 printMessage。

```cpp showLineNumbers title="example.h"
#ifndef __EXAMPLE_H__
#define __EXAMPLE_H__

class MyClass
{
public:
    void printMessage();
};

#endif /* __EXAMPLE_H__ */
```

printMessage 函数的定义在 example.cpp，它要做的事情很简单，就是使用 C++ 的标准输出接口打印一句话。

```cpp showLineNumbers title="example.cpp"
#include "example.h"
#include <iostream>

void MyClass::printMessage() 
{
    std::cout << "Hello from C++ class!" << std::endl;
}
```

接下来，创建一个 example_wrapper.h 文件，在这个文件中，需要使用 `extern "C"` 包裹所有声明，以便 C 能够识别这些符号。

```cpp showLineNumbers title="example_wrapper.h"
#ifndef __EXAMPLE_WRAPPER_H__
#define __EXAMPLE_WRAPPER_H__

#ifdef __cplusplus
extern "C" {
#endif

struct MyClass;

struct MyClass* createMyClass();
void callPrintMessage(struct MyClass* obj);
void destroyMyClass(struct MyClass* obj);

#ifdef __cplusplus
}
#endif

#endif /* __EXAMPLE_WRAPPER_H__ */
```

因为 C 中没有类的概念，因此这里需要使用 `struct MyClass;` 声明，并将 `MyClass` 类的功能封装成 C 的接口。

- `createMyClass` 函数的作用是创建一个 MyClass 类实例；
- `callPrintMessage` 函数的作用是调用 MyClass 类中的成员函数 printMessage；
- `destroyMyClass` 函数的作用是销毁 MyClass 类对象。

这些函数的实现在包装器文件 example_wrapper.cpp 中，实现了 C 函数来调用这个 C++ 类的功能。

```cpp showLineNumbers title="example_wrapper.cpp"
#include "example.h"

extern "C" {
    struct MyClass* createMyClass() {
        return new MyClass();
    }

    void callPrintMessage(struct MyClass* obj) {
        obj->printMessage();
    }

    void destroyMyClass(struct MyClass* obj) {
        delete obj;
    }
}
```

最后，在 main.c 文件中调用 example_wrapper 封装的功能，创建 MyClass 对象，并调用 MyClass 对象的 printMessage 函数。

```c showLineNumbers title="main.c"
#include "example_wrapper.h"

int main()
{
    // Create an instance of the C++ class
    struct MyClass* obj = createMyClass();

    // Call the C++ member function from C
    callPrintMessage(obj);

    // Destroy the C++ class instance
    destroyMyClass(obj);

    return 0;
}
```



### 编译运行

首先编译 C++ 文件 example.cpp，生成目标文件 example.o：

```bash
g++ -c example.cpp
```

然后编译包装器文件 example_wrapper.cpp，生成目标文件 example_wrapper.o：

```bash
g++ -c example.cpp example_wrapper.cpp
```

最后编译 main.c 文件，链接 example.o 和 example_wrapper.o 目标文件：

```bash
gcc main.c -o example example.o example_wrapper.o -lstdc++
```

编译成功后会生成 example 可执行文件，运行结果如下：

```bash
./example
Hello from C++ class!
```

