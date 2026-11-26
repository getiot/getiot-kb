---
sidebar_position: 1
---

# GDB 调试工具



GDB 是一个由 GNU 开源组织发布的、Unix/Linux 操作系统下的、基于命令行的、功能强大的程序调试工具。 对于一名 Linux 下工作的 C/C++ 程序员，GDB 是必不可少的工具。

本文主要介绍 GDB 工具的基本用法，熟练掌握这些技巧将有助于提高开发效率，更快地排查问题。



## 启动 gdb

对 C/C++ 程序的调试，需要在编译前就加上 -g 选项：

```bash
g++ -g hello.cpp -o hello
```

### 调试可执行文件

调试可执行文件：

```bash
gdb <program>
```

program 也就是你的执行文件，一般在当前目录下。

### 调试 core 文件

调试 core 文件（core 是程序非法执行后 core dump 后产生的文件）：

```bash
gdb <program> <core dump file>
gdb program core.11127
```

### 调试服务程序

调试服务程序：

```bash
gdb <program> <PID>
gdb hello 11127
```

如果你的程序是一个服务程序，那么你可以指定这个服务程序运行时的进程 ID。gdb 会自动 attach 上去，并调试该程序。需要注意，program 应该能在 `PATH` 环境变量中搜索得到。

### 调试带参数的程序

可以在 gdb 启动时，通过选项指定被调试程序的参数，例如：

```bash
gdb -args <program> a b c
```

也可以在 gdb 中，通过命令来设置，例如：

```bash
(gdb) set args a b c
(gdb) show args
Argument list to give program being debugged when it is started is "a b c".
```

也可以在运行程序时，直接指定：

```bash
(gdb) r a b
Starting program: /tmp/a.out a b
(gdb) show args
Argument list to give program being debugged when it is started is "a b".
(gdb) r
Starting program: /tmp/a.out a b 
```

可以看出，参数已经被保存了，下次运行时直接运行 `run` 命令，即可。

最后，如果想让参数设为空，不带参数设置即可，如下。

```bash
(gdb) set args
```



## gdb 交互命令

启动 gdb 后，进入到交互模式，通过以下命令完成对程序的调试。

提示：

- 高频使用的命令一般都会有缩写，熟练使用这些缩写命令能提高调试的效率。
- 交互模式下直接回车的作用是重复上一指令，对于单步调试非常方便。



### 运行

| 命令              | 简写 | 说明                                                         |
| ----------------- | :--- | ------------------------------------------------------------ |
| `run`             | `r`  | 其作用是运行程序，当遇到断点后，程序会在断点处停止运行，<br/>等待用户输入下一步的命令。 |
| `continue`        | `c`  | 继续执行，到下一个断点处（或运行结束）。                     |
| `next`            | `n`  | 单步跟踪程序，当遇到函数调用时，也不进入此函数体。           |
| `step`            | `s`  | 单步调试如果有函数调用，则进入函数。                         |
| `until`           |      | 当你厌倦了在一个循环体内单步跟踪时，这个命令可以运行程序<br/>直到退出循环体。 |
| `until 行号`      |      | 运行至某行，不仅仅用来跳出循环。                             |
| `finish`          |      | 运行程序，直到当前函数完成返回，并打印函数返回时的堆栈地址<br/>和返回值及参数值等信息。 |
| `call 函数(参数)` |      | 调用程序中可见的函数，并传递“参数”，如：`call gdb_test(55)`  |
| `quit`            | `q`  | 退出 gdb                                                     |

提示：next 命令与 step 的主要区别是，step 遇到用户自定义的函数，将步进到函数中去运行，而 next 则直接调用函数，不会进入到函数体内。



### 设置断点

| 命令                 | 简写     | 说明                                                |
| -------------------- | -------- | --------------------------------------------------- |
| `break n`            | `b n`    | 在第 n 行处设置断点（break 缩写为 b）               |
| `b fn1 if a > b`     |          | 条件断点设置                                        |
| `break func`         | `b func` | 在函数 func() 的入口处设置断点，如：break cb_button |
| `delete 断点号n`     | `d n`    | 删除第 n 个断点                                     |
| `disable 断点号n`    |          | 暂停第 n 个断点                                     |
| `enable 断点号n`     |          | 开启第 n 个断点                                     |
| `clear 行号n`        |          | 清除第 n 行的断点                                   |
| `info breakpoints`   | `info b` | 显示当前程序的断点设置情况                          |
| `delete breakpoints` |          | 清除所有断点                                        |



### 查看源代码

| 命令          | 简写 | 说明                                                    |
| ------------- | ---- | ------------------------------------------------------- |
| `list`        | `l`  | 其作用就是列出程序的源代码，默认每次显示10行。          |
| `list 行号`   |      | 将显示当前文件以“行号”为中心的前后10行代码，如：list 12 |
| `list 函数名` |      | 将显示“函数名”所在函数的源代码，如：list main           |
| `list`        |      | 不带参数，将接着上一次 list 命令的，输出下边的内容。    |



### 打印表达式

print 表达式（简记为 p），其中“表达式”可以是任何当前正在被测试程序的有效表达式，比如当前正在调试C语言的程序，那么“表达式”可以是任何 C 语言的有效表达式，包括数字，变量甚至是函数调用。

| 命令                 | 说明                                                         |
| -------------------- | ------------------------------------------------------------ |
| `print a`            | 将显示整数 a 的值                                            |
| `print ++a`          | 将把 a 中的值加 1，并显示出来                                |
| `print name`         | 将显示字符串 name 的值                                       |
| `print gdb_test(22)` | 将以整数 22 作为参数调用 gdb_test() 函数                     |
| `print gdb_test(a)`  | 将以变量 a 作为参数调用 gdb_test() 函数                      |
| `display 表达式`     | 在单步运行时将非常有用，使用display命令设置一个表达式后，<br/>它将在每次单步进行指令后，紧接着输出被设置的表达式及值。<br/>如：display a |
| `watch 表达式`       | 设置一个监视点，一旦被监视的“表达式”的值改变，gdb 将强行<br/>终止正在被调试的程序。如：watch a |
| `whatis`             | 查询变量或函数                                               |
| `info function`      | 查询函数                                                     |
| `info locals`        | 显示当前堆栈页的所有变量                                     |



### 查询运行信息

| 命令            | 说明                                           |
| --------------- | ---------------------------------------------- |
| `where/bt`      | 当前运行的堆栈列表                             |
| `bt backtrace`  | 显示当前调用堆栈                               |
| `up/down`       | 改变堆栈显示的深度                             |
| `set args 参数` | 指定运行时的参数                               |
| `show args`     | 查看设置好的参数                               |
| `info program`  | 来查看程序的是否在运行，进程号，被暂停的原因。 |



### 分割窗口

| 命令           | 说明                                     |
| -------------- | ---------------------------------------- |
| `layout`       | 用于分割窗口，可以一边查看代码，一边测试 |
| `layout src`   | 显示源代码窗口                           |
| `layout asm`   | 显示反汇编窗口                           |
| `layout regs`  | 显示源代码/反汇编和 CPU 寄存器窗口       |
| `layout split` | 显示源代码和反汇编窗口                   |
| `Ctrl + L`     | 刷新窗口                                 |



## 更强大的工具

### CGDB

cgdb 可以看作 gdb 的界面增强版，用来替代 gdb 的 gdb -tui。cgdb 主要功能是在调试时进行代码的同步显示，这无疑增加了调试的方便性，提高了调试效率。界面类似 vi，符合 unix/linux 下开发人员习惯；如果熟悉 gdb 和 vi，几乎可以立即使用 cgdb。

关于 CGDB 的使用，可以阅读下面资料。

- [中文《CGDB中文使用手册》](https://leeyiw.gitbooks.io/cgdb-manual-in-chinese/content/index.html)
- [英文原版《CGDB Manual》](http://cgdb.github.com/docs/cgdb.html)

