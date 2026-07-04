---
sidebar_position: 42
---

# C 语言 - extern 用法


## 全局变量

假设在一个 .c 文件里定义全局变量 a 为 int 型，然后在头文件声明了 `extern int a;`，可是另一个 .c 文件在使用变量 a 的时候觉得 double 会更好，然后就声明了 `extern double a;`，但是又没有把所有类型修改过来，这会导致编译出错。解决办法是要么所有声明都使用 `extern a;` 不指定类型，由变量定义的地方确定类型。

为了确保全局变量的唯一性，可以在头文件中使用如下宏定义进行保护。

```c showLineNumbers
#ifdef xxx_GLOBALS
#define xxx_EXT
#else
#define xxx_EXT extern
#endif
```

并只在真正定义该变量的源文件中添加 `xxx_GLOBALS` 宏定义（在引用该头文件之前）。

```c showLineNumbers
#define xxx_GLOBALS
#include "xxx.h"
```

当编译器处理 .c 文件时，它强制 `xxx_EXT` 为空（因为 `xxx_GLOBALS` 已经定义），所以编译器会为全局变量分配内存空间。而其他的 .c 文件，由于 `xxx_GLOBALS` 没有定义，所以 `xxx_EXT` 被定义为 extern，这样用户就可以调用外部全局变量了。

