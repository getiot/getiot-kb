---
sidebar_position: 2
---

# Linux Chrony 时间同步

时间在 **Linux 服务器**中扮演着重要角色，特别是在银行、股票市场和其他金融领域。如果我们希望所有 Linux 服务器都拥有正确的时间，那么必须配置一个 **NTP 客户端**，它将始终从远程 NTP 服务器获取正确的时间，并在需要时进行必要的调整以同步时间。

本文介绍如何在 Linux 服务器上使用 Chrony（NTP 客户端）与 NTP 服务器同步时间。

## 什么是 Chrony

Chrony 是一个网络时间协议（NTP）的实现，用于同步系统时钟。与传统的 `ntp` 相比，Chrony 能够更快、更准确地同步系统时钟。从 RHEL 8/CentOS 8 开始，`ntp` 不再可用，已被 `chrony` 取代。

**Chrony 的主要特点**：

- 更快的同步速度
- 更高的时间精度
- 更好的网络条件适应能力
- 支持离线模式（即使断开网络也能继续工作）
- 更安全的认证机制

## 安装 Chrony

#### Debian/Ubuntu 系统

```bash
sudo apt update
sudo apt install -y chrony
```

#### RedHat/CentOS 系统

对于 CentOS 7 及更早版本：

```bash
sudo yum install -y chrony
```

对于 CentOS 8/RHEL 8 及更新版本：

```bash
sudo dnf install -y chrony
```

#### Fedora 系统

```bash
sudo dnf install -y chrony
```

#### 验证安装

安装完成后，Linux 系统会增加两个命令：

- **[chronyc](/linux-command/chronyc/)**：Chrony 的命令行界面，用于查询和控制 chronyd
- **[chronyd](/linux-command/chronyd/)**：Chrony 的守护进程，负责时间同步服务，可以在系统重启后自动启动

验证安装：

```bash
# 检查 chronyc 命令
chronyc --version

# 检查 chronyd 服务
systemctl status chronyd
```

## 配置 Chrony

Chrony 的配置文件在不同发行版上的位置略有不同，通常是 `/etc/chrony.conf` 或者 `/etc/chrony/chrony.conf`。

### 配置文件位置

```bash
# 查找配置文件位置
ls -l /etc/chrony.conf /etc/chrony/chrony.conf 2>/dev/null

# 或使用命令查找
chronyd -V | grep "config file"
```

### 配置文件示例

以下是 Ubuntu 系统的默认配置文件示例：

```ini showLineNumbers title="/etc/chrony/chrony.conf"
# Welcome to the chrony configuration file. See chrony.conf(5) for more
# information about usuable directives.

# This will use (up to):
# - 4 sources from ntp.ubuntu.com which some are ipv6 enabled
# - 2 sources from 2.ubuntu.pool.ntp.org which is ipv6 enabled as well
# - 1 source from [01].ubuntu.pool.ntp.org each (ipv4 only atm)
# This means by default, up to 6 dual-stack and up to 2 additional IPv4-only
# sources will be used.
# At the same time it retains some protection against one of the entries being
# down (compare to just using one of the lines). See (LP: #1754358) for the
# discussion.
#
# About using servers from the NTP Pool Project in general see (LP: #104525).
# Approved by Ubuntu Technical Board on 2011-02-08.
# See http://www.pool.ntp.org/join.html for more information.
pool ntp.ubuntu.com        iburst maxsources 4
pool 0.ubuntu.pool.ntp.org iburst maxsources 1
pool 1.ubuntu.pool.ntp.org iburst maxsources 1
pool 2.ubuntu.pool.ntp.org iburst maxsources 2

# This directive specify the location of the file containing ID/key pairs for
# NTP authentication.
keyfile /etc/chrony/chrony.keys

# This directive specify the file into which chronyd will store the rate
# information.
driftfile /var/lib/chrony/chrony.drift

# Uncomment the following line to turn logging on.
#log tracking measurements statistics

# Log files location.
logdir /var/log/chrony

# Stop bad estimates upsetting machine clock.
maxupdateskew 100.0

# This directive enables kernel synchronisation (every 11 minutes) of the
# real-time clock. Note that it can't be used along with the 'rtcfile' directive.
rtcsync

# Step the system clock instead of slewing it if the adjustment is larger than
# one second, but only in the first three clock updates.
makestep 1 3
```

### 配置参数说明

- **`pool ntp.ubuntu.com iburst maxsources 4`**：指定远程 NTP 服务器池，chrony 将从这里获取时间
  - `pool`：使用 NTP 服务器池（推荐）
  - `iburst`：启动时快速同步（发送多个请求）
  - `maxsources`：从该池中使用的最大源数量

- **`driftfile /var/lib/chrony/chrony.drift`**：漂移文件，包含系统时钟的漂移数据，用于在重启后快速恢复

- **`makestep 1.0 3`**：如果时间调整大于 1 秒，则步进系统时钟（快速调整），但仅在首次 3 次时钟更新时执行

- **`keyfile /etc/chrony/chrony.keys`**：NTP 认证密钥文件

- **`logdir /var/log/chrony`**：日志文件目录

- **`rtcsync`**：启用内核同步（每 11 分钟同步一次实时时钟）

- **`maxupdateskew 100.0`**：防止错误的时间估计影响系统时钟

### 配置中国大陆 NTP 服务器

在中国大陆，建议使用国内的 NTP 服务器以获得更好的同步效果：

```ini
# 使用阿里云 NTP 服务器
server ntp.aliyun.com iburst
server ntp1.aliyun.com iburst
server ntp2.aliyun.com iburst
server ntp3.aliyun.com iburst
server ntp4.aliyun.com iburst
server ntp5.aliyun.com iburst
server ntp6.aliyun.com iburst
server ntp7.aliyun.com iburst

# 或使用腾讯云 NTP 服务器
server ntp.tencent.com iburst

# 或使用中科院 NTP 服务器
server ntp.ntsc.ac.cn iburst
server cn.ntp.org.cn iburst

# 或使用教育网 NTP 服务器
server time.edu.cn iburst
```

编辑配置文件：

```bash
sudo nano /etc/chrony.conf
# 或
sudo nano /etc/chrony/chrony.conf
```

添加上述服务器配置后，保存并重启服务：

```bash
sudo systemctl restart chronyd
```

## 测试 Chrony

类似于 NTP 发行版中的 `ntpdate` 命令，我们可以使用 `chronyd` 手动将 Linux 服务器的时间与远程 NTP 服务器同步。

#### 语法

```bash
chronyd -q 'server {ntp_server_name} iburst'
```

#### 示例

```bash
# 查看当前时间
date

# 手动同步时间（使用欧洲 NTP 服务器）
sudo chronyd -q 'server 0.europe.pool.ntp.org iburst'

# 再次查看时间，应该已经同步
date
```

从上面的输出可以看到，chrony 已经纠正了系统时间。在运行 `chronyd` 命令之前，系统时间几乎比准确时间慢了 2 小时。

#### 使用国内服务器测试

```bash
# 使用阿里云 NTP 服务器测试
sudo chronyd -q 'server ntp.aliyun.com iburst'

# 使用腾讯云 NTP 服务器测试
sudo chronyd -q 'server ntp.tencent.com iburst'
```

## 启动 Chronyd 服务

运行以下命令启动并启用 chronyd 守护进程，以便在系统重启后自动启动：

```bash
# 启动服务
sudo systemctl start chronyd

# 设置开机自启
sudo systemctl enable chronyd
```

验证 chronyd 服务状态：

```bash
sudo systemctl status chronyd
```

#### 管理 Chronyd 服务

```bash
# 启动服务
sudo systemctl start chronyd

# 停止服务
sudo systemctl stop chronyd

# 重启服务
sudo systemctl restart chronyd

# 重新加载配置（不中断服务）
sudo systemctl reload chronyd

# 查看服务状态
sudo systemctl status chronyd

# 查看服务日志
sudo journalctl -u chronyd -f
```

## 验证时间同步

### 验证和跟踪 Chrony 同步状态

要验证系统时间是否已使用 chrony 同步，执行以下命令：

```bash
chronyc tracking
```

输出示例：

```bash
Reference ID    : 78197314 (120.25.115.20)
Stratum         : 3
Ref time (UTC)  : Wed Dec 14 07:14:30 2022
System time     : 0.000070560 seconds fast of NTP time
Last offset     : +0.000299871 seconds
RMS offset      : 0.007765118 seconds
Frequency       : 18.610 ppm fast
Residual freq   : +0.004 ppm
Skew            : 0.193 ppm
Root delay      : 0.009446586 seconds
Root dispersion : 0.006204020 seconds
Update interval : 1041.1 seconds
Leap status     : Normal
```

**输出字段说明**：

- **Reference ID**：当前系统时间同步的服务器 ID 和名称
- **Stratum**：层级，表示距离带有参考时钟的服务器有多少跳（hops）
  - Stratum 1：直接连接到参考时钟的服务器
  - Stratum 2：从 Stratum 1 服务器同步的服务器
  - 以此类推，数字越大，距离参考时钟越远
- **Ref time (UTC)**：参考时间的 UTC 时间
- **System time**：系统时间与 NTP 时间的差值
- **Last offset**：最后一次时间偏移量
- **RMS offset**：时间偏移的均方根值
- **Frequency**：系统时钟频率偏差
- **Leap status**：闰秒状态（Normal 表示正常）

### 检查 Chrony 时间源

要列出 chronyd 当前使用的时间源信息，运行以下命令：

```bash
chronyc sources
```

输出示例：

```bash
210 Number of sources = 7
MS Name/IP address         Stratum Poll Reach LastRx Last sample               
===============================================================================
^- prod-ntp-3.ntp4.ps5.cano>     2  10   137    68    -16ms[  -16ms] +/-  129ms
^? prod-ntp-4.ntp4.ps5.cano>     0   6     0     -     +0ns[   +0ns] +/-    0ns
^? prod-ntp-5.ntp4.ps5.cano>     0   6     0     -     +0ns[   +0ns] +/-    0ns
^- 139.199.214.202               2  10   377   697  -1328us[-1328us] +/-   35ms
^- time.neu.edu.cn               1  10   277   411  +2588us[+2588us] +/-   29ms
^- ntp1.flashdance.cx            2  10   375   452    +35ms[  +35ms] +/-  203ms
^* 120.25.115.20                 2  10   374   65m   +574us[ +874us] +/- 7174us
```

**状态符号说明**：

- `*`：当前正在使用的时间源（已同步）
- `+`：可接受的时间源（已组合）
- `-`：不可接受的时间源（未组合）
- `?`：无法访问的时间源
- `x`：时间可能错误
- `~`：时间变化太大

要查看更详细的时间源信息，运行：

```bash
chronyc sources -v
```

输出示例：

```bash
210 Number of sources = 7

  .-- Source mode  '^' = server, '=' = peer, '#' = local clock.
 / .- Source state '*' = current synced, '+' = combined , '-' = not combined,
| /   '?' = unreachable, 'x' = time may be in error, '~' = time too variable.
||                                                 .- xxxx [ yyyy ] +/- zzzz
||      Reachability register (octal) -.           |  xxxx = adjusted offset,
||      Log2(Polling interval) --.      |          |  yyyy = measured offset,
||                                \     |          |  zzzz = estimated error.
||                                 |    |           \
MS Name/IP address         Stratum Poll Reach LastRx Last sample               
===============================================================================
^- prod-ntp-3.ntp4.ps5.cano>     2  10   137    97    -16ms[  -16ms] +/-  129ms
^? prod-ntp-4.ntp4.ps5.cano>     0   6     0     -     +0ns[   +0ns] +/-    0ns
^? prod-ntp-5.ntp4.ps5.cano>     0   6     0     -     +0ns[   +0ns] +/-    0ns
^- 139.199.214.202               2  10   377   724  -1328us[-1328us] +/-   35ms
^- time.neu.edu.cn               1  10   277   438  +2588us[+2588us] +/-   29ms
^- ntp1.flashdance.cx            2  10   375   479    +35ms[  +35ms] +/-  203ms
^* 120.25.115.20                 2  10   374   65m   +574us[ +874us] +/- 7174us
```

### 检查 Chrony 时间源统计信息

要列出 chronyd 使用的每个时间源的漂移速度和偏移估计信息，运行：

```bash
chronyc sourcestats -v
```

### 其他有用的命令

```bash
# 强制立即同步
chronyc makestep

# 查看活动连接
chronyc activity

# 查看服务器列表
chronyc serverlist

# 查看客户端列表（如果配置为 NTP 服务器）
chronyc clients

# 手动添加时间源
chronyc add server ntp.example.com

# 删除时间源
chronyc delete server ntp.example.com
```

## 配置 Chrony 作为 NTP 服务器

假设你想将 Linux 服务器配置为 Chrony NTP 服务器，为所有内部系统提供时间同步服务。要实现这一点，我们需要在配置文件 `/etc/chrony.conf` 中取消注释两行：

- `local stratum 10`：将服务器配置为本地 NTP 服务器
- `allow 192.168.0.0/16`：允许指定网段的客户端连接

### 编辑配置文件

```bash
sudo vim /etc/chrony.conf
# 或
sudo vim /etc/chrony/chrony.conf
```

找到以下行并取消注释（删除 `#`）：

```ini
# 启用本地 NTP 服务器模式
local stratum 10

# 允许指定网段的客户端连接（根据实际网络修改）
allow 192.168.0.0/16
```

### 使用 sed 命令快速修改

```bash
# 取消注释 local stratum 10
sudo sed -i 's/^#local stratum 10/local stratum 10/' /etc/chrony.conf

# 取消注释 allow 配置（根据实际网络修改）
sudo sed -i 's/^#allow 192.168.0.0\/16/allow 192.168.0.0\/16/' /etc/chrony.conf
```

**配置说明**：

- **`local stratum 10`**：将 Linux 服务器配置为 chrony NTP 服务器，即使断开网络连接也能继续正常工作
- **`allow 192.168.0.0/16`**：允许来自该网段的客户端连接到我们的 Chrony NTP 服务器进行时间同步

### 重启服务并验证

修改配置后，重启 chrony 服务并跟踪同步状态：

```bash
# 重启服务
sudo systemctl restart chronyd

# 实时查看同步状态
watch chronyc tracking
```

### 配置防火墙

如果启用了防火墙，需要允许 NTP 服务：

**Ubuntu/Debian (ufw)**：

```bash
sudo ufw allow 123/udp
sudo ufw reload
```

**CentOS/RHEL/Fedora (firewalld)**：

```bash
sudo firewall-cmd --add-service=ntp --permanent
sudo firewall-cmd --reload
```

**iptables**：

```bash
sudo iptables -A INPUT -p udp --dport 123 -j ACCEPT
sudo iptables-save
```

### 客户端配置

其他 Linux 客户端可以配置为使用此 NTP 服务器：

```ini
# 在客户端的 /etc/chrony.conf 中添加
server your-ntp-server-ip iburst
```

## 常见问题排查

### 1. 时间同步失败

如果时间同步失败，可以尝试：

```bash
# 检查服务状态
sudo systemctl status chronyd

# 查看详细日志
sudo journalctl -u chronyd -n 50

# 检查网络连接
chronyc sources -v

# 强制同步
sudo chronyd -q 'server ntp.aliyun.com iburst'
```

### 2. 时间源不可达

如果所有时间源都显示 `?`（不可达），检查：

```bash
# 检查网络连接
ping ntp.aliyun.com

# 检查 DNS 解析
nslookup ntp.aliyun.com

# 检查防火墙规则
sudo iptables -L -n | grep 123
```

### 3. 时间偏差过大

如果时间偏差过大，可以：

```bash
# 强制步进调整（快速调整）
sudo chronyc makestep

# 或停止服务后手动设置时间
sudo systemctl stop chronyd
sudo date -s "2024-01-01 12:00:00"
sudo systemctl start chronyd
```

### 4. 验证时间同步

```bash
# 查看当前时间
date

# 查看同步状态
chronyc tracking

# 查看时间源
chronyc sources
```

## 总结

本文介绍了如何使用 Chrony 在 Linux 服务器上同步时间，包括：

1. **安装 Chrony**：在不同 Linux 发行版上安装 chrony
2. **配置 Chrony**：配置 NTP 服务器和时间同步参数
3. **测试和验证**：测试时间同步并验证同步状态
4. **服务管理**：启动、停止和管理 chrony 服务
5. **配置 NTP 服务器**：将服务器配置为 NTP 服务器供其他客户端使用

通过正确配置 Chrony，可以确保 Linux 服务器的时间始终准确，这对于需要精确时间的应用场景（如金融交易、日志分析等）非常重要。

## 参考

- [Chrony 官方文档](https://chrony.tuxfamily.org/documentation.html)
- [Chrony 配置文件手册](https://chrony.tuxfamily.org/doc/4.3/chrony.conf.html)
- [NTP Pool Project](https://www.ntppool.org/)
- [阿里云 NTP 服务器](https://help.aliyun.com/document_detail/92704.html)
