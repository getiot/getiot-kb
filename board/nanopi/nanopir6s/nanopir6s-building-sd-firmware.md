---
sidebar_position: 4
---

# NanoPi R6S 制作固件



## 设置环境

```bash
sudo apt-get -y update
sudo apt-get install -y sudo wget
wget https://raw.githubusercontent.com/friendlyarm/build-env-on-ubuntu-bionic/master/install.sh
sudo ./install.sh
```



```bash
https://github.com/friendlyarm/build-env-on-ubuntu-bionic
```

（资源有：build-env-on-ubuntu-bionic-master） 

```bash
sudo ./install.sh
```

即可 



## 下载文件

下载本仓库到本地, 然后下载并解压分区映象压缩包: 

```bash
git clone https://github.com/friendlyarm/sd-fuse_rk3588
cd sd-fuse_rk3588
```

（资源里有分区映象压缩包ubuntu-jammy-desktop-arm64-images.tgz） 

```bash
tar xvzf ubuntu-jammy-desktop-arm64-images.tgz
```

注：将资源中“07_源代码”文件夹中文件均放到“sd-fuse_rk3588/out”文件夹中并单独解压。 

（编译过程中会需要这些文件，直接手动放入可以避免clone失败） 

```bash
$ ls -lh ubuntu-jammy-desktop-arm64
总用量 3.7G
-rw-r--r-- 1 rudy rudy 7.5M 11月 23 16:54 boot.img
-rw-r--r-- 1 rudy rudy 1.4K 7月  26 17:44 dtbo.img
-rw-r--r-- 1 rudy rudy 284K 10月 26 13:18 idbloader.img
-rw-r--r-- 1 rudy rudy   67 12月 13 14:01 info.conf
-rw-r--r-- 1 rudy rudy  36M 10月 26 13:18 kernel.img
-rw-r--r-- 1 rudy rudy 439K 7月  26 15:45 MiniLoaderAll.bin
-rw-r--r-- 1 rudy rudy  48K 7月  26 15:45 misc.img
-rw-r--r-- 1 rudy rudy  470 12月 13 14:00 parameter.txt
-rw-r--r-- 1 rudy rudy 4.3M 11月 16 16:06 resource.img
-rw-r--r-- 1 rudy rudy 3.6G 12月 13 14:00 rootfs.img
-rw-r--r-- 1 rudy rudy 4.0M 10月 26 13:18 uboot.img
-rw-r--r-- 1 rudy rudy  97K 12月 13 14:00 userdata.img
```





## 编译内核

调用 `build-kernel.sh` 编译一次内核源代码, 脚本会从github克隆内核源代码到本地, 环境变量 `KERNEL_SRC` 用于指定源代码目录: （同样资源有源码linux-kernel......，提前手动放入可避免clone失败） 

```bash
export KERNEL_SRC=$PWD/kernel
./build-kernel.sh ubuntu-jammy-desktop-arm64  
```



安装交叉编译工具链

```bash
git clone https://github.com/friendlyarm/prebuilts.git -b master --depth 1
cd prebuilts/gcc-x64
#cat toolchain-6.4-aarch64.tar.gz* | sudo tar xz -C /
sudo tar xvJf toolchain-11.3-aarch64.tar.xz -C /
```





## 重新打包 SD-to-eMMC 卡刷固件 

```bash
cd sd-fuse_rk3588
```

（资源有emmc-flasher镜像） 

```bash
tar xvzf emmc-flasher-images.tgz
```

再使用以下命令, 打包卡刷固件, autostart=yes参数表示使用此固件开机时,会自动进入烧写流程: （需要指定名字，否则有可能不会创建） 

```bash
./mk-emmc-image.sh ubuntu-jammy-desktop-arm64 filename=myimg-emmc.img autostart=yes
```

命令执行成功后, 将生成以下文件, 此文件可烧写到SD卡运行

```bash
out/.......img
```

