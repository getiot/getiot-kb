---
sidebar_position: 6
---

# NanoPi R6S 内核编译



本文以 ubuntu-jammy-desktop 系统固件（即 Ubuntu 22.04）为例，介绍如何为 NanoPi R6S 编译内核。



## 准备工作

开始之前，首先需要安装交叉编译工具链：

```bash
sudo apt install gcc-aarch64-linux-gnu
```

然后克隆 sd-fuse_rk3588 仓库到本地：

```bash
git clone https://github.com/friendlyarm/sd-fuse_rk3588
```

下载并解压分区映象压缩包 ubuntu-jammy-desktop-arm64-images.tgz：

```bash
cd sd-fuse_rk3588
wget http://112.124.9.243/dvdfiles/rk3588/images-for-eflasher/ubuntu-jammy-desktop-arm64-images.tgz
tar xvzf ubuntu-jammy-desktop-arm64-images.tgz
```



## 编译内核源码

调用 build-kernel.sh 编译一次内核源代码, 脚本会从 github 克隆内核源代码到本地, 环境变量 `KERNEL_SRC` 用于指定源代码目录：

```bash
export KERNEL_SRC=$PWD/kernel
./build-kernel.sh ubuntu-jammy-desktop-arm64
```

根据需要配置内核：

```bash
cd $KERNEL_SRC
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- menuconfig     # 根据需要改动配置
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- savedefconfig
cp defconfig ./arch/arm64/configs/my_defconfig                  # 保存配置 my_defconfig
git add ./arch/arm64/configs/my_defconfig
cd -
```

使用 `KCFG` 环境变量指定内核的配置（`KERNEL_SRC` 指定源代码目录），使用你的配置编译内核：

```bash
export KERNEL_SRC=$PWD/kernel
export KCFG=my_defconfig
./build-kernel.sh ubuntu-jammy-desktop-arm64
```

不使用脚本编译：

```bash
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- menuconfig
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- savedefconfig
cp defconfig ./arch/arm64/configs/my_defconfig
make CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 my_defconfig
make CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 nanopi6-images -j$(nproc)
```



## 编译设备树

arch/arm64/boot/dts/rockchip/rk3588-nanopi6-rev02.dtb
arch/arm64/boot/dts/rockchip/rk3588-nanopi6-rev03.dtb



## 编译内核头文件

设置环境变量 `MK_HEADERS_DEB` 为 1，将编译内核头文件：

```bash
MK_HEADERS_DEB=1 ./build-kernel.sh ubuntu-jammy-desktop-arm64
```



编译成功后，生成文件所在位置：

| 文件            | 路径                                                    |
| --------------- | ------------------------------------------------------- |
| 内核 img 文件   | ./arch/arm64/boot//zImage                               |
| 设备树 dtb 文件 | ./arch/arm64/boot/dts/rockchip/rk3588-nanopi6-rev03.dtb |
| modules 文件夹  | ./out/lib/modules                                       |



