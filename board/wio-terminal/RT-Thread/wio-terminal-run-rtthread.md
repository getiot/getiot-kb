---
sidebar_position: 1
slug: /wio-terminal-run-rtthread
---

# Wio Terminal 运行 RT-Thread 系统



![](https://static.getiot.tech/rt-thread-on-wio-terminal-01.jpg#center)



**Wio Terminal** 是 Seeed Studio 设计的一款开发套件。它基于 SAMD51 的微控制器，运行速度为 120MHz（最高可达 200MHz），拥有 4MB 外部闪存和 192KB RAM，具有 Realtek RTL8720DN 支持的无线连接，同时支持蓝牙和 Wi-Fi 功能，是物联网项目的一个不错选择。并且它使用 Arduino IDE 就可以进行开发，新手也可以非常容易上手。

但是，基于 Arduino 的开发也有一些缺点，比如无法调试、无法使用多线程编程、不利于理解底层代码深入学习嵌入式开发、难以进行系统优化等等。于是，我在想能不能在 Wio Terminal 上运行 RT-Thread 操作系统？使用 RT-Thread 强大的软件生态进行开发呢？

说干就干！经过两个周末的折腾，我终于实现了将 RT-Thread 移植到 Wio Terminal 上。那么，本文就来介绍我是如何实现这个目标的。



## 背景知识

开始之前，我们先来了解一些相关概念，以便顺利完成本次实验。

### SAM 系列芯片

Microchip ATSAM 系列芯片在各种工业、消费类和汽车领域有广泛应用。Arduino 开发板常用的芯片就是 Atmel 公司生产的 AVR 和 SAM 系列微控制器。而我们这里用到的 Wio Terminal，它的主控制器是 **ATSAMD51P19A-U**。

我们先来看看这个 SAM 芯片家族，下面是数据手册提供的说明。其中，ATSAMD51P19 就表示核心是 Cortex-M4F（不含 CAN 和 Ethernet 外设）、Flash 容量 512 KB，管脚共 120/128 个（具体和封装有关）。

![](https://static.getiot.tech/microchip-atsamd51-20230909001333.png#center)



### Atmel START

[Atmel START](https://start.atmel.com) 是一款可对 SAM 和 AVR 微控制器项目进行直观的图形配置的在线工具，作用类似于 ST 的 STM32CubeMX 工具。由于 Atmel START 以 SaaS 形式提供服务，所以我觉得更加方便。

![](https://static.getiot.tech/atmel-start-screenshot.jpeg#center)

Atmel START 基于最新一代的高级软件框架 ASF4。使用 Atmel START，你可以选择和配置软件组件、驱动程序和中间件，以及专门根据你的应用程序需求定制的完整示例项目。

通过图形引脚复用和时钟配置，你可以轻松地将软件和驱动程序与你使用的硬件布局相匹配。配置阶段还会检查软件组件之间的依赖关系、冲突和硬件约束。如果发生冲突，Atmel START 会自动建议适合你特定设置的解决方案。



### ASF4

ASF4 全称 Advanced Software Framework Version 4，它是 Microchip 提供的一套外设驱动程序、中间件和软件应用程序等软件组件的集合。该框架支持 Microchip 的 SAM 系列微控制器。



### Microchip Studio

Atmel Studio 是 Atmel（现在是 Microchip）公司推出的一款集成开发环境（IDE），专门用于嵌入式系统的开发。提供了丰富的工具和功能，以支持 Atmel 微控制器的编程、调试和部署。Atmel Studio 支持多种编译器，包括 GCC 和 IAR 编译器，可用于生成最优化的代码。支持多种编程语言，包括 C、C++ 和汇编语言。开发者可以根据自己的需求选择最合适的编程语言来编写他们的应用程序。

由于 Atmel 被 Microchip 收购了，所以 Atmel Studio 也更名为 Microchip Studio。它整合了 Atmel Studio 的功能，并扩展支持了更多 Microchip 微控制器系列，包括 PIC 系列等。

![](https://static.getiot.tech/microchip-studio-screenshot.jpeg#center)

我们这里使用最新的 Microchip Studio 7.0，你可以在[这里](https://www.microchip.com/en-us/tools-resources/develop/microchip-studio)下载。



### Atmel ICE Programmer

Atmel-ICE 是 Microchip 新推出的功能强大的调试编程工具，适用于 Atmel ARM Cortex-M 的 SAM 和 AVR 系列芯片。

![](https://static.getiot.tech/atmel-ice-programmer.jpg#center)

Atmel-ICE 支持的软件：

- 支持 MIcrochip Studio 6.2 以上版本
- 支持 ICC8AVR 以上版本
- 支持烧录 ICCAVR、CVAVR、IAR 等生成的 HEX 文件

本次实验将使用 MIcrochip Studio + Atmel-ICE 来完成 RT-Thread 固件烧录。



## 搭建工程

### 下载源代码

我已经完成 RT-Thread 的移植了，你可以从我的 GitHub 分支拉取移植好的 rt-thread 工程，这样就能快速启动你的 Wio Terminal。

```bash
git clone -b microchip https://github.com/luhuadong/rt-thread.git
```

国内的小伙伴也可以从 Gitee 下载，这样会更快一点。

```bash
git clone -b microchip https://gitee.com/luhuadong/rt-thread.git
```

Wio Terminal 对应的 BSP 位于 `bsp/microchip/samd51-seeed-wio-terminal` 目录。

### 编译 BSP

目前仅提供在 Windows 下通过 Env 工具编译。使用 Env 工具打开 samd51-seeed-wio-terminal 目录，输入 `scons` 即可编译该 BSP 工程。

![](https://static.getiot.tech/rtthread-env-build-wio-terminal-bsp-01.jpeg#center)

因为我已经事先配置好工程了，因此你不需要执行 `menuconfig` 配置即可编辑。当然，你也可以执行 `menuconfig` 命令对该 BSP 工程进行重新配置，添加你想要的组件或软件包。



### 创建工程

打开 Microchip Studio，依次选择 File -> Open -> Open Object File For Debugging，打开工程配置窗口。

![](https://static.getiot.tech/microchip-studio-open-debugging-project.jpeg#center)

选择刚刚编译好的 rt-thread-samd51.elf 文件，设置项目名称，以及工程目录，如下图所示。

![](https://static.getiot.tech/microchip-studio-open-debugging-project-02.png#center)

点击 Next，选择对应芯片型号 ATSAMD51P19A，如下图所示。

![](https://static.getiot.tech/microchip-studio-open-debugging-project-03.png#center)

点击 Finish 完成 Microchip Studio 工程配置。

![](https://static.getiot.tech/microchip-studio-open-debugging-project-04.jpeg#center)



## 烧录调试

### 硬件改造

Wio Terminal 默认只提供了 USB 接口通过 Arduino IDE 开发，通过查阅 Wio Terminal 电路图，我们发现 PCB 上有预留 SWD 调试接口。

![](https://static.getiot.tech/wio-terminal-SWD-0.png#center)

一种方式是以 Grove 接口提供，对应 Wio Terminal 正面左侧的 I2C Grove 接口。不过需要在 PCB 上 R33 和 R34 位置焊接 0Ω 电阻可以使用。

![](https://static.getiot.tech/wio-terminal-SWD-2.png#center)

另一种方式是以测试触点提供的接口，如下图左侧所示。

![](https://static.getiot.tech/wio-terminal-SWD-1.png#center)

在实验过程中，我尝试通过电烙铁和热风枪的方式将两颗  0Ω 电阻焊接上去，因为使用的是 0402 尺寸电阻，所以对没有硬件经验的同学操作起来有一定难度。

首先，拆开 Wio Terminal 外壳。提示：Wio Terminal 的两颗螺丝隐藏在背面左上角和右下角的两个垫片下。

![](https://static.getiot.tech/wio-terminal-hacking-01.jpeg#center)

拆开后取出 PCB 板，找到 R33 和 R34 焊盘位置，将两颗 0Ω 电阻摆放好。

![](https://static.getiot.tech/wio-terminal-hacking-02.jpeg#center)

由于位置刁钻，建议使用热风枪调至 300 ℃ 左右慢慢将其焊接好。另一个方法是先把 Grove 座子焊下来，腾出空间用电烙铁将 0402 电阻焊上。提示：焊接完一定要检查是否虚焊。

![](https://static.getiot.tech/wio-terminal-hacking-03.jpeg#center)

如果你觉得 0402 电阻难度太大，也可以尝试直接用导线将测试触点引出来。需要注意的是，由于测试触点不是专用的焊盘，表面没有涂锡，因此操作的时候要特别小心，不要焊太久，否则很容易像我这样把铜片都焊掉了 (⊙﹏⊙)b

![](https://static.getiot.tech/wio-terminal-hacking-04.jpeg#center)

后来我找到了一种专用于烧录的“顶针夹具”，应该是最方便的了，不需要焊接，直接夹上就可以用了！不过，大家注意要选择 2.0mm 的，而不是 2.54mm 的。 

![](https://static.getiot.tech/wio-terminal-hacking-05.jpeg#center)



### 连接 Atmel ICE

解决了硬件问题，接下来就可以连接 Atmel ICE 啦。这里用到的是 SWD（Serial Wire Debug）接口，需要连接四根线，SWDIO、SWCLK 以及 VCC 和 GND，分别是对应 2、4、1、3 端口。

![](https://static.getiot.tech/atatmel-ice-swd-header-pinout.png#center)

连接好 Atmel ICE 之后，点击 Microchip Studio 菜单栏中的 Tools -> Device Programming，打开 Device Programming 窗口。

![](https://static.getiot.tech/microchip-studio-device-programming.jpeg#center)

此时，你可以在 Interface settings 选项卡中，Tool 下拉框选择 Atmel-ICE 调试器，点击 Apply 按钮。如果连接正常，点击右侧的 Read 按钮，可以读取设备签名信息和电压值。

![](https://static.getiot.tech/atmel-ice-device-programming-01.jpg#center)



### 擦除 Bootloader

想要将 RT-Thread 固件写入 Wio Terminal，还有一个非常关键的地方 —— 擦除设备原先的 Bootloader 程序。

点击左侧 Fuses 选项卡，然后找到 NVM 控制寄存器 `USER_WORD_0_NVMCTRL_BOOTPORT` 配置项，可以看到当前设置为 16 KB。也就是说，Flash 的前 16 KB 被用于存放 Bootloader 程序了。

![](https://static.getiot.tech/atmel-ice-device-programming-03.jpg#center)

我们需要将其改为 0 KB，然后点击 Program 按钮保存修改。这样，Bootloader 占用的 Flash 空间就不再受保护。

![](https://static.getiot.tech/atmel-ice-device-programming-05.jpg#center)

接着，在 Memories 选项卡中，选择 Erash Chip，点击 Erase now，擦除整片 Flash。

![](https://static.getiot.tech/atmel-ice-device-programming-06.jpg#center)

等待擦除完毕，你就可以写入新的固件啦！



### 烧录程序

回到 Microchip Studio 主界面，在工具栏点击“小锤子”按钮，如下图 ① 所示。选择 Tool 选项卡，设置调试器为 Atmel-ICE，接口为 SWD，保存配置。

然后点击工具栏中“绿色小三角”按钮，如下图 ④ 所示，将固件 rt-thread-samd51.elf 下载到 Wio Terminal，并进入调试模式。

![](https://static.getiot.tech/microchip-studio-set-debug-tool.png#center)

在实验过程中，我们发现第一次烧录可能会出现“Launch Failed”错误导致无法烧录成功。解决方法是拉下 Wio Terminal 左侧的 Reset 开关，然后松开，立即点击“小三角”按钮（或者 F5 键）。

![](https://static.getiot.tech/atmel-ice-launch-failed.jpg#center)

如果失败了，多尝试几遍，并检查连线是否正常。多点耐心，一定会成功的。



## 运行测试

当固件烧录成功后，就会进入调试模式。你可以在工程代码中打上一些断点，检查 RT-Thread 程序是否正常运行。

![](https://static.getiot.tech/microchip-studio-screenshot.jpeg#center)

在这个 BSP 中，我们配置了一个 LED 设备、一个 UART 串口设备，以及一个 USB CDC 设备。在 RT-Thread 程序中，我们启动一个线程用于循环控制 LED 灯亮灭。因此，当 main 函数运行起来后，你会看到 Wio Terminal 板载的蓝色 LED 灯开始闪烁。

该 BSP 默认配置 uart0 为 RT-Thread 的 Finsh 控制台，uart0 对应的引脚在 Wio Terminal 背面 40 pin 接口上，如下图所示。

![](https://static.getiot.tech/wio-terminal-UART-0.png#center)

使用 USB 转 TTL 串口模块连接该串口，打开任意一款串口终端工具，配置串口参数为 115200 N 8 1。当 RT-Thread 固件启动后，可以在终端上看到熟悉的打印，这意味着 RT-Thread 系统已经在 Wio Terminal 上跑起来了。

![](https://static.getiot.tech/rtthread-run-on-wio-terminal-01.jpeg#center)

现在，你可以尝试输入 RT-Thread 内置的命令，查看系统信息。例如 `ps` 命令查看系统当前有多少个任务。



## Atmel START 配置

首先，你需要使用 Atmel START 在线工具生成一套基于 ASF4 框架的工程示例代码。配置流程大致如下，首先创建一个特定芯片型号的工程，然后配置时钟、管脚、驱动、中间件等，最后根据配置生成并导出代码。

![](https://static.getiot.tech/microchip-atsamd51-20230909113910.png#center)

### 创建工程

使用浏览器打开 Atmel START 网页 [https://start.atmel.com](https://start.atmel.com)，点击“CREATE NEW PROJECT”创建一个新的工程。控制器选择 ATSAMD51P19A，封装选择 TFBGA120。

![](https://static.getiot.tech/atmel-start-wio-terminal-create.jpeg#center)

### 时钟配置

选择左侧的 CLOCKS 选项卡，开始配置时钟。这里以内部晶振作为时钟源为例，配置完成后如下图所示，最终生成 48MHz 的时钟给到 CPU。

![](https://static.getiot.tech/atmel-start-wio-terminal-config-clock.jpeg#center)

具体来说，勾选时钟发生器 0 和 1，generator 1 选择 32kHz 内部晶振（OSCULP32K）作为时钟源，并作为 DFLL48M 数控频率锁定环的输入，然后 generator 0 选择 DFLL48M 作为时钟源，并输出到 CPU。

当然，Wio Terminal 本身是提供外部晶振的，可以配置更高的时钟频率，你可以自行探索。

### 串口配置

切换到 DASHBOARD 选项卡，点击 Add software component 添加串口驱动。搜索 `stdio` 关键字，添加 STDIO Redirect 组件。

![](https://static.getiot.tech/atmel-start-wio-terminal-config-uart-01.jpeg#center)

此时会增加 STDIO_REDIRECT_0 和 TARGET_IO 两个模块，这里的 TARGET_IO 对应的就是 UART 外设。不过，由于 STDIO Redirect 依赖导致 TARGET_IO 无法设置为异步模式，所以这里需要把 STDIO_REDIRECT_0 组件删除，只留下 TARGET_IO 驱动，如下图所示。

![](https://static.getiot.tech/atmel-start-wio-terminal-config-uart-02.jpeg#center)

现在，点击 TARGET_IO，开始配置串口。查阅 Wio Terminal 的电路图，可以找到有哪些串口供我们使用，这里以背面 40 pin 引脚中的 UART 串口为例，其对应关系如下：

- TXD - TXD0/GPIO14 - A13 - PB26/I12/SERCOM2.0+4.1/TCC1.3
- RXD - RXD0/GPIO15 - B12 - PB27/I13/SERCOM2.1+4.0/TCC1.3

因此，Driver 选择 `HAL:Driver:USART_Async`，Mode 选择 `UART`，Instance 选择 `SERCOM2`。RX 引脚为 `PB27`，TX 引脚为 `PB26`。

![](https://static.getiot.tech/atmel-start-wio-terminal-config-uart-03.jpeg#center)

另外，还可以修改串口参数，例如波特率为 115200、8 位数据位、1 位停止位、无奇偶校验位。

![](https://static.getiot.tech/atmel-start-wio-terminal-config-uart-04.jpeg#center)

这样，串口就配置好了。

### LED 配置

Wio Terminal 上有一个 USER LED，我们把它配置起来，后续在 RT-Thread 中实现点灯操作。查阅电路图，这颗 LED 的管脚对应关系为：

- USER_LED - PA15/I15/SERCOM2+4.3/TC3.1+TCC2.1+1.3

切换到 PINMUX 选项卡，在右边找到 PA15 管脚，添加 User label 信息为 LED0，Pin mode 为 Digital output 即可。

![](https://static.getiot.tech/atmel-start-wio-terminal-config-led.jpeg#center)



### 生成工程

配置完成后，将项目名称修改为“Wio-Terminal”。下图是我制作好的 BSP 对应的配置树，这里还配置了一个 USB CDC 设备，用于实现 USB 虚拟串口。不过本次实验暂时没有用到，所以这里就不展开了。

![](https://static.getiot.tech/atmel-start-wio-terminal-config.jpeg#center)

点击右上方的“EXPORT PROJECT”导出工程，勾选需要导出的 IDE 工程，然后点击“DOWNLOAD PACK”即可打包生成一个 Wio-Terminal.atzip 文件。

![](https://static.getiot.tech/atmel-start-wio-terminal-export.jpeg#center)

实际上，你现在就可以用 Microchip Studio 打开 Wio-Terminal.atzip 文件，编译并通过 Atmel-ICE 将固件下载到 Wio Terminal 中。不过，我们的目标是要在 Wio-Terminal 上面跑 RT-Thread 操作系统，所以还需要继续下去！



## RT-Thread BSP 移植

好，下面开始移植 RT-Thread。受篇幅限制，这里只着重介绍一些关键点，具体可参照代码学习和分析。

### 搭建 BSP 工程

通常来说，将一个操作系统移植到一个新平台上，最简单快捷的方法就是找一个和目标平台最接近的 BSP 作为参考。好在 RT-Thread 的 bsp/microchip 目录里面有一些现场的 BSP。由于没有 SAMD51 系列的，因此我们选择了 SAME54 作为参考。

将 same54 文件夹拷贝一份，命名为 samd51-seeed-wio-terminal，并切换到该文件夹下，接下来我们将在这里进行修改。

首先，解压缩前面生成的 Wio-Terminal.atzip 文件（可以将其后缀修改 zip 再解压）。删除 samd51-seeed-wio-terminal/bsp 目录下除 SConscript 文件外的所有文件，并将解压出来的文件全部拷贝到该目录下，如下图所示。

![](https://static.getiot.tech/rt-thread-wio-terminal-bsp-01.jpeg#center)



### 修改 SConscript

接下来，修改 samd51-seeed-wio-terminal/bsp 目录下的 SConscript 文件。我们知道，RT-Thread 使用 scons 作为构建工具，SConscript 文件是 scons 构建系统的一部分，其作用是描述项目中每个目录的构建规则以及它们之间的依赖关系。

简单来说，就是要在这个 SConscript 文件里指定需要添加 Atmel START 生成的 Wio-Terminal 工程中的哪些 .c 和 .h 文件。例如：

```python showLineNumbers
src  = Glob('hal/src/*.c')
src += Glob('hal/utils/src/*.c')
src += Glob('hpl/core/*.c')
src += Glob('hpl/gclk/*.c')
src += Glob('hpl/mclk/*.c')
src += Glob('hpl/osc32kctrl/*.c')
src += Glob('hpl/oscctrl/*.c')
src += Glob('hpl/pm/*.c')
src += Glob('hpl/port/*.c')
src += Glob('hpl/ramecc/*.c')
src += Glob('hpl/sercom/*.c')
src += [cwd + '/atmel_start.c']
src += [cwd + '/driver_init.c']
```



### 修改 rtconfig.py

接着，修改 samd51-seeed-wio-terminal 工程根目录下的 rtconfig.py 文件，它的作用是让该 BSP 更好地支持多种编译器，以及方便地调整编译参数。

这里需要修改 `DEVICE_SERIES` 和 `DEVICE_TYPE` 等参数，如下所示。

```bash showLineNumbers
DEVICE_SERIES = 'SAMD51'
DEVICE_TYPE = '__SAMD51P19A__'
DEVICE_PART = 'samd51'
```

并将链接脚本修改为 bsp/samd51a/gcc/gcc/samd51p19a_flash.ld。

```python showLineNumbers
if PLATFORM == 'gcc':
    # toolchains
    ...
    LFLAGS = DEVICE + \
             ' -Wl,--gc-sections,-Map=rt-thread-' + \
             DEVICE_PART + \
             '.map,-cref,-u,Reset_Handler -T bsp/samd51a/gcc/gcc/samd51p19a_flash.ld'
```



### 修改 samd51p19a_flash.ld

链接文件（*.ld）是单片机编译和链接过程中的一个重要文件。它是链接器（linker）的输入文件，用于控制目标文件如何被组合和布局，以生成最终的可执行文件。

在这里，我们需要修改 samd51p19a_flash.ld 链接脚本，在 text 代码段中增加 RT-Thread 必要的信息。例如 Finsh 需要的 `__fsymtab_start` 和 `__fsymtab_end` 等信息，如下所示。

```assembly showLineNumbers
/* Section Definitions */
SECTIONS
{
    .text :
    {
        . = ALIGN(4);
        _sfixed = .;
        KEEP(*(.vectors .vectors.*))
        *(.text .text.* .gnu.linkonce.t.*)
        *(.glue_7t) *(.glue_7)
        *(.rodata .rodata* .gnu.linkonce.r.*)
        *(.ARM.extab* .gnu.linkonce.armextab.*)

        /* section information for finsh shell */
        . = ALIGN(4);
        __fsymtab_start = .;
        KEEP(*(FSymTab))
        __fsymtab_end = .;
        . = ALIGN(4);
        __vsymtab_start = .;
        KEEP(*(VSymTab))
        __vsymtab_end = .;
        . = ALIGN(4);

        /* section information for initial. */
        . = ALIGN(4);
        __rt_init_start = .;
        KEEP(*(SORT(.rti_fn*)))
        __rt_init_end = .;
        . = ALIGN(4);

        /* section information for utest */
        . = ALIGN(4);
        __rt_utest_tc_tab_start = .;
        KEEP(*(UtestTcTab))
        __rt_utest_tc_tab_end = .;
        
        /* 省略 */
        
        . = ALIGN(4);
        _efixed = .;            /* End of text section */
    } > rom
    
    /* 省略 */
    
    . = ALIGN(4);
    _end = . ;
    __bss_end = _end;
    _ram_end_ = ORIGIN(ram) + LENGTH(ram) - 1 ;
}
```



### 修改 startup_samd51.c

startup_samd51.c 文件同样位于 bsp/samd51a/gcc/gcc 目录下，它是整个工程的入口，定义了 `Reset_Handler` 复位函数。在该函数最后，调用了 `main()` 函数，我们需要将其修改为 RT-Thread 系统的启动函数 `rtthread_startup()`。

```c showLineNumbers
void Reset_Handler(void)
{
    ...

	/* Initialize the C library */
	__libc_init_array();

	/* Branch to rtthread_startup function */
	rtthread_startup();

	/* Infinite loop */
	while (1)
		;
}
```

RT-Thread 的启动函数定义位于 rt-thread/src/components.c，包括硬件初始化、系统对象初始化、调度器初始化等一系列启动流程。最后会将启动主线程，执行 `main()` 函数。

```c showLineNumbers
int rtthread_startup(void)
{
    rt_hw_interrupt_disable();
    rt_hw_board_init();             /* board level initialization */
    rt_show_version();              /* show RT-Thread version */
    rt_system_timer_init();         /* timer system initialization */
    rt_system_scheduler_init();     /* scheduler system initialization */
    rt_application_init();          /* create init_thread */
    rt_system_timer_thread_init();  /* timer thread initialization */
    rt_thread_idle_init();          /* idle thread initialization */
    rt_system_scheduler_start();    /* start scheduler */
    
    return 0;                       /* never reach here */
}
```



### 修改 board.c

`rtthread_startup()` 函数在关中断之后，做的第一件事就是调用 `rt_hw_board_init()` 函数初始化板级硬件。`rt_hw_board_init()` 函数定义位于各个 BSP 提供的 board.c 文件，也就是说，你需要自己实现它。

大致流程如下，主要是初始化当前需要用到的驱动和中间件、初始化定时器、初始化内存堆、注册 RT-Thread 设备等非常底层的工作。

```c showLineNumbers
void rt_hw_board_init(void)
{
    /* Initializes MCU, drivers and middleware */
    atmel_start_init();

    /* enable USART stdout module */
    hw_board_init_usart();

    /* UART driver initialization is open by default */
    rt_hw_uart_init();

    /* init systick */
    SysTick_Config(CONF_CPU_FREQUENCY / RT_TICK_PER_SECOND);

    /* set pend exception priority */
    NVIC_SetPriority(PendSV_IRQn, (1 << __NVIC_PRIO_BITS) - 1);

    /* init memory system */
    rt_system_heap_init((void*)&__bss_end, (void*)HEAP_END);

    /* Set the shell console output device */
    rt_console_set_device(RT_CONSOLE_DEVICE_NAME);

    /* init system components */
    rt_components_board_init();
}
```



### 修改 serial.c

在这个 BSP 中，部分通用的接口是放在 microchip/common 目录下的，例如前面 `rt_hw_board_init()` 调用的 `rt_hw_uart_init()` 串口初始化函数。它的作用是对接 ASF4 串口驱动和 RT-Thread 的串口设备框架，具体则通过 ops 结构体绑定操作接口。

```c showLineNumbers
int rt_hw_uart_init(void)
{
    struct serial_configure config = RT_SERIAL_CONFIG_DEFAULT;
    config.baud_rate = DEFAULT_USART_BAUD_RATE;

    sam_serial.ops       = &sam_serial_ops;
    sam_serial.config    = config;
    rt_hw_serial_register(&sam_serial, "uart0" /* RT_CONSOLE_DEVICE_NAME */,
                          RT_DEVICE_FLAG_RDWR | RT_DEVICE_FLAG_INT_RX |
                          RT_DEVICE_FLAG_INT_TX, (void *)&TARGET_IO);

    usart_async_register_callback(&TARGET_IO, USART_ASYNC_TXC_CB, serial_txcallback);
    usart_async_register_callback(&TARGET_IO, USART_ASYNC_RXC_CB, serial_rxcallback);

    return 0;
}
```

注意，这里使用的是 RT-Thread 串口设备框架 V2 版本，如果你是重新配置的 BSP，需要使用 `menuconfig` 配置 Serial V2 选项。



### 修改 main.c

现在，打开 applications/main.c 文件，开始编写你的应用程序吧。例如，让 LED 等闪烁起来。

```c showLineNumbers
#include <rtthread.h>

static rt_uint8_t led_stack[512];
static struct rt_thread led_thread;

static void led_thread_entry(void* parameter)
{
    while (1)
    {
        /* toggle led */
        gpio_toggle_pin_level(LED0);
        rt_thread_delay(RT_TICK_PER_SECOND/2);
    }
}

int main(void)
{
    rt_err_t result;
    result = rt_thread_init(&led_thread, "led", led_thread_entry, RT_NULL,
                            (rt_uint8_t*)&led_stack[0], sizeof(led_stack),
                            RT_THREAD_PRIORITY_MAX/3, 5);
    rt_thread_startup(&led_thread);

    return 0;
}
```



## 小结

将 RT-Thread 移植到 Wio Terminal 开发板上的一点点细节就介绍到这里，更多细节请直接翻阅代码。你也可以根据上一篇文章介绍的方法尝试将其编译并烧录到 Wio Terminal 上，在此基础上，你还可以探索更多有意思的东西！


