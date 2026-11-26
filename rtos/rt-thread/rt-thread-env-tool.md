---
sidebar_position: 4
authors: [luhuadong]
---

# RT-Thread Env 工具



Env 是 RT-Thread 推出的开发辅助工具，包括配置器和包管理器。开发者可以使用 Env 工具对 RT-Thread 内核和组件的功能进行配置，对组件进行自由裁剪，对线上软件包进行管理，使得系统以搭积木的方式进行构建，简单方便。

针对基于 RT-Thread 操作系统的项目工程，Env 工具提供三大功能：

1. 编译构建环境
2. 图形化系统配置
3. 软件包管理



## 安装

Env 工具支持 Windows、Linux 和 macOS 操作系统。由于 Env 工具依赖 Git 版本管理工具，因此你需要先安装并配好 Git 工具。

对于 Windows 用户，可以在官网 [下载页面](https://www.rt-thread.org/page/download.html) 下载 Env 工具安装包，解压到安装目录即可。Env 工具提供基于控制台的字符界面，你可以双击 env.exe 启动它（如果失败则双击 env.bat 脚本）。

![RT-Thread Env 工具](https://static.getiot.tech/rt-thread-env-windows.png#center)

另外，你还可以将 Env 添加到右键菜单栏，这样就可以很方便地在任意工程目录启动 Env 工具。具体的设置方法是：右击 Env 工具的标题栏，点击“Setting...”，选择“Integration”，点击“Register”，最后点击“Save Settings”保存设置。

对于 Linux 和 macOS 用户，在安装好 Git 和 Scons 等工具后，打开任意 RT-Thread 工程目录，第一次执行 menuconfig 操作时会自动安装 Env 工具。（参考 [RT-Thread 搭建 Linux 开发环境](/rtt/rt-thread-env-for-linux/)）

```bash
scons --menuconfig
```

当然，你也可以直接拉取 Env 的 GitHub 仓库（[RT-Thread/env](https://github.com/RT-Thread/env)），不过不建议这么操作。

为了方便在 Shell 终端使用 Env 工具，我们可以将下面一行代码添加到 ~/.bashrc 文件末尾，这样每次打开终端时都会使 Env 工具生效。

```bash
source ~/.env/env.sh
```



## 使用

Env 工具的主要功能包括编译构建环境、图形化系统配置、软件包管理，在 Windows 与在 Linux、macOS 中的操作有一些不一样，下面我们分别介绍一下。



### 编译项目 scons

RT-Thread 支持多种集成开发环境（IDE），可以使用 Env 快速生成特定 IDE 的工程，大大加快了项目的搭建过程。

1. 进入 BSP 目录

2. scons 生成 IAR/MDK 工程

   ```bash
   scons --target=mdk5
   scons --target=mdk4
   scons --target=iar
   ```

3. scons 编译，默认使用 Env 内部集成的 GCC 编译器

   ```bash
   scons
   ```



### 配置项目 menuconfig

每个 RT-Thread 的 BSP 工程都有其默认的配置，比如系统内核支持的最大线程优先级、系统时钟频率、使用的设备驱动、控制台使用的串口等。RT-Thread 操作系统具有高度的可裁剪性，开发者可以根据自己的需求使用 Env 工具进行配置和裁剪。

在 BSP 目录下打开 Env，然后在使用 `menuconfig` 命令打开配置界面。（Linux 和 macOS 用户使用 `scons --menuconfig` 命令）

![RT-Thread Env 工具 menuconfig 配置](https://static.getiot.tech/rt-thread-scons-menuconfig.png#center)

menuconfig 配置菜单的操作与 Linux 内核的操作相似，会自动处理配置项的依赖关系。配置完成后保存退出，会自动生成 rtconfig.h 头文件。

项目配置完成后，执行下面命令自动生成、更新 IAR/MDK 工程。

```bash
menuconfig -s
```



### 软件包管理 pkgs

Env 工具的另一大功能是管理 RT-Thread 的数百个[软件包](https://github.com/RT-Thread-packages)，支持软件包下载、更新、删除等功能。这些功能都是通过 **`pkgs`** 命令行工具提供的，该命令的说明如下。

```bash
> pkgs
usage: env.py package [-h] [--update] [--list] [--wizard] [--upgrade]
                      [--printenv]

optional arguments:
  -h, --help  show this help message and exit
  --update    update packages, install or remove the packages as you set in
              menuconfig
  --list      list target packages
  --wizard    create a package with wizard
  --upgrade   update local packages list from git repo
  --printenv  print environmental variables to check
```

在 RT-Thread 工程中，具体操作如下：

- **下载**：使用 menuconfig 配置软件包，如果选中的软件包未下载，那么执行 `pkgs --update` 命令将自动下载软件包到本地工程。
- **更新**：如果选中的软件包使用 **latest** 版本，并且该软件包有更新，那么执行 `pkgs --update` 命令将自动更新本地工程中的软件包。
- **删除**：如果不再需要某个软件包（使用 menuconfig 配置去除选中），那么执行 `pkgs --update` 命令将自动删除本地工程中的软件包。

另外，特别说明一下 update 和 upgrade 命令的区别。

- `pkgs --update` 下载或更新配置选中的软件包，默认升级到最新版本。如果项目配置中指定软件包的版本，执行该命令并不会更新软件包。
- `pkgs --upgrade` 升级命令：更新本地软件包信息（索引），同时也会更新 Env 工具内部的一些脚本命令。升级的主要原因是我们的软件包信息是存储在云端平台上的，当云端平台增加了新的软件包，或者对软件包进行了更新，执行该命令就可以使本地的软件包信息与云端进行同步，保证 `menuconfig` 看到的软件包信息始终是最新的。



### 搭建项目框架

在 BSP 目录下打开 Env 工具，执行下面命令，将会在该 BSP 目录下生成 dist 目录。

```bash
scons --dist
```

这是以该 BSP 为模板的独立工程，包含完整的目录结构，RT-Thread 源码也位于项目文件夹内，因此可以随意拷贝 dist 文件夹的工程到任何目录下使用。



## 环境变量

使用 Env 工具构建工程时，会设置一些环境变量，例如 `RTT_ROOT` 和 `BSP_ROOT`。

- `RTT_ROOT` —— 指向到 RT-Thread 代码的根目录
- `BSP_ROOT` —— 指向到 BSP 的工程目录

RT-Thread 的构建脚本会依赖这些环境变量。



