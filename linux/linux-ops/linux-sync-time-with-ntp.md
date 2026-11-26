---
sidebar_position: 1
---

# Linux NTP 时间同步

时间在 Linux 服务器中扮演着重要角色，特别是在银行、股票市场和其他金融领域。如果我们希望所有 Linux 服务器都拥有正确的时间，那么必须配置一个 **NTP 客户端**，它将始终从远程 NTP 服务器获取正确的时间，并在需要时进行必要的调整以同步时间。

本文介绍如何在 Linux 服务器上使用传统的 NTP（Network Time Protocol）服务与 NTP 服务器同步时间。

## 什么是 NTP

NTP（Network Time Protocol）是网络时间协议，用于同步计算机系统时钟。NTP 是 Linux 系统中传统的时间同步解决方案，在较旧的系统版本中广泛使用。

**NTP 的主要特点**：

- 成熟稳定，经过长期验证
- 支持多种时间源
- 提供高精度的时间同步
- 支持层级（Stratum）结构
- 支持认证机制

**注意**：从 RHEL 8/CentOS 8 开始，传统的 `ntp` 包已被 `chrony` 取代。如果你使用的是较新的系统，建议使用 [Chrony 时间同步](./linux-sync-time-with-chrony.md)。本文主要适用于 CentOS 7/RHEL 7 及更早版本的系统。

## 安装 NTP

#### Debian/Ubuntu 系统

```bash
sudo apt update
sudo apt install -y ntp
```

#### RedHat/CentOS 系统

对于 CentOS 7 及更早版本：

```bash
sudo yum install -y ntp
```

**注意**：CentOS 8/RHEL 8 及更新版本不再提供 `ntp` 包，请使用 `chrony`。

#### Fedora 系统

```bash
sudo dnf install -y ntp
```

#### 验证安装

安装完成后，Linux 系统会增加以下命令和服务：

- **ntpdate**：用于手动同步时间的命令
- **ntpq**：NTP 查询程序，用于查询 NTP 服务器状态
- **ntpd**：NTP 守护进程，负责时间同步服务

验证安装：

```bash
# 检查 ntpdate 命令
ntpdate -v

# 检查 ntpd 服务
systemctl status ntpd
# 或
service ntpd status
```

## 配置 NTP

NTP 的配置文件通常是 `/etc/ntp.conf`。

### 配置文件位置

```bash
# 查找配置文件位置
ls -l /etc/ntp.conf

# 查看配置文件内容
cat /etc/ntp.conf
```

### 配置文件示例

以下是 CentOS 7 系统的默认配置文件示例：

```ini showLineNumbers title="/etc/ntp.conf"
# For more information about this file, see the man pages
# ntp.conf(5), ntp_acc(5), ntp_auth(5), ntp_clock(5), ntp_misc(5), ntp_mon(5).

driftfile /var/lib/ntp/drift

# Permit time synchronization with our time source, but do not
# permit the source to query or modify the service on this system.
restrict default nomodify notrap nopeer noquery

# Permit all access over the loopback interface.  This could
# be tightened as well, but to do so would effect some of
# the administrative functions.
restrict 127.0.0.1
restrict ::1

# Hosts on local network are less restricted.
#restrict 192.168.1.0 mask 255.255.255.0 nomodify notrap

# Use public servers from the pool.ntp.org project.
# Please consider joining the pool (http://www.pool.ntp.org/join.html).
server 0.centos.pool.ntp.org iburst
server 1.centos.pool.ntp.org iburst
server 2.centos.pool.ntp.org iburst
server 3.centos.pool.ntp.org iburst

# Ignore stratum 0 sources
fudge 127.127.1.0 stratum 10

# Enable public key cryptography.
#crypto

includefile /etc/ntp/crypto/pw

# Key file containing the keys and key identifiers used when operating
# with symmetric key cryptography.
keys /etc/ntp/keys

# Specify the key identifiers which are trusted.
#trustedkey 4 8 42

# Specify the key identifier to use with the ntpdc utility.
#requestkey 8

# Specify the key identifier to use with the ntpq utility.
#controlkey 8

# Enable writing of statistics records.
#statistics clockstats cryptostats loopstats peerstats
```

### 配置参数说明

- **`driftfile /var/lib/ntp/drift`**：漂移文件，记录系统时钟的漂移率，用于在重启后快速恢复

- **`restrict default nomodify notrap nopeer noquery`**：默认访问限制
  - `nomodify`：不允许修改配置
  - `notrap`：不允许 trap 查询
  - `nopeer`：不允许对等体连接
  - `noquery`：不允许查询

- **`restrict 127.0.0.1`**：允许本地回环接口的访问

- **`server 0.centos.pool.ntp.org iburst`**：指定 NTP 服务器
  - `iburst`：启动时快速同步（发送多个请求）

- **`fudge 127.127.1.0 stratum 10`**：配置本地时钟作为备用时间源，层级为 10

### 配置中国大陆 NTP 服务器

在中国大陆，建议使用国内的 NTP 服务器以获得更好的同步效果。编辑配置文件：

```bash
sudo vim /etc/ntp.conf
```

添加或修改服务器配置：

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

保存后重启服务：

```bash
sudo systemctl restart ntpd
# 或
sudo service ntpd restart
```

## 测试 NTP

类似于 `ntpdate` 命令，我们可以手动将 Linux 服务器的时间与远程 NTP 服务器同步。

#### 语法

```bash
ntpdate -q {ntp_server_name}
```

或强制同步：

```bash
ntpdate -s {ntp_server_name}
```

#### 示例

```bash
# 查看当前时间
date

# 查询 NTP 服务器时间（不修改系统时间）
ntpdate -q ntp.aliyun.com

# 手动同步时间（使用阿里云 NTP 服务器）
sudo ntpdate -s ntp.aliyun.com

# 再次查看时间，应该已经同步
date
```

**注意**：如果 `ntpd` 服务正在运行，`ntpdate` 命令可能会失败。需要先停止 `ntpd` 服务：

```bash
# 停止 ntpd 服务
sudo systemctl stop ntpd

# 手动同步时间
sudo ntpdate -s ntp.aliyun.com

# 启动 ntpd 服务
sudo systemctl start ntpd
```

#### 使用国内服务器测试

```bash
# 使用阿里云 NTP 服务器测试
sudo ntpdate -q ntp.aliyun.com

# 使用腾讯云 NTP 服务器测试
sudo ntpdate -q ntp.tencent.com

# 使用中科院 NTP 服务器测试
sudo ntpdate -q ntp.ntsc.ac.cn
```

## 启动 NTP 服务

运行以下命令启动并启用 ntpd 守护进程，以便在系统重启后自动启动：

```bash
# 启动服务
sudo systemctl start ntpd

# 设置开机自启
sudo systemctl enable ntpd
```

对于使用 `service` 命令的系统：

```bash
# 启动服务
sudo service ntpd start

# 设置开机自启
sudo chkconfig ntpd on
```

验证 ntpd 服务状态：

```bash
sudo systemctl status ntpd
# 或
sudo service ntpd status
```

#### 管理 NTP 服务

```bash
# 启动服务
sudo systemctl start ntpd
# 或
sudo service ntpd start

# 停止服务
sudo systemctl stop ntpd
# 或
sudo service ntpd stop

# 重启服务
sudo systemctl restart ntpd
# 或
sudo service ntpd restart

# 重新加载配置（不中断服务）
sudo systemctl reload ntpd

# 查看服务状态
sudo systemctl status ntpd
# 或
sudo service ntpd status

# 查看服务日志
sudo journalctl -u ntpd -f
# 或
sudo tail -f /var/log/messages
```

## 验证时间同步

### 验证和跟踪 NTP 同步状态

要验证系统时间是否已使用 NTP 同步，可以使用 `ntpq` 命令：

```bash
ntpq -p
```

输出示例：

```bash
     remote           refid      st t when poll reach   delay   offset  jitter
==============================================================================
*120.25.115.20    .INIT.          16 u    -   64    0    0.000    0.000   0.000
+ntp.aliyun.com   120.25.115.20    2 u   45   64  377    0.035    0.001   0.002
+ntp1.aliyun.com  120.25.115.20    2 u   44   64  377    0.032    0.002   0.003
```

**输出字段说明**：

- **remote**：NTP 服务器的地址或主机名
- **refid**：参考 ID，显示该服务器同步的时间源
- **st**：Stratum（层级），表示距离参考时钟的跳数
  - Stratum 1：直接连接到参考时钟的服务器
  - Stratum 2：从 Stratum 1 服务器同步的服务器
  - 以此类推，数字越大，距离参考时钟越远
- **t**：类型（u=unicast, b=broadcast, l=local）
- **when**：距离上次查询的时间（秒）
- **poll**：轮询间隔（秒，以 2 的幂表示）
- **reach**：可达性寄存器（八进制），显示最近 8 次查询的成功情况
- **delay**：网络延迟（毫秒）
- **offset**：时间偏移量（毫秒）
- **jitter**：时间抖动（毫秒）

**状态符号说明**：

- `*`：当前正在使用的时间源（已同步）
- `+`：可接受的时间源（已组合）
- `-`：不可接受的时间源（未组合）
- `?`：无法访问的时间源
- `x`：时间可能错误
- `~`：时间变化太大

### 查看详细同步信息

```bash
# 查看详细的同步信息
ntpq -c "rv"

# 查看系统变量
ntpq -c "sysinfo"

# 查看关联信息
ntpq -c "associations"
```

### 使用 ntpstat 命令

如果系统安装了 `ntpstat` 工具，可以使用它查看同步状态：

```bash
# 安装 ntpstat（如果未安装）
sudo yum install -y ntpstat
# 或
sudo apt install -y ntpstat

# 查看同步状态
ntpstat
```

输出示例：

```
synchronised to NTP server (120.25.115.20) at stratum 2
   time correct to within 2 ms
   polling server every 64 s
```

### 检查时间同步状态

```bash
# 查看当前时间
date

# 查看系统时钟同步状态
timedatectl status

# 查看 NTP 服务器状态
ntpq -p
```

## 配置 NTP 作为时间服务器

默认情况下，安装的 NTP 服务只作为客户端使用，不会为其他客户端提供时间服务。只有在需要将服务器配置为内部 NTP 时间服务器时，才需要进行以下配置。大多数用户只需要配置客户端功能即可。

如果你需要将 Linux 服务器配置为 NTP 时间服务器，为内部系统提供时间同步服务，可以按以下步骤配置：

#### 编辑配置文件

```bash
sudo vim /etc/ntp.conf
```

#### 允许客户端访问

在配置文件中添加或修改 `restrict` 配置，允许指定网段的客户端访问：

```ini
# 允许本地网络访问（根据实际网络修改）
restrict 192.168.0.0 mask 255.255.0.0 nomodify notrap
```

#### 重启服务

```bash
sudo systemctl restart ntpd
```

#### 配置防火墙

如果启用了防火墙，需要允许 NTP 服务（UDP 端口 123）：

```bash
# Ubuntu/Debian (ufw)
sudo ufw allow 123/udp
sudo ufw reload

# CentOS/RHEL/Fedora (firewalld)
sudo firewall-cmd --add-service=ntp --permanent
sudo firewall-cmd --reload
```

## 常见问题排查

### 1. 时间同步失败

如果时间同步失败，可以尝试：

```bash
# 检查服务状态
sudo systemctl status ntpd

# 查看详细日志
sudo journalctl -u ntpd -n 50
# 或
sudo tail -n 50 /var/log/messages

# 检查网络连接
ping ntp.aliyun.com

# 检查 NTP 服务器状态
ntpq -p

# 停止服务后手动同步
sudo systemctl stop ntpd
sudo ntpdate -s ntp.aliyun.com
sudo systemctl start ntpd
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

# 检查 NTP 端口是否开放
sudo netstat -tulpn | grep 123
```

### 3. 时间偏差过大

如果时间偏差过大，可以：

```bash
# 停止服务
sudo systemctl stop ntpd

# 手动设置时间
sudo date -s "2024-01-01 12:00:00"

# 手动同步时间
sudo ntpdate -s ntp.aliyun.com

# 启动服务
sudo systemctl start ntpd
```

### 4. 服务无法启动

如果 `ntpd` 服务无法启动：

```bash
# 检查配置文件语法
ntpd -t

# 查看详细错误信息
sudo journalctl -u ntpd -n 100

# 检查端口是否被占用
sudo netstat -tulpn | grep 123

# 检查权限
ls -l /var/lib/ntp/
```

### 5. 验证时间同步

```bash
# 查看当前时间
date

# 查看同步状态
ntpq -p

# 查看系统时钟状态
timedatectl status

# 使用 ntpstat（如果已安装）
ntpstat
```

## NTP vs Chrony

虽然 NTP 是传统的时间同步解决方案，但在新版本系统中，Chrony 已经取代了 NTP。以下是两者的对比：

| 特性 | NTP | Chrony |
|:----:|:---:|:------:|
| **同步速度** | 较慢 | 更快 |
| **时间精度** | 高 | 更高 |
| **网络适应** | 一般 | 更好 |
| **离线模式** | 不支持 | 支持 |
| **系统支持** | 旧版本系统 | 新版本系统（RHEL 8+） |

**建议**：
- **CentOS 7/RHEL 7 及更早版本**：可以使用 NTP
- **CentOS 8/RHEL 8 及更新版本**：建议使用 [Chrony](./linux-sync-time-with-chrony.md)

## 总结

本文介绍了如何使用传统的 NTP 服务在 Linux 服务器上同步时间，包括：

1. **安装 NTP**：在不同 Linux 发行版上安装 ntp
2. **配置 NTP**：配置 NTP 服务器和时间同步参数
3. **测试和验证**：测试时间同步并验证同步状态
4. **服务管理**：启动、停止和管理 ntpd 服务

通过正确配置 NTP，可以确保 Linux 服务器的时间始终准确，这对于需要精确时间的应用场景（如金融交易、日志分析等）非常重要。

**注意**：如果你使用的是较新的系统（RHEL 8/CentOS 8 及以上），建议使用 Chrony 而不是 NTP，因为 Chrony 提供了更好的性能和功能。

