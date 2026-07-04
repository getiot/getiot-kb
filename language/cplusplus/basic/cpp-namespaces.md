---
sidebar_position: 44
slug: /cpp-namespaces
---

# C++ 命名空间



C++ 中的命名空间（namespace）实际上就是一个由程序设计者命名的内存区域，程序设计者可以根据需要指定一些有名字的空间域，把一些全局实体分别放在各个命名空间中，从而与其他全局实体分隔开来。

命名空间是 ANSI C++ 引入的可以由用户命名的作用域，用来处理程序中常见的同名冲突。



## 命名空间解释

假设这样一种情况，一个班上同时有两个名叫“梅小喵”的学生，为了明确区分他们，我们在使用名字之外，不得不使用一些额外的信息，比如他们的家庭住址，或者他们父母的名字等等。

同样的情况也出现在 C++ 应用程序中。例如，我们可能会写一个名为 `xyz()` 的函数，而在另一个可用的库中也存在一个相同的函数 `xyz()`。这样，编译器就无法判断该程序所使用的是哪一个 `xyz()` 函数，这种情况称为全局命名空间污染。

正因如此，C++ 引入了**命名空间**这个概念，专门用于解决上面的问题，它可作为附加信息来区分不同库中相同名称的函数、类、变量等。

使用了命名空间即定义了上下文。本质上，命名空间就是一种描述逻辑分组的机制，它定义了一个范围，以便将逻辑上同属一类的声明放在同一个命名空间中，避免了名称污染。



## 定义命名空间

关键字 `namespace` 用来定义命名空间。语法如下：

```cpp showLineNumbers
namespace namespace_name {
    // 代码声明
}
```

为了调用带有命名空间的函数或变量，需要在前面加上命名空间的名称，如下所示：

```cpp showLineNumbers
namespace::code;  // code 可以是变量或函数
```

下面示例演示如何使用命名空间为变量或函数等实体定义范围。

```cpp showLineNumbers
#include <iostream>
using namespace std;

// 第一个命名空间
namespace first_namespace {
    void func() {
        cout << "Inside first_namespace" << endl;
    }
}

// 第二个命名空间
namespace second_namespace {
    void func() {
        cout << "Inside second_namespace" << endl;
    }
}

int main(void)
{
    // 调用第一个命名空间中的函数
    first_namespace::func();
    // 调用第二个命名空间中的函数
    second_namespace::func();
    return 0;
}
```

执行 `g++ main.cpp && ./a.out` 编译运行以上示例，输出结果如下：

```bash
Inside first_namespace
Inside second_namespace
```



## 引入命名空间

C++ 使用 `using` 关键字来将命名空间引入到当前文件中。指令为 **`using namespace`** 后加上命名空间的名称，之后使用就不需要在前面加上命名空间的名称了。

示例 : 使用 `using` 指令引入命名空间

```cpp showLineNumbers
#include <iostream>
using namespace std;

// 第一个命名空间
namespace first_namespace {
    void func() {
        cout << "Inside first_namespace" << endl;
    }
}

using namespace first_namespace;

int main(void)
{
    // 调用第一个命名空间中的函数
    first_namespace::func();
    return 0;
}
```

编译运行以上示例，输出结果如下：

```bash
Inside first_namespace
```

除了引入整个命名空间，`using` 关键字也可以只引入指定命名空间中的特定项目。例如，我们只打算使用 `std` 命名空间中的 `cout`，则可以使用如下的语句：

```cpp showLineNumbers
using std::cout;
```

之后的代码在使用 `cout` 时就可以不用加上命名空间名称作为前缀。但是 `std` 命名空间中的其他项目仍然需要加上命名空间名称作为前缀。例如：

```cpp showLineNumbers
#include <iostream>
using std::cout;

int main(void)
{
    cout << "std::endl must used with std!" << std::endl;
    return 0;
}
```

编译运行以上的代码，输出结果如下：

```bash
std::endl must used with std!
```

注意：`using` 引入的名称遵循正常的范围规则，名称从使用 `using` 开始是可见的，直到该范围结束。此时，在范围以外定义的同名实体是隐藏的。



## 不连续的命名空间

一个命名空间的各个组成部分可以分散在多个文件中。也就是说，命名空间的定义可以不连续，可以由几个单独定义的部分组成的。

如果命名空间中的某个组成部分需要请求定义在另一个文件中的名称，则仍然需要声明该名称。因此，下面的命名空间定义可以是定义一个新的命名空间，也可以是为已有的命名空间增加新的元素。

```cpp showLineNumbers
namespace namespace_name {
    // 代码声明
}
```



## 嵌套的命名空间

命名空间可以嵌套，我们可以在一个命名空间中定义另一个命名空间。例如：

```cpp showLineNumbers
namespace namespace_name1 {
    // 代码声明
    
    namespace namespace_name2 {
        // 代码声明
    }
}
```

我们可以通过使用 `::` 运算符来访问嵌套的命名空间中的成员。

```cpp showLineNumbers
// 访问 namespace_name2 中的成员
using namespace namespace_name1::namespace_name2;

// 访问 namespace:name1 中的成员
using namespace namespace_name1;
```

在上面的语句中，如果使用的是 `namespace_name1`，那么在该范围内 `namespace_name2` 中的元素也是可用的。

**示例**：命令空间嵌套使用

```cpp showLineNumbers
#include <iostream>
using namespace std;

// 第一个命名空间
namespace first_namespace
{
    void func() {
        cout << "Inside first space" << endl;
    }
    
    // 第二个命名空间
    namespace second_namespace
    {
        void func() {
            cout << "Inside second space" << endl;
        }
    }
}

using namespace first_namespace::second_namespace;

int main(void)
{
    // 调用第二个命名空间中的函数
    func();
    return 0;
}
```

执行 `$ g++ main.cpp && ./a.out` 编译运行以上示例，输出结果如下：

```bash
Inside second space
```