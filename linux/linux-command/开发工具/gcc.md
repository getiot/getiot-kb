---
sidebar_label: gcc 命令
sidebar_position: 1
slug: /gcc
---

# gcc 命令 - GNU C 编译器



## 介绍

**GCC**（英文全拼：GNU Compiler Collection）是 GNU 工具链的主要组成部分，是一套以 GPL 和 LGPL 许可证发布的程序语言编译器自由软件，由 Richard Stallman 于 1985 年开始开发。

GCC 原名为 GNU C语言编译器，因为它原本只能处理 C 语言，但如今的 GCC 不仅可以编译 C、C++ 和 Objective-C，还可以通过不同的前端模块支持各种语言，包括 Java、Fortran、Ada、Pascal、Go 和 D 语言等等。

GCC 的编译过程可以划分为四个阶段：预处理（Pre-Processing）、编译（Compiling）、汇编（Assembling）以及链接（Linking）。

![](https://static.getiot.tech/gcc-process.png#center)

Linux 程序员可以根据自己的需要控制 GCC 的编译阶段，以便检查或使用编译器在该阶段的输出信息，帮助调试和优化程序。以 C 语言为例，从源文件的编译到可执行文件的运行，整个过程大致如下。

![](https://static.getiot.tech/what-happens-when-you-type-gcc.png#center)

各文件后缀说明如下：

| 后缀             | 描述                    | 后缀     | 描述           |
| ---------------- | ----------------------- | -------- | -------------- |
| .c               | C 源文件                | .s/.S    | 汇编语言源文件 |
| .C/.cc/.cxx/.cpp | C++ 源文件              | .o/.obj  | 目标文件       |
| .h               | C/C++ 头文件            | .a/.lib  | 静态库         |
| .i/.ii           | 经过预处理的 C/C++ 文件 | .so/.dll | 动态库         |

**语法**：

```bash
gcc [options] file...
```

**选项**：

- `-pass-exit-codes` ：从一个阶段以最高错误代码退出。
- `--target-help` ：显示特定于目标的命令行选项。
- `--help={common|optimizers|params|target|warnings|[^]{joined|separate|undocumented}}[,...]` ：显示特定类型的命令行选项（使用 `-v --help` 显示子进程的命令行选项）。
- `-dumpspecs` ：显示所有内置规范字符串。
- `-dumpversion` ：显示编译器的版本。
- `-dumpmachine` ：显示编译器的目标处理器。
- `-print-search-dirs` ：显示编译器搜索路径中的目录。
- `-print-libgcc-file-name` ：显示编译器配套库的名称。
- `-print-file-name=<lib>` ：显示库 `<lib>` 的完整路径。
- `-print-prog-name=<prog>` ：显示编译器组件 `<prog>` 的完整路径。
- `-print-multiarch` ：显示目标的规范化 GNU 三元组，用作库路径中的一个组件。
- `-print-multi-directory` ：显示 libgcc 版本的根目录。
- `-print-multi-lib` ：显示命令行选项和多个库搜索目录之间的映射。
- `-print-multi-os-directory` ：显示操作系统库的相对路径。
- `-print-sysroot` ：显示目标库目录。
- `-print-sysroot-headers-suffix` ：显示用于查找标题的 sysroot 后缀。
- `-Wa,<options>` ：将逗号分隔的 `<options>` 传递给汇编器（assembler）。
- `-Wp,<options>` ：将逗号分隔的 `<options>` 传递给预处理器（preprocessor）。
- `-Wl,<options>` ：将逗号分隔的 `<options>` 传递给链接器（linker）。
- `-Xassembler <arg>` ：将 `<arg>` 传递给汇编器（assembler）。
- `-Xpreprocessor <arg>` ：将 `<arg>` 传递给预处理器（preprocessor）。
- `-Xlinker <arg>` ：将 `<arg>` 传递给链接器（linker）。
- `-save-temps` ：不用删除中间文件。
- `-save-temps=<arg>` ：不用删除指定的中间文件。
- `-no-canonical-prefixes` ：在构建其他 gcc 组件的相对前缀时，不要规范化路径。
- `-pipe` ：使用管道而不是中间文件。
- `-time` ：为每个子流程的执行计时。
- `-specs=<file>` ：使用 `<file>` 的内容覆盖内置规范。
- `-std=<standard>` ：假设输入源为 `<standard>`。
- `--sysroot=<directory>` ：使用 `<directory>` 作为头文件和库的根目录。
- `-B <directory>` ：将 `<directory>` 添加到编译器的搜索路径。
- `-v` ：显示编译器调用的程序。
- `-###` ：与 `-v` 类似，但引用的选项和命令不执行。
- `-E` ：仅执行预处理（不要编译、汇编或链接）。
- `-S` ：只编译（不汇编或链接）。
- `-c` ：编译和汇编，但不链接。
- `-o <file>` ：指定输出文件。
- `-pie` ：创建一个动态链接、位置无关的可执行文件。
- `-I` ：指定头文件的包含路径。
- `-L` ：指定链接库的包含路径。
- `-shared` ：创建共享库/动态库。
- `-static` ：使用静态链接。
- `--help` ：显示帮助信息。
- `--version` ：显示编译器版本信息。



## 示例

### 阶段编译

假设有文件 hello.c，内容如下：

```c
#include <stdio.h>

int main(void)
{
    printf("Hello, GetIoT\n");
    return 0;
}
```

编译 hello.c，默认输出 a.out

```bash
gcc hello.c
```

编译 hello.c 并指定输出文件为 hello

```bash
gcc hello.c -o hello
```

只执行预处理，输出 hello.i 源文件

```bash
gcc -E hello.c -o hello.i
```

只执行预处理和编译，输出 hello.s 汇编文件

```bash
gcc -S hello.c
```

也可以由 hello.i 文件生成 hello.s 汇编文件

```bash
gcc -S hello.i -o hello.s
```

只执行预处理、编译和汇编，输出 hello.o 目标文件

```bash
gcc -c hello.c
```

也可以由 hello.i 或 hello.s 生成目标文件 hello.o

```bash
gcc -c hello.i -o hello.o
gcc -c hello.s -o hello.o
```

由 hello.o 目标文件链接成可执行文件 hello

```bash
gcc hello.o -o hello
```



### 使用静态库

创建一个 foo.c 文件，内容如下：

```c
#include <stdio.h>

void foo(void)
{
    printf("Here is a static library\n");
}
```

将 foo.c 编译成静态库 libfoo.a

```bash
gcc -c foo.c             # 生成 foo.o 目标文件
ar rcs libfoo.a foo.o    # 生成 libfoo.a 静态库
```

查看文件描述

```bash
$ file *
foo.c:    C source, ASCII text
foo.o:    ELF 64-bit LSB relocatable, x86-64, version 1 (SYSV), not stripped
libfoo.a: current ar archive
```

修改 hello.c 文件，调用 foo 函数

```c
#include <stdio.h>

void foo(void);

int main(void)
{
    printf("Hello, GetIoT\n");
    foo();
    return 0;
}
```

编译 hello.c 并链接静态库 libfoo.a（加上 `-static` 选项）

```bash
gcc hello.c -static libfoo.a -o hello
```

也可以使用 `-L` 指定库的搜索路径，并使用 `-l` 指定库名

```bash
gcc hello.c -static -L. -lfoo -o hello
```

运行结果

```bash
$ ./hello
Hello, GetIoT
Here is a static library
```

查看 hello 文件描述

```bash
$ file hello
hello: ELF 64-bit LSB executable, x86-64, version 1 (GNU/Linux), statically linked, BuildID[sha1]=b72236c2211dd8f0c3003bc02ad5e70bb2354e8c, for GNU/Linux 3.2.0, not stripped
```



### 使用共享库

修改 foo.c 文件，内容如下：

```c
#include <stdio.h>

void foo(void)
{
    printf("Here is a shared library\n");
}
```

将其编译为动态库/共享库（由于动态库可以被多个进程共享加载，所以需要使用 `-fPIC` 选项生成位置无关的代码

```bash
gcc foo.c -shared -fPIC -o libfoo.so
```

hello.c 代码无需修改，内容仍然如下：

```c
#include <stdio.h>

void foo(void);

int main(void)
{
    printf("Hello, GetIoT\n");
    foo();
    return 0;
}
```

编译 hello.c 并链接共享库 libfoo.so

```bash
gcc hello.c libfoo.so -o hello
```

也可以使用 `-L` 和 `-l` 选项指定库的路径和名称

```bash
gcc hello.c -L. -lfoo -o hello
```

 但是此时运行 hello 程序失败

```bash
$ ./hello
./hello: error while loading shared libraries: libfoo.so: cannot open shared object file: No such file or directory
```

原因是找不到 libfoo.so 共享库

```bash
$ ldd hello
        linux-vdso.so.1 (0x00007fff5276d000)
        libfoo.so => not found
        libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007fcc90fa7000)
        /lib64/ld-linux-x86-64.so.2 (0x00007fcc911bd000)
```

这是因为 libfoo.so 并不在 Linux 系统的默认搜索目录中，解决办法是我们主动告诉系统，libfoo.so 共享库在哪里。

**方式一**：设置环境变量 `LD_LIBRARY_PATH`

```bash
export LD_LIBRARY_PATH=$(pwd)
```

将 libfoo.so 所在的当前目录添加到 `LD_LIBRARY_PATH` 变量，再次执行 hello

```bash
$ ./hello
Hello, GetIoT
Here is a shared library
```

**方式二**：使用 rpath 将共享库位置嵌入到程序

```bash
gcc hello.c -L. -lfoo -Wl,-rpath=`pwd` -o hello
```

rpath 即 run path，是种可以将共享库位置嵌入程序中的方法，从而不用依赖于默认位置和环境变量。这里在链接时使用 `-Wl,-rpath=/path/to/yours` 选项，`-Wl` 会发送以逗号分隔的选项到链接器，注意逗号分隔符后面没有空格哦。

这种方式要求共享库必须有一个固定的安装路径，欠缺灵活性，不过如果设置了 `LD_LIBRARY_PATH`，程序加载时也是会到相应路径寻找共享库的。

**方式三**：将 libfoo.so 共享库添加到系统路径

```bash
sudo cp libfoo.so /usr/lib/
```

执行程序

```bash
$ ./hello
Hello, GetIoT
Here is a shared library
```

如果 hello 程序仍然运行失败，请尝试执行 [ldconfig](/linux-command/ldconfig) 命令更新共享库的缓存列表。

此时，再次查看 hello 程序的共享库依赖

```bash
$ ldd hello
        linux-vdso.so.1 (0x00007ffecfbb1000)
        libfoo.so => /lib/libfoo.so (0x00007f3f3f1ad000)
        libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f3f3efbb000)
        /lib64/ld-linux-x86-64.so.2 (0x00007f3f3f1d6000)
```

可以看到 libfoo.so 已经被发现了，其中 /lib 是 /usr/lib 目录的软链接。

示例代码可以在 [GitHub](https://github.com/getiot/linux-c/tree/main/hello) 找到。



