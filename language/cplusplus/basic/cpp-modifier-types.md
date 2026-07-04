---
sidebar_position: 10
slug: /cpp-modifier-types
---

# C++ 修饰符类型



在 C++ 中，我们可以在基本数据类型（例如 `char`、`int` 和 `double`）的变量前放置修饰符，用来改变基本类型的含义，以满足各种情境的需求。



## 符号修饰符

C++ 数据类型的符号修饰符有以下几种：`signed`、`unsigned`、`long` 和 `short`。使用说明如下：

- 修饰符 `signed`、`unsigned`、`long` 和 `short` 可应用于整型（int）
- 修饰符 `signed` 和 `unsigned` 可应用于字符型（char）
- `long` 可应用于双精度型（double）
- 修饰符 `signed` 和 `unsigned` 也可以作为 `long` 或 `short` 修饰符的前缀。例如：`unsigned long int`

C++ 允许使用速记符号来声明 **无符号短整数** 或 **无符号长整数** 。因此我们可以不写 int，只写单词 `unsigned`、`short` 或 `unsigned`、`long` ，int 是隐含的。

例如，下面的两个语句都声明了无符号整型变量。

```cpp showLineNumbers
unsigned x;
unsigned int y;
```

运行下面示例，可以帮助理解 C++ 解释有符号整数和无符号整数修饰符之间的差别。

```cpp showLineNumbers
#include <iostream>
using namespace std;

#define NUMBER 49000

int main()
{
    short int i;           // 有符号短整数
    short unsigned int j;  // 无符号短整数

    j = NUMBER;
    i = NUMBER;
    cout << i << " " << j << endl;

    return 0;
}
```

编译运行上面的程序，输出结果如下

```bash
$ ./a.out 
-16536 49000
```

可以看到，同一个数值（49000）赋予有符号短整型变量和无符号短整数变量后表现不一样，有符号短整数被解释为 -16536。



## 限定修饰符

在 C++ 中，常见的存储类别修饰符主要有五个：`const`、`static`、`extern`、`inline` 和 `volatile`。

### const

const 修饰的对象在程序执行期间不能被修改，主要用于定义[常量](/cplusplus/cpp-constants-literals/)。例如：

```cpp showLineNumbers
const int COUNT = 100;
const float PI = 3.1415926;
const float E = 2.7182818;
```

另外一个常见的使用场景是函数的形式参数，例如：

```cpp showLineNumbers
int add(const int a, const int b)
{
    return a + b;
}
```

使用 `const` 修饰形式参数，在一定程度上可以提高程序的健壮性，避免意外修改不应该修改的变量。同时，用 `const` 修饰的参数也能反映出该参数只作为输入值，不用作输出。



### static

static 修饰符放置的位置主要有两个，即语句块（例如函数、循环）的内部和外部。

- 语句块外部：修饰变量或函数时，可改变它们的可见性和链接类型。即采用内部链接，只在本文件内可见。
- 语句块内部：修饰局部变量时，将改变其存储类型和生命周期，使之成为静态的局部变量。该变量只能在函数体内部可见，但在函数体外部也可通过指针实现访问和修改。

另外，`static` 也常用于修饰 C++ 类中的成员。其作用有：

- 设计思路：将和某些类紧密相关的全局变量或函数写在类里面，使其看上去像一个整体，易于理解和维护。
- 访问方式：可以想访问普通成员函数和变量一样通过对象访问，但常直接用 `类名::???` 的方式访问。
- 静态成员变量：必须在类声明体外的某个地方（一般是实现文件`.cpp`）初始化。静态成员变量本质上是全局变量，在类的所有实例对象中共享一份。
- 静态成员函数：本质上是全局函数，并不具体作用于某个对象，不需要对象也可以访问。静态成员函数中不能访问非静态成员变量，也不能调用非静态成员函数。



### extern

extern 修饰符用在变量或者函数的声明前，用来说明“此变量/函数是在别处定义的，要在此处引用”。

被修饰的对象必须是全局可见的变量或函数，也就是说必须在此之前被定义过才能被引用。如果该全局变量被 `static` 修饰过，那么使用 `extern` 修饰也无法引用。

在 C++ 中，`extern` 还有另外一个作用 —— 用于指示 C 或者 C++ 函数的调用规范。

```cpp showLineNumbers
#ifdef __cplusplus
extern "C" {
#endif
 
/*...*/
 
#ifdef __cplusplus
}
#endif
```

这是由于 C++ 和 C 程序中的标识符在编译完成后的目标代码中是不同的，需要用此方法来解决名字匹配的问题。



### inline

inline 通常用于修饰函数，用来建议编译器对一些特殊函数进行内联扩展。也就是说，建议编译器将指定的函数体插入并取代每一处调用该函数的地方（上下文），从而节省了每次调用函数带来的额外时间开支。

函数的调用需要额外的时间，如果函数体比较小（1-5行），可以将函数的调用改成将函数体的代码复制到原来的上下文中，合并了比较小的函数代码，减少了调用的时间成本。以达到优化的目的。如果函数体比较大，编译器会按照普通函数调用进行处理。

示例：

```cpp showLineNumbers
inline int max( int a , int b )
{
    if( a > b )
        return a;
     return b;
}
```



### volatile

volatile 修饰符告诉编译器，该变量的值是随时可能发生变化的，每次使用该变量的时候都必须从其地址中读取。

一般说来，`volatile` 用在如下几个地方：

- 中断服务程序中修改的供其它程序检测的变量需要加 `volatile`。
- 多任务环境下各任务间共享的标志应该加 `volatile`。
- 存储器映射（Memory Mapped）的硬件寄存器通常也要加 `volatile` 说明，因为每次对它的读写都可能有不同的意义。


