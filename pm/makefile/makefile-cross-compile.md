---
sidebar_position: 7
draft: true
---

# Makefile 交叉编译



嵌入式开发中常常需要设置 `ARCH` 和 `CROSS_COMPILE` 环境变量：

```bash showLineNumbers
export ARCH=arm64
export CROSS_COMPILE=aarch64-poky-linux-
```



变量 **`ARCH`** 即 architecture，就是选择编译哪一种 CPU architecture，对于 Linux kernel 来说就是编译 arch/ 目录下的哪一个子目录。如指定 `make ARCH=arm` 就是编译 arch/arm 下的代码。如果不指定，make 将使用本机（用什么机器编译就是什么）的 CPU 作为缺省 ARCH。

注意：arch/arm 下不但有 arm 体系架构特有的代码，还有 arm 特有的 kconfig，也就是配置选项，所以在执行 `make menuconfig`、`make xxxx_defconfig` 命令时也必须指定 `ARCH=arm`。

变量 **`CROSS_COMPILE`** 即交叉编译器的前缀（prefix），也就是选择将代码编译成目标 CPU 的指令的工具，如指定 `make CROSS_COMPILE=arm-none-linux-gnueabi-` 就是使用 `arm-none-linux-gnueabi-gcc`、`arm-none-linux-gnueabi-ld` 等工具将代码编译成 arm 的可执行指令。如果不指定 `CROSS_COMPILE` 参数，make 时将认为 prefix 为空，即使用 gcc 来编译。



## 配置

在配置或编译内核之前，首先要确定目标 CPU 架构，以及编译时采用什么工具链。这是最最基础的信息，首先要确定的。

如果你是为当前使用的 PC 机编译内核，则无须设置。否则的话，就要明确设置。下面以 arm 为例进行说明，主要有两种设置方法。

### 修改 Makefile

打开内核源码根目录下的 Makefile，修改如下两个 Makefile 变量并保存。

```makefile showLineNumbers
ARCH           := arm
CROSS_COMPILE  := arm-linux-
```

提示：这里 `CROSS_COMPILE` 的设置，是假定所用的交叉工具链的 gcc 程序名称为 arm-linux-gcc。如果实际使用的 gcc 名称是 some-thing-else-gcc，则这里照葫芦画瓢填 some-thing-else- 即可。总之就是要省去名称中最后的 gcc 那 3 个字母。

### 通过命令行参数传递

每次执行 make 命令时，都通过命令行参数传入这些信息。这其实是通过 make 工具的命令行参数指定变量的值。

例如，配置内核：

```bash
make ARCH=arm CROSS_COMPILE=arm-linux- menuconfig
```

编译内核：

```bash
make ARCH=arm CROSS_COMPILE=arm-linux- 
```

注意，实际上，对于编译 PC 机内核的情况，虽然用户没有明确设置，但并不是这两项没有配置。因为如果用户没有设置这两项，内核源码顶层 Makefile（位于源码根目录下）会通过如下方式生成这两个变量的值。

```makefile showLineNumbers
SUBARCH := $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ \
 -e s/arm.*/arm/ -e s/sa110/arm/ \
 -e s/s390x/s390/ -e s/parisc64/parisc/ \
 -e s/ppc.*/powerpc/ -e s/mips.*/mips/ \
 -e s/sh[234].*/sh/ )

ARCH?= $(SUBARCH)
CROSS_COMPILE ?=
```

经过上面的代码，`ARCH` 变成了 PC 编译机的 arch，即 `SUBARCH`。因此，如果 PC 机上 `uname -m` 输出的是 ix86，则 `ARCH` 的值就成了 i386。

而 `CROSS_COMPILE` 的值，如果没配置，则为空字符串。这样一来所使用的工具链程序的名称，就不再有类似 arm-linux- 这样的前缀，就相当于使用了 PC 机上的 gcc。

另外，`ARCH` 的值还需要再进一步做泛化。因为内核源码的 arch 目录下，不存在 i386 这个目录，也没有 sparc64 这样的目录。因此顶层 Makefile 中又构造了一个 `SRCARCH` 变量，通过如下代码，生成他的值。这样一来，`SRCARCH` 变量，才最终匹配到内核源码 arch 目录中的某一个架构名。

```makefile showLineNumbers
SRCARCH := $(ARCH)  

ifeq ($(ARCH),i386)
	SRCARCH := x86
endif


ifeq ($(ARCH),x86_64)
	SRCARCH := x86
endif

ifeq ($(ARCH),sparc64)
	SRCARCH := sparc
endif

ifeq ($(ARCH),sh64)
	SRCARCH := sh
endif
```

