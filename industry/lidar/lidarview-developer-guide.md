---
sidebar_position: 26
sidebar_label: LidarView 开发手册
authors: [luhuadong]
---

# LidarView 开发手册

> 声明：本文翻译自 [LidarView Developer Guide](https://gitlab.kitware.com/LidarView/lidarview-core/-/blob/master/Documentation/LidarView_Developer_Guide.md)

## 1. LidarView 编译概览

本文档收集了构建基于 LidarView 的应用程序所需的所有信息。部分内容与 [安装指南](https://gitlab.kitware.com/LidarView/lidarview-core/-/blob/master/Documentation/INSTALLATION.md) 中的信息类似。

LidarView 主要依赖于 CMake 和 *superbuild* 系统，它处理大多数（不是全部）必要依赖项的下载和编译。

但是由于各种原因，superbuild 可能会（或可能不会）提供某些依赖项，并且必须在某些平台上从外部获取，请参阅以下部分了解每个平台的说明。

LidarView 目前在 Windows、Ubuntu 18.04、Ubuntu 20.04 和 OSX 上积极维护。



## 2. 配置和构建说明

### 2.1 跨平台说明

**跨平台依赖和工具**

以下工具的特定版本可能在你的操作系统包管理器中可用，也可能不可用。

 - **[必需] CMake 3.20.3+**，下载地址：[https://cmake.org/](https://cmake.org/)

 - **[推荐] Ninja 1.8.2+**，下载地址：[https://ninja-build.org/](https://ninja-build.org/)

    强烈建议在所有平台上使用 Ninja 以加快编译速度，如果你不想使用它，请确保从配置命令中删除 `-GNinja` 选项。

### 2.2 Windows 说明

#### 2.2.1 Windows 特定依赖

 - **Microsoft Visual Studio 14/17/19** 为支持新旧版本做出了巨大努力。

    如果你对向后兼容性或许可有疑虑，可能更倾向于使用 MSVC 14 (2015)，请参阅 [附加说明](#msvc15-installer)

 - **Qt 5.15.2** 你必须自己构建它并在配置时指定 Qt 的目录。

    更多信息，请参阅 [附加说明](#qt-build)。

 - **[仅用于打包]** **NSIS version 3.04 及以上版本**，下载地址：[https://nsis.sourceforge.io/Download](https://nsis.sourceforge.io/Download)

#### 2.2.2 Windows 注意事项

 - **必须使用 MSVC 构建环境命令提示符（随 MSVC 一起安装）**

    打开位置 `Windows Start Menu > Visual Studio 20XX > "VS20XX x64 Native Tools Command Prompt"`

    提示：如果你不熟悉 Windows 开发，建议使用该提示（Prompt）进行构建，因为与常规 cmd.exe 提示相比，它设置了适当的构建环境。

 - **工作目录、源（src）和构建（build）路径必须短且靠近根（root）驱动器**

    这些目录的路径必须很短，因为 Windows 对文件路径和命令的最大长度有限制。

    提示：这些路径在构建过程中会出现无数次，可能会不小心达到最大限制。

  - **源目录不得位于 LidarView 源代码目录中**

    建议使用如下目录结构：

| 位置      | 工作目录   |
| -------- | ---------- |
| C:\src   | 源代码目录 |
| C:\build | 构建目录   |

注意：在配置或编译后移动这些目录，将破坏所有构建环境并需要完全重建。

#### 2.2.3 Windows 构建说明

 - 请注意，配置命令提到了源目录中的子目录“*Superbuild*”目录，而不是源目录本身。

 - 请注意，CMake 变量，如 `Qt5_DIR` 路径参数，必须在所有平台（Unix PATH 格式）上使用正斜杠（`/`），否则 MSVC 将使用 `\\Q` 作为构建选项。

 - 如果你更改了默认的 Qt 安装路径，则必须调整配置命令。

 - 从头开始构建可能需要 20 分钟到 2 小时，具体取决于你的硬件性能。

 - 默认情况下，添加 `-j` 选项将使用机器上所有的核进行编译，你也可以使用 `-j N` 指定要使用的内核数。

    ```bash
    cd <work-directory>
    git clone <git url to LidarView-based app repository> --recurse-submodules src
    mkdir <work-directory>\build
    cd <work-directory>\build
    cmake <work-directory>\src\Superbuild -GNinja -DCMAKE_BUILD_TYPE=Release -DUSE_SYSTEM_qt5=True -DQt5_DIR="C:/Qt/Qt5.15.2/5.15.2/msvc2015_64/lib/cmake/Qt5"
    cmake --build . -j
    install\bin\<LidarView-based app name>
    ```



### 2.3 Linux 构建说明

#### 2.3.1 Linux 特定依赖

**显卡驱动**

确保显卡驱动程序是最新的，确保安装了必要的图形软件包。

提示：如果你没有显卡，则需要安装 `mesa` 驱动程序。

**软件包/库**

 - 在 Ubuntu 18.04 及更高版本上构建，需要安装以下软件包：

    ```bash
    sudo apt-get install build-essential byacc flex freeglut3-dev libbz2-dev libffi-dev \
        libfontconfig1-dev libfreetype6-dev libnl-genl-3-dev libopengl0 libprotobuf-dev \
        libx11-dev libx11-xcb-dev libx11-xcb-dev libxcb-glx0-dev libxcb-glx0-dev \
        libxcb-icccm4-dev libxcb-image0-dev libxcb-keysyms1-dev libxcb-randr0-dev \
        libxcb-render-util0-dev libxcb-shape0-dev libxcb-shm0-dev libxcb-sync-dev \
        libxcb-util-dev libxcb-xfixes0-dev libxcb-xinerama0-dev libxcb-xkb-dev libxcb1-dev \
        libxext-dev libxext-dev libxfixes-dev libxi-dev libxkbcommon-dev libxkbcommon-dev \
        libxkbcommon-x11-dev libxkbcommon-x11-dev libxrender-dev libxt-dev pkg-config \
        protobuf-compiler zlib1g-dev
    ```

 - 如果是 Ubuntu 20，还需要额外安装：

    ```bash
    sudo apt-get install libglx-dev
    ```



**[可选] Qt5**

Qt5 由 Superbuild 自动构建，但是为了加快构建过程，你可以选择使用内置的二进制文件，选项参数如下：

 - 如果你的系统软件包管理器提供 Qt5 5.15.2 或以上版本（例如 Ubuntu20.04），那么使用：

    ```bash
    qt5-default qtmultimedia5-dev qtbase5-private-dev libqt5x11extras5-dev libqt5svg5-dev qttools5-dev
    ```

    并将选项参数 `-DUSE_SYSTEM_qt5=ON` 添加到 CMake 配置中。

 - 自行构建：详细说明请参考 [附加说明](#qt-build)


#### 2.3.2 Linux 指导说明

**源目录不得位于 LidarView 源代码目录中**.

推荐的目录结构如下：

| /home/username/lidarview       | 工作目录 |
| ------------------------------ | -------- |
| /home/username/lidarview/src   | 源目录   |
| /home/username/lidarview/build | 构建目录 |

**注意：**在配置或编译后移动这些目录，将破坏所有构建环境并需要完全重建。

#### 2.3.3 Linux 编译说明

 - 请注意，配置命令提到了源目录中的子目录 *Superbuild* 目录，而不是源目录本身。

 - 如果你更改了默认的 Qt 安装路径，则必须调整配置命令。

 - 从头开始构建可能需要 20 分钟到 2 小时，具体取决于你的硬件性能。

 - 默认情况下，添加 `-j` 选项将使用机器上所有的核进行编译，你也可以使用 `-j N` 指定要使用的内核数。

 - 如果你选择使用预构建的二进制文件而不是默认的 Superbuild 编译，请不要忘记 Qt5 配置选项。

    ```bash
    cd <work-directory>
    git clone <git url to LidarView-based app repository> --recurse-submodules src
    mkdir <work-directory>/build
    cd <work-directory>/build
    cmake <work-directory>/src/Superbuild -GNinja -DCMAKE_BUILD_TYPE=Release
    cmake --build . -j
    ./install/bin/<LidarView-based app name>
    ```


![](https://static.getiot.tech/lidarview-build-done-on-ubuntu.png)


## 3. 使能 LidarView 扩展特性

### 3.1 使能 SLAM 特性

 - 在 **UNIX** 系统需要安装额外的软件包：

    ```bash
    sudo apt-get install liblapack-dev
    ```

 - 使用这些附加的选项参数，重新运行 CMake 配置命令：

    ```bash
    -DENABLE_ceres=True -DENABLE_nanoflann=True -DENABLE_pcl=True -DLIDARVIEW_BUILD_SLAM=True
    ```

 - 运行或重新运行 CMake 构建命令：

    ```bash
    cmake --build . -j
    ```

有关 SLAM 的更多信息，请访问《[How to SLAM with LidarView](https://gitlab.kitware.com/keu-computervision/slam/-/blob/master/paraview_wrapping/doc/How_to_SLAM_with_LidarView.md)》。

### 3.2 使能 OpenCV 特性

 - 安装 OpenCV

    下载地址 [https://opencv.org/](https://opencv.org/)，在 UNIX 系统中，你可以使用如下命令安装：

    ```bash
    sudo apt-get install libavformat-dev libavdevice-dev libavcodec-dev
    ```

 - 使用下列附加参数重新运行 CMake 配置命令：

    ```bash
    -DENABLE_opencv=True
    ```

 - 运行或重新运行 CMake 构建命令：

    ```bash
    cmake --build . -j
    ```




## 4. 增量构建说明

 - 如果你只修改了 LidarView 源代码，通常会希望增量构建，以缩短构建时间。命令如下：

    ```bash
    cd <work-directory>\build\common-superbuild\lidarview\build
    cmake --build . -j --target install
    ```




## 5. 调试构建说明

  - 完整的 superbuild 不能在调试模式下可靠地构建，但是单个项目，如 LidarView 本身可以在 `Debug` 或 `RelWithDebInfo` 模式下构建：

    ```bash
    cd <work-directory>\build\common-superbuild\lidarview\build
    cmake . -DCMAKE_BUILD_TYPE=Debug
    cmake --build . -j --target install
    ```



## 6. 打包说明

 - 通过 CMake 配置激活 tests 的构建：

    ```bash
    cd <work-directory>/build
    cmake . -DBUILD_TESTING=True
    ```

 - 使用新配置构建：

    ```bash
    cmake --build . -j
    ```

 - 使用 cpack 打包：

    ```bash
    ctest
    ```



## 7. 测试说明
运行基于 LidarView 的应用程序测试的详细说明《[LidarView Testing Guide](https://gitlab.kitware.com/LidarView/lidarview-core/-/blob/master/Testing/README.md)》。



## 8. 附加说明

### 8.1 从源代码构建 Qt5.15.2 <a name="qt-build"></a>

Qt5.15.2 - [Source Package](https://download.qt.io/official_releases/qt/5.15/5.15.2/single/)

查看构建脚本 [Build Script](https://gitlab.kitware.com/LidarView/lidarview-superbuild/utils)，安装位置说明：

- 在 Unix 系统，我们推荐安装在 `/opt` 目录，并使用以下命令将此目录添加到你的 ld 配置中：

  ```bash
  sudo echo "/usr/local/lib" >> /etc/ld.so.conf && sudo ldconfig
  ```

- 在 Windows 系统，我们推荐安装在 `C:\` 盘


```bash
* Add proper parameters to CMake configuration options: `-DUSE_SYSTEM_qt5=ON -DQt5_DIR="/path/to/install/location/lib/cmake/Qt5"`

  **Always forward slashes, UNIX style, on all platforms**

  e.g If installed in `/opt`: `-DQt5_DIR=/opt/Qt5.15.2/5.15.2/gcc_64/lib/cmake/Qt5`

  e.g If installed in `C:\` : `-DQt5_DIR=C:/Qt/Qt5.15.2/5.15.2/msvc2015_64/lib/cmake/Qt5`
```

### 8.2 Microsoft Visual Studio 14 (2015) Express <a name="msvc15-installer"></a>

下载地址：[Microsoft Visual Studio Express 2015 for Windows Desktop - 简体中文](http://go.microsoft.com/fwlink/?LinkId=615464)

你也可以点击[这里](https://docs.microsoft.com/en-us/previous-versions/visualstudio/visual-studio-2015/install/create-an-offline-installation-of-visual-studio?view=vs-2015)下载离线安装包，或者下载 [ISO 镜像](https://go.microsoft.com/fwlink/?LinkId=615448)。



## 9. 疑难解答 / FAQ

### 9.1 UBUNTU Cannot find Qt Packages "unable to locate package qt5-default"

解决：Qt 是 [community software](https://packages.ubuntu.com/focal/qt5-default)，修改 Ubuntu 系统中的 /etc/apt/sources.list 文件，取消注释（或添加）`universe` PPA 源。例如，`deb http://archive.ubuntu.com/ubuntu/ focal universe`。



### 9.2 Superbuild failure with PCL enabled

由于硬件的差别，当你启用 `-DENABLE_pcl=True` 时，superbuild 可能会在 PCL 编译期间失败，并由于内存分配紧张而出现 *Internal compiler error* 错误。

要解决该问题，你可以尝试：

 - 重新运行构建命令，因为连续的增量构建最终可能会成功。
 - 使用 `-j N` 选项减少构建命令中的编译作业数量。

