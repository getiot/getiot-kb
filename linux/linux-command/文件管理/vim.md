---
sidebar_label: vim 命令
sidebar_position: 18
slug: /vim
---

# Linux vim 命令 - 文本编辑器



## 介绍

**vim** 是 Linux 系统中非常流行的一个文本编辑器，绝大多数 Linux 系统都会内置 vim。

vim 是 Vi IMproved 的简写，从名字可以看出，它是从 vi 发展出来的一个文本编辑器，提供了代码补完、编译及错误跳转等方便编程的功能。同时，可通过 vim 插件扩展其功能，将 vim 打造成一款强大的 IDE 工具。

可以说，vim 是 Linux 系统中的一个神兵利器。但对于初学者来说，vim 可能会显得有些复杂，因为要想熟练使用它，需要记住很多操作命令。

:::tip

Vim 的第一个版本由布莱姆·米勒在1991年发布，如今代码托管在 [GitHub](https://github.com/vim/vim) 上。

:::

**语法**：

```bash
vim [参数] [文件 ..]        # 编辑指定的文件
vim [参数] -               # 从标准输入(stdin)读取文本
vim [参数] -t tag          # 编辑 tag 定义处的文件
vim [参数] -q [errorfile]  # 编辑第一个出错处的文件
```

**选项**：

- `--`：在这以后只有文件名。
- `-v`：Vi 模式（同 "vi"）。
- `-e`：Ex 模式（同 "ex"）。
- `-E`：改进的 Ex 模式。
- `-s`：安静（批处理）模式（只能与 "ex" 一起使用）。
- `-d`：Diff 模式（同 "vimdiff"）。
- `-y`：容易模式（同 "evim"，无模式）。
- `-R`：只读模式（同 "view"）。
- `-Z`：限制模式（同 "rvim"）。
- `-m`：不可修改（写入文件）。
- `-M`：文本不可修改。
- `-b`：二进制模式。
- `-l`：Lisp 模式。
- `-C`：兼容传统的 Vi（compatible）。
- `-N`：不完全兼容传统的 Vi（nocompatible）。
- `-V[N][fname]`：将 N 等级的详细消息记录到 fname 文件。
- `-D`：调试模式。
- `-n`：不使用交换文件，只使用内存。
- `-r`：列出交换文件并退出。
- `-r (跟文件名)`：恢复崩溃的会话。
- `-L`：同 `-r`。
- `-A`：以 Arabic 模式启动。
- `-H`：以 Hebrew 模式启动。
- `-T <terminal>`：设定终端类型为 `<terminal>`。
- `--not-a-term`：跳过输入/输出不是终端的警告。
- `--ttyfail`：如果输入或输出不是终端则退出。
- `-u <vimrc>`：使用 `<vimrc>` 替代任何 .vimrc。
- `--noplugin`：不加载 plugin 脚本。
- `-p[N]`：打开 N 个标签页（默认值：每个文件一个）。
- `-o[N]`：打开 N 个窗口（默认值：每个文件一个）。
- `-O[N]`：同 -o 但垂直分割。
- `+`：启动后跳到文件末尾。
- `+<lnum>`：启动后跳到第 `<lnum>` 行。
- `--cmd <command>`：加载任何 vimrc 文件前执行 `<command>`。
- `-c <command>`：加载第一个文件后执行 `<command>`。
- `-S <session>`：加载第一个文件后执行文件 `<session>`。
- `-s <scriptin>`：从文件 `<scriptin>` 读入正常模式的命令。
- `-w <scriptout>`：将所有输入的命令追加到文件 `<scriptout>`。
- `-W <scriptout>`：将所有输入的命令写入到文件 `<scriptout>`。
- `-x`：编辑加密的文件。
- `--startuptime <file>`：将启动时序消息（startup timing messages）写入文件 `<file>`。
- `-i <viminfo>`：使用 `<viminfo>` 取代 .viminfo。
- `--clean`：Vim 默认模式，没有插件，没有 viminfo。
- `-h, --help`：打印帮助信息。
- `--version`：打印版本信息。



## 示例

打开当前目录下的 hello.txt 文件：

```bash
vim hello.txt
```

同时打开 hello.txt 和 world.txt 文件：

- 首先执行 `vim hello.txt` 打开其中一个文件；
- 然后在 vim 中输入 `:split world.txt`，打开另一个文件（默认是上下分隔窗口）；
- 如果想要左右分割窗口，则输入 `:vsplit world.txt`。

关于 vim 编辑器的详细使用方法，可参考《[Vim 文本编辑器](/linux/linux-vim-text-editor)》。
