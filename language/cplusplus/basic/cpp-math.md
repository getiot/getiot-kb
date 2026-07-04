---
sidebar_position: 24
slug: /cpp-math
---

# C++ 数学函数



C++ 标准库（std）通过 `<cmath>` 头文件内置了丰富的数学函数，可对各种数字进行运算。



## 头文件

如果要使用 C++ 标准库提供的数学函数，需要包含 `<cmath>` 头文件。

```cpp showLineNumbers
#include <cmath>
```



## 相关函数

下表列出了 C++ 标准库提供的一些有用的数学函数。

| 函数                             | 描述                                   |
| -------------------------------- | -------------------------------------- |
| `double cos(double)`             | 返回弧度角（double 型）的余弦。        |
| `double sin(double)`             | 返回弧度角（double 型）的正弦。        |
| `double tan(double)`             | 返回弧度角（double 型）的正切。        |
| `double log(double)`             | 返回参数的自然对数。                   |
| `double pow(double x, double y)` | 返回 x 的 y 次方。                     |
| `double hypot(double, double)`   | 返回两个参数的平方总和的平方根。       |
| `double sqrt(double)`            | 返回参数的平方根。                     |
| `int abs(int)`                   | 返回整数的绝对值。                     |
| `double fabs(double)`            | 返回任意一个十进制数的绝对值。         |
| `double floor(double)`           | 返回一个小于或等于传入参数的最大整数。 |



## 示例

```cpp showLineNumbers
#include <iostream>
#include <cmath>

using namespace std;

int main ()
{
    int a = 2;

    cout << "sin(d)    :" << sin(a) << endl;
    cout << "abs(i)    :" << abs(a) << endl;
    cout << "floor(d)  :" << floor(a) << endl;
    cout << "sqrt(f)   :" << sqrt(a) << endl;
    cout << "pow(d, 2) :" << pow(a, 2) << endl;

    return 0;
}
```

编译和运行以上示例，输出结果如下：

```bash
sin(d)    :0.909297
abs(i)    :2
floor(d)  :2
sqrt(f)   :1.41421
pow(d, 2) :4
```