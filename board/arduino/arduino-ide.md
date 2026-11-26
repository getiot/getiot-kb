---
sidebar_position: 3
authors: [luhuadong]
---

# Arduino 开发环境



在开始使用 Arduino 之前，我们需要先在电脑上安装 Arduino 的集成开发环境。使用最广泛的是 Arduino 官方提供的 Arduino IDE。另外，也可以使用 VScode、Eclipse、PlatformIO 等更为专业的开发环境进行开发。当然，如果使用第三方的开发工具，通常需要额外安装 Arduino 插件并进行相关配置。



## Arduino IDE

Arduino 集成开发环境（Arduino IDE）是一个开源软件，它本身也是基于 Java、Processing、AVR-GCC 等开源软件写成的，您可以在 [GitHub](https://github.com/arduino/Arduino/) 找到它。

### 下载 Arduino IDE

Arduino 开源的 IDE 可以[免费下载](https://www.arduino.cc/en/software)得到。支持 Windows、Linux 和 MacOS 平台。

![](https://static.getiot.tech/download-arduino-ide-1.8.13.png#center)

Windows 和 MacOS 版本直接点击安装即可。Linux 版本可以通过如下命令进行安装（以 1.8.3 版本为例）。

```bash
tar xvf arduino-1.8.13-linux64.tar.xz
cd arduino-1.8.13/
sudo ./install.sh
```

或者使用包管理器进行安装，比如 apt 安装：

```bash
sudo apt install arduino
```



### 认识 Arduino IDE

Arduino IDE 包含了一个用于写代码的文本编辑器、一个消息区、一个文本控制台以及一个带有常用功能按钮和文本菜单的工具栏。Arduino IDE 软件外观和功能布局如下图所示。

![](https://static.getiot.tech/arduino-ide-layout.png#center)

使用 Arduino IDE 编写的代码被称为项目（sketches），这些项目写在文本编辑器中，以 .ino 的文件形式保存，软件中的文本编辑器有剪切/粘贴和搜索/替换功能。当保存、输出以及出现错误时消息区会显示反馈信息。控制台会文字形式显示 Arduino IDE 的输出信息，包括完整的错误信息以及其他消息。整个窗口的右下角会显示当前选定的控制板和串口信息。工具栏按钮从左到右分别是验证（编译）、下载程序、新建、打开、保存以及串口监视器的功能。

![](https://static.getiot.tech/arduino-ide-menu-bar.png#center)

- **验证**：检查代码编译时的错误。
- **上传**：编译你的代码并且上传到选定的控制板中。
- **新建**：创建一个新的项目。
- **打开**：弹出一个包含你在项目文件夹中所有项目的菜单，选择其中一个会打开相应的代码，新的项目会覆盖当前的项目。
- **保存**：保存项目或将项目另存为。
- **串口监视器**：打开串口监视器（软件连接 Arduino 之后，能与控制板相互通信）。

Arduino IDE 麻雀虽小，五脏俱全，提供了开发 Arduino 所需的必要功能。软件中的文本编辑器有剪切/粘贴和搜索/替换功能，当保存、输出以及出现错误时消息区会显示反馈信息，控制台会文字形式显示 Arduino 软件（IDE）的输出信息，包括完整的错误信息以及其他消息。

但同时也可以看到，相对于 IAR、Keil 等专业的硬件开发环境，Arduino 的开发环境显得尤为清新、简洁。而正是这种简单，省去了很多不常用的功能，同时代码编辑器的功能也比较有限，对于开发大型项目来说不太方便。



## Arduino 库管理器

Arduino 的生态系统非常大，有来自全球各地开发者贡献的各种功能的库，我们可以通过 Arduino IDE 的库管理器（Library Manager）添加所需的库。添加步骤如下：

- **步骤 1**：打开 Arduino IDE，依次点击 *Sketch -> Include Library -> Manage Libraries...*，打开库管理器。
- **步骤 2**：在搜索框中输入所需库的名字，选择版本（默认为 latest 版本）。
- **步骤 3**：点击 *Install* 安装。



## Arduino Web Editor

网址：[https://create.arduino.cc/editor](https://create.arduino.cc/editor)



## VSCode + Arduino 插件

安装 Arduino 插件

出现 “vscode Arduino cannot find the sketch file”，使用 “打开文件夹” 的方式导入工程。

VSCode 输出窗口出现中文乱码，可以通过修改系统 “区域设置” 来解决。





## PlatformIO

https://dronebotworkshop.com/platformio/





