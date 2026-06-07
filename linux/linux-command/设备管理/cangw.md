---
sidebar_label: cangw 命令
sidebar_position: 16
slug: /cangw
---

# Linux cangw 命令 - 管理 CAN 网关路由规则



## 介绍

**cangw** 命令用于通过 PF_CAN netlink 接口管理 CAN 网关（Gateway）路由规则。它可以在不同 CAN 接口之间转发报文，并支持报文过滤、帧内容修改（AND/OR/XOR/SET）、CRC8 校验等高级功能，适用于网关设备、协议转换和总线桥接场景。

cangw 命令由 can-utils 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install can-utils
```

**语法**：

```bash
cangw [options]
```

**命令**：

- `-A`：添加新规则
- `-D`：删除规则
- `-F`：清除所有规则
- `-L`：列出所有规则

**必填参数**（添加/删除规则时）：

- `-s <src_dev>`：源网络设备
- `-d <dst_dev>`：目标网络设备

**选项**：

- `-X`：此规则适用于 CAN FD 帧
- `-t`：保留源设备接收时间戳
- `-e`：回显已发送的帧（在 vcan 接口上推荐使用）
- `-i`：允许路由到入站接口
- `-u <uid>`：用户自定义修改标识符
- `-l <hops>`：限制帧跳转/路由次数
- `-f <filter>`：设置 CAN 过滤器
- `-m <mod>`：设置经典 CAN 帧修改规则
- `-M <MOD>`：设置 CAN FD 帧修改规则
- `-x <from_idx>:<to_idx>:<result_idx>:<init_xor_val>`：XOR 校验和
- `-c <from>:<to>:<result>:<init_val>:<xor_val>:<crctab[256]>`：CRC8 校验和
- `-p <profile>:[<profile_data>]`：CRC8 校验和配置文件及参数

**过滤器格式**：

- `<can_id>:<can_mask>`：当 `received_can_id & mask == can_id & mask` 时匹配
- `<can_id>~<can_mask>`：当 `received_can_id & mask != can_id & mask` 时匹配

**经典 CAN 帧修改格式**（`-m`）：

`<instruction>:<elements>:<can_id>.<can_dlc>.<can_data>`

- `<instruction>`：`AND`、`OR`、`XOR`、`SET` 之一
- `<elements>`：`I`（ID）、`L`（长度）、`D`（数据）的一个或多个组合
- 最多 4 条修改按 AND → OR → XOR → SET 顺序执行

所有值均使用十六进制表示，前导零可省略。

相关命令：[candump](/linux-command/candump/)、[cansend](/linux-command/cansend/)



## 示例

1、列出当前所有网关规则：

```bash
cangw -L
```

2、将 can0 上的报文转发到 vcan0（带回显，适合虚拟 CAN 测试）：

```bash
cangw -A -s can0 -d vcan0 -e
```

3、添加带过滤器的转发规则，只转发 ID 为 0x123 的标准帧：

```bash
cangw -A -s can0 -d vcan3 -e -f 123:C00007FF
```

4、转发时修改报文 ID 和数据：

```bash
cangw -A -s can0 -d vcan3 -e -f 123:C00007FF -m SET:IL:333.4.1122334455667788
```

5、删除 can0 到 vcan0 的转发规则：

```bash
cangw -D -s can0 -d vcan0
```

6、清除所有网关规则：

```bash
cangw -F
```
