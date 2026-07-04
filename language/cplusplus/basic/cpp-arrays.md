---
sidebar_position: 19
slug: /cpp-arrays
---

# C++ 数组



在设计 C++ 程序时，如果需要保持很多数据，而且是一组同类型的数据，那么可以使用**数组**。

C++ 支持**数组**数据结构，它可以存储一个固定大小的相同类型元素的顺序集合。

需要注意，在 C++ 中，数组保存的一组数据的类型必须是完全一致的，C++ 不支持数组保存不同的数据类型。这一点和 Python 等动态语言不一样。



## 声明数组

C++ 中声明一个数组，需要指定元素的类型和元素的数量。语法如下：

```cpp showLineNumbers
type arrayName [ arraySize ];
```

1. **arraySize** 必须是一个大于零的整数常量
2. **type** 可以是任意有效的 C++ 数据类型

例如，要声明一个类型为 double 的包含 5 个元素的数组 **grade** ，声明语句如下：

```cpp showLineNumbers
double grade[5];
```

现在，`grade` 是一个可用的数组，可以容纳 5 个类型为 double 的数字。



## 数组初始化

在 C++ 中，数组的初始化有两种方法。一种是在定义数组的时候进行初始化，语法格式为：

```cpp showLineNumbers
type arrName[count] = {val1, val2, val3, ....};
```

其中，大括号 `{}` 之间的值的数目不能大于我们在数组声明时在方括号 `[]` 中指定的元素数目。如果填充的数据不够，对于局部变量而言，其内容是随机的。

示例：定义时初始化

```cpp showLineNumbers
double grade[5] = {88.0, 59.5, 32.5, 99.0, 100.0};
```

如果省略掉了数组的大小，数组的大小则为初始化时元素的个数。例如下面示例将创建一个与前一个示例中所创建的数组是完全相同的数组。

```cpp showLineNumbers
double grade[] = {88.0, 59.5, 32.5, 99.0, 100.0};
```

第二种方法是先声明数组，再逐个初始化。例如：

```cpp showLineNumbers
double grade[5];

grade[0] = 88.0;
grade[1] = 59.5;
grade[2] = 32.5;
grade[3] = 99.0;
grade[4] = 100.0;
```

创建完数组后，我们还可以使用下标索引给数组添加值或者替换相应下标的值。例如，把数组中第五个元素的值赋为 99.5。

```cpp showLineNumbers
grade[4] = 99.5;
```



## 访问数组元素

在 C++ 中，所有的数组都是由连续的内存位置组成。最低的地址对应第一个元素，最高的地址对应最后一个元素。数组中的特定元素可以通过索引访问，并且索引从 0 开始（也被称为基索引）。也就是说，数组第一个元素的索引为 0，最后一个索引是数组的总大小减去 1。

下图列出了上述示例 `grade` 数组在内存中的一般存储形式：

![数组的存储形式](https://static.getiot.tech/cplusplus_array_1.png#center)

所以，我们就可以通过数组名称加索引进行访问来数组元素。其中，元素的索引是放在方括号内，跟在数组名称的后边。例如：

```cpp showLineNumbers
double point = grade[3];
```

这条语句把数组中第 4 个元素的值赋给 `point`变量。



## 示例

下面示例将演示如何声明数组、数组赋值、访问数组。

```cpp showLineNumbers
#include <iostream>
#include <iomanip>

using std::setw;

const int LEN = 10;

int main ()
{
    int arr[ LEN ]; // arr 是一个包含 10 个整数的数组

    // 初始化数组元素          
    for ( int i=0; i<LEN; i++ )
    {
        arr[i] = i + 128; // 设置元素 i 为 i + 128
    }

    std::cout << "Element" << std::setw(13) << "Value" << std::endl;

    // 输出数组中每个元素的值                     
    for ( int j=0; j<10; j++ )
    {
        std::cout << setw(7)<< j << std::setw( 13 ) << arr[j] << std::endl;
    }

    return 0;
}
```

其中，`setw()` 函数用于格式化输出，看起来更整齐。输出结果如下：

```bash
Element        Value
      0          128
      1          129
      2          130
      3          131
      4          132
      5          133
      6          134
      7          135
      8          136
      9          137
```



## 计算数组长度

在 C++ 中，没有获取数组长度的函数，要数组数组的长度，我们可以使用 sizeof 首先获取整个数组的占用字节大小，再次使用 sizeof 获取单个元素的内存大小，最后相除得到数组长度。如下：

```cpp showLineNumbers
int count = sizeof(arr) / sizeof(arr[0]);
```

