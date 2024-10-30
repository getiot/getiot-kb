---
sidebar_label: xargs 命令
sidebar_position: 19
slug: /xargs
---

# xargs 命令 - 构建并执行命令行参数



## 介绍

**xargs**（英文全拼： eXtended ARGuments）是 Linux 系统给命令传递参数的一个过滤器，也是组合多个命令的一个工具，一般是和管道一起使用。

简单来说，使用 xargs 命令能够捕获一个命令的输出，然后传递给另外一个命令。因此，通过它就可以将多个命令串联起来，这在 Linux 命令行中非常重要，有着独特的作用。

在输入方面，xargs 可以将管道或标准输入（stdin）数据转换成命令行参数，也能够从文件的输出中读取数据。也可以将单行或多行文本输入转换为其他格式，例如多行变单行，单行变多行。

**语法**：

```bash
xargs [options] [command [initial-arguments]]
somecommand | xargs [options] [command [initial-arguments]]
```

**选项**：

- `-a file`：从文件中读入，而不是从标准输入（stdin）读入。
- `-e eof-str`：注意有的时候可能会是 `-E`，`eof-str` 必须是一个以空格分隔的标志，当 xargs 分析到含有 `eof-str` 这个标志的时候就停止。
- `-p, --interactive`：当每次执行的时候都要询问用户，输入 y 或 Y 后才执行。
- `-n max-args`：每个命令行最多使用 `max-args` 个参数。
- `-t, --verbose`：表示先打印命令，然后再执行。
- `-I replace-str`：将初始参数中出现的 `replace-str` 替换为从标准输入读取的名称。
- `-i`：同 `-I`。
- `-r, --no-run-if-empty`：当 xargs 的输入为空的时候则停止 xargs，不用再去执行了。
- `-s max-chars`：命令行的最大字符数，指的是 xargs 后面那个命令的最大命令行字符数。
- `-L max-lines`：从标准输入一次读取 `max-lines` 行送给 command 命令。
- `-l`：同 `-L`。
- `-d delim`：分隔符，默认的 xargs 分隔符是回车，argument 的分隔符是空格，这里修改的是 xargs 的分隔符。
- `-x, --exit`：如果超出大小（请参阅 `-s` 选项），则退出。
- `-P max-procs`：一次最多运行 `max-procs` 个进程； 默认值为 1。如果设为 0，xargs 将一次运行尽可能多的进程。



## 示例

大多数时候，xargs 命令都是和管道一起使用的。但是，它也可以单独使用。例如：

```bash
$ xargs
hello (Ctrl + D)
hello
```

由于 xargs 后面的命令默认是 [`echo`](/linux-command/echo)，因此当输入 xargs 按下回车以后，命令行就会等待用户输入，作为标准输入。你可以输入任意内容，然后按下 `Ctrl + D` 键结束，此时 echo 命令就会把前面的输入打印出来。

当然，单独使用时 xargs 后面可以带上其他命令，例如：

```bash
$ xargs find -name
*.md
```

当输入命令 `xargs find -name` 以后，命令行会等待用户输入所要搜索的文件。此时输入 `*.md`，表示搜索当前目录下的所有 Markdown 文件，然后按下 `Ctrl + D` 键结束输入。此时会输出所有 .md 文件，该命令相当执行 `find -name *.md`。

下面再看使用 xargs 和管道打印 Hello World（将管道左侧的标准输入，转为命令行参数，传递给 echo 命令）：

```bash
echo "hello world" | xargs echo
```

使用 xargs 和管道创建目录（等效于 `mkdir one two three`）：

```bash
echo "one two three" | xargs mkdir
```

