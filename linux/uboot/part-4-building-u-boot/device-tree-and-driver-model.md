---
sidebar_position: 7
sidebar_label: 设备树与 Driver Model
slug: /device-tree-and-driver-model
---

# U-Boot 设备树与 Driver Model

现代 U-Boot 大量使用 Device Tree 和 Driver Model。对初学者来说，你可以先把它们理解为两件事：Device Tree 描述硬件，Driver Model 把硬件描述绑定到驱动和设备实例。

如果说设备树是一份硬件清单，那么 Driver Model 就是 U-Boot 根据这份清单创建、管理、初始化设备的机制。设备树里有节点，不代表设备一定已经可用；驱动存在，也不代表它一定会绑定到你的设备。

## 1. U-Boot 为什么也需要设备树

Linux 需要 DTB 描述硬件，U-Boot 也需要知道串口、网卡、存储控制器等设备在哪里。否则它无法输出日志、加载文件或通过网络下载镜像。

U-Boot 使用的设备树常被称为 control FDT。它可能来自：

- 编译进 U-Boot 的 DTB。
- 固件传入的 DTB。
- QEMU 动态生成并传入的 DTB。

不要简单认为“U-Boot 用的 DTB”和“传给 Linux 的 DTB”永远是同一份。

## 2. control FDT 与 Linux DTB

U-Boot 至少可能接触两类 FDT：

- control FDT：U-Boot 自己用来初始化设备。
- OS FDT：U-Boot 启动 Linux 时传给 Linux 的 DTB。

在简单实验中，它们可能来自同一份数据；在真实产品中，它们可能不同。比如 U-Boot control FDT 只保留启动阶段需要的设备，而 Linux DTB 描述完整硬件。

你可以在 U-Boot 中查看当前 FDT 相关信息：

```bash
# [U-Boot]
fdt addr
fdt header
```

如果你手动加载了 Linux DTB 并执行 `fdt addr ${fdt_addr_r}`，当前 `fdt` 命令操作的地址会切换到这份 DTB。调试时要知道自己正在看哪一份 FDT。

## 3. Driver Model 的基本概念

Driver Model 中常见对象包括：

- `uclass`：设备类别，例如 serial、eth、mmc。
- `driver`：驱动实现。
- `udevice`：运行时设备实例。
- `plat` / `priv`：平台数据和驱动私有数据。

你在 U-Boot 命令行中可以观察：

```bash
# [U-Boot]
dm tree
dm uclass
```

`dm tree` 能帮助你判断设备是否被绑定、探测到了哪一步。

`dm tree` 的输出通常会按树形结构列出设备。你可以重点观察：

- 设备属于哪个 uclass。
- 设备是否已经 probed。
- 设备名称是否符合预期。
- 设备树节点是否对应到运行时设备。

如果一个设备没有出现在 `dm tree` 中，说明它可能还没有绑定；如果出现了但使用失败，可能是 probe、资源、驱动或硬件初始化问题。

## 4. 从设备树到驱动

一个设备节点通常包含 `compatible` 字符串。驱动通过匹配 `compatible` 绑定设备。例如某个串口节点声明自己兼容某种 UART，U-Boot 中对应串口驱动就可以接管它。

排查设备不可用时，按顺序检查：

1. 设备树中是否有节点。
2. 节点状态是否为 `okay`。
3. U-Boot 是否启用了对应驱动配置。
4. `dm tree` 中是否出现该设备。
5. probe 是否报错。

你可以在源码中搜索 `compatible`：

```bash
# [Host]
rg "compatible" drivers/serial drivers/net drivers/virtio
```

也可以搜索某个驱动的 `U_BOOT_DRIVER`：

```bash
# [Host]
rg "U_BOOT_DRIVER" drivers/virtio drivers/serial
```

`U_BOOT_DRIVER` 宏通常描述驱动名称、所属 uclass、匹配表和 probe/remove 等函数。看到它，你就找到了 Driver Model 驱动注册的重要入口。

## 5. uclass 是什么

uclass 是一类设备的抽象。例如所有串口设备都属于 serial uclass，所有以太网设备属于 eth uclass。这样上层代码不用关心具体是 PL011、16550 还是某个厂商 UART，也能以统一方式访问“一个串口设备”。

在 U-Boot 命令行中查看：

```bash
# [U-Boot]
dm uclass
```

你会看到当前系统中有哪些设备类别，以及每类下有哪些设备。

## 6. `bind`、`probe` 和“可用”的区别

Driver Model 中有几个状态容易混淆：

- bind：根据设备树或平台数据创建了设备对象。
- probe：驱动真正初始化设备，申请资源、映射寄存器、准备使用。
- remove：释放设备。

一个设备被 bind 后，还不一定已经 probe；一个设备在 `dm tree` 中出现，也不代表硬件一定正常工作。真实排障时，要结合日志、命令输出和驱动 probe 返回值判断。

## 7. QEMU 的特殊性

QEMU `virt` 机器的硬件是模拟出来的，设备树也可能由 QEMU 提供。它非常适合学习 U-Boot 的通用机制，但不能代表真实 SoC 的启动 ROM、时钟、电源、pinmux 和存储初始化细节。

在 QEMU 中，你可以专注观察 Driver Model 概念；在真实开发板上，还要额外考虑：

- pinctrl 是否正确。
- clock/reset 是否开启。
- 电源域是否上电。
- 外设复位状态是否正确。
- SPL 阶段是否需要同一设备。

## 8. 常见排查路径

以网卡不可用为例：

```bash
# [U-Boot]
dm tree
dm uclass
printenv ethaddr
```

再从源码和配置侧检查：

```bash
# [Host]
grep CONFIG_NET .config
rg "virtio.*net|U_BOOT_DRIVER.*eth" drivers net
```

如果是真实开发板，还要回到设备树检查网卡节点、PHY、时钟、reset、pinctrl 和 MAC 地址来源。

## 本章小结

Device Tree 解决“硬件是什么”，Driver Model 解决“谁来管理这些硬件”。当你遇到串口、网卡、MMC 不工作时，不要只盯着命令本身，要回到设备树、配置和驱动绑定链路逐层检查。

## 思考与练习

1. 在 U-Boot 中执行 `dm tree`，找出 console 或网卡相关设备。
2. 解释 bind 和 probe 的区别。
3. 在源码中搜索一个 `U_BOOT_DRIVER`，观察它属于哪个 uclass。
