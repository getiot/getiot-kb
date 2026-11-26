---
sidebar_position: 3
sidebar_label: 开发环境
---

# 潘多拉 IoT Board 开发环境



潘多拉（Pandora）是一款基于 STM32 的 RT-Thread 物联网开发板，本文将介绍如何在 Windows 和 Linux 中搭建 RT-Thread 开发环境，并通过 stlink 工具将程序烧写到开发板。


## Windows 系统

待补充

## Linux 系统

### 安装依赖

**安装 Git 版本管理工具**

```bash
sudo apt install git-all
```

**安装 Scons 构建工具**

```bash
sudo apt install scons
```

**安装 ncurses 库**

```bash
sudo apt install libncurses5-dev
```

**安装 GCC 交叉编译工具链**

下载工具链（例如 gcc-arm-none-eabi-7-2017-q4-major-linux.tar.bz2）

```bash
wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/7-2017q4/gcc-arm-none-eabi-7-2017-q4-major-linux.tar.bz2
```

解压缩到 /opt 目录

```bash
tar jxvf gcc-arm-none-eabi-7-2017-q4-major-linux.tar.bz2 -C /opt/
```



### 安装 stlink

通过包管理器安装 stlink 工具

```bash
sudo apt install stlink-tools
sudo apt install stlink-gui
```

安装成功后，系统增加了如下几个工具：

| 工具         | 功能                                |
| :----------- | :---------------------------------- |
| `st-flash`   | 将二进制文件固化到 STM32 设备       |
| `st-info`    | 查询已连接 STLink 的 STM32 设备信息 |
| `st-util`    | 运行 GDB 服务与 STM32 设备进行交互  |
| `stlink-gui` | STlink 图形化工具                   |

使用 Micro USB 线连接 Pandora 开发板到 PC，在 Shell 终端输入 `st-info --probe` 命令，检查 stlink 工具及开发板是否正常。

```bash
$ st-info --probe
Found 1 stlink programmers
 serial: 303637304646353135323535373036353837323131373239
openocd: "\x30\x36\x37\x30\x46\x46\x35\x31\x35\x32\x35\x35\x37\x30\x36\x35\x38\x37\x32\x31\x31\x37\x32\x39"
  flash: 524288 (pagesize: 2048)
   sram: 98304
 chipid: 0x0415
  descr: L4 device
```

提示：这种方式获取的软件可能并不是最新版本的，如果需要安装最新版本，可以访问 [GitHub 仓库](https://github.com/stlink-org/stlink.git)。



### 烧写程序

首先进入 RT-Thread 项目对应的 BSP 目录。

```bash
cd rt-thread/bsp/stm32/stm32l475-atk-pandora
```

构建独立的工程目录。

```bash
scons --dist
```

进入 dist/stm32l475-atk-pandora 目录，修改 rtconfig.py 中的 GCC 路径。

```python showLineNumbers title="rtconfig.py"
# cross_tool provides the cross compiler
# EXEC_PATH is the compiler execute path, for example, CodeSourcery, Keil MDK, IAR
if  CROSS_TOOL == 'gcc':
    PLATFORM    = 'gcc'
    EXEC_PATH   = r'/opt/gcc-arm-none-eabi-7-2017-q4-major/bin/'
```

回到终端执行 `scons` 命令，编译工程，生成 rtthread.bin 和 rt-thread.elf 二进制文件。

将二进制文件 rtthread.bin 烧写到 STM32 开发板。

```bash
st-flash write rtthread.bin 0x8000000
```

现在，你应该会看到 Pandora 开发板上的红色 LED 灯闪烁。

