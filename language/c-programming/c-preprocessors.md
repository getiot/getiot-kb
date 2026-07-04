---
sidebar_position: 30
---

# C 语言 - 预处理器

**C 预处理器**（Preprocessor）不是编译器的一部分，而是编译过程中的一个单独步骤。简单来说，C 预处理器只是一个文本替换工具，它指示编译器在实际编译之前进行所需的预处理。

在 C 语言中，所有预处理器命令（Directive）均以井号（`#`）开头。它必须是第一个非空白字符，换句话说，预处理器指令 `#` 前面可以有空白符，但是为了可读性，不建议在 `#` 前面添加空白符。

下表列出了 C 语言中常见且重要的预处理器指令。

| 序号 |      指令      | 说明                                       |
| :--: | :------------: | :----------------------------------------- |
|  1   | **`#define`**  | 替代预处理器宏，或者叫“宏定义”。           |
|  2   | **`#include`** | 引入一个头文件。                           |
|  3   |  **`#undef`**  | 取消定义预处理器宏。                       |
|  4   |  **`#ifdef`**  | 如果定义了该宏，则返回 true。              |
|  5   | **`#ifndef`**  | 如果未定义该宏，则返回 true。              |
|  6   |   **`#if`**    | 测试编译时条件是否为真。                   |
|  7   |  **`#else`**   | `#if` 条件的另一个分支。                   |
|  8   |  **`#elif`**   | 相当于将 `#else` 和 `#if` 写在一条语句中。 |
|  9   |  **`#endif`**  | 结束 `#if` 预处理器。                      |
|  10  |  **`#error`**  | 在 stderr 上打印错误消息。                 |
|  11  | **`#pragma`**  | 使用标准方法向编译器发出特殊命令。         |

## 初识预处理器

下面通过一些简单的示例，带你了解 C 语言预处理器的常见用法。

```c showLineNumbers
#define MAX_ARRAY_LENGTH 20
```

上述指令告诉 C 预处理器在编译时将代码中的 `MAX_ARRAY_LENGTH` 实例替换为数字 `20`。对常量使用 `#define` 可以提高代码可读性，例如在这个示例中，你可以很清晰地知道数字 20 表示的是数组长度。

```c showLineNumbers
#include <stdio.h>
#include "myheader.h"
```

上述指令告诉 C 预处理器从系统库获取头文件 stdio.h 并将其内容插入到当前源文件中，第二行告诉 C 预处理器从本地目录获取头文件 **myheader.h** 并将其内容插入到当前源文件中。

```c showLineNumbers
#undef  FILE_SIZE
#define FILE_SIZE 42
```

上述指令告诉 C 预处理器取消已经存在的 `FILE_SIZE` 宏定义，然后将其重新定义为 42。

```c showLineNumbers
#ifndef MESSAGE
    #define MESSAGE "You wish!"
#endif
```

上述指令告诉 C 预处理器如果 `MESSAGE` 宏还没定义，则定义该宏。

```c showLineNumbers
#ifdef DEBUG
    /* Your debugging statements here */
#endif
```

上述指令告诉 C 预处理器如果定义了 `DEBUG`，就处理该宏所包含的语句。例如，如果你在编译时将 `-DDEBUG` 标志传递给 gcc 编译器，就会定义 `DEBUG` 宏。通过这种方式，你可以在编译期间动态打开和关闭调试。

## 预定义宏

ANSI C 预定义了一些宏，它们使用双下划线包裹。你可以在你的 C 程序中使用它们。但需要注意，请不要直接修改这些预定义的宏，例如取消定义或重新定义它们。

| 序号 |       宏       | 说明                                          |
| :--: | :------------: | :-------------------------------------------- |
|  1   | **`__DATE__`** | 当前日期，以 `MMM DD YYYY` 格式保存的字符串。 |
|  2   | **`__TIME__`** | 当前时间，以 `HH:MM:SS` 格式保存的字符串。    |
|  3   | **`__FILE__`** | 当前文件名，以字符串格式保存。                |
|  4   | **`__LINE__`** | 当前代码行号，以十进制常量形式保存。          |
|  5   | **`__STDC__`** | 当编译器符合 ANSI 标准时定义为 1。            |

一起来看看下面的例子：

```c showLineNumbers
#include <stdio.h>

int main()
{
    printf("File :%s\n", __FILE__ );
    printf("Date :%s\n", __DATE__ );
    printf("Time :%s\n", __TIME__ );
    printf("Line :%d\n", __LINE__ );
    printf("ANSI :%d\n", __STDC__ );
    return 0;
}
```

将上述代码保存为 test.c 文件，编译并运行程序，结果如下：

```bash showLineNumbers
File :test.c
Date :Nov 19 2023
Time :14:11:37
Line :8
ANSI :1
```

## 预处理器运算符

C 语言预处理器提供了一些运算符（Operator）用于帮助程序员创建宏定义。

### 宏延续（`\`）运算符

在 C 语言中，宏通常仅限于一行。但如果你确实需要定义比较长的宏，可以使用宏延续运算符（Macro continuation operator）将其分成多行。宏延续运算符使用反斜杠（`\`）表示，请看下面示例：

```c showLineNumbers
#define  message_for(a, b)  \
    printf(#a " and " #b ": We love you!\n")
```

### 字符串化（`#`）运算符

在宏定义中使用字符串化运算符（Stringize operator）时，会将宏参数转换为字符串常量。需要注意，该运算符只能用在具有指定参数或参数列表的宏中。字符串化运算符使用井号（`#`）表示，请看下面示例：

```c showLineNumbers
#include <stdio.h>

#define  message_for(a, b)  \
    printf(#a " and " #b ": We love you!\n")

int main(void) {
    message_for(Carole, Debra);
    return 0;
}
```

编译并执行上述程序，输出结果如下：

```bash showLineNumbers
Carole and Debra: We love you!
```

### 标记粘贴（`##`）运算符

宏定义中的标记粘贴运算符（Token pasting operator）用于组合两个参数。使用它，可以将宏定义中的两个单独的标记连接成单个标记。标记粘贴运算符使用双井号（`##`）表示，请看下面示例：

```c showLineNumbers
#include <stdio.h>

#define tokenpaster(n) printf ("token" #n " = %d", token##n)

int main(void) {
    int token34 = 40;
    tokenpaster(34);
    return 0;
}
```

编译并执行上述程序，输出结果如下：

```bash showLineNumbers
token34 = 40
```

实际上，在这个例子中，第 7 行 `tokenpaster(34);` 会被预处理器转换为如下代码：

```c showLineNumbers
printf ("token34 = %d", token34);
```

这个例子不仅演示了 `token##n` 到 `token34` 的符号粘贴，还使用了字符串化运算符。

### `defined()` 运算符

预处理器 **`defined`** 运算符可以测试某个标识符是否已使用 `#define` 定义。如果定义了指定的标识符，则该值为 true（非零）；如果未定义符号，则值为 false（零）。请看下面示例：

```c showLineNumbers
#include <stdio.h>

#if !defined (MESSAGE)
    #define MESSAGE "You wish!"
#endif

int main(void) {
    printf("Here is the message: %s\n", MESSAGE);  
    return 0;
}
```

编译并执行上述程序，输出结果如下：

```bash showLineNumbers
Here is the message: You wish!
```

你可以在编译时定义 `MESSAGE` 宏并指定一个值，例如：

```bash showLineNumbers
gcc defined_example.c -DMESSAGE="\"getiot.tech\""
```

此时，程序输出结果为：

```bash showLineNumbers
Here is the message: getiot.tech
```



## 参数化宏

C 预处理器的另一个强大功能是可以使用参数化宏（Parameterized macros）来模拟函数。例如，有一个用于计算一个数字的平方的函数，如下所示。

```c showLineNumbers
int square(int x) {
    return x * x;
}
```

你可以使用宏来实现上述代码，如下：

```c showLineNumbers
#define square(x) ((x) * (x))
```

带参数的宏必须先使用 `#define` 指令定义，然后才能使用。参数列表用括号括起来，并且必须紧跟在宏名称之后。值得注意的是，宏名称和左括号之间不允许有空格。请看下面示例：

```c showLineNumbers
#include <stdio.h>

#define MAX(x, y) ((x) > (y) ? (x) : (y))

int main(void) {
    printf("Max between 20 and 10 is %d\n", MAX(10, 20));  
    return 0;
}
```

编译并执行上述程序，输出结果如下：

```bash showLineNumbers
Max between 20 and 10 is 20
```

