---
sidebar_position: 2
---

# C 语言标准

C 语言自诞生到现在，期间经历了多次标准化过程，主要分成以下几个阶段：



## Traditional C

此时的 C 语言还没有标准化，来自“C Programming Language, First Edition, by Brian W. Kernighan, Dennis M. Ritchie. Prentice Hall PTR 1978”的 C 描述可算作“正式”的标准，所以此时的 C 也称为“K&R” C。

期间 C 语言一直不断的发生细微的变化，各编译器厂商也有自己的扩展，这个过程一直持续到20世纪80年代末。



## C89

考虑到标准化的重要，ANSI（American National Standards Institute）制定了第一个 C 标准，在1989年被正式采用（American National Standard X3.159-1989），故称为 C89，也称为 ANSI C。

该标准随后被 ISO 采纳，成为国际标准（ISO/IEC 9899:1990）。

C89 的主要改动：

- 定义了 C 标准库；
- 新的预处理命令和特性；
- 函数原型（prototype）；
- 新关键字：const、volatile、signed；
- 宽字符、宽字符串和多字节字符；
- 转化规则、声明（declaration）、类型检查的改变。



## C95

这是对 C89 的一个修订和扩充，称为“C89 with Amendment 1”或 C95，严格说来并不是一个真正的标准。

C95 的主要改动：

- 3个新标准头文件：iso646.h、wctype.h、wchar.h；
- 一些新的标记（token）和宏（macro）；
- 一些新的 printf/scanf 系列函数的格式符；
- 增加了大量的宽字符和多字节字符函数、常数和类型。



## C99

1999年，在做了一些必要的修正和完善后，ISO 发布了新的 C 语言标准，命名为 ISO/IEC 9899:1999，简称“C99”。

C99 的主要改动：

- 复数（complex）；
- 整数（integer）类型扩展；
- 变长数组；
- Boolean 类型；
- 非英语字符集的更好支持；
- 浮点类型的更好支持；
- 提供全部类型的数学函数；
- C++ 风格注释（`//`）。



## C11

2007 年，C语言标准委员会又重新开始修订C语言，到了 2011 年正式发布了 ISO/IEC 9899:2011，简称为 C11 标准。

C11 标准新引入的特征尽管没 C99 相对 C90 引入的那么多，但是这些也都十分有用，比如：字节对齐说明符、泛型机制（generic selection）、对多线程的支持、静态断言、原子操作以及对 Unicode 的支持。



## C17

C17（也被称为为 C18）是于2018年6月发布的 ISO/IEC 9899:2018 的非正式名称，也是目前（截止到2020年6月）为止最新的 C语言编程标准，被用来替代 C11 标准。

C17 没有引入新的语言特性，只对 C11 进行了补充和修正。



## C2x

下一个版本的 C 标准，预计将于2022年12月1日完成。

有许多人提出想为 C 语言添加面向对象的特性，包括增加类、继承、多态等已被 C++ 语言所广泛使用的语法特性，但是最终被委员会驳回了。因为这些复杂的语法特性并不符合 C 语言的设计理念以及设计哲学，况且 C++ 已经有了这些特性，C 语言无需再对它们进行支持。

关于C语言历史与演化进程的详细介绍可参考维基百科：[C (programming language)](https://en.wikipedia.org/wiki/C_(programming_language))。

