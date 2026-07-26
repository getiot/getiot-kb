---
sidebar_position: 4
sidebar_label: 综合实践：在开发板上启动 Linux
slug: /development-board-project
---

# 综合实践：用 U-Boot 在开发板上启动 Linux

这个实践不指定具体开发板，因为不同硬件差异很大。你要把 QEMU 中学到的方法迁移到自己的开发板上，并形成一份可复现记录。

真实开发板实践不要追求“一次成功”。更合理的目标是把每一步变成可观察、可回退、可复现的工程记录。

## 1. 实践目标

最终你应该得到：

- 一份板级启动链说明。
- 一份可编译 U-Boot 配置。
- 一份完整串口日志。
- 一组手动启动 Linux 的 U-Boot 命令。
- 一份可恢复方案。

## 2. 准备工作

开始前准备：

- 串口线和串口工具。
- 稳定电源。
- 原厂镜像和恢复工具。
- 可启动 SD card 或其他 recovery 介质。
- 目标板原理图或至少启动介质说明。
- 当前使用的 U-Boot、kernel、DTB、rootfs 文件清单。

:::warning
不要在没有 recovery 方案时覆盖板载启动介质。开发板能否恢复，比第一次启动是否成功更重要。
:::

## 3. 推荐步骤

1. 使用原厂镜像启动开发板，保存日志。
2. 记录 SoC、板卡版本、DRAM、启动介质和串口参数。
3. 找到最接近的 mainline defconfig。
4. 编译 U-Boot，但先不要覆盖板载启动介质。
5. 使用 SD card、USB download 或其他可恢复方式临时启动。
6. 进入 U-Boot 后执行只读命令验证设备。
7. 手动加载 kernel 和 DTB。
8. 设置 `bootargs` 并启动 Linux。
9. 整理为 boot script、extlinux 或产品启动变量。

建议每完成一步都保存日志。失败日志和成功日志一样有价值。

## 4. 记录模板

```bash
开发板：
SoC：
板卡版本：
U-Boot 版本：
启动介质：
串口：
DRAM：
启动链：
kernel 路径：
DTB 路径：
rootfs：
bootargs：
原厂日志：
新 U-Boot 日志：
恢复方式：
```

## 5. 只读验收

至少确认：

```bash
# [U-Boot]
version
bdinfo
printenv
dm tree
mmc list
part list mmc 0
```

如果启动介质不是 MMC，把 `mmc` 换成实际设备，例如 `usb`、`nvme`、`scsi` 或网络启动。

## 6. 手动启动验收

按你的开发板调整命令。例如使用 MMC：

```bash
# [U-Boot]
setenv kernel_addr_r 0x40200000
setenv fdt_addr_r 0x4fa00000
setenv bootargs "console=<your-console> root=<your-rootfs> rw rootwait"

mmc dev 0
part list mmc 0
load mmc 0:1 ${kernel_addr_r} /boot/Image
load mmc 0:1 ${fdt_addr_r} /boot/<board>.dtb
fdt addr ${fdt_addr_r}
fdt header
booti ${kernel_addr_r} - ${fdt_addr_r}
```

这里的 console、rootfs、DTB 路径、地址都必须按你的开发板调整。不要直接复制 QEMU 参数。

## 7. 自动启动整理

手动启动成功后，再整理自动启动：

- 临时环境变量脚本。
- `boot.scr`。
- `extlinux.conf`。
- Standard Boot。
- 产品级 `bootcmd`。

建议先使用可替换的 `boot.scr` 或 `extlinux.conf`，不要一开始就把复杂脚本永久写入 environment。

## 8. 完成标准

完成本实践时，你应该拥有：

- 原厂启动日志。
- 新 U-Boot 启动日志。
- 成功手动启动 Linux 的命令。
- 成功自动启动 Linux 的配置。
- 当前使用的镜像文件和 hash。
- 明确 recovery 操作流程。

最后保存成功日志和失败日志，作为后续维护资料。

## 本章小结

开发板实践的关键是可复现和可恢复。你不是只为了“这次启动成功”，而是要留下以后自己和团队都能看懂的启动链资料。

## 思考与练习

1. 填写本文记录模板。
2. 把 QEMU 的 `virtio` 启动命令改写成你的开发板启动命令。
3. 设计一个“新 U-Boot 启动失败后如何恢复”的流程。
