---
sidebar_position: 48
slug: /cpp-preprocessor
---

# C++ 预处理器



在 C++ 语言中，预处理是指在进行编译的第一遍扫描（词法扫描和语法分析）之前所作的工作。预处理是 C++ 的一个重要功能，它由预处理程序负责完成。当对一个源文件进行编译时，系统把自动引用预处理程序对源程序中的预处理部分作处理，处理完毕自动进入对源程序的编译。

C++ 提供了多种预处理功能，如宏定义、文件包含、 条件编译等。合理地使用预处理功能编写的程序便于阅读、修改、 移植和调试，也有利于模块化程序设计。



## 编译步骤

实际上，C/C++ 程序的构建（Build）可分为四个阶段：预处理、编译、汇编、链接。

1. 预处理（Pre-Processing）就是本文要详细说的宏替换、头文件包含等。
2. 编译（Compiling）是指对预处理后的代码进行语法和语义分析，最终得到汇编代码或接近汇编的其他中间代码。
3. 汇编（Assembling）是指将上一步得到的汇编或中间代码转换为目标机器的二进制指令，一般是每个源文件生成一个二进制文件（VS 是 .obj，GCC 是 .o）。
4. 链接（Linking）是对上一步得到的多个二进制文件“链接”成可执行文件或库文件等。

参考：[gcc 命令](/linux-command/gcc/)



## 预处理器

预处理器是一些指令，指示编译器在实际编译之前所需完成的预处理。使用特点如下：

- 所有的预处理器指令都是以**井号（`#`）**开头；
- 只有空格字符可以出现在预处理指令之前；
- 预处理指令不是 C++ 语句，所以它们不会以分号（`;`）结尾。

前面所有的 C++ 示例中都有 `#include` 指令，其实它们就是预处理指令，用于把头文件包含到源文件中。

C++ 还支持很多预处理指令：`#include`、`#define`、`#if`、`#else`、`#line` 等。



## define 宏

`#define` 预处理指令用于创建符号常量，该符号常量通常称为**宏**（Macro）。语法格式如下：

```cpp showLineNumbers
#define macro-name replacement-text
```

使用 `#define` 定义了宏，在该文件中后续出现的所有宏 `macro-name` 都将会在程序编译之前被替换为 `replacement-text`。

示例代码：

```cpp showLineNumbers
#include <iostream>
using namespace std;

#define PI 3.1415926

int main(void)
{
    cout << "Value of PI is :" << PI << endl;
    return 0;
}
```

现在开始测试这段代码，先来看看预处理的结果。使用 `-E` 选项表示只执行预处理，命令如下：

```bash
g++ -E main.cpp -o main.i
```

然后使用 `tail main.i` 命令查看预处理后的 main.i 文件末尾部分的内容，如下：

```cpp showLineNumbers
# 2 "main.cpp"
using namespace std;



int main(void)
{
    cout << "Value of PI is :" << 3.1415926 << endl;
    return 0;
}
```

可以看到，代码中的 `PI` 数字 3.1415926 替换了！



## 定义参数宏

可以使用 `#define` 来定义一个带有参数的宏，语法格式如下：

```cpp showLineNumbers
#include <iostream>
using namespace std;

#define MAX(a,b) (a>b ? a : b)

int  main ()
{
    int i, j;
    i = 39;
    j = 47;
    cout <<"较大的值为：" << MAX(i, j) << endl;
    
    return 0;
}
```

执行 `g++ main.cpp && ./a.out` 编译运行以上程序，输出结果如下：

```bash
较大的值为：47
```



## 条件编译

`#if`、`#else`、`#endif` 等几个指令可以用来有选择地对部分程序源代码进行编译。这个过程被称为**条件编译**。下表列出了 C++ 中支持的所有条件编译指令。

| 条件编译指令 | 说明                                             |
| ------------ | ------------------------------------------------ |
| `#if`        | 如果条件为真，则执行相应操作。                   |
| `#elif`      | 如果前面条件为假，而该条件为真，则执行相应操作。 |
| `#else`      | 如果前面条件均为假，则执行相应操作。             |
| `#endif`     | 结束相应的条件编译指令。                         |
| `#ifdef`     | 如果该宏已定义，则执行相应操作。                 |
| `#ifndef`    | 如果该宏没有定义，则执行相应操作。               |

条件预处理器的结构与 if-else 选择结构很像。比如这段预处理器的代码：

```cpp showLineNumbers
#ifndef NULL
   #define NULL 0
#endif
```

我们可以只在调试时进行编译，调试开关可以使用一个宏来实现：

```cpp showLineNumbers
#ifdef DEBUG
   cerr << "Variable x = " << x << endl;
#endif
```

如果在指令 `#ifdef DEBUG` 之前已经定义了符号常量 `DEBUG`，则会对程序中的 `cerr` 语句进行编译。

在代码调试中，常常使用 `#if 0` 语句注释掉程序的一部分，比如：

```cpp showLineNumbers
#if 0
   不进行编译的代码
#endif
```

接下来我们看一个使用条件编译的示例：

```cpp showLineNumbers
#include <iostream>
using namespace std;

#define DEBUG

#define MAX(a,b) (((a)>(b)) ? a : b)

int main(void)
{
    int i, j;
    i = 100;
    j = 30;

#ifdef DEBUG
    cerr <<"Trace: Inside main function" << endl;
#endif

#if 0
    /* 这是注释部分 */
    cout << MKSTR(HELLO C++) << endl;
#endif
    
    cout <<"The manimum is " << MAX(i, j) << endl;

#ifdef DEBUG
    cerr <<"Trace: Coming out of main function" << endl;
#endif
    return 0;
}
```

编译运行以上示例，输出结果如下：

```bash
Trace: Inside main function
The manimum is 100
Trace: Coming out of main function
```



## # 运算符

`#` 和 `##` 预处理运算符在 C++ 和 ANSI/ISO C 中都是可用的。`#` 运算符会把 `replacement-text` 令牌转换为用引号引起来的字符串。

```cpp showLineNumbers
#define macro-name replacement-text
```

我们来看一个示例：

```cpp showLineNumbers
#include <iostream>
using namespace std;

#define MKSTR( x ) #x

int main(void)
{
    cout << MKSTR(HELLO 人人都懂物联网) << endl;
    return 0;
}
```

编译运行以上示例，输出结果如下：

```bash
HELLO 人人都懂物联网
```

让我们来看看它是如何工作的，执行 `gcc -E main.cpp | tail` 命令预处理并查看预处理后的代码。如下：

```cpp showLineNumbers
# 2 "main.cpp"
using namespace std;



int main(void)
{
    cout << "HELLO 人人都懂物联网" << endl;
    return 0;
}
```

C++ 预处理器把下面这行：

```cpp showLineNumbers
cout << MKSTR(HELLO 人人都懂物联网) << endl;
```

转换成了

```cpp showLineNumbers
cout << "HELLO 人人都懂物联网" << endl;
```



## ## 运算符

`##` 运算符可以把两个令牌拼接起来，语法如下：

```cpp showLineNumbers
#define CONCAT( x, y )  x ## y
```

当 `CONCAT` 出现在程序中时，它的参数会被连接起来，并用来取代宏。

示例： 使用 `##` 拼接令牌

```cpp showLineNumbers
#include <iostream>
using namespace std;

#define CONCAT(a, b) a ## b
int main(void)
{
    double xy = 99.999;
    cout << CONCAT(x, y) << endl;
    
    return 0;
}
```

编译运行以上程序，输出结果如下：

```bash
99.999
```

让我们来看看它是如何工作的，执行 `gcc -E main.cpp | tail` 命令预处理并查看预处理后的代码。如下：

```cpp showLineNumbers
using namespace std;


int main(void)
{
    double xy = 99.999;
    cout << xy << endl;

    return 0;
}
```

C++ 预处理器把下面这行：

```cpp showLineNumbers
cout << CONCAT(x, y) << endl;
```

转换成了

```cpp showLineNumbers
cout << xy << endl;
```



## C++ 中预定义的宏

为了方便调试，C++ 中预定义的一些宏，如下表所示。

| 宏         | 说明                                                         |
| ---------- | ------------------------------------------------------------ |
| `__LINE__` | 这会在程序编译时包含当前行号。                               |
| `__FILE__` | 这会在程序编译时包含当前文件名。                             |
| `__DATE__` | 这会包含一个形式为 `month/day/year` 的字符串，它表示把源文件转换为目标代码的日期。 |
| `__TIME__` | 这会包含一个形式为 `hour:minute:second` 的字符串，它表示程序被编译的时间。 |

示例： 使用 C++ 中预定义的宏

```cpp showLineNumbers
#include <iostream>
using namespace std;

int main ()
{
    cout << "Value of __LINE__ : " << __LINE__ << endl;
    cout << "Value of __FILE__ : " << __FILE__ << endl;
    cout << "Value of __DATE__ : " << __DATE__ << endl;
    cout << "Value of __TIME__ : " << __TIME__ << endl;

    return 0;
}
```

编译运行以上程序，输出结果如下：

```bash
Value of __LINE__ : 6
Value of __FILE__ : main.cpp
Value of __DATE__ : Nov 30 2021
Value of __TIME__ : 13:08:17
```

让我们来看看它是如何工作的，执行 `gcc -E main.cpp | tail` 命令预处理并查看预处理后的代码。如下：

```cpp showLineNumbers

int main ()
{
    cout << "Value of __LINE__ : " << 6 << endl;
    cout << "Value of __FILE__ : " << "main.cpp" << endl;
    cout << "Value of __DATE__ : " << "Nov 30 2021" << endl;
    cout << "Value of __TIME__ : " << "13:09:20" << endl;

    return 0;
}
```



## #error 错误宏

`#error` 用于在编译期间给出一个错误信息，并终止程序的编译。语法如下：

```cpp showLineNumbers
#error error-message
```

注意，`#error` 后面的错误信息不需要使用双引号。



## 取消宏定义

在 C++ 中，可以使用 `undef` 取消之前定义的宏。语法如下：

```cpp showLineNumbers
#undef MACRO_NAME
```

示例：

```cpp showLineNumbers
#include <iostream>
using namespace std;

#define PI 3.1415926
int main(void)
{
    cout << "PI = " << PI << endl;
    #undef PI
    cout << "PI = " << PI << endl;
    return 0;
}
```

编译程序，出现如下错误：

```bash
$ g++ undef_example.cpp 
undef_example.cpp: In function ‘int main()’:
undef_example.cpp:9:24: error: ‘PI’ was not declared in this scope
    9 |     cout << "PI = " << PI << endl;
      |                        ^~
```

这是因为第二次 `cout` 输出的时候，参数宏 `PI` 已经被取消了。