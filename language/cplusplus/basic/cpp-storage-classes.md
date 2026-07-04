---
sidebar_position: 11
slug: /cpp-storage-classes
---

# C++ 存储类



**存储类** 定义 C++ 程序中标识符（变量或函数）的可见性和生命周期，存储类说明符放置在它们所修饰的类型之前。C++ 中可用的存储类说明符包括：`auto`、`register`、`static`、`extern`、`mutable` 以及 `thread_local`（C++11）。

注意：C++ 11 开始，`auto` 关键字不再是 C++ 存储类说明符，`register` 关键字被弃用。`auto` 被弃用是因为它是默认的存储类说明符，而且用的极少。`register` 被弃用是因为，即使使用了该类型说明符，CPU 也不一定照旧使用。



## auto 存储类

C++ 11 开始，`auto` 关键字用于两种情况：

- 声明变量时根据初始化表达式自动推断该变量的类型；
- 声明函数时函数返回值的占位符。

C++98 标准中，`auto` 关键字用于自动变量的声明，在 C++11 中已删除这一用法。

示例：`auto` 根据初始化表达式自动推断被声明的变量的类型

```cpp showLineNumbers
auto f = 3.1415926;              // double
auto s("hello");                 // const char*
auto z = new auto(9);            // int*
auto x1 = 5, x2 = 5.0, x3= 'r';  // 错误，必须是初始化为同一类型
```



## register 存储类

`register` 存储类用于定义存储在寄存器中而不是内存中的局部变量。它修饰的变量的最大尺寸等于寄存器的大小，且不能对它应用一元的 `&` 运算符，因为它没有内存位置。

```cpp showLineNumbers
{
    register int  miles;
}
```

寄存器只用于需要快速访问的变量，比如计数器。

注意：`register` 并不意味着变量将被存储在寄存器中，它意味着变量可能存储在寄存器中，这取决于硬件和实现的限制。因为这一限制，所以 `register` 被 C++11 弃用也是正常的。



## static 存储类

`static` 存储类指示编译器在程序的生命周期内保持局部变量的存在，而不需要在每次它进入和离开作用域时进行创建和销毁。

- 使用 static 修饰局部变量可以在函数调用之间保持局部变量的值。
- static 修饰符也可以用于修饰全局变量，这会使变量的作用域限制在声明它的文件内。
- 当 static 用在类数据成员上时，会使仅有一个该成员的副本被类的所有对象共享。

**示例：**

```cpp showLineNumbers
#include <iostream>
using namespace std;

void func(void);

static int count = 5;

int main()
{
    while (count--) {
        func();
    }

    return 0;
}

void func( void )
{
    static int i = 5; // 局部静态变量
    i++;
    std::cout << "变量 i 为 " << i ;
    std::cout << " , 变量 count 为 " << count << std::endl;
}
```

编译和运行程序，输出结果如下：

```bash
$ ./a.out
变量 i 为 6 , 变量 count 为 4
变量 i 为 7 , 变量 count 为 3
变量 i 为 8 , 变量 count 为 2
变量 i 为 9 , 变量 count 为 1
变量 i 为 10 , 变量 count 为 0
```



## extern 存储类

`extern` 用来在另一个文件中声明一个全局变量或函数。用于提供一个全局变量的引用，全局变量对所有的程序文件都是可见的。使用 `extern` 时，对于没有初始化的变量，会把变量名指向一个之前定义过的存储位置。

`extern` 修饰符通常用于当有两个或多个文件共享相同的全局变量或函数。当有多个文件且定义了一个可以在其他文件中使用的全局变量或函数时，可以在其他文件中使用 `extern` 来得到已定义的变量或函数的引用。

**示例 ：extern 关键字的使用**

源文件 main.cpp 内容如下：

```cpp showLineNumbers title="main.cpp"
#include <iostream>
using namespace std;

int count ;
extern void write_extern();

int main()
{
    count = 4;
    write_extern();
}
```

源文件 support.cpp 内容如下：

```cpp showLineNumbers title="support.cpp"
#include <iostream>
using namespace std;

extern int count;

void write_extern(void)
{
    std::cout << "Count is " << count << std::endl;
}
```

文件 support.cpp 中的 `extern` 关键字用于声明已经在文件 main.cpp 中定义的 count 变量。

编译源代码

```bash
$ g++ main.cpp support.cpp
```

运行程序，输出结果如下：

```bash
$  && ./a.out
Count is 4
```



## mutable 存储类

`mutable` 说明符仅适用于类的对象，它允许对象的成员替代常量。使用 `mutable` 说明符的成员可以通过 `const` 成员函数修改。



## thread_local 存储类

`thread_local` 说明符声明的变量仅可在它在其上创建的线程上访问。

- 变量在创建线程时创建，并在销毁线程时销毁。
- 每个线程都有其自己的变量副本。
- `thread_local` 说明符可以和 `static` 或 `extern` 一起使用。
- `thread_local` 仅应用于数据声明和定义，不能用于函数声明或定义。

**示例 ：thread_local 说明符的使用**

```cpp showLineNumbers
thread_local int x;                    // 命名空间下的全局变量

class X
{
    static thread_local std::string s; // 类的 static 成员变量
};

static thread_local std::string X::s;  // X::s 是需要定义的

void foo()
{
    thread_local std::vector<int> v;   // 本地变量
}
```

