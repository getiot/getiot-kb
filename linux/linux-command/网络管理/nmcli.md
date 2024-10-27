---
sidebar_label: nmcli 命令
sidebar_position: 40
slug: /nmcli
---

# nmcli 命令



## 介绍

**nmcli** 是 NetworkManager 网络管理客户端附带的一个命令行工具。使用 nmcli 命令，可以完成网络设备上的所有配置，并写入配置文件中。

**语法**：

```bash
nmcli [OPTIONS] OBJECT { COMMAND | help }
```

**选项**：

- `-a, --ask`：询问缺少的参数。
- `-c, --colors auto|yes|no`：是否在输出中使用颜色。
- `-e, --escape yes|no`：转义值中的列分隔符。
- `-f, --fields <字段,...>|all|common`：指定要输出的字段。
- `-g, --get-values <字段,...>|all|common`：组合选项 `-m tabular -t -f` 的快捷方式。
- `-h, --help`：显示帮助信息。
- `-m, --mode tabular|multiline`：输出模式。
- `-o, --overview`：概览模式。
- `-p, --pretty`：以美化模式输出。
- `-s, --show-secrets`：允许显示密码。
- `-t, --terse`：以简洁模式输出。
- `-v, --version`：显示版本信息。
- `-w, --wait <秒数>`：设定操作完成的等待超时。

**对象**：

- `g[eneral]`：NetworkManager 的常规状态和操作。
- `n[etworking]`：整体网络控制。
- `r[adio]`：NetworkManager 切换开关。
- `c[onnection]`：NetworkManager 的连接。
- `d[evice]`：NetworkManager 管理的设备。
- `a[gent]`：NetworkManager 的私密代理或 polkit 代理。
- `m[onitor]`：监视 NetworkManager 更改。

:::tip

对象名可以是单个字母的缩写，也可以是任意字母的组合。例如 `connection` 对象，写成 `c`、`con`、`connection` 是等效的。

:::



## 示例

### 查看连接

显示连接列表及其名称、UUID、类型和支持设备：

```bash
$ nmcli connection show
```

显示活动的连接：

```bash
$ nmcli connection show -active
```

显示指定一个网络连接配置：

```bash
$ nmcli connection show "lan eth0"
```

### 查看和操作设备

显示所有网络设备及其状态：

```bash
$ nmcli device
```

等效于：

```bash
$ nmcli device status
```

查看所有网络设备的详细信息：

```bash
$ nmcli device show
```

查看指定网络设备的详细信息：

```bash
$ nmcli device show "eth0"
```

断开网络接口上的连接：

```bash
$ nmcli device disconnect ifname eth0
```

### 创建、配置和删除连接

定义一个名字为 default 的新连接，它将使用 DHCP 通过 `eth0` 设备的以太网自动连接 ：

```bash
$ nmcli connection add con-name "default" type ethernet ifname eth0
```

关闭自动连接：

```bash
$ nmcli connection modify "default" connection.autoconnect no
```

添加 DNS：

```bash
$ nmcli connection modify "default" ipv4.dns 8.8.8.8
```

启用 default 连接配置（激活连接）：

```bash
$ nmcli connection up "default"
```

删除 default 连接：

```bash
$ nmcli connection delete "default"
```

重启服务：

```bash
$ nmcli connection reload
```

### Wi-Fi 操作

显示附近的 Wi-Fi 网络：

```bash
$ nmcli device wifi list
```

连接到 Wi-Fi 网络：

```bash
$ nmcli device wifi connect <SSID_或_BSSID> password <密码>
```

连接到隐藏的 Wi-Fi 网络：

```bash
$ nmcli device wifi connect <SSID_或_BSSID> password <密码> hidden yes
```

连接到 `wlan1` 网络接口上的 Wi-Fi：

```bash
$ nmcli device wifi connect <SSID_或_BSSID> password <密码> ifname wlan1 <profile_name>
```

关闭 Wi-Fi：

```bash
$ nmcli radio wifi off
```

### 查看帮助

nmcli 命令有很多子命令，可通过如下方式查看命令及其子命令的帮助信息：

```bash
$ nmcli help
$ nmcli connection help
$ nmcli connection add help
```

