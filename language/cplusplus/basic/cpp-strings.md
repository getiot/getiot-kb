---
sidebar_position: 20
slug: /cpp-strings
---

# C++ 字符串



在 C++ 中，我们有两种方式表示字符串，一种是使用 char 数组（字符数组），另一种是使用 string 类。string 类是 STL 中 basic_string 模板实例化得到的模板类，与 char 数组相比，使用起来更方便。



## 字符数组

字符数组就是一个 char 类型的数组，是最直接的字符串。例如：

```cpp showLineNumbers
char hello[] = {'H','e','l','l','o','\0'};
```

`hello` 是一个字符数组，它的内容是 `Hello` 字符串。其中，字符 `\0` 对应 `NULL`，表示一个字符串的结束，是字符串所必须的。

运行下面示例可以加深理解：

```cpp showLineNumbers
#include <iostream>

int main()
{
    char hello[] = {'H','e','l','l','o','\0'};
    std::cout << hello << std::endl;

    char world[] = {'W','o','r','l','d','\0','H','i','\0'};
    std::cout << world << std::endl;

    return 0;
}
```

编译运行上面的代码，输出结果如下：

```bash
Hello
World
```

除了像数组一样初始化字符数组，我们还可以直接将字符串赋值给字符数组。下面三种初始化方式的效果是一样的，都创建了一个 "Hello" 字符串。

```cpp showLineNumbers
char hello[6] = {'H', 'e', 'l', 'l', 'o', '\0'};
char hello[6] = "Hello";
char hello[] = "Hello";
```

由于 C++ 编译器会在初始化数组时，会自动把 `\0` 放在字符串的末尾，所以不需要额外把 `\0` 字符放在字符串常量的末尾。



### 字符数组相关函数

C++ 在头文件 `<cstring>` 中包含了大量的的函数用来操作以 `\0` 结尾的字符数组（字符串）。常用的一些函数及说明如下：

| 函数             | 说明                                                         |
| ---------------- | ------------------------------------------------------------ |
| `strcpy(s1, s2)` | 复制字符串 s2 到字符串 s1。                                  |
| `strcat(s1, s2)` | 连接字符串 s2 到字符串 s1 的末尾。                           |
| `strlen(s1)`     | 返回字符串 s1 的长度。                                       |
| `strcmp(s1, s2)` | 如果 s1 和 s2 是相同的，则返回 0；如果 s1s2 则返回大于 0。   |
| `strchr(s1, ch)` | 返回一个指针，指向字符串 s1 中字符 ch 的第一次出现的位置。   |
| `strstr(s1, s2)` | 返回一个指针，指向字符串 s1 中字符串 s2 的第一次出现的位置。 |

下面示例将演示如何使用这些函数：

```cpp showLineNumbers
#include <iostream>
#include <cstring>

int main()
{
    char str1[11] = "Hello";
    char str2[11] = "World";
    char str3[11];
    int  len ;

    // 复制 str1 到 str3
    strcpy( str3, str1);
    std::cout << "strcpy(str3, str1) : " << str3 << std::endl;

    // 连接 str1 和 str2
    strcat( str1, str2);
    std::cout << "strcat(str1, str2) : " << str1 << std::endl;

    // 连接后，str1 的总长度
    len = strlen(str1);
    std::cout << "strlen(str1) : " << len << std::endl;

    return 0;
}
```

编译和运行以上示例，输出结果如下：

```bash
strcpy(str3, str1) : Hello
strcat(str1, str2) : HelloWorld
strlen(str1) : 10
```



## string 类

string 类是 STL 中 basic_string 模板实例化得到的模板类，其定义如下：

```cpp showLineNumbers
typedef basic_string <char> string;
```

由于字符串的使用频率很高，而字符数组使用起来不太方便，所以 C++ 通过标准库的形式专门提供了一个字符串类型 `std::string`。

使用 C++ 提供的 `std::string` 类型需要包含头文件 `<string>`。

```cpp showLineNumbers
#include <string>
```

如果想去掉命名空间前缀 `std::` ，则可以加上 `using namespace std;`

```cpp showLineNumbers
#include <string>

using namespace std;
```

`std::string` 类型的使用和其它基本类型，比如 `int`,`short` 一样。例如，声明一个字符串变量的形式如下：

```cpp showLineNumbers
string hello = "Hello";
```

除此之外，string 类还提供了多个构造函数，提供非常灵活的初始化操作。例如：

```cpp showLineNumbers
string s1();               // s1 = ""
string s2("GetIoT");       // s2 = "GetIoT"
string s3(4, 'G');         // s3 = "GGGG"
string s4("12345", 1, 3);  // s4 = "234"，即 "12345" 的从下标 1 开始，长度为 3 的子串
```

可以使用字符串 string 的构造函数来构造字符串对象，关于构造函数的内容在后续讲解。



### string 赋值

在 C++ 中，对 string 类字符串进行直接赋值时，可以使用双引号的形式，如果是单个字符，我们还可以使用单引号。例如：

```cpp showLineNumbers
string s1;
s1 = "Hello";  // s1 = "Hello"
s2 = 'H';      // s2 = "H"
```

除了使用 `=` 赋值运算符，string 类提供了 assign 方法，该方法提供了多种参数形式，可以很灵活得给 string 字符串赋值。

示例：使用 assign 方法

```cpp showLineNumbers
string s1("12345"), s2;
s2.assign(s1);             // s2 = s1
s2.assign(s1, 1, 2);       // s2 = "23"，即 s1 的子串(1, 2)
s2.assign(4, 'H');         // s2 = "HHHH"
s2.assign("abcde", 2, 3);  // s2 = "cde"，即 "abcde" 的子串(2, 3)
```



### string 长度

和字符数组通过 sizeof 或 strlen 函数获取长度不同，要获取 string 类型的字符串的长度，可以直接使用 length 函数或者使用 size 函数。

像这样：

```cpp showLineNumbers
string s = "Hello World";
s.length();
s.size();
```



### string 操作符

string 字符串可以使用加法（+）运算符将两个字符串拼接成一个字符串。如下：

```cpp showLineNumbers
string hello = "Hello";
string world = "World";

string hello_world  = hello + world;       // 得到 "HelloWorld";
string hello_world2 = hello + " " + world; // 得到 "Hello World";
```

运行下面示例可以加深理解：

```cpp showLineNumbers
#include <iostream>
#include <string>

int main()
{
   std::string str1 = "Hello";
   std::string str2 = "World";
   std::string str3;
   int  len ;

   // 复制 str1 到 str3
   str3 = str1;
   std::cout << "str3 : " << str3 << std::endl;

   // 连接 str1 和 str2
   str3 = str1 + str2;
   std::cout << "str1 + str2 : " << str3 << std::endl;

   // 连接后，str3 的总长度
   len = str3.size();
   std::cout << "str3.size() :  " << len << std::endl;

   return 0;
}
```

输出结果如下：

```bash
str3 : Hello
str1 + str2 : HelloWorld
str3.size() :  10
```

