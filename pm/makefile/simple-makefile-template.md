---
sidebar_position: 2
---

# 万能 Makefile 模板（C 语言）



在 Linux 编程时，对于很多小工程来说，很多时候似乎没有必要用 autoconf 和 automake 工具来生成 Makefile，反而自己写一个 Makefile 更省事。这里给大家提供一个简单的 Makefile 模板，根据需要作相应修改，可以适用于很多小项目。

```makefile showLineNumbers
CC=gcc
SRCS=$(wildcard *.c */*.c)
OBJS=$(patsubst %.c, %.o, $(SRCS))
FLAG=-g
NAME=$(wildcard *.c)
TARGET=$(patsubst %.c, %, $(NAME))

$(TARGET):$(OBJS)
	$(CC) -o $@ $^ $(FLAG)

%.o:%.c
	$(CC) -o $@ -c $< -g

clean:
	rm -rf $(TARGET) $(OBJS)
```

解释一下：

- 第1行指定编译器为 gcc，可以根据需要修改为 g++ 或者 arm-linux-gcc 等交叉编译工具链。
- 第2行是为了获取匹配模式的文件名，`*.c` 表示当前工程目录的 c 文件，`*/*.c` 表示所有下一级目录的 .c 文件。
- 第3行是将 `$(SRCS)` 中的 .c 文件替换成 .o 文件。
- 第4行用于指定编译选项，根据需要添加，比如 -g、-ml、-Wall、-O2 等等。
- 第5、6行，同样使用了 wildcard 和 patsubst 函数来处理，目的是为了指定最终生成的可执行文件名。
- 第8行 `$(TARGET):$(OBJS)` 表示由 .o 文件链接成可执行文件。
- 注意第9行前面是一个 `<tab>` 键，而 `$@` 表示目标，也就是 `$(TARGET)`，`$^` 表示依赖列表，也就是 `$(OBJS)` 。
- 第11行 `%.o:%.c` 表示由 .c 文件生成 .o 文件。
- 第12行中的 `$<` 表示搜索到的第一个匹配的文件。
- 第14行的 clean 是伪目标（.PHONY），它不需要依赖，执行 `make` 命令时是不会执行的，当执行 `make clean` 时才会执行。

另外，Makefile 的赋值除了使用等号（=），还可以使用 `:=` 、`+=` 、`?=` 符号。具体含义如下：

 - `:=` 表示简单赋值（注意右边的 $ 值只会向上寻找）
 - `+=` 表示追加赋值
 - `?=` 表示判断赋值（判断左边是否已经定义过，如果是则忽略本次赋值）

