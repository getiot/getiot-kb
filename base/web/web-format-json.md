---
sidebar_position: 6
slug: /web-format-json
---

# JSON 格式



JSON 是 JavaScript Object Notation 的缩写，即 JavaScript 对象表示法，读作“J-son”。JSON 是一种通用的轻量级数据交换/描述格式，易于人阅读和编写，同时也易于机器解析和生成。

JSON 最早是 JavaScript Programming Language, Standard ECMA-262 3rd Edition - December 1999 的一个子集。采用完全独立于语言的文本格式，但是也使用了类似于 C 语言家族的习惯（包括 C/C++、C#、Java、JavaScript、Perl、Python 等）。与 [XML](https://getiot.tech/web/web-format-xml.html) 相比，JSON 更轻巧，也更容易解析，这些特性使 JSON 成为理想的数据交换语言。



## 数据格式

如果你学过 [JavaScript](https://getiot.tech/category/js)，那么一眼就能看懂 JSON 格式，因为它和 JavaScript 对象表示方法一样。没学过 JavaScript 也不用害怕，因为 JSON 格式很简单，可以理解为就是加了大括号、冒号等内容的字符串数据。

假设我们用 `temp` 代表温度，`humi` 代表湿度，`pins` 代表传感器引脚，那么可以用 JSON 格式表示如下。

```json
{
    "temp": 22,
    "humi": 60,
    "pins": {
        "sda": 123,
        "scl": 124
    }
}
```

对象是一个无序的“‘名称/值’对”集合。一个对象以 `{`左括号 开始， `}`右括号 结束。每个“名称”后跟一个 `:`冒号 ；“‘名称/值’ 对”之间使用 `,`逗号 分隔。

简单来说，JSON 建构于两种结构：

- “名称/值”对的集合（A collection of name/value pairs）。不同的语言中，它被理解为对象（object）、记录（record）、结构（struct）、字典（dictionary）、哈希表（hash table）、有键列表（keyed list），或者关联数组 （associative array）。
- 值的有序列表（An ordered list of values）。在大部分语言中，它被理解为数组（array）。

这些都是常见的数据结构。事实上大部分现代计算机语言都以某种形式支持它们，这使得一种数据格式在同样基于这些结构的编程语言之间交换成为可能。



## 优缺点

JSON 格式的优点是数据格式比较简单，天生具有自我描述性，易于人的阅读和编写。而且可以压缩成二进制格式（称为 BSON），网络带宽占用小。

同时，许多编程语言（如 JavaScript、Python、PHP）等都具有解析 JSON 数据的相关函数库，可以很方便地进行数据解析。相对 XML 来说，可以使得服务器端和客户端的程序变得更加简洁，易于维护。

但是目前来说，JSON 没有 XML 格式这么推广的深入人心和使用广泛。



