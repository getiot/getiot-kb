---
sidebar_position: 7
sidebar_label: 从 QEMU 迁移到开发板
slug: /qemu-to-development-board
---

# 把 U-Boot 从 QEMU 迁移到开发板

QEMU 教会你通用启动模型，但开发板会引入真实硬件细节。本章帮助你把 QEMU 中学到的知识迁移过去，同时避免把模拟环境的假设误当成硬件事实。

最容易踩的坑是：把 QEMU 中“被简化掉的东西”误认为真实硬件也不存在。QEMU 让你专注学习 U-Boot proper，而开发板还要面对 Boot ROM、SPL、DDR、pinmux、电源和固件打包。

## 1. 哪些知识可以迁移

可以直接迁移的能力包括：

- 阅读 U-Boot 启动日志。
- 使用 `help`、`version`、`bdinfo`、`printenv`。
- 理解地址变量和加载流程。
- 手动加载 kernel、DTB、initramfs。
- 设置 `bootargs`。
- 拆分启动脚本。
- 使用 Standard Boot 排查启动项。

这些能力是通用的。

## 2. 哪些经验不能照搬

不能直接照搬：

- QEMU 的 DRAM 起始地址。
- `-bios u-boot.bin` 的加载方式。
- `virtio 0:1` 设备编号。
- `console=ttyAMA0`。
- `/dev/vda2` rootfs。
- QEMU 用户网络的 `10.0.2.2`。
- QEMU 自动生成或传入设备树的方式。

这些都是平台相关事实，换到开发板必须重新确认。

## 3. 哪些内容必须重新确认

必须针对开发板确认：

- DRAM 起始地址和大小。
- 串口设备名和波特率。
- kernel、DTB、rootfs 所在介质和路径。
- U-Boot environment 存储位置。
- 是否需要 SPL、TF-A、OP-TEE、OpenSBI。
- 是否需要厂商打包工具。
- 启动 ROM 对镜像格式和偏移的要求。

## 4. 迁移步骤

建议按下面顺序推进：

1. 让原厂镜像启动，保存完整日志。
2. 找到同 SoC 或同板子的 mainline 支持状态。
3. 编译最接近的 defconfig。
4. 用可恢复方式启动新 U-Boot。
5. 只验证 U-Boot 命令行和设备识别。
6. 手动启动 Linux。
7. 整理环境变量或 Standard Boot 配置。
8. 最后再考虑写入板载启动介质。

每一步都只改变一个变量。比如你第一次上板时，不要同时更换 U-Boot、kernel、DTB 和 rootfs。先用原厂 kernel/DTB/rootfs 配合新 U-Boot，或者用原厂 U-Boot 加载新 kernel，逐层定位。

## 5. QEMU 命令到开发板命令的转换

QEMU 中：

```bash
# [U-Boot]
load virtio 0:1 ${kernel_addr_r} /boot/Image
```

开发板上可能变成：

```bash
# [U-Boot]
load mmc 0:1 ${kernel_addr_r} /boot/Image
```

或者：

```bash
# [U-Boot]
tftpboot ${kernel_addr_r} Image
```

变化的是“文件从哪里加载”，不是“把 kernel 放到内存再启动”的基本模型。

## 6. 保留对照组

开发板调试时，永远保留一个“已知可启动”的对照组：原厂镜像、旧版 U-Boot 或可启动 SD card。每次只改变一个条件，才能判断问题来自 U-Boot、DTB、kernel、rootfs 还是烧录布局。

对照组至少包括：

- 原厂完整串口日志。
- 原厂启动介质或恢复镜像。
- 当前可启动的 SD card。
- 能进入 recovery 的操作说明。

## 7. 迁移完成标准

不要只以“偶然启动一次 Linux”为完成标准。更好的标准是：

- 新 U-Boot 能稳定进入命令行。
- 能识别目标启动介质。
- 能手动加载 kernel 和 DTB。
- 能用明确 `bootargs` 启动 Linux。
- 能保存成功日志。
- 有恢复方案。
- 自动启动脚本或 Standard Boot 配置可复现。

## 本章小结

从 QEMU 迁移到开发板时，思维方式可以迁移，硬件参数不能照搬。你要把 QEMU 学到的启动链拆解能力，用在真实板子的资料、日志和源码上。

## 思考与练习

1. 列出 QEMU 示例中哪些参数不能直接用于你的开发板。
2. 把 QEMU 的手动启动命令改写成开发板的 `mmc` 或 `tftpboot` 命令。
3. 说明你准备用什么方式作为开发板恢复路径。
