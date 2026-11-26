---
sidebar_position: 3
slug: /flutter-setup-linux
---

# Flutter Linux 环境搭建

在正式开始学习 Flutter 之前，需要先搭建好开发环境。由于 Flutter 会同时构建 Android 和 iOS 两个平台的发布包，因此需要同时安装 Android SDK 和 iOS SDK。



## 在 Linux 上搭建 Flutter 开发环境

### 系统配置要求

要想安装和运行 Flutter，你的开发环境至少应该满足如下的需求：

- **操作系统**: Linux (64 位)
- **磁盘空间**: 1.6 GB (不包含安装 IDE 和其他工具的空间)
- **命令工具**: Flutter 需要以下命令行工具：
  - `bash`
  - `curl`
  - `file`
  - `git` 2.x
  - `mkdir`
  - `rm`
  - `unzip`
  - `which`
  - `xz-utils`
  - `zip`
- **公用库**: Flutter 的 `test` 命令需要 `libGLU.so.1` 库。 `mesa` 套件已经包含了这个库：在 Ubuntu/Debian 上是 `libglu1-mesa`，在 Fedora 上是 `mesa-libGLU`。

### 方式 1：使用 snapd 安装 Flutter

```bash
sudo snap install flutter --classic
```

### 方式 2：手动安装 Flutter

如果你没有 `snapd`，那么你可以通过以下步骤安装 Flutter。

1. 通过 [GitHub Release](https://github.com/flutter/flutter/releases) 下载下面的安装包以获得最新 stable release 版本的 Flutter SDK，例如 flutter_linux_3.16.0-stable.tar.xz。

2. 切换到你的工作目录，解压缩 Flutter SDK。

   ```bash
   cd ~/workspace
   tar xf ~/Downloads/flutter_linux_3.16.0-stable.tar.xz
   ```

3. 将 `flutter` 工具添加到环境变量中。

   ```bash
   export PATH="$PATH:`pwd`/flutter/bin"
   ```

   注意：上述命令添加 `PATH` 仅在当前的命令行终端生效，要将 Flutter 永久添加到环境变量中，可以将该命名添加到 ~/.bashrc 文件。

4. 预下载开发二进制文件（可选）。

   ```bash
   flutter precache
   ```

### 检查安装结果

安装 Flutter 后，运行如下命令：

```bash
flutter doctor
```

该命令将检查你的环境情况并显示汇报在命令行窗口中。
