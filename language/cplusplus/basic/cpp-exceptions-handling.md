---
sidebar_position: 42
slug: /cpp-exceptions-handling
---

# C++ 异常处理



在计算机程序设计中，异常（Exception）是指在程序运行过程中出现的非正常事件。触发异常的原因有很多，比如硬件错误、内存不足、网络不通、输入不合法、除零操作等等。

在 C++ 中，与异常处理相关的关键字有三个：

- **`throw`**：当问题出现时，程序会抛出一个异常。这是通过使用 throw 关键字来完成的。
- **`catch`**：在你想要处理问题的地方，通过异常处理程序捕获异常。catch 关键字用于捕获异常。
- **`try`**：try 块中的代码标识将被激活的特定异常。它后面通常跟着一个或多个 catch 块。



## try 语句

`try` 语句可以将可能会产生问题的代码监测起来。try 块中放置可能抛出异常的代码，try 块中的代码被称为保护代码。如果有一个块抛出一个异常，捕获异常的方法是使用 `try` 和 `catch` 关键字。

`try/catch` 语句的语法格式如下：

```cpp showLineNumbers
try
{
    // 保护代码
} catch ( ExceptionName e1 )
{
    // catch 块
} catch ( ExceptionName e2 )
{
    // catch 块
} catch ( ExceptionName eN )
{
    // catch 块
}
```

如果 `try` 块在不同的情境下会抛出不同的异常，这个时候可以尝试设置多个 `catch` 语句，用于捕获不同类型的异常。



## 抛出异常

`throw` 语句用来在代码块中的任何地方抛出异常。`throw` 语句的操作数可以是任意的表达式，表达式的结果的类型决定了抛出的异常的类型。

示例：除以零时抛出异常

```cpp showLineNumbers
double division(int a, int b)
{
    if (b == 0) {
        throw "Division by zero condition!";
    }
    return (a/b);
}
```



## 捕获异常

`catch` 关键字可以用来捕获异常，`catch` 块跟在 `try` 块后面，用于捕获异常。`catch` 括号内的异常声明可以用来指定想要捕捉的异常类型。

`catch` 语法格式如下：

```cpp showLineNumbers
try
{
    // 保护代码
} catch ( ExceptionName e )
{
    // 处理 ExceptionName 异常的代码
}
```

上面的代码会捕获一个类型为 `ExceptionName` 的异常。此外，`catch` 块可以处理 `try` 块抛出的任何类型的异常，方法是在异常声明的括号内使用省略号 `...`。

`catch` 捕获所有异常的语法格式：

```cpp showLineNumbers
try
{
    // 保护代码
} catch (...)
{
    // 能处理任何异常的代码
}
```

示例：抛出一个除以零的异常，并在 catch 块中捕获

```cpp showLineNumbers
#include <iostream>
using namespace std;

double division(int a, int b)
{
    if (b == 0) {
        throw "除 0 异常 !";
    }
    return (a/b);
}

int main ()
{
    int x = 32;
    int y = 0;
    double z = 0;
    
    try 
    {
        z = division(x, y);
        cout << z << endl;
    }
    catch (const char* msg)
    {
        cerr << msg << endl;
    }
    
    return 0;
}
```

上面示例抛出了一个类型为 `const char*` 的异常，因此，当捕获该异常时，必须在 `catch` 块中使用 `const char*`。

执行 `g++ main.cpp && ./a.out` 编译运行以上示例，输出结果如下：

```bash
除 0 异常 !
```



## 标准异常

C++ 预先定义了一系列标准的异常，这些异常定义在 `std` 命名空间下的  `<exception>` 头文件中。这些异常是以父子类层次结构组织起来的，如下所示：

![C++ 标准异常的层次结构](https://static.getiot.tech/cplusplus-std-exceptions.png#center)

下表是对上面层次结构中出现的每个异常的说明。

| 异常                    | 描述                                                         |
| ----------------------- | ------------------------------------------------------------ |
| `std::exception`        | 所有标准 C++ 异常的父类。                                    |
| `std::bad_alloc`        | 可以通过 `new` 关键字抛出。                                  |
| `std::bad_cast`         | 可以通过 `dynamic_cast` 抛出。                               |
| `std::bad_exception`    | 这在处理 C++ 程序中无法预期的异常时非常有用。                |
| `std::bad_typeid`       | 该异常可以通过 `typeid` 抛出。                               |
| `std::logic_error`      | 理论上可以通过读取代码来检测到的异常。                       |
| `std::domain_error`     | 当使用了一个无效的数学域时，会抛出该异常。                   |
| `std::invalid_argument` | 当使用了无效的参数时，会抛出该异常。                         |
| `std::length_error`     | 当创建了太长的 `std::string` 时，会抛出该异常。              |
| `std::out_of_range`     | 该异常可以通过方法抛出，例如 `std::vector` 和 `std::bitset<>::operator`。 |
| `std::runtime_error`    | 理论上不可以通过读取代码来检测到的异常。                     |
| `std::overflow_error`   | 当发生数学上溢时，会抛出该异常。                             |
| `std::range_error`      | 当尝试存储超出范围的值时，会抛出该异常。                     |
| `std::underflow_error`  | 当发生数学下溢时，会抛出该异常。                             |



## 自定义异常

`std::exception` 是所有标准 C++ 异常的父类，因此我们可以通过继承和重载 `std::exception` 类可以定义新的异常。

一般情况下，继承 `std:exception` 之后需要重写 `what()`方法。`what()` 返回异常产生的原因，是异常类提供的一个公共方法，它已被所有子异常类重载。

示例：如何继承 `std::exception` 类来实现自己的异常

```cpp showLineNumbers
#include <iostream>
#include <exception>

struct MyException : public std::exception
{
    const char * what () const throw ()
    {
        return "My C++ Exception";
    }
};

int main()
{
    try
    {
        throw MyException();
    }
    catch (MyException& e)
    {
        std::cout << "MyException caught" << std::endl;
        std::cout << e.what() << std::endl;
    }
    catch(std::exception& e)
    {
        // 其他的错误
    }
    
    return 0;
}
```

执行 `g++ main.cpp && ./a.out` 编译运行以上示例，输出结果如下：

```bash
MyException caught
My C++ Exception
```

