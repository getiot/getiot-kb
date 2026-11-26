---
sidebar_position: 2
sidebar_label: PCL 安装
---

# PCL（点云库）安装

本文以 Ubuntu 20.04 为例，介绍如何安装 PCL 库，包括通过 apt 包管理器安装和源码编译安装两种方式。



## 安装依赖

在安装 PCL 之前，需要先安装依赖库，比如 VTK 库等。

```bash
sudo apt-get update
sudo apt-get install git build-essential linux-libc-dev
sudo apt-get install cmake cmake-gui
sudo apt-get install libusb-1.0-0-dev libusb-dev libudev-dev
sudo apt-get install mpi-default-dev openmpi-bin openmpi-common
sudo apt-get install libflann1.9 libflann-dev
sudo apt-get install libeigen3-dev
sudo apt-get install libboost-all-dev
sudo apt-get install libqhull* libgtest-dev  
sudo apt-get install freeglut3-dev pkg-config  
sudo apt-get install libxmu-dev libxi-dev   
sudo apt-get install mono-complete   
sudo apt-get install libopenni-dev   
sudo apt-get install libopenni2-dev 
sudo apt-get install libvtk7-dev libvtk6-dev
sudo apt-get install qt5-default
```



## 通过 apt 安装

```bash
sudo apt install libpcl-dev
```

这样就已经安装好了！



## 源码编译安装

首先打开 [PCL Release](https://github.com/PointCloudLibrary/pcl/releases) 页面，找到并下载你需要的 PCL 库版本。不过需要注意，PCL 和 VTK 之间会有版本匹配问题，较新的 PCL 库依赖高版本的 VTK 库。

以 PCL 1.13.0 版本为例，编译、安装步骤如下：

- 创建并切换到 build 目录

  ```bash
  mkdir build
  cd build
  ```

- CMake 配置，设置 `CMAKE_INSTALL_PREFIX` 是为了把 pcl 安装到指定目录

  ```bash
  cmake -DCMAKE_INSTALL_PREFIX=/usr/local/pcl-1.13.0 -DCMAKE_TYPE=None ..
  ```

- 编译（启动 4 个线程）

  ```bash
  make -j4
  ```

- 将编译好的 PCL 库安装到指定的安装目录

  ```bash
  sudo make install
  ```



