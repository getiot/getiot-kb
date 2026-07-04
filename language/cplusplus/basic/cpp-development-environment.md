---
sidebar_position: 3
slug: /cpp-development-environment
---

# C++ 开发环境



安装和配置 C++ 开发环境是简单的，实际上，你可以使用任意一个编辑器来编写 C++ 代码，再通过 C++ 编译器编译成目标文件即可。当然，你可能还需要一些依赖库。

编辑器有很多，比如 Vim、[Emacs](https://www.gnu.org/software/emacs/)、[Sublime Text3](https://www.sublimetext.com/)、[Visual Studio Code](https://code.visualstudio.com/) 等都是不错的选择。如果你想找 IDE，那么可以考虑 [Eclipse CDT](https://www.eclipse.org/cdt/)、[Clion](https://www.jetbrains.com/clion/)、[Qt Creator](https://www.qt.io/product/development-tools)、[Xcode](https://developer.apple.com/xcode/)，还有 Visual Studio Code + 插件等集成开发环境。

在开始之前，我们先对编译运行 C、C++ 文件的基础知识进行简单的介绍：

- C++ 程序的源文件通常使用扩展名 `.cpp`、.`cp` 或 `.c`，建议使用 `.cpp`。
- 可以使用 `gcc` 工具来编译运行 C 语言编写的代码文件。
- 可以使用 `g++` 工具来编译运行 C++ 语言编写的代码文件。
- 可以使用 `gdb` 工具来调试 C 或 C++ 语言编写的代码文件。

由于 C++ 是一门静态编译型语言，需要将源文件编译为二进制的机器码才能被计算机执行。最常用的编译器是 GNU 的 C/C++ 编译器 g++，接下来将介绍如何在不同系统平台上安装 g++ 编译器。



## 编译器安装

### Linux

许多 Linux 发行版都预装了 GCC（包含 g++），可以先执行下面命令检查系统是否安装了 g++。

```bash
g++ -v
```

例如在 Ubuntu 上可能会看到如下打印信息：

```bash
rudy@OptiPlex-7050:~$ g++ -v
Using built-in specs.
COLLECT_GCC=g++
COLLECT_LTO_WRAPPER=/usr/lib/gcc/x86_64-linux-gnu/9/lto-wrapper
OFFLOAD_TARGET_NAMES=nvptx-none:hsa
OFFLOAD_TARGET_DEFAULT=1
Target: x86_64-linux-gnu
Configured with: ../src/configure -v --with-pkgversion='Ubuntu 9.3.0-17ubuntu1~20.04' --with-bugurl=file:///usr/share/doc/gcc-9/README.Bugs --enable-languages=c,ada,c++,go,brig,d,fortran,objc,obj-c++,gm2 --prefix=/usr --with-gcc-major-version-only --program-suffix=-9 --program-prefix=x86_64-linux-gnu- --enable-shared --enable-linker-build-id --libexecdir=/usr/lib --without-included-gettext --enable-threads=posix --libdir=/usr/lib --enable-nls --enable-clocale=gnu --enable-libstdcxx-debug --enable-libstdcxx-time=yes --with-default-libstdcxx-abi=new --enable-gnu-unique-object --disable-vtable-verify --enable-plugin --enable-default-pie --with-system-zlib --with-target-system-zlib=auto --enable-objc-gc=auto --enable-multiarch --disable-werror --with-arch-32=i686 --with-abi=m64 --with-multilib-list=m32,m64,mx32 --enable-multilib --with-tune=generic --enable-offload-targets=nvptx-none=/build/gcc-9-HskZEa/gcc-9-9.3.0/debian/tmp-nvptx/usr,hsa --without-cuda-driver --enable-checking=release --build=x86_64-linux-gnu --host=x86_64-linux-gnu --target=x86_64-linux-gnu
Thread model: posix
gcc version 9.3.0 (Ubuntu 9.3.0-17ubuntu1~20.04)
```

不过，预装的 g++ 版本可能并不满足你的需要，那么你可以执行下面命令手动更新或安装指定版本。

Debian/Ubuntu 系统：

```bash
sudo apt update
sudo apt install g++        # 更新 g++
sudo apt install g++-10     # 安装 g++-10
```

Redhat/Centos 系统：

```bash
sudo yum update
sudo yum install gcc-c++
```



### MacOS

在 MacOS 系统上，你可以像 Linux 系统一样安装命令行编译工具。不过，MacOS 提供了更方便的方式，只需要安装苹果的 Xcode 开发环境，就可以使用 GNU 编译器。

安装方法：

- 在 App Store 搜索 Xcode 下载安装。
- 通过网页 [https://developer.apple.com/xcode/](https://developer.apple.com/xcode/) 下载安装。



### Windows

Windows 系统可以通过安装 [MinGW](https://www.mingw-w64.org/)、[MSYS2](https://www.msys2.org/) 或 [Gygwin](https://www.cygwin.com/) 等工具运行 GNU 编译环境。在 Win 10 及以上版本系统上，还可以通过 WSL（Windows Subsystem for Linux）子系统编译 C++ 项目。

打开 PowerShell 或 Windows 命令行窗口，输入并执行下面命令，即可安装 WSL 子系统的所需内容。

```bash
wsl --install
```

默认情况下，安装的 Linux 发行版为 Ubuntu，你可以使用 `-d` 选项进行更改。

```bash
wsl --install -d <Distribution Name>
```



## 编译示例

新建 hello.cpp 源文件，在编辑器中输入如下内容：

```cpp showLineNumbers
#include <iostream>

using namespace std;

int main()
{
    cout << "Hello, World!" << endl;
    cout << "你好，世界！" << endl;
    return 0;
}
```

使用命令行编译

```bash
$ g++ hello.cpp -o hello
```

执行 hello 程序

```bash
$ ./hello 
Hello, World!
你好，世界！
```



## 编译选项

g++ 编译器是将 gcc 默认语言设为 C++ 的一个特殊的版本，链接时它自动使用 C++ 标准库而不用 C 标准库。和 gcc 一样，g++ 也有许多命令选项。

下列是一些常见的选项：

| 选项           | 解释                                                         |
| -------------- | ------------------------------------------------------------ |
| `-ansi`        | 只支持 ANSI 标准的 C 语法。 这一选项将禁止 GNU C 的某些扩展，如 asm 或 typeof 关键词。 |
| `-c`           | 只编译并生成目标文件。                                       |
| `-DMACRO`      | 以字符串"1"定义 MACRO 宏。                                   |
| `-DMACRO=DEFN` | 以字符串"DEFN"定义 MACRO 宏。                                |
| `-E`           | 只运行 C 预编译器。                                          |
| `-g`           | 生成调试信息。GNU 调试器可利用该信息。                       |
| `-IDIRECTORY`  | 指定额外的头文件搜索路径 DIRECTORY。                         |
| `-LDIRECTORY`  | 指定额外的函数库搜索路径 DIRECTORY。                         |
| `-lLIBRARY`    | 连接时搜索指定的函数库 LIBRARY。                             |
| `-m486`        | 针对 486 进行代码优化。                                      |
| `-o`           | FILE 生成指定的输出文件 默认的文件名为 `a.out`, 这个选项可以自定义生成的执行文件名。 |
| `-O0`          | 不进行优化处理。                                             |
| `-O`           | 或 `-O1` 优化生成代码。                                      |
| `-O2`          | 进一步优化。                                                 |
| `-O3`          | 比 `-O2` 更进一步优化，包括 inline 函数。                    |
| `-shared`      | 生成共享目标文件。通常用在建立共享库时。                     |
| `-static`      | 禁止使用共享连接。                                           |
| `-UMACRO`      | 取消对 MACRO 宏的定义。                                      |
| `-w`           | 不生成任何警告信息。                                         |
| `-Wall`        | 生成所有警告信息。                                           |



## 参考

- [Cygwin/MinGW/MSys/WSL区别与联系](https://www.biaodianfu.com/cygwin-mingw-msys.html)