---
sidebar_position: 5
slug: /web-format-xml
---

# XML 格式



XML（eXtensible Markup Language，可扩展标记语言）是在纯文本当中加入描述数据的标签，是互联网常见的一种数据交换格式。比如，广泛用于博客和新闻网站的 RSS 采用的就是 XML 格式。



## 数据格式

XML 标签的写作格式有标准规范，看起来和 HTML 一样，最大的区别在于 XML 标签名称可完全由用户自定义，而 HTML 标签则由 W3 协会或浏览器厂商制定。

```xml
<?xml version="1.0"?>
<person>
    <name>Rudy</name>
    <age>26</age>
</person>
<person>
    <name>Tina</name>
    <age>26</age>
</person>
<person>
    <name>Terry</name>
    <age>8</age>
</person>
```



## 优缺点

XML 的优点是格式统一，符合标准。容易与其他系统进行远程交互, 数据共享比较方便。

但缺点也很明显，由于采用闭合标签标记，XML 格式的文件通常比较庞大，格式复杂，传输占用带宽。同时，服务器端和客户端都需要花费大量代码来解析 XML，使得代码变的更加复杂，不易于维护。

