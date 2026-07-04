---
sidebar_position: 23
slug: /cpp-input-output
---

# C++ 标准输入输出

在 C 语言中，使用 scanf 和 printf 等函数来对数据进行输入输出操作。我们依然能在 C++ 中使用 C 语言的这一套输入输出库，但是 C++ 又提供更容易使用的输入输出库（iostream、iomanip、fstream）。

C++ 的 I/O 发生在流中，流是字节序列。如果字节流是从设备（如键盘、磁盘驱动器、网络连接等）流向内存，则是输入操作。如果字节流是从内存流向设备（如显示屏、打印机、磁盘驱动器、网络连接等），则是输出操作。



## C++ I/O 库头文件

先来理解几个 I/O 输入输出概念：

- 对系统指定的标准设备的输入和输出（即从键盘输入数据，输出到显示器屏幕）称为标准的输入输出，简称 **标准 I/O**。
- 以外存磁盘文件为对象进行输入和输出（即从磁盘文件输入数据，数据输出到磁盘文件）称为文件的输入输出，简称 **文件 I/O**。
- 对内存中指定的空间进行输入和输出（通常指定一个字符数组作为存储空间）称为字符串输入输出，简称 **串 I/O**。

针对 I/O 操作的差异，C++ 提供了三个头文件用于处理 I/O，具体如下表：

| 头文件       | 函数和描述                                                   |
| ------------ | ------------------------------------------------------------ |
| `<iostream>` | 该文件定义了 cin、cout、cerr 和 clog 对象，分别对应于标准输入流、标准输出流、非缓冲标准错误流和缓冲标准错误流。 |
| `<iomanip>`  | 该文件通过所谓的参数化的流操纵器（比如 setw 和 setprecision），来声明对执行标准化 I/O 有用的服务。 |
| `<fstream>`  | 该文件为用户控制的文件处理声明服务。我们将在文件和流的相关章节讨论它的细节。 |



## cout 标准输出

`cout`（读作 see out）对象可用于在计算机屏幕上显示信息，程序可以显示的最简单的屏幕输出类型是控制台输出，它只是纯文本。`cout` 是 iostream 类的一个实例。`cout` 是与流插入运算符 `<< ` 结合使用的。

`cout` 定义在命名空间 `std` 当中，所以一般的使用方法是 `std::cout`，或者在开头添加一行 `using namespace std;` 使 std 命名空间的所有标识符对本源文件可见。

示例：

```cpp showLineNumbers
#include <iostream>
using namespace std;

int main(void)
{
    std::cout << "C++ " << std::endl;
    cout << "getiot.tech " << "is GetIoT" << endl;
    return 0;
}
```

使用 `g++ main.cpp && ./a.out` 命令编译和运行代码，输出结果如下：

```bash
C++ 
getiot.tech is GetIoT
```

**注意**：流插入运算符 `<<` 在一个语句中可以多次使用。`endl` 用于添加一个换行符。



## cin 标准输入

`cin`（读作 see in）对象可用于从键盘获取用户输入，程序中可以获取用户输入信息。`cin` 是 iostream 类的一个实例。`cin` 是与流提取运算符 `>>` 结合使用的。

```cpp showLineNumbers
#include <iostream>
using namespace std;

int main(void)
{
    char a;
    int b;
    float c;
    cin >> a >> b >> c;
    cout << a << " " << b << " " << c << " " << endl;
    return 0;
}
```

**注意**：流提取运算符 `>>` 在一个语句中可以多次使用，获取输入的多个数据。



## cerr 标准错误

`cerr` 是 iostream 类的一个实例。`cerr`不经过缓冲而直接输出，一般用于迅速输出出错信息，是标准错误，默认情况下被关联到标准输出流，但它不被缓冲，也就说错误消息可以直接发送到显示器，而无需等到缓冲区或者新的换行符时，才被显示。`cerr` 也是与流插入运算符 `<<` 结合使用的。

示例：

```cpp showLineNumbers
#include <iostream>
using namespace std;

int main(void)
{
    cout << "cout" << endl;
    cerr << "cerr" << endl;
    return 0;
}
```



## clog 标准日志流

`clog` 是 `cerr` 的缓冲版本。对于 `cout` 和 `cerr` 及 `clog` 都是 C++ 内置的输出流。如果你用 `clog` 来输出的话，则隐含的信息就是你输出的是错误信息。

`clog` 对象是缓冲的，这意味着每个流插入到 `clog` 都会先存储在缓冲区，直到缓冲填满或者缓冲区刷新时才会输出。同样，`clog` 也是与流插入运算符 `<<` 结合使用的。

示例：

```cpp showLineNumbers
#include <iostream>
using namespace std;

int main(void)
{
    char str[] = "An error occurred";
    clog << "Error message: " << str << endl;
    return 0;
}
```

使用 `g++ main.cpp && ./a.out` 命令编译和运行代码，输出结果如下：

```bash
Error message: An error occurred
```

