---
sidebar_label: canfdtest 命令
sidebar_position: 14
slug: /canfdtest
description: "canfdtest 命令是一个 CAN FD 全双工测试程序，包含 DUT（被测设备）端和 Host（主机）端两种工作模式。可用于验证 CAN FD 接口的收发功能、数据完整性和链路可靠性。"
---

# Linux canfdtest 命令 - CAN FD 全双工测试



## 介绍

**canfdtest** 命令是一个 CAN FD 全双工测试程序，包含 DUT（被测设备）端和 Host（主机）端两种工作模式。可用于验证 CAN FD 接口的收发功能、数据完整性和链路可靠性。

- 使用 `-g` 选项时：在指定接口上生成测试报文并校验回环数据
- 不使用 `-g` 时：接收到的报文会被回发，同时将 CAN ID 和所有数据字节递增

canfdtest 命令由 can-utils 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install can-utils
```

**语法**：

```bash
canfdtest [options] <can-interface>
```

**选项**：

- `-v`：低详细度输出
- `-vv`：高详细度输出
- `-g`：生成测试报文（Host 端模式）
- `-l COUNT`：测试循环次数
- `-f COUNT`：在途帧数量（默认 50）

使用 `CTRL-C` 可中止测试。

相关命令：[cansend](/linux-command/cansend/)、[cangen](/linux-command/cangen/)、[cansequence](/linux-command/cansequence/)



## 示例

1、在被测设备（DUT）端运行，监听并回发递增报文：

```bash
canfdtest -v can0
```

2、在主机（Host）端运行，生成测试报文：

```bash
canfdtest -g -v can0
```

3、典型双端测试：DUT 和 Host 分别连接 can0 和 can2，两端同时运行：

```bash
# DUT 端
canfdtest -v can0

# Host 端
canfdtest -g -v can2
```

4、限制在途帧数为 100，运行 10 个测试循环：

```bash
canfdtest -g -vv -f 100 -l 10 can0
```
