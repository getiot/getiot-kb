---
sidebar_position: 19
---

# 制作 shell 脚本安装包



在 Linux 中可以利用 cat 命令连接两个文件来制作简单的安装包，其文件后缀通常为 sh、run 或 bin。安装包的文件结构如下图所示：

![shell 脚本安装包结构](https://static.getiot.tech/shell-installation-package.png#center)

安装包实质上是一个安装脚本和要安装的内容的组合。文件的头部是脚本文件，执行的时候需要把尾部的二进制文件分解出来。通常这个二进制文件是个压缩包，能够打包很多不同类型的文件，在脚本中解压出来进行处理即可，因此具有不错的灵活性。

简单起见，我们先来写一个 hello 程序：

```c showLineNumbers title="hello.c"
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char** argv)
{
	printf("Hello, %s!\n", getenv("USER"));
	return 0;
}
```

编译、运行看看效果：

```bash
$ gcc hello.c -o hello
$ ./hello
Hello, rudy!
```

我们的目的是将 hello 程序安装到目标机器的 /bin 目录。为了达到这个目的，我们编写一个 install.sh 安装脚本：

```bash showLineNumbers title="install.sh"
#!/bin/bash
cp hello /bin
```

更进一步，我们可以先将 hello 压缩成 hello.tar.bz2

```bash
tar jcvf hello.tar.bz2 hello
```

然后将 install.sh 安装脚本修改为：

```bash showLineNumbers title="install.sh"
#!/bin/bash

lines=9 
tail -n+$lines $0 > /tmp/hello.tar.bz2
cd /tmp
tar jxvf hello.tar.bz2
cp hello /bin
exit 0
```

代码解释：

- 第3行：变量 `lines` 的值是指这个脚本的行数加1（这个脚本共有8行）；
- 第4行：`$0` 表示脚本本身，这个命令用来把从 `$lines` 开始的内容写入一个 /tmp 目录的 hello.tar.bz2 文件里；
- 第5行：切换到 /tmp 目录操作，解压出来的文件重启系统后将会消失。

接下来我们用 cat 命令连接安装脚本 install.sh 和 hello.tar.bz2：

```bash
cat install.sh hello.tar.bz2 > helloinstall.run
```

方便起见，我们写个 Makefile 来构建安装包：

```makefile showLineNumbers showLineNumbers showLineNumbers showLineNumbers title="Makefile"
SCRIPT=install.sh
BIN=hello
RUN=helloinstall.run

all:
	gcc hello.c -o $(BIN)
	tar jcvf $(BIN).tar.bz2 $(BIN)
	cat $(SCRIPT) $(BIN).tar.bz2 > $(RUN)
	chmod +x $(RUN)

clean:
	rm $(BIN) $(BIN).tar.bz2 
	rm $(RUN)
```

总共3个文件：

```bash
$ tree
.
├── hello.c
├── install.sh
└── Makefile
```

在当前目录 `make` 一下就构建好 helloinstall.run 安装包啦，将其传输至目标设备即可安装：

```bash
sudo ./helloinstall.run
```

安装成功，在系统任意位置都可以执行 hello 命令了！

```bash
$ hello
Hello, rudy!
```

所有代码可在 GitHub 仓库 [shell-courses](https://github.com/getiot/shell-courses/tree/main/helloinstall) 找到。


