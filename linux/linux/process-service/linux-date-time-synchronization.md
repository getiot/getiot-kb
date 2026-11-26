---
sidebar_position: 8
sidebar_label: 时间同步
slug: /linux-date-time-synchronization
authors: [luhuadong]
---

# Linux 时间同步



无论是 Linux 服务器还是嵌入式设备，只要有网络连接需求，都需要保持时间同步。对许多应用场景来说，时间的准确性都至关重要，例如数据采集上报、订单信息提交、即时通讯等等。

Linux 系统为我们提供了一些与时间同步相关的服务和命令，下面将一一介绍。



## NTP 服务

NTP 是网络时间协议（Network Time Protocol）的简称，主要用于网络时间的同步，诞生于 20 世纪 80 年代，至今仍是互联网的基础性协议之一，使用 UDP 123 端口。

NTP 基于客户端（client）和服务器（server）架构，客户端发出包含客户端发出时间的数据包，服务器收到数据包并回复，回复的数据包中附加了服务器收到和发出数据包的时间。客户端收到回复后便获知自己与服务器的时间差，以及网络延迟时间，并据此调整自己的系统时间，达到时间同步的目的。

![](https://static.getiot.tech/ntp_synchronize.gif#center)

在 Linux 系统中，ntpq 命令可用于查询网络中连接的 NTP 服务器，例如：

```bash
$ sudo ntpq -pn
     remote           refid      st t when poll reach   delay   offset  jitter
==============================================================================
 127.127.1.0     .LOCL.          10 l    -   64    0    0.000    0.000   0.000
*120.25.115.20   10.137.53.7      2 u  850 1024  377    1.288    0.108   0.280
```

行首加 `*` 号的是当前服务器。同时还列出了网络延迟时间（delay）、与服务器的时间差（offset）等关键的 NTP 时间数据。

如果时间不对，可以执行下面命令强制同步 NTP 时间：

```bash
$ sudo service ntp stop
$ sudo ntpd -gq
$ sudo service ntp start
```



## systemd-timesyncd

systemd-timesyncd 是一个用于跨网络同步系统时钟的守护服务，它实现了一个 SNTP 客户端。与 NTP 的复杂实现相比，这个服务简单的多，它只专注于从远程服务器查询然后同步到本地时钟。除非你打算为客户端提供 NTP 服务器或者连接本地硬件时钟，否则这个简单的 NTP 客户端应该更适合大多数设备。

systemd-timesyncd 守护进程运行只需要很少的特权，并且会跟网络服务 networkd 挂钩，仅在网络连接可用时才工作。每次收到一个新的 NTP 同步请求时，后台服务就把当前时间保存到磁盘，并尽可能在系统启动时修正系统时间，这样处理的目的是为了适应像 Raspberry Pi 这种缺少 RTC 的嵌入式设备。

如果要使用这个守护进程，需要在安装系统时创建一个新的系统用户和组"systemd-timesync"。有了这个守护进程之后，就可以使用 systemd 服务的方式启用或禁用时间同步功能。

```bash
$ sudo systemctl start systemd-timesyncd
$ sudo systemctl stop systemd-timesyncd
```

检查 systemd-timesyncd 服务的状态

```bash
$ systemctl status systemd-timesyncd
● systemd-timesyncd.service - Network Time Synchronization
     Loaded: loaded (/lib/systemd/system/systemd-timesyncd.service; enabled; vendor preset: enabled)
     Active: active (running) since Wed 2021-09-15 08:56:10 CST; 26min ago
       Docs: man:systemd-timesyncd.service(8)
   Main PID: 805 (systemd-timesyn)
     Status: "Initial synchronization to time server 91.189.94.4:123 (ntp.ubuntu.com)."
      Tasks: 2 (limit: 9171)
     Memory: 1.3M
     CGroup: /system.slice/systemd-timesyncd.service
             └─805 /lib/systemd/systemd-timesyncd

9月 15 08:56:10 pocket-ubuntu systemd[1]: Starting Network Time Synchronization...
9月 15 08:56:10 pocket-ubuntu systemd[1]: Started Network Time Synchronization.
9月 15 08:56:41 pocket-ubuntu systemd-timesyncd[805]: Initial synchronization to time server 91.189.94.4:123 (ntp.ubuntu.com).
```

如果此服务已启用并处于活动状态，那么系统时钟应与互联网时间服务器同步。

### 配置

systemd-timesyncd 启动时会读取 /etc/systemd/timesyncd.conf 配置文件，内容如下：

```ini showLineNumbers
[Time]
#NTP=
#FallbackNTP=ntp.ubuntu.com
#RootDistanceMaxSec=5
#PollIntervalMinSec=32
#PollIntervalMaxSec=2048
```

默认虽然上面的选项都处于注释状态，但是 systemd-timesyncd 还是会去默认的 NTP 服务器进行同步，如果要更改 NTP 服务器请修改上面的选项。各选项说明如下：

- `NTP` ：一个以空格分隔的 NTP 服务器列表，可以使用主机名，也可以使用 IP 地址。在运行时，此处设置的列表将与 systemd-networkd.service 中已配置的 NTP 服务器列表合并在一起。systemd-timesyncd 将会依次尝试列表中的每个 NTP 服务器，直到同步成功为止。如果为此选项设置一个空字符串，则表示清空所有此选项先前已设置的 NTP 服务器列表（此选项的默认值为空）。
- `FallbackNTP` ：一个以空格分隔的 NTP 服务器列表，用作备用 NTP 服务器。 可以使用主机名，也可以使用 IP 地址。如果所有已配置在 systemd-networkd.service 中的 NTP 服务器以及上述 `NTP` 选项中设置的 NTP 服务器都尝试失败，那么将尝试此处设置的备用 NTP 服务器。 如果为此选项设置一个空字符串，则表示清空所有此选项先前已设置的 NTP 服务器列表。若未设置此选项，则使用编译时设置的默认备用 NTP 服务器。
- `RootDistanceMaxSec` ：最大可接受的 "root distance" 秒数（最大误差），默认值为 5 秒。
- `PollIntervalMinSec` 和 `PollIntervalMaxSec` ：NTP 消息的最小/最大轮询间隔秒数。其中，`PollIntervalMinSec` 必须不小于 16 秒，`PollIntervalMaxSec` 必须大于 `PollIntervalMinSec`。`PollIntervalMinSec` 默认为 32 秒，`PollIntervalMaxSec` 默认为 2048 秒。

例如，我们可以设置成国内的 NTP 服务器（比如：*ntp.ntsc.ac.cn* 或 *cn.ntp.org.cn*），其他选项可配置也可不配置。

```ini showLineNumbers
[Time]
NTP=ntp.ntsc.ac.cn cn.ntp.org.cn
FallbackNTP=ntp.ubuntu.com time1.google.com time2.google.com
RootDistanceMaxSec=5
PollIntervalMinSec=32
PollIntervalMaxSec=2048
```

然后重启 systemd-timesyncd 服务使配置生效

```bash
$ sudo systemctl restart systemd-timesyncd
```

再次查看服务状态并同步时间

```bash
$ systemctl status systemd-timesyncd
* systemd-timesyncd.service - Network Time Synchronization
   Loaded: loaded (/lib/systemd/system/systemd-timesyncd.service; enabled; vendor preset: enabled)
   Active: active (running) since Wed 2021-09-15 10:04:17 CST; 5min ago
     Docs: man:systemd-timesyncd.service(8)
 Main PID: 950 (systemd-timesyn)
   Status: "Synchronized to time server for the first time 114.118.7.163:123 (ntp.ntsc.ac.cn)."
    Tasks: 2
   Memory: 1.1M
   CGroup: /system.slice/systemd-timesyncd.service
           `-950 /lib/systemd/systemd-timesyncd

Sep 15 10:04:17 imx8mqevk systemd[1]: Starting Network Time Synchronization...
Sep 15 10:04:17 imx8mqevk systemd[1]: Started Network Time Synchronization.
Sep 15 10:04:17 imx8mqevk systemd-timesyncd[950]: Synchronized to time server for the first time 114.118.7.163:123 (ntp.ntsc.ac.cn).
```

### timedatectl

另外，也可以通过 timedatectl 命令启用自动网络时间同步

```bash
$ sudo timedatectl set-ntp true
$ sudo timedatectl set-ntp false
```

注意：如果需要手动修改时间则必须将该项设置为 false，否则时间设置不会生效。

查看同步服务状态

```bash
$ timedatectl status
               Local time: Wed 2021-09-15 10:10:47 CST
           Universal time: Wed 2021-09-15 02:10:47 UTC
                 RTC time: Wed 2021-09-15 02:10:48
                Time zone: Asia/Shanghai (CST, +0800)
System clock synchronized: yes
              NTP service: active
          RTC in local TZ: no
```

查看更多的服务信息

```bash
$ timedatectl timesync-status
       Server: 114.118.7.163 (ntp.ntsc.ac.cn)
Poll interval: 4min 16s (min: 32s; max 34min 8s)
         Leap: normal
      Version: 4
      Stratum: 2
    Reference: 7B8B2103
    Precision: 1us (-22)
Root distance: 93.177ms (max: 5s)
       Offset: -6.153ms
        Delay: 44.133ms
       Jitter: 9.516ms
 Packet count: 3
    Frequency: +30.738ppm
```

更多设置请参考 [timedatectl 命令使用](/linux-command/timedatectl/)。



## date

除了使用 NTP 同步网络时间，在 Linux 系统上，我们还可以通过 date 命令手动调整系统时间。例如：

```bash
$ sudo date -s "2021-12-01 00:00:00"
```

更多设置请参考 [date 命令使用](/linux-command/date/)。



## hwclock

前面同步的时间其实都是系统时间，如果想同步更新到硬件 RTC，可以通过 hwclock 命令来回写。例如：

```bash
$ sudo hwclock --systohc
```

为了保证硬件时钟的准确性，通常会定期更新 RTC 时间，例如设定 cron 周期任务。

更多设置请参考 [hwclock 命令使用](/linux-command/hwclock/)。



## Q&A

### 时间服务器同步的频率是多少？

答：在 /etc/systemd/timesyncd.conf 配置文件中，有 `PollIntervalMinSec` 和 `PollIntervalMaxSec` 两个选项，用于设置轮询 NTP 服务器的周期。

```ini showLineNumbers
PollIntervalMinSec=32
PollIntervalMaxSec=2048
```

默认值为 32 和 2048，意味着 systemd-timesyncd 服务将在最短32秒，最长2048秒内轮询一次 NTP 服务器（例如 *ntp.ubuntu.com* 服务器池）。如果客户端不同步（多少取决于在默认情况下如何考虑漂移差异），它将尝试与服务器同步。如果服务器无法访问，则轮询周期将继续，并且很可能遵循常规的 NTP 指数补偿算法，直到达到 2048 秒的“最大轮询间隔”。


