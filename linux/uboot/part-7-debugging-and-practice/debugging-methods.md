---
sidebar_position: 1
sidebar_label: U-Boot 调试方法
slug: /debugging-methods
---

# U-Boot 调试方法

U-Boot 调试的第一原则是保存证据。串口日志、构建配置、启动命令、镜像版本和设备树，比“我感觉它卡住了”有用得多。

调试不是把所有命令都试一遍，而是不断缩小范围。你要先判断问题发生在哪个阶段，再选择对应工具。

## 1. 串口日志

真实硬件上，串口是最重要的调试入口。保存完整日志，包括上电前后的所有输出。QEMU 中可以用 `script` 记录：

```bash
# [Host]
script -f logs/qemu-uboot.log
qemu-system-aarch64 -machine virt -cpu cortex-a57 -m 1024 -nographic -bios u-boot.bin
```

退出 `script` 后，日志会保存到文件中。

真实开发板上，建议每次实验都保存日志，并用文件名标记时间、镜像版本和实验目的：

```bash
logs/2026-07-26-board-a-u-boot-v2026.07-first-boot.log
logs/2026-07-26-board-a-tftp-kernel.log
```

日志文件名清楚，几天后你还能知道当时发生了什么。

## 2. 建立基线

每个实验环境都应该有一份“正常基线”：

- 原厂镜像完整启动日志。
- 你编译的 U-Boot 第一次启动日志。
- 成功手动启动 Linux 的日志。
- 当前 `.config` 或 defconfig。
- QEMU 命令或开发板烧录说明。

以后出现问题，先和基线比较。很多问题不是“坏了”，而是你无意中换了 DTB、bootargs、启动介质或镜像版本。

## 3. 只读命令优先

排查时优先使用只读命令：

```bash
# [U-Boot]
version
bdinfo
printenv
dm tree
part list virtio 0
ls virtio 0:1 /boot
fdt addr ${fdt_addr_r}
fdt header
```

写命令、擦除命令、保存环境变量命令都应放到最后，并确认风险。

常用只读排查组合：

```bash
# [U-Boot]
version
bdinfo
printenv bootcmd bootargs
dm tree
dm uclass
```

如果排查存储：

```bash
# [U-Boot]
mmc list
part list mmc 0
ls mmc 0:1 /
```

如果排查 DTB：

```bash
# [U-Boot]
fdt addr ${fdt_addr_r}
fdt header
fdt print /chosen
```

## 4. 构建侧调试

主机上常用工具：

```bash
# [Host]
grep CONFIG_BOOTSTD .config
aarch64-linux-gnu-objdump -h u-boot
grep ' board_init_r' u-boot.map
```

如果某个命令不存在，先查 `.config` 是否启用，再查源码是否参与构建。

再补几个常用动作：

```bash
# [Host]
grep CONFIG_CMD_BOOTFLOW .config
grep CONFIG_SPL .config
grep ' do_booti' u-boot.map
file u-boot u-boot.bin
```

这能帮助你判断“功能没有编译进去”还是“编译进去了但运行时不可用”。

## 5. 设备树调试

设备树问题常见但不容易一眼看出。你可以从三处看：

- 源码中的 `.dts` / `.dtsi`。
- U-Boot control FDT。
- 启动 Linux 时传给 kernel 的 DTB。

在 U-Boot 中验证已加载 DTB：

```bash
# [U-Boot]
fdt addr ${fdt_addr_r}
fdt header
fdt print /memory
fdt print /chosen
```

如果 Linux 没有串口输出，`/chosen` 和 `bootargs` 是优先检查对象。

## 6. 网络调试

网络启动失败时，先不要急着改 TFTP server。按顺序确认：

```bash
# [U-Boot]
dm tree
printenv ipaddr serverip ethaddr
ping ${serverip}
tftpboot ${kernel_addr_r} Image
```

如果 `No ethernet found`，问题在网卡识别；如果 `TFTP error: File not found`，问题在 TFTP 根目录或文件名；如果下载成功但启动失败，问题已经进入 kernel/DTB/bootargs 阶段。

## 7. GDB 调试

QEMU 可以配合 GDB 调试 U-Boot。启动 QEMU 时添加 `-S -s`，让 CPU 停在复位入口并监听 1234 端口：

```bash
# [Host]
qemu-system-aarch64 -machine virt -cpu cortex-a57 -m 1024 -nographic -bios u-boot.bin -S -s
```

另一个终端连接：

```bash
# [Host]
aarch64-linux-gnu-gdb u-boot
(gdb) target remote :1234
```

GDB 调试涉及符号加载、重定位地址和断点位置，初学阶段先把它作为深入工具，不必每次都使用。

如果你在 relocation 之后打断点，可能需要考虑 U-Boot 重定位后的地址。初学阶段可以先用 GDB 看早期代码是否执行，等理解重定位后再做更深入调试。

## 8. 一次只改变一个条件

调试时要避免同时更换：

- U-Boot。
- kernel。
- DTB。
- rootfs。
- bootargs。
- 启动介质。

一次只改变一个条件，才能知道哪个变化引入了问题。这个习惯比掌握很多命令更重要。

## 本章小结

调试 U-Boot 时，先保存日志，再用只读命令确认状态，最后才修改配置或写存储。把证据链建好，问题会清楚很多。

## 思考与练习

1. 为你的 QEMU 实验保存一份完整启动日志。
2. 用只读命令记录当前 U-Boot 的版本、内存和环境变量。
3. 故意改错一个文件路径，观察错误发生在哪个阶段。
