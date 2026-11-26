---
sidebar_label: Verilog
sidebar_position: 3
slug: /verilog
---

# Verilog



**Verilog** 是一种用于描述、设计电子系统的硬件描述语言，主要用于在集成电路设计，特别是超大规模集成电路的计算机辅助设计。

Verilog 最初由 Gateway Design Automation 公司（GDA）的 Phil Moorby 于1983年创建，作为内部仿真器的语言，主要用于逻辑建模和仿真验证，被广泛使用。1989年，GDA 被 Cadence 公司收购，并在1990年成立了 OVI（Open Verilog International）组织，以促进 Verilog 向公众领域发展，并致力于将 Verilog OVI 标准推广为 IEEE 标准。1995年，Verilog 成为电气电子工程师学会的 1364 号标准。

下面是一段用 Verilog 写的 Hello World 程序。

```verilog
//-----------------------------------------------------
// This is a simple Verilog Program
// Design Name : hello_world
// File Name   : hello_world.v
// Function    : This program will print 'hello world'
// Author      : GetIoT
//-----------------------------------------------------
module hello_world ;

initial begin
    $display ("Hello World by GetIoT");
    #10  $finish;
end

endmodule // End of Module hello_world
```

