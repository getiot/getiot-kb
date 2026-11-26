---
sidebar_position: 2
---

# OpenCV 安装



**OpenCV** 是一个开源的跨平台计算机视觉库，支持所有主流操作系统，包括 Linux、Windows、macOS 等，并提供 C++、Python 和 Java 库接口。

本文主要介绍在 Linux 平台（以 Ubuntu 为例）如何安装 OpenCV，包括使用 apt 包管理工具、手动从源码编译安装、使用 pip 安装等方式。



## Ubuntu 安装 OpenCV

### 通过 apt 安装 OpenCV

打开命令行终端，执行如下命令即可安装 OpenCV 必要软件包。

```bash
sudo apt update
sudo apt install -y libopencv-dev python3-opencv
sudo apt install -y libopencv-calib3d-dev libopencv-objdetect-dev \
                    libopencv-shape-dev libopencv-stitching-dev \
                    libopencv-superres-dev libopencv-videostab-dev
```

安装完成后可通过 `opencv_version` 命令查看版本，确认是否安装成功。

```bash
$ opencv_version 
4.2.0
```

也可以通过 Python3 命令交互来检查，如下：

```python
python3 -c "import cv2; print(cv2.__version__)"
```



## 从源码安装 OpenCV

前面的安装方式虽然简单，但可能无法安装最新版本（或者你想要的指定版本），那么这时候你就需要从源码编译安装 OpenCV。这种方式还会在编译时针对你的特定系统进行优化，并且你可以完整控制所有的构建选项。

下面以当前最新版本为例，介绍 OpenCV 的安装步骤。

1. **安装构建工具和所有的依赖软件包**

   ```bash
   sudo apt install build-essential cmake git pkg-config libgtk-3-dev \
        libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
        libxvidcore-dev libx264-dev libjpeg-dev libpng-dev libtiff-dev \
        gfortran openexr libatlas-base-dev python3-dev python3-numpy \
        libtbb2 libtbb-dev libdc1394-22-dev libopenexr-dev \
        libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev
   ```

2. **创建工作目录，克隆 OpenCV 和 OpenCV contrib 源代码**

   ```bash
   mkdir ~/opencv_build && cd ~/opencv_build
   git clone https://github.com/opencv/opencv.git
   git clone https://github.com/opencv/opencv_contrib.git
   ```

   注意，上述克隆方式将会下载当前最新的 OpenCV 项目源代码，例如我们当前是 4.7.0，而你操作的时候可能会有更新版本。

3. **下载完成后，创建一个临时构建目录 build，并且切换到这个目录**

   ```bash
   cd ~/opencv_build/opencv
   mkdir -p build && cd build
   ```

4. **配置 OpenCV 工程**

   使用 CMake 命令配置 OpenCV 构建：

   ```bash
   cmake -D CMAKE_BUILD_TYPE=RELEASE \
         -D CMAKE_INSTALL_PREFIX=/usr/local \
         -D INSTALL_C_EXAMPLES=ON \
         -D INSTALL_PYTHON_EXAMPLES=ON \
         -D OPENCV_GENERATE_PKGCONFIG=ON \
         -D OPENCV_EXTRA_MODULES_PATH=~/opencv_build/opencv_contrib/modules \
         -D BUILD_EXAMPLES=ON ..
   ```

   此时输出如下提示：

   ```bash
   -- Configuring done
   -- Generating done
   -- Build files have been written to: /home/rudy/opencv_build/opencv/build
   ```

5. **开始编译 OpenCV**

   ```bash
   make -j$(nproc)
   ```

   这里的 `nproc` 会获取系统的处理器核心数，以最快的速度进行编译。

6. **安装 OpenCV**

   ```bash
   sudo make install
   ```

7. 验证安装结果

   ```bash
   $ pkg-config --modversion opencv4
   4.7.0
   ```

   输入上述命令，如果看到对应的 OpenCV 版本则说明安装成功。



## Python 安装

如果你是 Python 开发者，可能只关心如何在 Python 环境中安装 OpenCV。安装方法很简单，直接使用 pip 安装即可。

```bash
pip install opencv-python
```

如果想要使用 Python 虚拟环境，可以参考 [Python 虚拟环境](/python/python-virtualenv/) 进行配置。

