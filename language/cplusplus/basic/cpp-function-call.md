---
sidebar_position: 17
slug: /cpp-function-call
---

# C++ 函数参数传递



当调用 C++ 函数时，有三种向函数传递参数的方式：

- 传值调用（call by value）
- 指针调用（call by pointer）
- 引用调用（call by reference）



## C++ 传值调用

在 C++ 中，向函数传递参数的 **传值调用** 方法，把参数的实际值复制给函数的形式参数。这种情况下，修改函数内的形式参数不会影响实际参数。默认情况下，C++ 使用传值调用方法来传递参数，这意味着函数内的代码不会改变用于调用函数的实际参数。

下面看一个示例：

```cpp showLineNumbers
#include <iostream>
using namespace std;

void swap(int x, int y)
{
    int temp;
    temp = x; /* 保存地址 x 的值 */
    x = y;    /* 把 y 赋值给 x */
    y = temp; /* 把 x 赋值给 y */

    return;
}

int main ()
{
    // 局部变量声明
    int a = 64;
    int b = 256;

    std::cout << "交换前，a 的值：" << a << std::endl;
    std::cout << "交换前，b 的值：" << b << std::endl;

    /* 调用函数来交换值 */
    swap(a, b);

    std::cout << "交换后，a 的值：" << a << std::endl;
    std::cout << "交换后，b 的值：" << b << std::endl;

    return 0;
}
```

编译和运行以上示例，输出结果如下：

```bash
交换前，a 的值：64
交换前，b 的值：256
交换后，a 的值：64
交换后，b 的值：256
```

结果表明：虽然在函数内改变了 a 和 b 的值，但是实际上 a 和 b 的值没有发生变化。



## C++ 指针传参

向函数传递参数的 **指针调用** 方法，把参数的地址复制给形式参数。在函数内，该地址用于访问调用中要用到的实际参数。这意味着，修改形式参数会影响实际参数。另外，使用 **指针传参** 需要声明函数的参数为指针类型。

下面示例将使用指针传参方式来交换参数所指向的两个整数变量的值。

```cpp showLineNumbers
#include <iostream>
using namespace std;

// 指针传参时需要将参数声明为指针类型
void swap(int *x, int *y)
{
    int temp;
    temp = *x; /* 保存地址 x 的值 */
    *x = *y;   /* 把 y 赋值给 x */
    *y = temp; /* 把 x 赋值给 y */

    return;
}

int main ()
{
    // 局部变量声明
    int a = 64;
    int b = 256;

    std::cout << "交换前，a 的值：" << a << std::endl;
    std::cout << "交换前，b 的值：" << b << std::endl;

    /* 调用函数来交换值 */
    swap(&a, &b);

    std::cout << "交换后，a 的值：" << a << std::endl;
    std::cout << "交换后，b 的值：" << b << std::endl;

    return 0;
}
```

编译和运行以上示例，输出结果如下：

```bash
交换前，a 的值：64
交换前，b 的值：256
交换后，a 的值：256
交换后，b 的值：64
```

可以看到，a 和 b 的值发生了交换。



## C++ 引用传参

向函数传递参数的 **引用调用** 方法，把引用的地址复制给形式参数。在函数内，该引用用于访问调用中要用到的实际参数。这意味着，修改形式参数会影响实际参数。另外，**引用传参** 需要声明函数参数为引用类型。

下面示例将使用引用传参交换参数所指向的两个整数变量的值。

```cpp showLineNumbers
#include <iostream>
using namespace std;

// 引用传参时需要将参数声明为引用类型
void swap(int &x, int &y)
{
   int temp;
   temp = x; /* 保存地址 x 的值 */
   x = y;    /* 把 y 赋值给 x */
   y = temp; /* 把 x 赋值给 y  */

   return;
}

int main ()
{
    // 局部变量声明
    int a = 64;
    int b = 256;

    std::cout << "交换前，a 的值：" << a << std::endl;
    std::cout << "交换前，b 的值：" << b << std::endl;

    /* 调用函数来交换值 */
    swap(a, b);

    std::cout << "交换后，a 的值：" << a << std::endl;
    std::cout << "交换后，b 的值：" << b << std::endl;

    return 0;
}
```

编译和运行以上示例，输出结果如下：

```bash
交换前，a 的值：64
交换前，b 的值：256
交换后，a 的值：256
交换后，b 的值：64
```

