---
sidebar_label: Chisel
sidebar_position: 2
slug: /chisel
---

# Chisel



![](https://static.getiot.tech/chisel_logo.svg#center-300)

**Chisel**（Constructing Hardware In a Scala Embedded Language）是伯克利大学（UC Berkeley）开发的一种开源硬件构造语言。它是建构在 Scala 语言之上的领域专用语言（DSL），支持高度参数化的硬件生成器，通过使用高度化的参数生成器和分层的专用硬件设计语言来支持高级硬件设计。

采用 Chisel 设计的电路经过编译，可以得到针对 FPGA、ASIC 的 Verilog HDL 代码。

下面是一段用 Chisel 写的 Hello World 程序。

```scala showLineNumbers
object HelloScala extends App{
    println("Hello Chisel World!")
}
```

更多资料：

- GitHub 仓库：[https://github.com/chipsalliance/chisel3](https://github.com/chipsalliance/chisel3)
- 官方网站：[https://www.chisel-lang.org](https://www.chisel-lang.org)
- 中文网站：[https://www.chiselchina.com](https://www.chiselchina.com)
- 一份教程：[Digital Design with Chisel](https://www.imm.dtu.dk/~masca/chisel-book-chinese.pdf)