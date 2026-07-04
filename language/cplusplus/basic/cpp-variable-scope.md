---
sidebar_position: 8
slug: /cpp-variable-scope
---

# C++ 变量作用域



一段程序代码中存在许多变量，而变量对应一块内存区域。为了节省内存空间，并提高内存访问的安全性，C++ 的变量是有作用域的。作用域就是变量在程序中的可视范围，作用域可以提高了程序逻辑的局部性、增强程序的可靠性、减少名字冲突。

一般来说，有三个地方可以定义变量：

- 在所有函数外部声明的变量，称为**全局变量**（Global variables）。
- 在函数或一个代码块内部声明的变量，称为**局部变量**（Local variables）。
- 在函数参数的定义中声明的变量，称为**形式参数**（Formal parameters）。

关于形式参数的概念将在后续函数相关章节展开，本文先来了解全局变量和局部变量。

下面示例中，分别定义了两个全局变量和两个局部变量。

```cpp showLineNumbers
#include <iostream>
using namespace std;

// 全局变量
int x;
char ch;

int main(void)
{
    // 局部变量
    int age;
    float number;
    
    cout << "Enter your age: ";
    cin >> age;
    ...
}
```



## 全局变量

在所有函数外部声明或定义的变量（通常是在程序的头部），称为全局变量。比如这里的 x 和 ch。

```cpp showLineNumbers
int x;
char ch;
```

全局变量的作用域在整个文件都有效，并在程序的整个生命周期内都有效，但在本文件外的其他地方访问需要使用 `extern` 声明。

定义全局变量时，系统会自动为其赋予初始值。这个初始值通常都是 0，但不同类型的变量有不同的含义：

| 数据类型 | 初始化默认值 |
| -------- | ------------ |
| int      | 0            |
| char     | '\0'         |
| float    | 0            |
| double   | 0            |
| 指针     | NULL         |



## 局部变量

在函数或一个代码块（例如 if 和 for 结构）内部声明的变量，称为局部变量。比如前面代码中的 age 和 number。

```cpp showLineNumbers
int age;
float number;
```

局部变量只能被函数内部或者代码块内部的语句使用，一旦离开该语句块，局部变量将会被释放，除非使用 static 修饰。

注意：在程序中，局部变量和全局变量的名称可以相同。但是在函数内，局部变量的值会覆盖全局变量的值。