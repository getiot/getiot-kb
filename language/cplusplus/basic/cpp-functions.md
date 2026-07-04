---
sidebar_position: 16
slug: /cpp-functions
---

# C++ 函数



函数（function）是一块独立的程序代码序列（code sequence），通常用于执行一些特定功能的运算。函数包含四个部分，即返回值类型（return type）、函数名称、参数列表（parameter list），以及函数体（function body）。

C++ 的函数可以分为：自定义函数和系统函数。在程序中，编写函数的主要目的是将一个需要很多行代码的复杂问题分解为一系列简单的任务来解决，而且同一个任务（函数）可以被多次调用，有助于代码重用。



## 什么是函数

我们可以将函数理解为完成某一功能的程序指令（语句）的集合。例如，我们写一个求两个 `int` 类型变量 `x` 和 `y` 中较大者的语句，如下：

```cpp showLineNumbers
int x = 128;
int y = 127;
int z;

if ( x > y )
    z = x;
else
    z = y;
```

如果我们此时还要求另外两个 `int` 类型变量 `a` 和 `b` 中较大者，可能写法如下：

```cpp showLineNumbers
int x = 128;
int y = 127;
int z;

if ( x > y )
    z = x;
else
    z = y;


int a = 255;
int b = 256;
int c;

if ( a > b )
    c = a;
else
    c = b;
```

多复杂啊，重复的代码写了一遍又一遍，能否复用下面这段代码呢？

```cpp showLineNumbers
int z;

if ( x > y )
    z = x;
else
    z = y;
```

答案是可以的，只要把这些语句封装成一个函数，就能实现复用的梦想。

封装一个函数，包括两部分：

1. 函数 **声明** 告诉编译器函数的名称、返回类型和参数，这个是可选的；
2. 函数 **定义** 提供了函数的实际主体，这个是必须的。



## 定义函数

C++ 中，函数由一个函数头和一个函数主体组成。其一般形式如下：

```cpp showLineNumbers
return_type function_name( parameter list )
{
   // body of the function
}
```

**`return_type` 返回类型**

- 一个函数可以返回一个值；
- return_type 是函数返回的值的数据类型；
- 有些函数执行所需的操作而不返回值，在这种情况下，`return_type` 是关键字 `void`。

**`function_name` 函数名**

- 这是函数的实际名称（标识符）；
- 函数名和参数列表一起构成了函数签名。

**`parameter list` 参数**

- 参数就像是占位符；
- 当函数被调用时，需要向参数传递一个值，这个值被称为实际参数；
- 参数列表包括函数参数的类型、顺序、数量；
- 参数是可选的，也就是说，函数可能不包含参数。

**`body of the function` 函数主体**

- 函数主体包含一组定义函数执行任务的语句。

下面通过一段代码演示如何定义一个函数。我们定义的函数名叫 `max`，它有两个 `int` 类型的参数 num1 和 num2，会返回这两个数中较大的那个数。

```cpp showLineNumbers
int max(int num1, int num2) 
{
   // 局部变量声明
   int result;

   if (num1 > num2)
      result = num1;
   else
      result = num2;

   return result; 
}
```



## 函数声明

函数声明的作用是告诉编译器函数名称及如何调用函数。函数的实际主体可以单独定义（只能定义一次，但可以声明多次）。

声明一个函数的一般语法格式如下：

```cpp showLineNumbers
return_type function_name( parameter list );
```

1. `return_type` 是函数的返回值类型
2. `function_name` 是函数的名称，必须是一个合法的 C++ 标志符
3. `parameter list` 是函数的参数列表

例如我们想声明一个叫 `max` 的函数，通过传递两个 `int` 类型的参数 `x`,`y`，返回 `x`,`y` 中的较大者，因为 `x`,`y` 是 `int` 类型，那么返回值类型也为 `int`。

以下是 `max` 的函数声明：

```cpp showLineNumbers
int max(int x, int y);
```

在函数声明中，参数的名称并不重要，只有参数的类型是必需的，因此下面也是有效的声明。

```cpp showLineNumbers
int max(int a, int b);
int max(int,int);
```

在一个源文件中定义函数且在另一个文件中调用函数时，函数声明是必需的。在这种情况下，应该在调用函数的文件顶部声明函数。



## 调用函数

C++ 声明和定义函数时，会定义函数做什么，然后通过调用函数来完成已定义的任务。

- 当程序调用函数时，程序控制权会转移给被调用的函数。
- 被调用的函数执行已定义的任务，当函数的返回语句被执行时，或到达函数的结束括号时，会把程序控制权交还给主程序。
- 调用函数时，传递所需参数，如果函数返回一个值，则可以存储返回值。

示例：函数调用

```cpp showLineNumbers
#include <iostream>
using namespace std;

// 函数声明
int max(int num1, int num2);

int main(void)
{
    // 局部变量声明
    int a = 128;
    int b = 127;
    int ret;

    // 调用函数来获取最大值
    ret = max(a, b);
    std::cout << "Max value is : " << ret << std::endl;
    return 0;
}

// 函数返回两个数中较大的那个数
int max(int num1, int num2) 
{
    // 局部变量声明
    int result;

    if (num1 > num2)
        result = num1;
    else
        result = num2;

    return result; 
}
```

编译和运行以上示例，输出结果如下：

```bash
Max value is : 128
```



## 函数参数

如果函数要使用参数，则必须声明接受参数值的变量，这些变量称为函数的 **形式参数**（Formal parameters）。形式参数就像函数内的其它局部变量，在进入函数时被创建，退出函数时被销毁。

当调用 C++ 函数时，有三种向函数传递参数的方式：

| 调用类型 | 描述                                                         |
| -------- | ------------------------------------------------------------ |
| 传值调用 | 把参数的实际值复制给函数的形式参数。<br/>在这种情况下，修改函数内的形式参数对实际参数没有影响。 |
| 指针调用 | 把参数的地址复制给形式参数。<br/>在函数内，该地址用于访问调用中要用到的实际参数（修改形式参数会影响实际参数）。 |
| 引用调用 | 把参数的引用复制给形式参数。<br/>在函数内，该引用用于访问调用中要用到的实际参数（修改形式参数会影响实际参数）。 |

默认情况下，C++ 使用 **传值调用** 来传递参数，这意味着函数内的代码不能改变用于调用函数的参数。



## 参数的默认值

定义一个函数时，可以为参数列表中后边的每一个参数指定默认值。参数的默认值是通过在函数定义中使用赋值运算符来为参数赋值的。

调用 C++ 函数时，如果未传递参数的值，则会使用默认值；如果指定了值，则会忽略默认值，使用传递的值。

```cpp showLineNumbers
#include <iostream>
using namespace std;

int sum(int a, int b = 64 )
{
    return ( a + b );
}

int main ()
{
    // 局部变量声明

    int a = 128;
    int b = 256;
    int result;

    // 调用函数计算和

    result = sum(a, b);
    std::cout << "sum( a + b ) = " << result << std::endl;

    // 再次调用函数
    result = sum(a);
    std::cout << "sum( a ) = " << result << std::endl;

    return 0;
}
```

编译和运行以上示例，输出结果如下：

```cpp showLineNumbers
sum( a + b ) = 384
sum( a ) = 192
```

:::tip

如果函数声明和函数定义分开的情况，不能在同时在声明和定义中设置参数默认值，否则会出现类似 “error: default argument given ...” 的错误。建议将默认参数统一放在函数声明的参数列表中。

:::

