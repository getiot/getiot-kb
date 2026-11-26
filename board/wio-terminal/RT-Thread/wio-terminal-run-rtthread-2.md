---
sidebar_position: 2
slug: /wio-terminal-run-rtthread-2
draft: true
---

# Wio Terminal 运行 RT-Thread 系统（二）



上一篇文章我们介绍了如何在 Wio Terminal 上快速运行 RT-Thread，使用的是已经制作好的 BSP 工程。那么，这篇文章我会进一步介绍制作该 BSP 的过程，了解这些方法和细节后，你将有能力制作自己的 BSP。



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

