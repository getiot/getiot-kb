---
sidebar_position: 4
sidebar_label: A/B 启动、回滚与 Recovery
slug: /ab-update-and-recovery
---

# U-Boot A/B 启动、回滚与 Recovery

A/B 启动是一种常见可靠升级策略：设备中保留两套系统分区，当前运行 A，升级写入 B。重启后先尝试从 B 启动，成功后标记 B 可用；失败则回滚到 A。

你可以把 A/B 看成“永远保留一条已知可启动的退路”。它不是为了让分区名字更复杂，而是为了降低升级失败导致设备不可用的概率。

## 1. 为什么需要 A/B

如果升级直接覆盖当前系统，升级失败可能让设备无法启动。A/B 的目标是让升级具备原子性和回滚能力。

典型分区包括：

- `boot_a`、`rootfs_a`
- `boot_b`、`rootfs_b`
- `misc` 或 `state` 分区，用于保存启动状态
- recovery 分区，可选

也有系统只做 rootfs A/B，boot 分区共享；也有系统 kernel、DTB、rootfs 全部分 slot。具体布局取决于产品风险和存储空间。

## 2. A/B 状态机

一个简化状态机可能是：

```bash
正常运行 A
升级写入 B
标记 B pending
重启尝试 B
    B 启动成功 -> Linux 用户空间标记 B good
    B 启动失败 -> U-Boot 回滚 A
```

关键点是“启动成功”不能由 U-Boot 单独判断。U-Boot 最多知道自己把 Linux 启动了，但不知道用户空间、网络、业务服务是否正常。因此通常需要 Linux 用户空间在系统健康后写入确认标记。

## 3. U-Boot 负责什么

U-Boot 通常负责：

- 读取当前 slot。
- 选择对应 kernel、DTB、rootfs。
- 记录启动尝试次数。
- 在启动失败后切换回旧 slot。
- 进入 recovery。

Linux 用户空间通常负责下载升级包、写入非活动 slot、标记新 slot 待启动，并在成功启动后确认。

U-Boot 不应该负责下载大型升级包、校验复杂业务策略或判断应用服务健康状态。让 U-Boot 保持简单，系统会更可靠。

## 4. 状态变量示例

简化状态可能包括：

- `boot_slot=a`
- `upgrade_available=1`
- `bootcount=0`
- `bootlimit=3`

U-Boot 中可通过 bootcount 机制实现尝试次数控制。具体存储方式与平台配置有关，可能保存在 environment、RTC、文件或专用存储区域。

状态变量需要满足两个条件：

- 断电后仍然可靠。
- 损坏时有安全默认行为。

如果状态变量只保存在普通 environment，而 environment 没有冗余或校验，A/B 可靠性会打折扣。产品中常会使用专用 metadata 分区或冗余状态区。

## 5. bootcount 与 bootlimit

U-Boot 支持 bootcount 机制，用来记录连续启动尝试次数。简化逻辑是：

```bash
if bootcount > bootlimit:
    run altbootcmd
else:
    run bootcmd
```

具体配置和存储后端与平台有关。使用前要确认：

- bootcount 存在哪里。
- 断电是否会丢失。
- Linux 成功启动后如何清零或确认。
- `altbootcmd` 是否真的能回滚到可用 slot。

## 6. Recovery

Recovery 是最后一道保险。触发方式可能包括：

- A/B 都启动失败。
- 用户按键。
- watchdog 连续复位。
- 升级状态损坏。
- 远程指令。

Recovery 系统应尽量小、稳定、少依赖，并能恢复主系统或重新刷写镜像。

Recovery 设计要回答：

- Recovery 镜像放在哪里。
- Recovery 是否参与安全验证。
- 如何防止用户误触发或攻击者滥用。
- Recovery 能否联网恢复。
- Recovery 自身升级失败怎么办。

## 7. A/B 与 Verified Boot

A/B 解决升级可靠性，Verified Boot 解决启动可信性。两者经常一起使用：

- 每个 slot 的 kernel/DTB/rootfs 都要验证。
- 状态 metadata 要防篡改或可检测篡改。
- Recovery 也要验证。
- 回滚不能切到已知不安全版本，必要时要配合 anti-rollback 机制。

如果只做 A/B 不做验证，攻击者可能替换某个 slot；如果只做验证不做 A/B，升级失败可能缺少回滚路径。

## 8. 常见设计错误

#### U-Boot 一启动 Linux 就标记成功

这太早。Linux kernel 启动不代表用户空间健康。应由用户空间完成必要健康检查后确认。

#### 回滚状态和 rootfs 放在同一个易损区域

如果 rootfs 损坏时状态也损坏，U-Boot 可能无法判断该回滚到哪里。状态区应尽量独立、冗余、可校验。

#### Recovery 依赖主系统

Recovery 应尽量独立。如果 recovery 还要依赖主 rootfs 才能运行，它就不是可靠的最后退路。

## 本章小结

A/B 与 Recovery 的核心不是分区名字，而是状态机。你要设计清楚每个状态如何进入、如何确认成功、失败如何回滚，以及状态本身损坏时怎么办。

## 思考与练习

1. 画出一个 A/B 升级状态机。
2. 说明为什么“Linux 用户空间确认成功”比 “U-Boot 跳转 kernel 成功”更可靠。
3. 列出 Recovery 系统必须独立具备的三个能力。
