---
sidebar_position: 6
sidebar_label: 烧录、启动与验证
slug: /flashing-and-verification
---

# U-Boot 烧录、启动与验证

烧录是 U-Boot 移植中风险最高的环节之一。错误偏移、错误介质或错误镜像都可能让开发板无法启动。本章提供一套通用验证流程，具体命令请以目标板文档为准。

本章不会给出某个具体开发板的 `dd`、`mmc write` 或 `sf erase` 命令，因为这些命令必须和你的硬件布局精确匹配。这里更重要的是流程：先备份，先临时验证，再写持久介质。

## 1. 烧录前清单

烧录前确认：

- 已保存原厂完整镜像或至少保存启动分区。
- 知道如何进入 maskrom、USB download、recovery 或 SD card 恢复模式。
- 串口线已连接，波特率正确。
- 电源稳定。
- 明确烧录文件、目标介质、偏移和大小。

:::danger
不要在不确认偏移和恢复方法的情况下执行 `mmc write`、`sf erase`、`nand erase` 等命令。它们可能直接破坏启动链。
:::

## 2. 备份优先

如果板子能进入原厂 U-Boot 或 Linux，优先备份启动相关区域。具体方式取决于平台，可能是：

- 在 Linux 中读取 block 设备。
- 使用厂商工具导出 flash。
- 在 U-Boot 中读取并通过网络保存。
- 使用外部编程器读取 SPI flash。

备份后记录：

- 备份时间。
- 板卡序列号或版本。
- 原厂固件版本。
- 读取命令。
- 文件 hash。

没有备份时，至少要确认有官方恢复镜像和恢复工具。

## 3. 先做非破坏性验证

优先选择不会覆盖板载存储的验证方式：

- 从 SD card 启动临时镜像。
- 通过 USB download 加载到 RAM。
- 通过 JTAG 或厂商工具临时运行。
- 在 U-Boot 中通过 TFTP 加载 Linux，而不是立刻改写 flash。

如果板子支持启动顺序选择，先用外部介质验证新 U-Boot。

非破坏性验证的目标不是一次启动完整系统，而是先确认：

- 新 U-Boot 是否有串口输出。
- DRAM 是否正确。
- 是否能进入命令行。
- 是否能识别启动介质。

这些都通过后，再考虑持久化写入。

## 4. 烧录后观察什么

串口日志是第一证据。按阶段检查：

1. Boot ROM 或早期 loader 是否有输出。
2. SPL 是否有输出。
3. DRAM size 是否正确。
4. U-Boot proper 是否打印版本。
5. environment 是否加载成功。
6. 存储、网络、USB 是否识别。
7. 是否能手动加载并启动 Linux。

你应该保存至少两份日志：

- 第一次启动新 U-Boot 的完整日志。
- 成功手动启动 Linux 的完整日志。

后续每次改动固件，都和这两份日志对比。

## 5. 最小验收

新 U-Boot 在开发板上至少应通过：

```bash
# [U-Boot]
version
bdinfo
dm tree
printenv
mmc list
```

如果要启动 Linux，再验证：

```bash
# [U-Boot]
load mmc 0:1 ${kernel_addr_r} /boot/Image
load mmc 0:1 ${fdt_addr_r} /boot/<board>.dtb
booti ${kernel_addr_r} - ${fdt_addr_r}
```

路径、设备编号和 DTB 名称必须根据你的开发板调整。

## 6. 写入后立即验证 environment

如果你启用了持久化 environment，不要马上 `saveenv`。先查看：

```bash
# [U-Boot]
printenv
```

确认默认环境合理，再确认 environment 存储位置。如果必须测试保存，也先准备 recovery 方案。

:::warning
`saveenv` 是写操作。environment 偏移错误时，它可能覆盖启动镜像或分区表。
:::

## 7. 失败后如何回退

如果新 U-Boot 无法启动，按恢复路径执行：

- 切回原厂 SD card 或恢复介质。
- 进入 Boot ROM recovery/maskrom。
- 使用厂商工具重新刷写原厂镜像。
- 使用外部编程器恢复 SPI flash。

不要在焦虑中继续随机写入。先恢复到已知可启动状态，再重新分析日志和打包步骤。

## 本章小结

烧录不是“把文件写进去”这么简单。可靠流程应该是先备份、再临时验证、最后持久化写入，并且每一步都用串口日志确认。

## 思考与练习

1. 写下你的开发板进入 recovery 模式的方法。
2. 保存一份原厂启动日志和一份新 U-Boot 启动日志。
3. 解释为什么第一次验证应优先选择 SD card、USB download 或 RAM load。
