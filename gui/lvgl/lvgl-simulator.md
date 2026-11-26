---
sidebar_position: 3
---

# LVGL 模拟器环境



为了方便大家学习 LVGL 图形库开发，我们可以在 PC 上使用模拟器进行学习，而无需从嵌入式开发板移植开始。目前有蛮多好用的 LVGL 模拟器，比如 Visual Studio、Clion、QEMU、Code::Blocks 等等。当然这些工具不是专门为 LVGL 而做的，它们的功能都很强大，作为 LVGL 的模拟器不在话下。



## Code::Blocks

本教程选择使用 Code::Blocks，因为它体积小、安装方便，而且是免费、开源、跨平台的集成开发环境。

Code::Blocks 使用 C++ 开发，并且使用 wxWidgets 做为 GUI 库，同时使用了插件架构，可以使用插件自由地扩展。我们知道 LVGL 是用 C 语言开发的，因此 Code::Blocks 可以很好地对它进行仿真。

![](https://static.getiot.tech/CodeBlocks.png#center)

你可以在它的官网 [codeblocks.org](https://www.codeblocks.org/) 下载 Code::Blocks 安装包，它提供 Windows、Linux 和 macOS 的多个版本。

如果是 Windows 用户，可以下载当前最新的 codeblocks-20.03mingw-setup.exe，然后双击安装即可。（本教程主要使用 Windows 系统进行仿真）

如果是 Ubuntu 用户，可以使用下面命令快速安装。

```bash
sudo apt install codeblocks
sudo apt install codeblocks-contrib  # 安装插件（可选）
```

第一次启动 Code::Blocks 时，它会寻找系统中所有可用的编译器，并将其添加到路径中，你也可以后续配置其他编译器。

在命令行输入 `codeblocks` 或者在系统菜单中搜索“Codeblocks”即可打开 Code::Blocks。新建一个 hello.c 文件，点击工具栏中的 *Build -> Run* 即可构建、运行该程序。之后会弹出一个小窗口，打印一句“It's GetIoT.tech”。

![Code::Blocks on Ubuntu](https://static.getiot.tech/CodeBlocks_Main_UI.png#center)



## 项目配置

安装好 Code::Blocks 之后，我们需要下载 LVGL 的项目工程（GitHub：[lvgl-courses](https://github.com/getiot/lvgl-courses)）。

使用 git 命令下载

```bash
https://github.com/getiot/lvgl-courses.git
```

lvgl-courses 项目依赖 lvgl 的一些子模块，因此还需要拉取子模块。命令如下：

```bash
git submodule update --init --recursive
```

这一步需要一些时间，你可以先去喝杯茶~

然后打开 Code::Blocks，点击菜单栏中的 *File -> Open...*，找到 lvgl-courses 目录，选择 LittlevGL.cbp 工程文件。打开后界面如下。

![Code::Blocks 打开 LVGL 工程](https://static.getiot.tech/CodeBlocks-Open-LittlevGL.png#center)

工程 main.c 中默认启动一个 lv_demo_widgets 示例程序，代码如下。

```c
int APIENTRY WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR szCmdLine, int nCmdShow)
{
    /*Initialize LittlevGL*/
    lv_init();

    /*Initialize the HAL for LittlevGL*/
    lv_win32_init(hInstance, SW_SHOWNORMAL, 800, 480, NULL);

    /*Output prompt information to the console, you can also use printf() to print directly*/
    LV_LOG_USER("LVGL initialization completed!");

    /*Run the demo*/
    lv_demo_widgets();

    while(!lv_win32_quit_signal) {
        /* Periodically call the lv_task handler.
         * It could be done in a timer interrupt or an OS task too.*/
        lv_task_handler();
        usleep(10000);       /*Just to let the system breath*/
    }
    return 0;
}
```

点击工具栏中的 *Build and run* 按钮，构建并运行该程序。这时候，你可以再喝一杯茶~

编译完成后会自动启动 lv_demo_widgets 程序，运行效果如下。

![Code::Blocks 模拟器运行 LVGL 示例](https://static.getiot.tech/lv_demo_widgets.png#center)

好啦，基于 Code::Blocks 模拟器的 LVGL 仿真环境已经搭建完成！接下来，我们会在这个环境中学习 LVGL 的各个部件和功能。

