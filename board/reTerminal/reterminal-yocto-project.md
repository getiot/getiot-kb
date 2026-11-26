---
sidebar_position: 6
---

# reTerminal 构建 Yocto 工程





## BSP

```bash
$ source layers/poky/oe-init-build-env 
You had no conf/local.conf file. This configuration file has therefore been
created for you with some default values. You may wish to edit it to, for
example, select a different MACHINE (target hardware). See conf/local.conf
for more information as common configuration options are commented.

You had no conf/bblayers.conf file. This configuration file has therefore been
created for you with some default values. To add additional metadata layers
into your configuration please add entries to conf/bblayers.conf.

The Yocto Project has extensive documentation about OE including a reference
manual which can be found at:
    https://docs.yoctoproject.org

For more information about OpenEmbedded see their website:
    https://www.openembedded.org/


### Shell environment set up for builds. ###

You can now run 'bitbake <target>'

Common targets are:
    core-image-minimal
    core-image-sato
    meta-toolchain
    meta-ide-support

You can also run generated qemu images with a command like 'runqemu qemux86'

Other commonly useful commands are:
 - 'devtool' and 'recipetool' handle common recipe tasks
 - 'bitbake-layers' handles common layer tasks
 - 'oe-pkgdata-util' handles common target package tasks
```



构建 rpi-test-image 镜像

```bash
MACHINE="seeed-reterminal" bitbake rpi-test-image
```

构建失败

```bash
| make[2]: Leaving directory '/home/rudy/reterminal-yocto/build/tmp/work/aarch64-poky-linux/qtbase/5.14.2+gitAUTOINC+3a6d8df521-r0/build/tests/auto/widgets'
| make[1]: Leaving directory '/home/rudy/reterminal-yocto/build/tmp/work/aarch64-poky-linux/qtbase/5.14.2+gitAUTOINC+3a6d8df521-r0/build/tests/auto'
| make: *** [Makefile:48: sub-auto-make_first] Error 2
| ERROR: oe_runmake failed
| WARNING: exit code 1 from a shell command.
| ERROR: Execution of '/home/rudy/reterminal-yocto/build/tmp/work/aarch64-poky-linux/qtbase/5.14.2+gitAUTOINC+3a6d8df521-r0/temp/run.do_compile_ptest_base.1912729' failed with exit code 1
ERROR: Task (/home/rudy/reterminal-yocto/layers/meta-qt5/recipes-qt/qt5/qtbase_git.bb:do_compile_ptest_base) failed with exit code '1'
NOTE: Tasks Summary: Attempted 5687 tasks of which 5686 didn't need to be rerun and 1 failed.

Summary: 1 task failed:
  /home/rudy/reterminal-yocto/layers/meta-qt5/recipes-qt/qt5/qtbase_git.bb:do_compile_ptest_base
Summary: There were 2 ERROR messages shown, returning a non-zero exit code.
```





位于 tmp/deploy/images/seeed-reterminal/





## Toolchain

```bash
MACHINE="seeed-reterminal" bitbake meta-toolchain
```

位于 tmp/deploy/sdk/

```bash
MACHINE="seeed-reterminal" bitbake rpi-basic-image -c populate_sdk
```



```bash
$ readelf -h ./hello.local 
ELF 头：
  Magic：  7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00 
  类别:                              ELF32
  数据:                              2 补码，小端序 (little endian)
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI 版本:                          0
  类型:                              EXEC (可执行文件)
  系统架构:                          ARM
  版本:                              0x1
  入口点地址：              0x10314
  程序头起点：              52 (bytes into file)
  Start of section headers:          6912 (bytes into file)
  标志：             0x5000400, Version5 EABI, hard-float ABI
  Size of this header:               52 (bytes)
  Size of program headers:           32 (bytes)
  Number of program headers:         9
  Size of section headers:           40 (bytes)
  Number of section headers:         29
  Section header string table index: 28
```



```bash
$ readelf -h ./hello
ELF 头：
  Magic：  7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00 
  类别:                              ELF64
  数据:                              2 补码，小端序 (little endian)
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI 版本:                          0
  类型:                              DYN (共享目标文件)
  系统架构:                          AArch64
  版本:                              0x1
  入口点地址：              0x680
  程序头起点：              64 (bytes into file)
  Start of section headers:          73120 (bytes into file)
  标志：             0x0
  Size of this header:               64 (bytes)
  Size of program headers:           56 (bytes)
  Number of program headers:         9
  Size of section headers:           64 (bytes)
  Number of section headers:         36
  Section header string table index: 35
```



