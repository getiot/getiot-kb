---
sidebar_position: 4
---

# NuMaker-HMI-N9H30 固件下载（Linux）



[前面](/board/NuMaker/numaker-hmi-n9h30-program-firmware/) 介绍了在 Windows 系统中使用 NuWriter 图形界面工具为 NuMaker-HMI-N9H30 开发板烧写固件程序的方法。对于 Linux 用户，虽然无法在 Linux 系统中运行 NuWriter 图形工具，不过我们可以使用命令行工具完成固件程序的下载。本文将以 Ubuntu 20.04 系统为例，演示如何安装 `NUC970_NuWriter_CMD` 命令行工具，并完成程序烧写。



## 编译安装

### 安装依赖

```bash
sudo apt install libusb-1.0-0-dev
sudo apt install autoconf automake automake-1.15
```

### 下载编译

在 [https://github.com/OpenNuvoton/NUC970_NuWriter_CMD](https://github.com/OpenNuvoton/NUC970_NuWriter_CMD) 下载源代码，例如使用 git 克隆仓库。

```bash
git clone https://github.com/OpenNuvoton/NUC970_NuWriter_CMD.git
```

切换到 NUC970_NuWriter_CMD 目录

```bash
cd NUC970_NuWriter_CMD
```

配置并编译程序

```bash
./configure --prefix=$PWD/install
make
```

如果 `make` 失败，出现如下错误提示：

```bash
$ make
 cd . && /bin/bash /home/rudy/workspace/NUC970_NuWriter_CMD/missing automake-1.15 --foreign
configure.ac:6: error: version mismatch.  This is Automake 1.15.1,
configure.ac:6: but the definition used by this AM_INIT_AUTOMAKE
configure.ac:6: comes from Automake 1.15.  You should recreate
configure.ac:6: aclocal.m4 with aclocal and run automake again.
WARNING: 'automake-1.15' is probably too old.
         You should only need it if you modified 'Makefile.am' or
         'configure.ac' or m4 files included by 'configure.ac'.
         The 'automake' program is part of the GNU Automake package:
         [http://www.gnu.org/software/automake](http://www.gnu.org/software/automake)
         It also requires GNU Autoconf, GNU m4 and Perl in order to run:
         [http://www.gnu.org/software/autoconf](http://www.gnu.org/software/autoconf)
         [http://www.gnu.org/software/m4/](http://www.gnu.org/software/m4/)
         [http://www.perl.org/](http://www.perl.org/)
make: *** [Makefile:355：Makefile.in] 错误 1
```

那么需要执行下面命令，在重新 `make` 编译。

```bash
$ aclocal
$ autoreconf --force
```

### 安装

编译完成后，执行下面命令将 nuwriter 安装到前面配置的指定目录

```bash
make install
```

添加 udev rule

```bash
sudo install -Dm644 99-nuvoton_isp.rules /etc/udev/rules.d/99-nuvoton_isp.rules
```

这样，nuwriter 命令行工具就安装成功了！可执行文件位于 install/bin/ 目录中。



## 命令参数

执行 `nuwriter -h` 命令，查看 nuwriter 工具的选项参数，如下所示。

```bash
============================================
==   Nuvoton NuWriter Command Tool V1.0   ==
============================================
NuWriter [Options] [File/Value]

-d [File]      Set DDR initial file
-d show        Print supported DDR model

-m sdram       Set SDRAM Mode
-m emmc        Set eMMC Mode
-m nand        Set NAND Mode
-m spi         Set SPI Mode

-t data        Set DATA Type
-t env         Set Environemnt Type
-t uboot       Set uBoot Type
-t pack        Set PACK Type
SDRAM parameters:
-a [value]     Set execute address
-w [File]      Write image file to SDRAM
-i [value]     device tree address
-n             Download & Run

NAND/SPI/eMMC parameters:
-a [value]     Set start offset/execute address
               if erase, unit of block
-w [File]      Write image file to NAND
-r [File]      Read image file from NAND
-e [value]     Read/Erase length(unit of block)
-e 0xFFFFFFFF  Chip erase
-v             Verify image file after Write image 

============================================
```



## 程序下载

### SDRAM 下载方式 

```bash
$ ./install/bin/nuwriter -m sdram -d N9H30F61IEC.ini -a 0x0 -w rtthread.bin -n
```



### SPI Flash 下载方式

```bash
$ ./install/bin/nuwriter -m spi -d N9H30F61IEC.ini -t uboot -a 0x0 -w rtthread.bin -v
```


