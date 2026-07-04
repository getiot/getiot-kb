---
sidebar_position: 5
slug: /cpp-data-types
---

# C++ 数据类型



C++ 是一种静态语言，在声明变量时需要指定它的数据类型。也就是说，C++ 的变量都具有数据类型，以决定其能够存储哪种数据，并在内存中分配相应的空间。

C++ 中的数据类型可以分为四大类，即基本类型、构造类型、指针类型和空类型。

- 基本类型也可以分为 **数值类型** 和 **字符类型**。其中，数值类型也可以分为 **整型** 和 **浮点型**，整型又可以分为短整型、整型和长整型，浮点型可以分为单精度型和双精度型。
- 构造类型可以分为 **数组**、**结构体**、**共用体**、 **枚举类型** 和 **类** 类型。

下面是 C++ 中最常见的七种基本数据类型：

| 类型     | 关键字  | 长度                             |
| :------- | :------ | -------------------------------- |
| 布尔型   | bool    | 1 字节                           |
| 字符型   | char    | 1 字节                           |
| 整型     | int     | 2-8 字节                         |
| 浮点型   | float   | 4 字节                           |
| 双浮点型 | double  | 8 字节                           |
| 无类型   | void    | 修饰指针时，其大小与系统位数相同 |
| 宽字符型 | wchar_t | 2 或 4 字节                      |



## 布尔型（bool）

在 C 语言中没有 bool 类型，因此关系运算和逻辑运算的结果用 0 表示假，用非 0 表示真。而在 C++ 中，增加了 bool 类型，用 true 来表示真，用 false 来表示假。

定义一个布尔型变量：

```cpp showLineNumbers
bool varname;
```

判断布尔值的真假：

```cpp showLineNumbers
if (varname == true)
{
    cout << "is true" << endl;
}
else if (varname == false)
{
    cout << "is false" << endl;
}
```



## 字符型（char）

在 C++ 中，字符类型使用 char 来定义。如果我们需要定义一个字符类型，那么该字符类型需要使用单引号 `''` 包围。

定义一个字符型变量：

```cpp showLineNumbers
char varname = 'a';
```

char 字符的取值范围为 -128 ~ 127。在 limits.h 中定义了常量 `CHAR_MIN` 和 `CHAR_MAX` 分别表示字符型的最小值和最大值。



## 整型（int）

C++ 的整型用来存放整数类型的数字，根据长度可以分为短整型 `short`、整型 `int`、长整型 `long` 和 `long long` 类型。

| 数据类型  | 取值范围                                   | 字节数 |
| --------- | ------------------------------------------ | ------ |
| short     | -32768 ~ 32767                             | 2      |
| int       | -2147483648 ~ 2147483647                   | 4      |
| long      | 2147483648 ~ 2147483647                    | 4      |
| long long | -9223372036854775808 ~ 9223372036854775807 | 8      |

默认情况下，所有的整型都是 signed 有符号类型的，可以显式添加 unsigned 修饰为无符号类型，此时能表示的最大值将扩大一倍。

```cpp showLineNumbers
int varname = value;
short int varname = value;      // 可以省略 int
long int varname = value;       // 可以省略 int
long long int varname = value;  // 可以省略 int
unsigned int varname = value;   // 无符号整型
```

同样，在 limits.h 中定义了常量 `SHRT_MIN`、`SHRT_MAX`、`INT_MIN`、`INT_MAX`、`LONG_MIN`、`LONG_MAX`、`LLONG_MIN`、`LLONG_MAX` 表示它们的最小值和最大值。

在定义整型变量时，需要根据预估的数据范围，选择合适的数据类型。如果我们选的数据类型太小，那么就会有溢出的错误；如果我们选的数据类型太大，那么就会造成资源的浪费。



## 浮点型（float）

C++ 中的 float 用来表示一个小数，也可以叫做单精度数，占 4 字节大小，可以表达精度 6~7 位的小数。如果我们需要表示的小数的精度比较小，那么可以使用 float 来定义，这样可以节省系统资源。

定义一个单精度浮点数：

```cpp showLineNumbers
float varname = value;
```

由于浮点类型的变量在计算机中以表示精确的方式存储，所以在比较浮点数时需要比较精度，这点要特别注意。



## 双浮点型（double）

C++ 中的 double 用来表示一个小数，也可以叫做双精度数，占 8 字节大小，可以表达精度 15~16 位的小数。如果我们需要表示的小数的精度比较高，那么可以使用 double 来定义，这样可以避免出错。

定义一个双精度浮点数：

```cpp showLineNumbers
double varname = value;
```



## 无类型（void）

C++ 中的 void 用来表示无类型，表示 “没有任何值可以获得”。因此，不可以采用这个类型声明变量或常量。但可以用 void 修饰函数或者指针。

例如，修饰函数返回值：

```cpp showLineNumbers
void func_name(paramlist)
{
    [return;]
}
```

修饰函数参数，表示函数不接受任何参数：

```cpp showLineNumbers
void func_name(void)
{
    [return;]
}
```

修饰指针（万能指针类型）：

```cpp showLineNumbers
void *ptr;
```



## 宽字符型（wchar_t）

在 C++ 中，wchar_t 是一个特有的基本类型。它是一种扩展的字符类型存储方式，主要用在国际化程序的实现中。

由于 char 是 8 位字符类型，最多只能表示 256 种字符。而许多的外文字符集所包含的字符数目超过 256 个，比如对于汉字，韩文以及日文这样的字符，它们的每一个文字都占据两个字节。所以，C++ 提出了 wchar_t 类型，也称为双字节类型，或宽字符类型。

实际上，wchar_t 类型是短整型的一个 typedef。

```cpp showLineNumbers
typedef short int wchar_t;
```

在字符或字符串前面加 `L`，可以表示使用 wchar_t 宽字符类型存储。比如：

```cpp showLineNumbers
const wchar_t* str = L"中国";
```

定义一个用宽字符存储文本 `L"hello"` 的数组：

```cpp showLineNumbers
wchar_t str[] = {L'h', L'e', L'l', L'l', L'o', 0}
```



## 测试数据类型长度

下面一段程序，可以测试 C++ 几种常见数据基本的长度。

```cpp showLineNumbers
#include <iostream>

using namespace std;

int main(void)
{
    cout << "Size of char      : " << sizeof(char) << endl;
    cout << "Size of int       : " << sizeof(int) << endl;
    cout << "Size of short int : " << sizeof(short int) << endl;
    cout << "Size of long int  : " << sizeof(long int) << endl;
    cout << "Size of float     : " << sizeof(float) << endl;
    cout << "Size of double    : " << sizeof(double) << endl;
    cout << "Size of wchar_t   : " << sizeof(wchar_t) << endl;
    return 0;
}
```


