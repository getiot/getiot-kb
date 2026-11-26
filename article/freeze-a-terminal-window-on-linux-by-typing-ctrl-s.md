---
sidebar_position: 26
slug: /freeze-a-terminal-window-on-linux-by-typing-ctrl-s
---

# 终端意外按下 Ctrl+S 冻结窗口



在 Linux 系统中，如果我们打开一个终端，无论是直接在桌面系统打开的 Shell（包括 Bash、Zsh 等）窗口，还是通过 SSH 远程连接，或者通过调试串口打开的终端。当我们按下 **Ctrl+S** 组合键时（先按住 Control 键，再按下 s 键），会将当前终端窗口冻结。这里的字母 S，可理解为是 start the freeze 的意思。

冻结窗口后，我们在终端输入的所有内容，都不会显示出来，就好像这个终端被挂起了一样。实际上，我们输入的命令仍然会被接收，只不过这些命令会堆积在一个队列中，并且只有在窗口解冻后才会执行。解冻的方法是按下 **Ctrl+Q** 组合键，这里的字母 Q，可理解为是 quit the freeze 的意思。

| 快捷键     | 英文             | 中文         |
| ---------- | ---------------- | ------------ |
| **Ctrl+S** | start the freeze | 冻结终端窗口 |
| **Ctrl+Q** | quit the freeze  | 解冻终端窗口 |

