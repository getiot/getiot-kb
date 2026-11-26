---
sidebar_position: 5
---

# reTerminal 开发环境



在为 reTerminal 开发软件之前，首先需要搭建开发环境，我们知道，reTerminal 是基于树莓派 Compute module 4 计算模块核心板的（简称 CM4）。所以，实际上我们需要搭建一套适用于 Raspberry Pi CM4 的交叉编译工具链，这样就能为 reTerminal 开发程序了。



## 安装工具链

```bash
sudo apt install gcc-arm-linux-gnueabihf
```





## crosstool-ng



安装依赖

```bash
sudo apt install texinfo help2man bison

sudo apt install -y byacc flex texinfo help2man gawk libtool libtool-bin libncurses5-dev
```





```bash
git clone https://github.com/crosstool-ng/crosstool-ng

cd crosstool-ng/
./bootstrap
./configure --prefix=/opt/crosstool-ng

make -j $(nproc)
make install
export PATH=/opt/crosstool-ng/bin:$PATH
```





```bash
mkdir ~/RPi_toolchain
cd ~/RPi_toolchain
# use rpi4 template
ct-ng aarch64-rpi4-linux-gnu
ct-ng menuconfig 
ct-ng build
```



```bash
$ ct-ng aarch64-rpi4-linux-gnu
  CONF  aarch64-rpi4-linux-gnu
#
# configuration written to .config
#

***********************************************************

Initially reported by: Bensuperpc <bensuperpc@gmail.com>
URL: https://github.com/Bensuperpc

Comment:
Raspberry PI 4 aarch64

***********************************************************

Now configured for "aarch64-rpi4-linux-gnu"
```



```bash
ct-ng menuconfig
```



![](https://static.getiot.tech/reTerminal-ct-ng-menuconfig.png)



```bash
# check the version of binutils
$ ld -v
GNU ld (GNU Binutils for Ubuntu) 2.34

# check the version of glibc
$ ldd --version
ldd (Ubuntu GLIBC 2.31-0ubuntu9.7) 2.31
Copyright (C) 2020 自由软件基金会。
这是一个自由软件；请见源代码的授权条款。本软件不含任何没有担保；甚至不保证适销性
或者适合某些特殊目的。
由 Roland McGrath 和 Ulrich Drepper 编写。

# check the kernel version
$ uname -a
Linux Latitude-3420 5.14.0-1051-oem #58-Ubuntu SMP Fri Aug 26 05:50:00 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
```





编译

```bash
mkdir ~/src
ct-ng build
```



![](https://static.getiot.tech/reTerminal-ct-ng-build.png)





## 出错

```bash
[INFO ]  Installing cross-gdb
[EXTRA]    Configuring cross gdb
[EXTRA]    Building cross gdb
[ERROR]    configure: error: no usable python found at /usr/bin/python3.7
[ERROR]    make[2]: *** [Makefile:11425: configure-gdb] Error 1
[ERROR]    make[1]: *** [Makefile:1001: all] Error 2
[ERROR]   
[ERROR]  >>
[ERROR]  >>  Build failed in step 'Installing cross-gdb'
[ERROR]  >>        called in step '(top-level)'
[ERROR]  >>
[ERROR]  >>  Error happened in: CT_DoExecLog[scripts/functions@376]
[ERROR]  >>        called from: do_gdb_backend[scripts/build/debug/300-gdb.sh@326]
[ERROR]  >>        called from: do_debug_gdb_build[scripts/build/debug/300-gdb.sh@73]
[ERROR]  >>        called from: do_debug[scripts/build/debug.sh@35]
[ERROR]  >>        called from: main[scripts/crosstool-NG.sh@697]
[ERROR]  >>
[ERROR]  >>  For more info on this error, look at the file: 'build.log'
[ERROR]  >>  There is a list of known issues, some with workarounds, in:
[ERROR]  >>      https://crosstool-ng.github.io/docs/known-issues/
[ERROR]  >>
[ERROR]  >>  If you feel this is a bug in crosstool-NG, report it at:
[ERROR]  >>      https://github.com/crosstool-ng/crosstool-ng/issues/
[ERROR]  >>
[ERROR]  >>  Make sure your report includes all the information pertinent to this issue.
[ERROR]  >>  Read the bug reporting guidelines here:
[ERROR]  >>      http://crosstool-ng.github.io/support/
[ERROR]   
[ERROR]  (elapsed: 19:15.69)
[19:16] / make: *** [/opt/crosstool-ng/bin/ct-ng:261：build] 错误 2
```

关闭 `CT_DEBUG_GDB` 选项



编译完成

```bash
[INFO ]  Installing final gcc compiler
[EXTRA]    Configuring final gcc compiler
[EXTRA]    Building final gcc compiler
[EXTRA]    Installing final gcc compiler
[EXTRA]    Housekeeping for final gcc compiler
[EXTRA]       '' --> lib (gcc)   lib64 (os)
[INFO ]  Installing final gcc compiler: done in 420.42s (at 19:52)
[INFO ]  =================================================================
[INFO ]  Finalizing the toolchain's directory
[INFO ]    Stripping all toolchain executables
[EXTRA]    Installing the populate helper
[EXTRA]    Installing a cross-ldd helper
[EXTRA]    Creating toolchain aliases
[EXTRA]    Removing installed documentation
[EXTRA]    Collect license information from: /home/rudy/RPi_toolchain/.build/aarch64-rpi4-linux-gnu/src
[EXTRA]    Put the license information to: /home/rudy/x-tools/aarch64-rpi4-linux-gnu/share/licenses
[INFO ]  Finalizing the toolchain's directory: done in 4.50s (at 19:57)
[INFO ]  Build completed at 20221019.235644
[INFO ]  (elapsed: 19:55.91)
[INFO ]  Finishing installation (may take a few seconds)...
```



编译工具链所在目录

```bash
.build/aarch64-rpi4-linux-gnu/buildtools/bin/
```



```bash
export PATH=/home/rudy/RPi_toolchain/.build/aarch64-rpi4-linux-gnu/buildtools/bin:$PATH
```



```bash
# 本地编译
$ file hello.local 
hello.local: ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-armhf.so.3, BuildID[sha1]=c38d3f9fb2e79eecb78a63fd3bfe2ec089fa7db5, for GNU/Linux 3.2.0, not stripped

# 交叉编译
$ file hello
hello: ELF 64-bit LSB pie executable, ARM aarch64, version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-aarch64.so.1, for GNU/Linux 6.0.2, with debug_info, not stripped
```



```bash
$ ./hello.local 
Hello, GetIoT

$ ./hello
-bash: ./hello：无法执行二进制文件: 可执行文件格式错误
```





