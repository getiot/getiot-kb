---
sidebar_position: 6
slug: /cpp-variables
---

# C++ 变量



C++ 中每个变量都有指定的类型，类型决定了变量存储的大小和布局，该范围内的值都可以存储在内存中，运算符可应用于变量上。我们可以把变量理解为程序可操作的某个存储区域的别名。

前面已经介绍了 [C++ 数据类型](/cplusplus/cpp-data-types/)，本文将进一步讲解如何定义、声明和使用各种类型的变量。

![](https://static.getiot.tech/cpp-variables-definition.png#center)



## C++ 中的变量定义

变量定义就是告诉编译器在何处创建变量的存储，以及如何创建变量的存储。 变量定义指定一个数据类型，并包含了该类型的一个或多个变量的列表。

### 定义变量

C++ 中变量定义的语法如下：

```cpp showLineNumbers
type variable_list;
```

其中：

- **type** 必须是一个有效的 C++ 数据类型，比如 char、wchar_t、int、float、double、bool 或其他任何用户自定义的对象；
- **variable_list** 可以由一个或多个标识符名称组成，多个标识符之间用逗号分隔。

下面是几个有效的声明：

```cpp showLineNumbers
int    i, j, k;
char   c, ch;
float  f, salary;
double d;
```

### 变量初始化

我们可以在声明变量的同时给它指定一个初始值，这个动作也称为初始化。初始化器由一个等号，后跟一个常量表达式组成，语法格式如下：

```cpp showLineNumbers
type variable_name = value;
```

下面是各种类型变量的初始化示例：

```cpp showLineNumbers
extern int d = 3, f = 5;    // d 和 f 的声明 
int d = 3, f = 5;           // 定义并初始化 d 和 f
byte z = 22;                // 定义并初始化 z
char x = 'x';               // 变量 x 的值为 'x'
```

### 默认初始化

全局变量或使用 `static` 修饰的变量会被隐式初始化为 `NULL` ，即所有字节的值都是 0。不过，建议大家养成变量初始化的良好编程习惯。



## C++ 中的变量声明

在 C++ 中，我们可以使用 `extern` 关键字在任何地方声明一个变量。当我们使用多个文件且只在其中一个文件中定义变量时（定义变量的文件在程序连接时是可用的），变量声明就显得非常有用。

变量声明只在编译时有它的意义，在程序连接时编译器需要实际的变量声明。变量声明需要（程序员）向编译器保证变量以给定的类型和名称存在，这样编译器在不需要知道变量完整细节的情况下也能继续进一步的编译。

**虽然我们可以在 C++ 程序中多次声明一个变量，但变量只能在某个文件、函数或代码块中被定义一次。**

示例：变量的声明和初始化

```cpp showLineNumbers
#include <iostream>
using namespace std;

//变量声明
extern int a, b, c;
extern float f;

int main ()
{
    // 变量定义
    int a, b, c;
    float f;

    // 实际初始化
    a = 10;
    b = 20;
    c = a + b;

    cout << c << endl ;

    f = 20.0/3.0;
    cout << f << endl ;

    return 0;
}
```

编译运行上面的程序，输出结果如下：

```cpp showLineNumbers
$ ./a.out 
30
6.66667
```



## 左值和右值

C++ 中有两种类型的表达式：

- **左值（lvalue）表达式：** 指向内存位置的表达式被称为左值表达式。左值可以出现在赋值号的左边，也可以出现在赋值号的右边。
- **右值（rvalue）表达式：** 指的是存储在内存中某些地址的数值。右值是不能对其进行赋值的表达式，也就是说，右值可以出现在赋值号的右边，但不能出现在赋值号的左边。

我们前面说到，变量是程序可操作的某个存储区域的别名。显然，变量是左值，因此可以出现在赋值号的左边。而数值型的字面值、字符常量、宏定义等不能被赋值，因此只能作为右值，不能出现在赋值号的左边。

下面的赋值语句都是有效的。

```cpp showLineNumbers
#define VALUE  10
int val;
val = 20;
val = VALUE;
```

但是下面这些就不是有效的语句，编译时会出现错误。

```cpp showLineNumbers
#define VALUE  10
int val;
VALUE = val;
VALUE = 20;
```

