---
sidebar_position: 54
authors: [luhuadong]
---

# Linux 交叉编译

在嵌入式开发或多平台开发中，你经常会遇到一个问题：你在 PC 上写好代码，但目标设备的 CPU 架构（比如 ARM、MIPS）和操作系统环境与开发机不一样，这时你就不能直接用 gcc 编译后运行。这时，交叉编译（Cross Compilation）就派上用场了。

本文将带你从零了解 Linux 下的交叉编译，包括：

- 什么是交叉编译，为什么要用它？
- 交叉编译器的工作原理；
- 如何获取交叉工具链；
- 一个实际的 C 程序交叉编译示例；
- 使用 CMake、Make 的交叉编译配置方法。



## 什么是交叉编译？

简单来说，**交叉编译**是指在一个平台（如 x86 架构的 Ubuntu PC）上编译出能在另一个平台（如 ARM 架构的开发板）运行的程序。

这时候你使用的编译器就不是默认的 `gcc`，而是一个能生成 ARM 可执行文件的交叉编译器，例如：

```bash
arm-linux-gnueabihf-gcc
aarch64-linux-gnu-gcc
```

你可能会看到这些术语：

- **主机（Host）**：你运行编译器的那台机器（例如 x86 的 Linux PC）。
- **目标（Target）**：你希望最终程序运行的设备（如 ARM 的开发板）。
- **构建（Build）**：构建工具实际运行的平台（一般与 Host 相同）。



## 交叉编译器的原理

交叉编译器是一种特殊的编译器，它的作用是：**在主机平台生成目标平台的可执行程序**。

它内部包含了一套为目标架构构建的：

- 编译器（gcc、g++）；
- 汇编器（as）；
- 链接器（ld）；
- 标准库（如 `libc`, `libstdc++`, `libm` 等）；
- 系统头文件（如 `unistd.h`, `stdio.h` 等）。

这些工具通常被打包成一个工具链（toolchain），可以直接使用或下载。



## 如何获取交叉工具链？

你可以使用多种方式获取交叉编译器工具链：

### 使用 Linux 包管理器

在 Ubuntu 上安装一个面向 ARM 的工具链：

```bash
sudo apt update
sudo apt install gcc-arm-linux-gnueabihf
```

安装完之后，你可以使用：

```bash
arm-linux-gnueabihf-gcc hello.c -o hello_arm
```

生成的 `hello_arm` 可以复制到 ARM 开发板上运行。

### 使用交叉工具链套件（如 Linaro）

访问 [https://releases.linaro.org](https://releases.linaro.org/) 下载交叉工具链，解压后配置 `PATH` 环境变量：

```bash
export PATH=/path/to/toolchain/bin:$PATH
```



## 交叉编译一个简单的 C 程序

假设你有一个 `hello.c`：

```c showLineNumbers title="hello.c"
#include <stdio.h>

int main() {
    printf("你好，嵌入式世界！\n");
    return 0;
}
```

你可以用交叉编译器编译它：

```bash
arm-linux-gnueabihf-gcc hello.c -o hello_arm
```

然后用 [`scp`](/linux-command/scp/) 或 U 盘等方式拷贝到你的 ARM 开发板，并运行它：

```bash
./hello_arm
```

你就能在开发板上看到输出啦！



## 使用 Make 进行交叉编译

你可以编写一个简单的 `Makefile`：

```makefile showLineNumbers title="Makefile"
CC = arm-linux-gnueabihf-gcc
CFLAGS = -Wall

all: hello

hello: hello.c
	$(CC) $(CFLAGS) hello.c -o hello

clean:
	rm -f hello
```

然后运行：

```bash
make
```

就能自动完成编译。



## 使用 CMake 的交叉编译方式

如果你项目使用 CMake 管理，那么你需要创建一个工具链文件 `arm-toolchain.cmake`：

```cmake showLineNumbers title="arm-toolchain.cmake"
SET(CMAKE_SYSTEM_NAME Linux)
SET(CMAKE_SYSTEM_PROCESSOR arm)

SET(CMAKE_C_COMPILER arm-linux-gnueabihf-gcc)
SET(CMAKE_CXX_COMPILER arm-linux-gnueabihf-g++)
```

然后在构建目录中这样运行：

```bash
cmake .. -DCMAKE_TOOLCHAIN_FILE=../arm-toolchain.cmake
make
```

这样 CMake 就会使用你指定的交叉编译器啦！



## 常见问题排查

| 问题                     | 原因及解决方式                                         |
| ------------------------ | ------------------------------------------------------ |
| 编译成功但开发板运行报错 | 检查目标架构是否一致，是否静态编译（避免依赖系统库）   |
| 无法找到交叉编译器命令   | 检查 PATH 环境变量是否正确设置                         |
| 动态库依赖缺失           | 可使用 `ldd` 查看依赖，也可以考虑用 `-static` 静态链接 |
| CMake 配置失败           | 确保 `CMAKE_SYSTEM_NAME` 和编译器路径设置正确          |



## 小结

通过本文，你了解了 Linux 下交叉编译的基础知识和实战流程，包括：

- 什么是交叉编译，为什么需要；
- 如何安装和使用交叉编译器；
- 如何交叉编译 C 程序；
- 如何用 Make 和 CMake 配置交叉编译项目；
- 常见问题排查方法。

如果你在做嵌入式开发、物联网项目，或者需要将程序部署到其他架构设备上，交叉编译是你必须掌握的技能。
