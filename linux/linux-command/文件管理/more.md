---
sidebar_label: more 命令
sidebar_position: 7
slug: /more
---

# Linux more 命令 - 分页查看文件



## 介绍

**more** 命令类似 [cat](/linux-command/cat) ，不过会以一页一页的形式显示，更方便使用者逐页阅读。

more 最基本的指令就是按空白键（space）就往下一页显示，按 b 键就会往回（back）一页显示，而且还有搜寻字串的功能（与 vi 相似），使用中的说明文件，请按 h 。

**语法**：

```bash
more [options] file...
```

**选项**：

- `-num` ：指定每屏显示的行数。
- `+num` ：从第 num 行开始显示。
- `-d` ：提示使用者，在画面下方显示 [Press space to continue, 'q' to quit.] ，如果使用者按错键，则会显示 [Press 'h' for instructions.] 而不是 '哔' 声。
- `-l` ：取消遇见特殊字元 `^L`（送纸字元）时会暂停的功能。
- `-f` ：计算行数时，以实际上的行数，而非自动换行过后的行数（有些单行字数太长的会被扩展为两行或两行以上）。
- `-p` ：不以卷动的方式显示每一页，而是先清除萤幕后再显示内容。
- `-c` ：与 `-p` 相似，不同的是先显示内容再清除其他旧资料。
- `-s` ：当遇到有连续两行以上的空白行，就代换为一行的空白行。
- `-u` ：不显示下引号 （根据环境变数 TERM 指定的 terminal 而有所不同）。
- `+/pattern` ：在每个文档显示前搜寻该字串（pattern），然后从该字串之后开始显示。

**命令内部操作**：

- Space 键：显示文本的下一屏内容
- Enter 键：向下n行，需要定义，默认为1行
- 斜线符 `\`：接着输入一个模式，可以在文本中寻找下一个相匹配的模式
- H 键：显示帮助屏
- B 键：显示上一屏内容
- Q 键：退出 more 命令
- Ctrl+F、空格键：向下滚动一屏
- Ctrl+B：返回上一屏
- `=`： 输出当前的行号
- `:f`：输出文件名和当前的行号
- `V`：调用 vi 编辑器
- `!`：调用 Shell，并执行命令



## 示例

显示文件 file 的内容，显示之前先清屏，附已显示的百分比：

```bash
more -dc file
```

显示文件 file 的内容，每10行显示一次，而且在显示之前先清屏：

```bash
more -c -10 file
```

显示文件 file 的内容，每5行显示一次，而且在显示之后再清屏：

```bash
more -p -5 file
```

逐页显示 file 文档内容，如有连续两行以上空白行则以一行空白行显示 ：

```bash
more -s file
```

从第 20 行开始显示 file 之文档内容 ：

```bash
more +20 file
```

