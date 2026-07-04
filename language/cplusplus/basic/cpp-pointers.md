---
sidebar_position: 21
slug: /cpp-pointers
---

# C++ 指针



C++ 中指针的概念和和 C 语言一样，指针就是内存的地址，指针变量则是保存了内存地址的变量。



## 内存地址

计算机中所有的数据都必须放在内存中，不同类型的数据占用的字节数不一样。为了正确地访问这些数据，必须为每个字节都编上号码，就像门牌号、身份证号一样，每个字节的编号是唯一的，根据编号可以准确地找到某个字节。

我们将内存中字节的编号称为地址（Address）或指针（Pointer）。CPU 只能通过地址来取得内存中的代码和数据，程序在执行过程中会告知 CPU 要执行的代码以及要读写的数据的地址。而程序中的变量名和函数名只是地址的一种助记符，当源文件被编译和链接成可执行程序后，它们都会被替换成地址。CPU 最终访问内存时需要的是地址，而不是变量名和函数名。下面这张图可以帮助理解这些概念。

![指针变量与地址](https://static.getiot.tech/cplusplus_pointer_1.png#center)



## 变量地址

上面说过，每一个变量都有一个内存位置，每一个内存位置都定义了可访问的地址。在 C++ 中，可以通过 `&` 取址符获得变量地址，通过 `*` 解地址符获取指针保存的值。

### 取地址符（`&`）

C++ 提供了取址符（`&`）可以获得一个变量的内存地址。示例：

```cpp showLineNumbers
#include <iostream>

using namespace std;

int main ()
{
    int  var1;
    char var2[10];

    std::cout << "var1 变量的地址： ";
    std::cout << &var1 << std::endl;

    std::cout << "var2 变量的地址： ";
    std::cout << &var2 << std::endl;

    return 0;
}
```

编译和运行以上示例，输出结果如下：

```cpp showLineNumbers
var1 变量的地址： 0x7ffee55a01c0
var2 变量的地址： 0x7ffee55a01ee
```

提示：你的输出结果可能和我的不一样，但没关系，它都表示了一个内存位置。

### 解地址符（`*`）

C++ 提供了解地址符（`*`）获取一个内存地址保存的值。示例：

```cpp showLineNumbers
#include <iostream>

using namespace std;

int main ()
{
    int     a = 100;
    double pi = 3.1415926;

    std::cout << "a 变量的地址： ";
    std::cout << &a << std::endl;

    std::cout << "pi 变量的地址： ";
    std::cout << &pi << std::endl;

    std::cout << "a 变量的地址保存的值: ";
    std::cout << *(&a) << std::endl;

    std::cout << "pi 变量的地址保存的值： ";
    std::cout << *(&pi) << std::endl;
    return 0;
}
```

编译和运行以上示例，输出结果如下：

```cpp showLineNumbers
a 变量的地址： 0x7ffee1d241b8
pi 变量的地址： 0x7ffee1d241b0
a 变量的地址保存的值: 100
pi 变量的地址保存的值： 3.14159
```



## C++ 指针

**指针** 是一个变量，其值为另一个变量的地址，即内存位置的直接地址。

![img](https://static.getiot.tech/cplusplus_pointer_2.png#center)

和其它变量或常量一样，必须在使用指针存储其它变量地址之前，对其进行声明。

指针变量声明的一般形式为：

```cpp showLineNumbers
[存储类型]  type_name  *var_name；
```

1. **type_name** 必须是一个有效的 C++ 数据类型；
2. **var_name** 是指针变量的名称；
3. 星号 `*` 用来指定一个变量是指针。

以下是有效的指针声明：

```cpp showLineNumbers
int    *ip;    /* 一个整型的指针 */
double *dp;    /* 一个 double 型的指针 */
float  *fp;    /* 一个浮点型的指针 */
char   *ch;    /* 一个字符型的指针 */
```

实际上，不管是整型、浮点型、字符型，还是其它的数据类型，所有指针的数据类型都一样，都是一个与内存地址长度相同的整数，通常用十六进制表示（例如 `0xffee0725`）。

不同数据类型的指针之间唯一的不同是，指针所指向的变量或常量的数据类型不同。



## C++ 中使用指针

C++ 指针只有五种操作：

**1、定义一个指针变量**

```cpp showLineNumbers
int *ptr_a;
```

**2、把变量地址赋值给指针，使用取址符（`&`）**

```cpp showLineNumbers
int pi = 3.1415926;
int *ptr_pi = &pi;
```

**3、访问指针变量中可用地址的值，使用解地址符（`*`）**

```cpp showLineNumbers
int pi = 3.1415926;
int *ptr_pi = &pi;

std::cout << *ptr_pi;
```

**4、简单的自增自减和加法减法运算符**

因为指针保存的是变量的地址，而变量的地址是十六进制整形，所以也支持四种操作，而且只支持下面四种。

```cpp showLineNumbers
ptr_pi++;
ptr_pi--;

ptr_pi = ptr_pi - 3;
ptr_pi = ptr_pi + 3;
```

**5、简单的比较两个指针的大小，可以使用三个比较运算符 `==`、`<` 和 `>`**

这三个比较运算符用于比较指针指向的内存地址是否相等，是否大于或小于。

C++ 指针使用示例：

```cpp showLineNumbers
#include <iostream>

int main ()
{
    double pi = 3.1415926;   // 实际变量的声明
    double  *ptr_pi;         // 指针变量的声明

    ptr_pi = &pi;            // 在指针变量中存储 pi 的地址

    // 输出变量 pi 的地址
    std::cout << "pi 变量的地址为: " << &pi << std::endl;
    // 在指针变量中存储的地址
    std::cout << "ptr_pi 保存的值为: "<< ptr_pi << std::endl;

    std::cout << "pi 变量的值为: " << pi << std::endl;
    // 访问指针中地址的值
    std::cout << "ptr_pi 中地址的值为: " << *ptr_pi << std::endl;

    return 0;
}
```

编译和运行以上示例，输出结果如下：

```cpp showLineNumbers
pi 变量的地址为: 0x7ffeec7e61b0
ptr_pi 保存的值为: 0x7ffeec7e61b0
pi 变量的值为: 3.14159
ptr_pi 中地址的值为: 3.14159
```