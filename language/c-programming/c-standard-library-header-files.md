---
sidebar_position: 45
---

# C 标准库头文件



C 标准库的 API 接口函数由以下头文件提供定义，其中 C89 标准提供了 15 个头文件，其余由后续的标准引入，在使用时需要稍作注意。

| 头文件                  | 描述                                                         |
| ----------------------- | ------------------------------------------------------------ |
| `<assert.h>`            | [条件编译宏，将参数与零比较](https://en.cppreference.com/w/c/error) |
| `<complex.h>` (C99)     | [复数运算](https://en.cppreference.com/w/c/numeric/complex)  |
| `<ctype.h>`             | [用来确定包含于字符数据中的类型的函数](https://en.cppreference.com/w/c/string/byte) |
| `<errno.h>`             | [报告错误条件的宏](https://en.cppreference.com/w/c/error)    |
| `<fenv.h>` (C99)        | [浮点环境](https://en.cppreference.com/w/c/numeric/fenv)     |
| `<float.h>`             | [浮点类型的极限](https://en.cppreference.com/w/c/types/limits) |
| `<inttypes.h>` (C99)    | [整数类型的格式转换](https://en.cppreference.com/w/c/types/integer) |
| `<iso646.h>` (C95)      | [运算符的替代写法](https://en.cppreference.com/w/c/language/operator_alternative) |
| `<limits.h>`            | [整数类型的范围](https://en.cppreference.com/w/c/types/limits) |
| `<locale.h>`            | [本地化工具](https://en.cppreference.com/w/c/locale)         |
| `<math.h>`              | [常用数学函数](https://en.cppreference.com/w/c/numeric/math) |
| `<setjmp.h>`            | [非局部跳转](https://en.cppreference.com/w/c/program)        |
| `<signal.h>`            | [信号处理](https://en.cppreference.com/w/c/program)          |
| `<stdalign.h>` (C11)    | [`alignas` 与 `alignof`](https://en.cppreference.com/w/c/types) 便利宏 |
| `<stdarg.h>`            | [可变参数](https://en.cppreference.com/w/c/variadic)         |
| `<stdatomic.h>` (C11)   | [原子操作](https://en.cppreference.com/w/c/thread#.E5.8E.9F.E5.AD.90.E6.93.8D.E4.BD.9C) |
| `<stdbool.h>` (C99)     | [布尔类型的宏](https://en.cppreference.com/w/c/types)        |
| `<stddef.h>`            | [常用宏定义](https://en.cppreference.com/w/c/types)          |
| `<stdint.h>` (C99)      | [定宽整数类型](https://en.cppreference.com/w/c/types/integer) |
| `<stdio.h>`             | [输入/输出](https://en.cppreference.com/w/c/io)              |
| `<stdlib.h>`            | 基础工具：[内存管理](https://en.cppreference.com/w/c/memory)、[程序工具](https://en.cppreference.com/w/c/program)、[字符串转换](https://en.cppreference.com/w/c/string)、[随机数](https://en.cppreference.com/w/c/numeric/random)、[算法](https://en.cppreference.com/w/c/algorithm) |
| `<stdnoreturn.h>` (C11) | [`noreturn`](https://en.cppreference.com/w/c/types) 便利宏   |
| `<string.h>`            | [字符串处理](https://en.cppreference.com/w/c/string/byte)    |
| `<tgmath.h>` (C99)      | [泛型数学](https://en.cppreference.com/w/c/numeric/tgmath)（提供 math.h 和 complex.h 的宏封装） |
| `<threads.h>` (C11)     | [线程库](https://en.cppreference.com/w/c/thread)             |
| `<time.h>`              | [时间/日期工具](https://en.cppreference.com/w/c/chrono)      |
| `<uchar.h>` (C11)       | [UTF-16 和 UTF-32 字符工具](https://en.cppreference.com/w/c/string/multibyte) |
| `<wchar.h>` (C95)       | [扩展多字节和宽字符工具](https://en.cppreference.com/w/c/string/wide) |
| `<wctype.h>` (C95)      | [用来确定包含于宽字符数据中的类型的函数](https://en.cppreference.com/w/c/string/wide) |





## 参考

- [https://en.cppreference.com/w/c/header](https://en.cppreference.com/w/c/header)
- [https://zh.cppreference.com/w/c/header](https://zh.cppreference.com/w/c/header)

