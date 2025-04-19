---
sidebar_label: timedatectl 命令
sidebar_position: 50
slug: /timedatectl
---

# Linux timedatectl 命令 - 时间日期控制



## 介绍

**timedatectl**（英文全拼：timedate control）命令用于在 Linux 中设置或查询系统时间、日期和时区等配置。在 Linux 运维中，通常使用此命令来设置或更改当前的日期、时间和时区，或启用自动系统时钟与远程 NTP 服务器同步，以确保 Linux 系统始终保持正确的时间。

systemd 是目前 Linux 系统上主要的系统守护进程管理工具，由于 init 一方面对于进程的管理是串行化的，容易出现阻塞情况，另一方面 init 也仅仅是执行启动脚本，并不能对服务本身进行更多的管理。所以许多 Linux 发行版都由 systemd 取代了 init 作为默认的系统进程管理工具。

systemd 所管理的所有系统资源都称作 Unit，通过 systemd 命令集可以方便的对这些 Unit 进行管理。比如 [systemctl](/linux-command/systemctl/)、hostnamectl、timedatectl、localctl 等命令，这些命令虽然改写了 init 时代用户的命令使用习惯（不再使用 chkconfig、service 等命令），但确实也提供了很大的便捷性。

从版本号 213 的 systemd 开始，包括了一个名为 **systemd-timesyncd** 的守护进程，将能够和远程的 NTP 服务器同步时间。此守护进程并不是为了取代已有的 NTP 服务，而是作为 SNTP 协议的实现客户端，它可用于更高级的任务和资源有限的系统。从版本号 216 的 systemd 开始，systemd-timesyncd 守护进程默认启用。

**语法**：

```shell
timedatectl [OPTIONS...] COMMAND ...
```

**命令**：

- `status` ：显示当前的时间设置。
- `show` ：显示 systemd-timedated 的属性。
- `set-time TIME` ：设置系统时间。
- `set-timezone ZONE` ：设置系统时区。
- `list-timezones` ：显示已知时区。
- `set-local-rtc BOOL` ：控制 RTC 是否在当地时间。（BOOL 的值可以是 1 / true 或 0 / false）
- `set-ntp BOOL` ：启用或禁用网络时间同步。（BOOL 的值可以是 1 / true 或 0 / false）
- `timesync-status` ：显示 systemd-timesyncd 的状态。
- `show-timesync` ：显示 systemd-timesyncd 的属性。

**选项**：

- `-h`, `--help` ：显示帮助信息。
- `--version` ：显示软件包版本。
- `--no-pager` ：不用将输出通过管道传输到寻呼机（pager）。
- `--no-ask-password` ：不提示输入密码。
- `-H`, `--host=[USER@]HOST` ：在远程主机上操作。
- `-M`, `--machine=CONTAINER` ：在本地容器上操作。
- `--adjust-system-clock` ：更改本地 RTC 模式时调整系统时钟。
- `--monitor` ：监控 systemd-timesyncd 的状态。
- `-p`, `--property=NAME` ：仅显示此名称的属性。
- `-a`, `--all` ：显示所有属性，包括空属性。
- `--value` ：显示属性时，只打印值。



## 示例

显示系统当前时间和日期

```shell
$ timedatectl status
               Local time: Tue 2021-09-14 16:02:41 CST
           Universal time: Tue 2021-09-14 08:02:41 UTC
                 RTC time: Tue 2021-09-14 16:02:35
                Time zone: Asia/Shanghai (CST, +0800)
System clock synchronized: yes
              NTP service: active
          RTC in local TZ: no
```

显示 systemd-timedated 的属性

```shell
$ timedatectl show
Timezone=Asia/Shanghai
LocalRTC=no
CanNTP=yes
NTP=yes
NTPSynchronized=yes
TimeUSec=Tue 2021-09-14 16:42:06 CST
RTCTimeUSec=Tue 2021-09-14 16:42:06 CST
```

显示系统所有可用的时区

```shell
$ timedatectl list-timezones
```

将本地时区从上海（Asia/Shanghai）设置为阿姆斯特丹（Europe/Amsterdam）

```shell
$ timedatectl set-timezone "Europe/Amsterdam"
```

将本地时区设置为协调世界时（UTC）

```shell
$ timedatectl set-timezone UTC
```

设置系统时间（格式：`HH:MM:SS`）

```shell
$ timedatectl set-time "07:25:46"
```

设置系统日期（格式：`YYYY-MM-DD`）

```shell
$ timedatectl set-time "2021-12-12"
```

如果只设置日期，那么时间将默认设置为 "00:00:00"（建议同时设置日期和时间）

```shell
$ timedatectl set-time "2021-12-12 07:25:46"
```

将硬件时钟（RTC）设置为本地时区（不建议，RTC 时钟统一使用 UTC 更恰当，避免在时区更改和夏令时调整方面产生各种问题）

```shell
$ timedatectl set-local-rtc 1
```

将硬件时钟（RTC）设置为协调世界时间（UTC）

```shell
$ timedatectl set-local-rtc 0
```

启用 NTP 自动时间同步

```shell
$ timedatectl set-ntp true
```

禁用 NTP 自动时间同步

```shell
$ timedatectl set-ntp false
```

查看 systemd-timesyncd 服务的状态

```shell
$ timedatectl timesync-status
       Server: 91.189.94.4 (ntp.ubuntu.com)
Poll interval: 17min 4s (min: 32s; max 34min 8s)
         Leap: normal
      Version: 4
      Stratum: 2
    Reference: 91EECB0E
    Precision: 1us (-23)
Root distance: 29.922ms (max: 5s)
       Offset: +2.497ms
        Delay: 199.540ms
       Jitter: 5.834ms
 Packet count: 6
    Frequency: +13.039ppm
```

systemd-timedated 可能默认配置了谷歌的 NTP 服务器（如 time1.google.com），为了顺利完成网络时间同步，您可以编辑 /etc/systemd/timesyncd.conf 文件添加自己的 NTP 服务器地址。

相关文章：[Linux 时间同步](/linux/linux-date-time-synchronization/)



