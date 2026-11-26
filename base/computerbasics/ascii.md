---
sidebar_position: 1
---

# ASCII 码



## ASCII 简史

我们知道，在计算机内部，所有的信息最终都表示为一个二进制的字符串。每一个二进制位（bit）有0和1两种状态，因此八个二进制位就可以组合出256种状态，这被称为一个字节（byte）。也就是说，一个字节一共可以用来表示256种不同的状态，每一个状态对应一个符号，就是256个符号，从 0000 0000 到 1111 1111。

上个世纪60年代，美国制定了一套字符编码，对英语字符与二进制位之间的关系，做了统一规定。这被称为ASCII码，一直沿用至今。

ASCII 码一共规定了128个字符的编码，比如空格“SPACE”是32（二进制 0010 0000），大写的字母 A 是65（二进制0100 0001）。这128个符号（包括32个不能打印出来的控制符号），只占用了一个字节的后面7位，最前面的1位统一规定为0。



## ASCII 码表

![](https://static.getiot.tech/ascii-table-875px.png#center)



## 大小写字母相差32

32，这个数字很凑巧，刚好可以使用位运算来对大小写进行转换，其实是在1963年一次投票后 ASCII 码中大小写才改进为相差32：

The X3.2.4 task group voted its approval for the change to ASCII at its May 1963 meeting.Locating the lowercase letters in columns 6 and 7 caused the characters to differ in bit pattern from the upper case by a single bit, which simplified case-insensitive character matching and the construction of keyboards and printers.



