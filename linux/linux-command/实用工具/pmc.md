---
sidebar_label: pmc 命令
sidebar_position: 13
slug: /pmc
---

# Linux pmc 命令 - 管理 PTP 网络



## 介绍

**pmc**（英文全拼：PTP management client）是一个根据 IEEE 1588 标准实现的 PTP 管理客户端程序，可用于获取 ptp4l 的更详细信息。

pmc 从标准输入或命令行读取按名称和管理 ID（MANAGEMENT IDS）指定的操作。然后通过选定的传输发送操作，并列显收到的任何答复。支持三种操作：`GET` 检索指定的信息，`SET` 更新指定的信息，`CMD`（或 `COMMAND`）发起指定的事件。默认情况下，管理命令针对所有端口。

相关命令：[ptp4l](/linux-command/ptp4l/)、[phc2sys](/linux-command/phc2sys/)、[phc_ctl](/linux-command/phc_ctl/)

关于 PTP 详细介绍，请参考《[PTP 精确时间协议](/protocol/ptp/)》。

**安装**：

pmc 命令由 LinuxPTP 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install linuxptp
```

**语法**：

```bash
pmc [options] [commands]
```

**选项**：

网络传输选项

- `-2`：使用 IEEE 802.3
- `-4`：使用 UDP IPV4（默认）
- `-6`：使用 UDP IPV6
- `-u`：使用本地 UDS（Unix Domain Socket）

其他选项

- `-b [num]`：边界跳数（boundary hops），默认为 1。
- `-d [num]`：域名（domain number），默认0。
- `-f [file]`：从文件中读取配置。
- `-i [dev]`：要使用的网络接口设备，网络默认为 eth0，UDS 为 `/var/run/pmc.$pid`。
- `-s [path]`：UDS 的服务器地址，默认为 `/var/run/ptp4l`。
- `-t [hex]`：传输特定字段，默认 0x0。
- `-z`：使用 GET 操作发送零长度 TLV 值。
- `-h`：打印帮助信息。
- `-v`：打印版本信息。

**命令**：

pmc 支持 `GET`、`SET`、`CMD` 三种操作，操作后面带上管理 ID，指定需要操作的目标。支持的管理 ID 包括：

- `ANNOUNCE_RECEIPT_TIMEOUT`
- `CLOCK_ACCURACY`
- `CLOCK_DESCRIPTION`
- `CURRENT_DATA_SET`
- `DEFAULT_DATA_SET`
- `DELAY_MECHANISM`
- `DOMAIN`
- `GRANDMASTER_SETTINGS_NP`
- `LOG_ANNOUNCE_INTERVAL`
- `LOG_MIN_PDELAY_REQ_INTERVAL`
- `LOG_SYNC_INTERVAL`
- `NULL_MANAGEMENT`
- `PARENT_DATA_SET`
- `PORT_DATA_SET`
- `PORT_DATA_SET_NP`
- `PRIORITY1`
- `PRIORITY2`
- `SLAVE_ONLY`
- `TIMESCALE_PROPERTIES`
- `TIME_PROPERTIES_DATA_SET`
- `TIME_STATUS_NP`
- `TRACEABILITY_PROPERTIES`
- `USER_DESCRIPTION`
- `VERSION_NUMBER`



## 示例

获取本地 ptp4l 运行信息（`CURRENT_DATA_SET`）

```bash
sudo pmc -u -b 0 'GET CURRENT_DATA_SET'
```

获取本地 ptp4l 运行信息（`TIME_STATUS_NP`）

```bash
sudo pmc -u -b 0 'GET TIME_STATUS_NP'
```

