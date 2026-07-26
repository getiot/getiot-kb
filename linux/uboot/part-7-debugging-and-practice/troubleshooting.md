---
sidebar_position: 2
sidebar_label: 常见启动故障与排查
slug: /troubleshooting
---

# U-Boot 常见启动故障与排查

启动失败看起来千奇百怪，但大多数问题都能按阶段定位。你可以从“最后一个成功阶段”开始，寻找第一处有意义的错误。

排查时先问三个问题：

1. 最后一个成功阶段是什么？
2. 第一条有意义的错误是什么？
3. 最近一次改变了什么？

这三个问题能帮你避免在无关方向上反复试错。

## 1. 没有任何串口输出

可能原因：

- 串口接线、波特率或电平错误。
- 镜像没有被 Boot ROM 加载。
- SPL 在串口初始化前崩溃。
- 电源或复位问题。

排查顺序：先验证原厂镜像是否有输出，再确认串口工具和接线，最后检查烧录偏移和早期固件。

如果原厂镜像也没有输出，优先怀疑串口、电源、启动模式或硬件连接。如果原厂镜像有输出，新镜像没有输出，才回到镜像格式、烧录位置、SPL 和早期初始化。

## 2. 卡在 DRAM 初始化

可能原因：

- DDR 参数错误。
- PMIC 或电源时序不对。
- SPL 配置缺失。
- 使用了错误板型的镜像。

DRAM 问题通常不能靠 U-Boot 命令行解决，因为命令行还没起来。需要回到 SPL、DDR 初始化代码和板级资料。

常见处理方法：

- 对比原厂日志中的 DRAM size。
- 确认使用了正确板型和内存颗粒配置。
- 确认 SPL 中启用了必要 DDR 初始化代码。
- 不要把同 SoC 但不同 DDR 的板子配置直接套用。

## 3. 找不到启动设备

现象可能是 `mmc init failed`、`No ethernet found`、`Cannot find boot device`。

排查：

```bash
# [U-Boot]
dm tree
mmc list
virtio scan
usb start
part list mmc 0
```

确认设备树、驱动配置、供电、pinmux 和启动介质。

如果设备在 `dm tree` 中不存在，优先检查设备树和驱动配置。如果设备存在但访问失败，再看供电、时钟、reset、介质和分区。

## 4. 找不到文件

常见原因是设备编号、分区编号或路径错误：

```bash
# [U-Boot]
ls mmc 0:1 /
ls mmc 0:1 /boot
```

路径大小写要匹配。不要把 Linux 中的 `/dev/mmcblk0p1` 写到 U-Boot 的 `load` 命令里。

排查路径时一层层 `ls`：

```bash
# [U-Boot]
ls mmc 0:1 /
ls mmc 0:1 /boot
ls mmc 0:1 /boot/extlinux
```

如果 `/boot` 是 Linux 中的挂载点，它在 U-Boot 看到的分区里可能并不存在。启动分区根目录可能直接就是 `Image`、`dtb/` 或 `extlinux/`。

## 5. kernel 启动失败

`Bad Linux ARM64 Image magic` 通常是镜像格式或地址错误。`Did not find a cmdline Flattened Device Tree` 通常是 DTB 参数错误。Linux 报 `Unable to mount root fs`，通常是 `bootargs`、rootfs、内核驱动或文件系统支持问题。

按错误拆分：

#### `Bad Linux ARM64 Image magic`

- 确认使用 ARM64 `Image`。
- 确认启动命令是 `booti`。
- 确认加载地址上不是 DTB、initramfs 或空数据。

#### `Did not find a cmdline Flattened Device Tree`

- 确认第三个参数传了 DTB 地址。
- 使用 `fdt addr` 和 `fdt header` 验证。
- 确认 DTB 没被 initramfs 或 kernel 覆盖。

#### `Unable to mount root fs`

- 确认 `root=` 是 Linux 视角设备名。
- 尝试增加 `rootwait`。
- 确认 kernel 内置或 initramfs 提供了对应存储和文件系统驱动。
- 确认 rootfs 分区内容正确。

## 6. 环境变量导致异常

环境变量可能覆盖你的手动设置。排查：

```bash
# [U-Boot]
printenv bootcmd
printenv bootargs
env default -a
```

:::warning
`env default -a` 只恢复当前运行时默认环境；如果再执行 `saveenv`，才会写入持久化存储。真实开发板上执行前请确认风险。
:::

## 7. Standard Boot 扫描不到

排查：

```bash
# [U-Boot]
bootdev list
bootmeth list
bootflow scan -l
ls virtio 0:1 /boot/extlinux
```

常见原因：

- `extlinux.conf` 路径不对。
- 文件系统不受支持。
- bootdev 没有被扫描到。
- bootmeth 顺序不包含 extlinux。
- 配置文件中 kernel 或 fdt 路径错误。

## 8. 网络启动失败

按层次判断：

- `No ethernet found`：网卡设备问题。
- `ping` 不通：IP、网络连接或 QEMU 参数问题。
- TFTP file not found：TFTP 根目录或文件名问题。
- TFTP 成功但 boot 失败：进入 kernel/DTB/bootargs 排查。

```bash
# [U-Boot]
printenv ipaddr serverip
ping ${serverip}
tftpboot ${kernel_addr_r} Image
```

## 9. 决策表

| 现象 | 优先检查 |
| --- | --- |
| 无任何输出 | 电源、串口、烧录偏移、SPL |
| 有 SPL 无 U-Boot proper | 后级镜像位置、格式、DRAM |
| 有 U-Boot 无设备 | 设备树、驱动配置、供电、pinmux |
| 能加载文件但不能启动 | 镜像格式、地址、DTB |
| Linux 启动后 panic | bootargs、rootfs、内核驱动 |
| 自动启动失败，手动成功 | environment、bootcmd、Standard Boot 配置 |

## 本章小结

排查启动问题时，不要一开始就怀疑最复杂的原因。按阶段确认：早期输出、DRAM、设备、分区、文件、地址、bootargs、Linux rootfs。每层只解决自己的问题。

## 思考与练习

1. 选择一个启动失败日志，标出最后一个成功阶段。
2. 故意写错 `root=` 参数，观察 Linux 报错。
3. 比较手动启动成功但自动启动失败时，应该优先检查哪些变量。
