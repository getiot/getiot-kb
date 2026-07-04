---
sidebar_position: 33
slug: /cpp-function-overloading
---

# C++ 函数重载



在 C++ 中，**重载** 是指一个与之前已经在该作用域内声明过的函数或方法具有相同名称的声明，但是它们的参数列表和定义不相同。C++ 允许在同一作用域中的某个函数指定多个定义，称为 **函数重载**。



## 重载函数

调用一个 **重载函数** 时，编译器通过比较函数的 **形参** 和 **实参**，决定选用最合适的定义。选择最合适的重载函数的过程，称为 **重载决策**。

- **形参**：即形式参数（Formal parameters），指函数声明或定义时指定的参数；
- **实参**：即实际参数（Actual parameters），指调用函数时传递的参数。

比如下面这个例子：

```cpp showLineNumbers
int max(int a, int b)
{
    return a > b ? a : b;
}

int x = 3;
int y = 5;
max(x, y);
```

这里的 `a` 和 `b` 是形参，`x` 和 `y` 是实参。



## 函数重载示例

在同一个作用域内，可以声明几个功能类似的同名函数，但是这些同名函数的形式参数（指参数的个数、类型或者顺序）必须不同。需要注意，不能仅通过返回类型的不同来重载函数。

下面通过一个示例来加深理解，这个示例中定义了多个不同的 `show()` 函数，调用时将根据传入的参数类型，选择最适合的重载函数。

```cpp showLineNumbers
#include <iostream>
using namespace std;

class GetIoT
{
public:
    void show(int i) 
    {
        cout << "Int: " << i << endl;
    }

    void show(double f) 
    {
        cout << "Float: " << f << endl;
    }

    void show(const char* s) 
    {
        cout << "String: " << s << endl;
    }
};

int main(void)
{
   GetIoT getiot;

   // 调用 show 函数输出 int 数据类型
   getiot.show(64);

   // 调用 show 函数输出 float 数据类型
   getiot.show(3.1415926);

   // 调用 show 函数输出 string 数据类型
   getiot.show("Welcome to getiot.tech");

   return 0;
}
```

使用 `g++ main.cpp && ./a.out` 命令编译和运行以上示例，输出结果如下：

```bash
Int: 64
Float: 3.14159
String: Welcome to getiot.tech
```