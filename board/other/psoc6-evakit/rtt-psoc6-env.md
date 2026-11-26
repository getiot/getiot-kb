---
sidebar_position: 3
sidebar_label: PSoC6 RTT 开发环境
slug: /rtt-psoc6-env
---

# 英飞凌 PSoC6 评估板 RT-Thread 开发环境搭建



本文介绍如何搭建基于 RT-Thread Studio IDE 工具的 PSoC6 RTT 评估板的开发环境，通过搭建一个简单的工程，将代码编译、下载到 PSoC6 RTT 开发板。



## 安装软件包

首先需要安装 RT-Thread Studio，如果你还没安装，可以点击[这里](https://www.rt-thread.org/studio.html)下载安装。RT-Thread Studio 是官方推出的一站式 RT-Thread 开发工具，通过简单易用的图形化配置系统以及丰富的软件包和组件资源，让物联网开发变得简单和高效。

打开 RT-Thread Studio，点击工具栏上的 SDK Manager 按钮，打开 RT-Thread SDK 管理器。

![](https://static.getiot.tech/PSoC6-RTT-env-SDK-Manager.jpg)

你需要安装以下 3 个软件包：

|            大类            |   子类   |                软件包                 | 版本  |
| :------------------------: | :------: | :-----------------------------------: | ----- |
|   Board_Support_Packages   | Infineon |          PSOC62-IFX-EVAL-KIT          | 1.1.2 |
| ToolChain_Support_Packages |    -     | GNU_Tools_for_ARM_Embedded_Processors | 5.4.1 |
| Debugger_Support_Packages  |    -     |           OpenOCD-Infineon            | 1.0.0 |

这 3 个软件包分别是 PSoC6 评估板的 SDK（包含 BSP）、编译工具链、调试器。

**① 勾选 PSOC62-IFX-EVAL-KIT 软件包 1.1.2 或最新版本：**

![](https://static.getiot.tech/PSoC6-RTT-env-install-package-1.jpg)

**② 勾选 GNU_Tools_for_ARM_Embedded_Processors 5.4.1 版本：**

![](https://static.getiot.tech/PSoC6-RTT-env-install-package-2.jpg)

**③ 勾选 OpenOCD-Infineon 1.0.0 版本：**

![](https://static.getiot.tech/PSoC6-RTT-env-install-package-3.jpg)

勾选之后，点击对话框右下角的“安装...”按钮，安装相应的软件依赖。



## 创建项目

安装好软件包之后，就可以创建一个针对 PSoC6 RTT 评估板的工程，验证是否这些软件依赖是否安装成功。

首先，依次点击 RT-Thread Studio 菜单栏的“文件 -> 新建 -> RT-Thread 项目”，打开“新建项目”对话框。创建方式选择“基于开发板”，并选择 PSOC62-IFX-EVAL-KIT 开发板，具体配置如下图所示，最后为该项目取一个名称（例如 PSoC62-IFX），点击“完成”。

![](https://static.getiot.tech/PSoC6-RTT-env-new-project-1.jpg)

稍等片刻，就会创建好一个名为 PSoC62-IFX 的项目。在左侧资源管理器依次打开“PSoC62-IFX -> applications -> main.c”，这个文件是整个工程的入口文件，`main()` 主函数就位于此。该程序默认功能是使 LED 按 1Hz 频率闪烁，你可以修改该程序，例如将 `rt_thread_mdelay(500)` 中的 500 修改为 200，这样会改变 LED 灯的闪烁频率。

![](https://static.getiot.tech/PSoC6-RTT-env-new-project-2.jpg)

点击工具栏中的“小锤子”按钮开始编译整个工程，点击“小虫子”按钮可以调试工程，点击“下载程序”按钮可以将编译好的固件烧录到开发板上。

![](https://static.getiot.tech/PSoC6-RTT-env-studio-compile-debug-download.jpg)

如果一切顺利，你将看到类似如下信息：

```
Info : Flash write discontinued at 0x10001848, next section at 0x10002000
Info : Padding image section 0 at 0x10001848 with 440 bytes (bank write end alignment)
[100%] [################################] [ Erasing     ]
[100%] [################################] [ Programming ]
Info : Padding image section 1 at 0x10019018 with 488 bytes (bank write end alignment)
[ 10%] [###                             ] [ Erasing     ]
[ 47%] [###############                 ] [ Erasing     ]
[ 50%] [################                ] [ Erasing     ]
[100%] [################################] [ Erasing     ]
[ 33%] [##########                      ] [ Programming ]
[ 63%] [####################            ] [ Programming ]
[100%] [################################] [ Programming ]
wrote 101376 bytes from file D:/RT-ThreadStudio/workspace/PSoC62-IFX/Debug/rtthread.hex in 3.116703s (31.764 KiB/s)
** Programming Finished **
```

按一下 PSoC6 RTT 开发板上的 RESET 按钮，你就可以看到原来以 1Hz 频率闪烁的 LED 灯的闪烁频率加快了！

![](https://static.getiot.tech/PSoC6-RTT-board-entiry-5.jpg)



## FAQs

如果下载程序时出现如下错误：

```
D:\RT-ThreadStudio>cd /d D:\RT-ThreadStudio\repo\Extract\Debugger_Support_Packages\Infineon\OpenOCD-Infineon\1.0.0\bin 
D:\RT-ThreadStudio\repo\Extract\Debugger_Support_Packages\Infineon\OpenOCD-Infineon\1.0.0\bin>openocd.exe -s ../scripts -f interface/kitprog3.cfg -f target/psoc6_2m.cfg  -c " program D:/RT-ThreadStudio/workspace/PSoC62-IFX/Debug/rtthread.hex exit" 
Open On-Chip Debugger 0.11.0+dev-4.3.0.1746 (2021-09-16-07:59)
Licensed under GNU GPL v2
For bug reports, read
	http://openocd.org/doc/doxygen/bugs.html
Info : auto-selecting first available session transport "swd". To override use 'transport select <transport>'.
adapter speed: 2000 kHz
adapter srst delay: 25
adapter srst pulse_width: 25
** Auto-acquire enabled, use "set ENABLE_ACQUIRE 0" to disable
cortex_m reset_config sysresetreq
cortex_m reset_config sysresetreq
Error: unable to find a matching CMSIS-DAP device
Error: No Valid JTAG Interface Configured.
```

或者调试程序时出现如下错误：

```
Open On-Chip Debugger 0.11.0+dev-4.3.0.1746 (2021-09-16-07:59)
Licensed under GNU GPL v2
For bug reports, read
	http://openocd.org/doc/doxygen/bugs.html
Info : auto-selecting first available session transport "swd". To override use 'transport select <transport>'.
adapter speed: 2000 kHz
adapter srst delay: 25
adapter srst pulse_width: 25
** Auto-acquire enabled, use "set ENABLE_ACQUIRE 0" to disable
cortex_m reset_config sysresetreq
cortex_m reset_config sysresetreq
Warn : SFlash programming allowed for regions: USER, TOC, KEY
Error: unable to find a matching CMSIS-DAP device
```

说明 IDE 没有识别到 PSoC6 RTT 开发板的调试口。

解决办法是：首先你需要检查 USB 接口是否连接正确，应该连接到 PSoC6 RTT 开发板上的 DAP 接口，而不是 MCU 接口。如果 USB 连接正确，那么可能是调试芯片固件版本太旧导致的，需要通过 ModusToolBox 软件更新固件，具体可参考[这里](https://community.infineon.com/t5/ModusToolbox/unable-to-find-a-matching-CMSIS-DAP-device-No-Valid-JTAG-Interface-Configured/td-p/368134#.)。

