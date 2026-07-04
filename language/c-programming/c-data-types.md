---
sidebar_position: 6
---

# C 语言 - 数据类型



C 语言是一门静态类型语言，也就是说，数据类型是在编译其间确定的，或者说在运行之前确定的，因此编写 C 代码时需要声明变量的数据类型。确定数据类型之后，就确定了其在存储中占用多少空间以及如何解释其中的字节。

那么，本节就给大家介绍 C 语言中都有哪些数据类型，以及使用它们的注意事项。



## 概览

C 语言中的数据类型可以分为如下几类：

- **基本类型**：基本类型是用作算术运算的数据类型，可进一步分为**整数**类型和**浮点**类型。
- **枚举类型**：枚举类型也属于算术类型，只不过它们用于定义只能分配某些离散整数值的变量。
- **void 类型**：类型说明符 *void* 表示没有可用值，即空类型。
- **派生类型**：包括**指针**类型、**数组**类型、**结构体**类型、**联合体**类型和**函数**类型。

枚举类型和派生类型我们将在接下来的章节中逐一介绍，包括数组类型、结构体类型、指针等等，这里我们主要介绍基本数据类型。



## 整数类型

C 语言的整数类型包括 char、short、int、long 和 long long 五种，默认是有符号的整数，如果想要声明为无符号整数，需要在前面加上 unsigned 关键字。下表列出了各整数类型及其存储大小和数值范围。

| 类型               | 存储大小    | 数值范围                                   |
| ------------------ | ----------- | ------------------------------------------ |
| char               | 1 字节      | -128 - 127                                 |
| unsigned char      | 1 字节      | 0 - 255                                    |
| int                | 4 字节      | -2,147,483,648 - 2,147,483,647             |
| unsigned int       | 4 字节      | 0 - 4,294,967,295                          |
| short              | 2 字节      | -32,768 - 32,767                           |
| unsigned short     | 2 字节      | 0 - 65,535                                 |
| long               | 4 或 8 字节 |                                            |
| unsigned long      | 4 或 8 字节 |                                            |
| long long          | 8 字节      | -9223372036854775808 - 9223372036854775807 |
| unsigned long long | 8 字节      | 0 - 18446744073709551615                   |

在声明数据类型，如果不添加 unsigned，则默认为 signed 类型。也就是说 `int` 和 `signed int` 是等效的。

值得一提的是，`int` 和 `long` 类型的存储大小在不同平台上可能会不一样，例如在某些单片机系统中，`int` 是 2 字节的。在 32 位系统中，`long` 是 4 字节的，而在 64 位系统中，`long` 是 8 字节的。然而，在不同的操作系统之间还会存在差异，例如同样是 64 位处理器，Windows 系统的 `long` 是 4 字节的，而 Linux 系统的 `long` 是 8 字节的。程序员在编写 C 程序时需要注意这一点。

为了解决整数类型存储大小不兼容的问题，标准 C 库特别定义了一系列类型，包括 `int8_t`、`int16_t`、`int32_t`、`int64_t`、`uint8_t`、`uint16_t`、`uint32_t`、`uint64_t`，可用它们可以增强程序的兼容性。

下面是定义整数类型变量的一些示例：

```c showLineNumbers
int a = 0;
uint16_t b = 0;
char c = 0;
```



## 浮点类型

C 语言的浮点类型包括 float、double 以及 long double 三种，浮点数都是有符号。其中，float 称为单精度浮点型，double 称为双精度浮点型。下表列出了各浮点类型及其存储大小和数值范围。

|    类型     | 存储大小 |       数值范围        |      精度      |
| :---------: | :------: | :-------------------: | :------------: |
|    float    |  4 字节  |   1.2E-38 - 3.4E+38   | 小数点后 6 位  |
|   double    |  8 字节  |  2.3E-308 - 1.7E+308  | 小数点后 15 位 |
| long double | 10 字节  | 3.4E-4932 - 1.1E+4932 | 小数点后 19 位 |

下面是定义浮点类型变量的一些示例：

```c showLineNumbers
float a = 1.0;
float b = 1.0f;
float c = 112.64E3;
double d = 0.7623e-2;
double e = 1.23002398;
```

浮点数可以使用科学计数法表示，在赋值时可以在数值常量末尾添加 `f` 进行限定。



## 空类型

在 C 语言中，void 类型有以下三种用法。

**1. 作为函数返回值**

如果一个函数返回 void，则表示该函数不返回任何值。例如：

```c showLineNumbers
void exit(int status);
```

**2. 作为函数参数**

如果一个函数的参数列表是 void，则表示该函数不接受任何参数，或者说它不需要参数。例如：

```c showLineNumbers
int rand(void);
```

**3. 指向 void 的指针**

`void *` 类型的指针表示对象的地址，但不表示其类型，或者说它是可以指向任意类型的指针。例如：

```c showLineNumbers
void *malloc( size_t size );
```

内存分配函数返回一个指向 void 的指针，该指针可以转换为任何数据类型。



## 示例代码

我们可以通过编写一段 C 代码来验证本节所学的数据类型，看看在你的计算机中，它们的存储大小和数值范围是多少？

### 计算存储大小

下面示例使用 `sizeof` 运算符计算各数据类型的存储大小，`sizeof(type)` 可以计算一个变量或者数据类型需要占用多少字节。代码可在 [GitHub](https://github.com/getiot/linux-c/blob/main/base/type/typesize.c) 下载。

```c showLineNumbers
#include <stdio.h>

int main(void)
{
    printf("sizeof(char)          = %lu\n", sizeof(char));
    printf("sizeof(short int)     = %lu\n", sizeof(short int));
    printf("sizeof(int)           = %lu\n", sizeof(int));
    printf("sizeof(long int)      = %lu\n", sizeof(long int));
    printf("sizeof(long long int) = %lu\n", sizeof(long long int));
    printf("sizeof(float)         = %lu\n", sizeof(float));
    printf("sizeof(double)        = %lu\n", sizeof(double));
    printf("sizeof(void)          = %lu\n", sizeof(void));
    printf("sizeof(void *)        = %lu\n", sizeof(void *));

    return 0;
}
```

将代码保存为 typesize.c，执行下面命令编译程序：

```bash
gcc typesize.c -o typesize
```

执行命令 `./typesize` 运行程序，在 64 位计算机中的结果如下：

```bash
sizeof(char)          = 1
sizeof(short int)     = 2
sizeof(int)           = 4
sizeof(long int)      = 8
sizeof(long long int) = 8
sizeof(float)         = 4
sizeof(double)        = 8
sizeof(void)          = 1
sizeof(void *)        = 8
```

### 计算数值范围

下面示例使用预定义的宏打印各数据类型的数值范围，头文件 limits.h 和 float.h 定义了一些宏，用于定义数据类型的范围值。代码可在 [GitHub](https://github.com/getiot/linux-c/blob/main/base/type/typelimits.c) 下载。

```c showLineNumbers
#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <float.h>

int main(void)
{
    printf("CHAR_BIT       : %d\n", CHAR_BIT);
    printf("CHAR_MIN       : %d\n", CHAR_MIN);
    printf("CHAR_MAX       : %d\n", CHAR_MAX);
    printf("SHRT_MIN       : %d\n", SHRT_MIN);
    printf("SHRT_MAX       : %d\n", SHRT_MAX);
    printf("INT_MIN        : %d\n", INT_MIN);
    printf("INT_MAX        : %d\n", INT_MAX);
    printf("LONG_MIN       : %ld\n", (long) LONG_MIN);
    printf("LONG_MAX       : %ld\n", (long) LONG_MAX);
    printf("SCHAR_MIN      : %d\n", SCHAR_MIN);
    printf("SCHAR_MAX      : %d\n", SCHAR_MAX);
    printf("UCHAR_MAX      : %d\n", UCHAR_MAX);
    printf("USHRT_MAX      : %d\n", (unsigned short) USHRT_MAX);
    printf("UINT_MAX       : %u\n", (unsigned int) UINT_MAX);
    printf("ULONG_MAX      : %lu\n", (unsigned long) ULONG_MAX);
    printf("-------------------------------------\n");
    printf("FLT_MAX        : %g\n", (float) FLT_MAX);
    printf("FLT_MIN        : %g\n", (float) FLT_MIN);
    printf("-FLT_MAX       : %g\n", (float) -FLT_MAX);
    printf("-FLT_MIN       : %g\n", (float) -FLT_MIN);
    printf("DBL_MAX        : %g\n", (double) DBL_MAX);
    printf("DBL_MIN        : %g\n", (double) DBL_MIN);
    printf("-DBL_MAX       : %g\n", (double) -DBL_MAX);
    printf("Precision value: %d\n", FLT_DIG );

    return 0;
}
```

将代码保存为 typelimits.c，执行下面命令编译程序：

```bash
gcc typelimits.c -o typelimits
```

执行命令 `./typelimits` 运行程序，在 64 位计算机中的结果如下：

```bash
CHAR_BIT       : 8
CHAR_MIN       : -128
CHAR_MAX       : 127
SHRT_MIN       : -32768
SHRT_MAX       : 32767
INT_MIN        : -2147483648
INT_MAX        : 2147483647
LONG_MIN       : -9223372036854775808
LONG_MAX       : 9223372036854775807
SCHAR_MIN      : -128
SCHAR_MAX      : 127
UCHAR_MAX      : 255
USHRT_MAX      : 65535
UINT_MAX       : 4294967295
ULONG_MAX      : 18446744073709551615
-------------------------------------
FLT_MAX        : 3.40282e+38
FLT_MIN        : 1.17549e-38
-FLT_MAX       : -3.40282e+38
-FLT_MIN       : -1.17549e-38
DBL_MAX        : 1.79769e+308
DBL_MIN        : 2.22507e-308
-DBL_MAX       : -1.79769e+308
Precision value: 6
```



## 参考

- [ header file in C with Examples - GeeksforGeeks](https://www.geeksforgeeks.org/complex-h-header-file-in-c-with-examples/)