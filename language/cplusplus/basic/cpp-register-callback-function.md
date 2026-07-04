---
sidebar_position: 56
slug: /cpp-register-callback-function
---

# C++ 注册回调函数



回调模式是一种常见的设计模式，在 C++ 程序设计中有着广泛的应用。例如，在 SDK 的设计中，为增强 SDK 的通用性，比如嵌入算法逻辑、实现插件支持等，这时候回调函数就能派上用场了。

下面通过三个示例，带领读者循序渐进设计 C++ 的回调函数，实现回调函数的注册和执行，以及参数的传递。与 C 语言中通过函数指针实现回调不同，在 C++ 中通常使用 `std::function` 和 `std::bind` 实现。



## 示例1：简单的回调

GitHub：[CallbackDemo.cpp](https://github.com/getiot/linux-cpp/blob/main/Demo/Callback/CallbackDemo.cpp)

```cpp showLineNumbers
#include <iostream>
#include <functional>

// 外部函数
void externalFunction() {
    // 在这里添加外部函数的实现
    // 这是一个示例，你可以根据你的需要来编写具体实现
    std::cout << "Calling external function." << std::endl;
}

class MyDemo {
public:
    // 绑定外部函数并调用
    void bindExternalFunction() {
        // 绑定外部函数到成员函数
        std::function<void()> func = std::bind(&externalFunction);
        
        // 在需要调用的时候调用
        func();
    }
};

int main() 
{
    MyDemo demo;
    demo.bindExternalFunction();
    
    return 0;
}
```

在示例1中，首先定义了一个名为 `externalFunction` 的外部函数。然后，我们定义了一个名为 `MyDemo` 的类，其中有一个名为 `bindExternalFunction` 的成员函数。

在 `bindExternalFunction` 中，我们使用 `std::bind` 将外部函数 `externalFunction` 绑定到一个函数对象 `func` 上。最后，我们在需要的时候调用了 `func`，实际上就是通过一种比较直接的方式调用了绑定的外部函数。



## 示例2：注册回调函数

GitHub：[CallbackDemo_Func.cpp](https://github.com/getiot/linux-cpp/blob/main/Demo/Callback/CallbackDemo_Func.cpp)

```cpp showLineNumbers
#include <iostream>
#include <functional>

// 外部函数
void externalFunction() {
    // 在这里添加外部函数的实现
    // 这是一个示例，你可以根据你的需要来编写具体实现
    std::cout << "Calling external function." << std::endl;
}

class MyDemo {
public:
    // 注册回调函数
    void registerCallback(const std::function<void()>& cb_func) {
        // 在需要调用的时候调用
        cb_func();
    }
};

int main() 
{
    MyDemo demo;
    demo.registerCallback(externalFunction);
    
    return 0;
}
```

在示例2中，我们对示例1进行了改进，在 `MyDemo` 类中定义了一个名为 `registerCallback` 的成员函数，用于注册回调函数。

在 `main` 函数中通过 `demo.registerCallback(externalFunction)` 将外部函数 `externalFunction` 注册到 `demo` 对象中。最后，在需要的时候调用该回调函数。



## 示例3：带参数的回调

GitHub：[CallbackDemo_Params.cpp](https://github.com/getiot/linux-cpp/blob/main/Demo/Callback/CallbackDemo_Params.cpp)

```cpp showLineNumbers
#include <iostream>
#include <functional>

// 外部函数
void externalFunction(int loop, std::string& msg) {
    // 在这里添加外部函数的实现
    // 这是一个示例，你可以根据你的需要来编写具体实现
    for (auto i=0; i<loop; i++) {
        std::cout << msg << std::endl;
    }
}

class MyDemo {
public:
    // 注册回调函数
    void registerCallback(const std::function<void(int, std::string&)>& cb_func) {
        // 在需要调用的时候调用
        std::string msg("Calling external function.");
        cb_func(3, msg);
    }
};

int main() 
{
    MyDemo demo;
    demo.registerCallback(externalFunction);
    
    return 0;
}
```

在示例3中，我们进一步修改示例2，注册一个带参数的回调函数。外部函数 `externalFunction` 具有两个参数 loop 和 msg，因此在 `MyDemo` 类的 `registerCallback` 成员函数需要声明参数列表。最后，在需要的时候调用该回调函数，并传入所需的参数。



## 运行

你可以在 [GitHub](https://github.com/getiot/linux-cpp/tree/main/Demo/Callback) 中找到上述3个示例代码，以及 Makefile 文件，在工程目录中执行 `make` 即可编译。

```bash
$ make
g++ -std=c++17 -Wall -Wextra -o CallbackDemo CallbackDemo.cpp
lg++ -std=c++17 -Wall -Wextra -o CallbackDemo_Func CallbackDemo_Func.cpp
g++ -std=c++17 -Wall -Wextra -o CallbackDemo_Params CallbackDemo_Params.cpp
```

编译成功会生成3个可执行文件，我们可以依次执行它们，例如：

```bash
$ ./CallbackDemo
Calling external function.
```

