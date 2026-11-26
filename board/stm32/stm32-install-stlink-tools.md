---
sidebar_position: 4
---

# Linux 安装 stlink 工具



本文以 Ubuntu 20.04 LTS 为例，介绍在 Linux 系统中如何安装 STM32 的 **stlink** 调试烧录工具。安装方法有两种，分别是通过包管理器（如 APT）安装，以及手动编译安装。

**提示**：包管理器安装的版本通常比较旧，如果需要使用最新版本，建议自行编译安装。



## 包管理器安装

通过包管理器安装 stlink 工具，命令如下：

```bash
sudo apt install stlink-tools
sudo apt install stlink-gui
```

安装成功后，系统增加了如下几个工具：

| 工具         | 功能                                |
| ------------ | ----------------------------------- |
| `st-flash`   | 将二进制文件固化到 STM32 设备       |
| `st-info`    | 查询已连接 STLink 的 STM32 设备信息 |
| `st-util`    | 运行 GDB 服务与 STM32 设备进行交互  |
| `stlink-gui` | STlink 图形化工具                   |



## 手动编译安装

### 安装依赖

编译之前需要安装 stlink 的一些依赖库和工具：

- `git`
- `gcc` 或 `clang` 或 `mingw32-gcc` 或 `mingw64-gcc`（在 Ubuntu 系统中，GCC 通常已经存在）
- `build-essential`（基于 Debian 的发行版需要）
- `cmake`（3.4.2 及以上版本）
- `rpm`（在基于 Debian 的发行版上，如果需要使用 `make package` 构建软件包）
- `libusb-1.0`
- `libusb-1.0-0-dev`（用于构建的开发头文件）
- `libgtk-3-dev`（可选的，`stlink-gui` 需要）
- `pandoc`（可选的，从 markdown 生成 manpages 需要）

安装命令：

```bash
sudo apt install gcc build-essential cmake libusb-1.0-0 \
                 libusb-1.0-0-dev libgtk-3-dev pandoc
```

### 下载源码

打开 Shell 终端，切换到你的工作目录，执行下面命令下载 stlink 源代码：

```bash
git clone https://github.com/stlink-org/stlink.git
```

### 编译安装

切换到 stlink 目录

```bash
cd stlink
```

先执行下面命令清理编译环境（可选）：

```bash
make clean
```

编译 Debug 版本：

```bash
make debug
```

编译 Release 版本（推荐）：

```bash
make release
```

安装到系统：

```bash
sudo make install
```

另外，还可以构建一个 Debian 软件包（生成的包在 `./build/dist` 目录）：

```bash
make package
```

