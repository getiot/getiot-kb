---
sidebar_position: 1
sidebar_label: Shell 脚本是什么
slug: /linux-shell-script-concept
---

# Linux Shell 脚本是什么

Shell 脚本就是把一组命令写进文件，让 Shell 按顺序执行。它特别适合把重复操作自动化。

在《Linux 基础教程》中，我们只做入门引导。等你熟悉基本概念后，可以继续阅读 [Shell 教材](/linux-shell/) 系统学习语法、函数、数组、文本处理和脚本工程实践。

## 为什么需要 Shell 脚本

如果你每天都要执行这些命令：

```bash
cd project
git pull
npm test
```

你可以把它们写成脚本：

```bash
#!/usr/bin/env bash

cd project
git pull
npm test
```

以后只需要运行脚本，就能自动完成这组操作。

## Shell 脚本适合做什么

常见用途包括：

- 批量处理文件。
- 自动备份目录。
- 检查服务状态。
- 初始化开发环境。
- 封装复杂命令。
- 编写简单运维任务。

Shell 脚本的优势是调用系统命令方便；劣势是复杂数据结构和大型工程维护能力不如 Python、Ruby、Go 等语言。

## shebang

脚本第一行常见写法是：

```bash
#!/usr/bin/env bash
```

这行叫 shebang，用来告诉系统使用哪个解释器执行脚本。

也可能看到：

```bash
#!/bin/sh
```

`sh` 通常表示 POSIX Shell，语法比 Bash 更通用，但功能也更少。初学阶段如果你使用 Bash 语法，就明确写 `#!/usr/bin/env bash`。

## 脚本和交互命令的区别

你在终端里手动输入命令，是交互式使用 Shell。

把命令写进文件再执行，是脚本式使用 Shell。

二者使用同一个命令环境，但脚本更需要注意：

- 当前工作目录是否正确。
- 变量是否被正确引用。
- 命令失败时是否需要停止。
- 输入参数是否存在。
- 输出和错误是否被记录。

## 什么时候不要用 Shell 脚本

Shell 脚本不是万能工具。下面情况更适合换语言：

- 复杂 JSON、XML、CSV 处理。
- 大量字符串和数据结构操作。
- 需要跨平台运行。
- 需要长期维护的大型程序。
- 需要完善测试和模块化设计。

Shell 更像胶水：把已有命令粘起来，完成一件明确的自动化任务。

## 小结

你可以这样理解 Shell 脚本：

- 它是命令的集合。
- 它由 Shell 解释执行。
- 它适合自动化重复操作。
- 它不适合无限扩展成大型程序。

下一篇你会写第一个可执行 Shell 脚本。
