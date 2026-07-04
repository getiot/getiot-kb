---
sidebar_position: 37
slug: /cpp-const-function
---

# C++ const 函数



我们经常看到 C++ 函数的前面或后面添加了 `const` 关键字，这是什么意思呢？

在 C++ 函数前后使用 `const` 的作用是不同的：

- 在函数前面添加 `const` 表示返回值为 `const` 类型的变量；
- 在函数后面添加 `const` 则表示函数不可以修改 class 类的成员。



## 示例

下面示例定义了两个函数，分别在函数前后添加 `const` 关键字。

```cpp showLineNumbers
const int getValue1();
int getValue2() const;
```

我们看看它们在使用时有何不同，代码如下：

```cpp showLineNumbers
#include <iostream>
using namespace std;

class GetIoT
{
public:
    GetIoT(int value=0) {
        this->value = value;
    }
    
    int getValue() {
        return value;
    }
    
    const int getValue1() {
        value = 1;
        return value;
    }
    
    int getValue2() const {
        value = 2;
        return value;
    }
    
private:
    int value;
};

int main(void)
{
    GetIoT getiot(3);
    
    cout << "getValue: " << getiot.getValue() << endl;
    cout << "getValue1: " << getiot.getValue1() << endl;
    cout << "getValue2: " << getiot.getValue2() << endl;

    return 0;
}
```

使用 `g++ main.cpp` 命令编译该示例，出现如下错误：

```cpp showLineNumbers
main.cpp: In member function ‘int GetIoT::getValue2() const’:
main.cpp:21:15: error: assignment of member ‘GetIoT::value’ in read-only object
   21 |         value = 2;
      |         ~~~~~~^~~
```

这是因为 `getValue2()` 函数后面添加了 `const`，不能修改成员变量 value 的值。