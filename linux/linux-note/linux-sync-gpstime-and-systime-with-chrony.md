---
sidebar_position: 11
---

# Linux 使用 Chrony 同步 GPS 时间



## PPS

执行 `ppsfind --help` 命令查找 PPS 设备

```bash
$ ppsfind --help
pps0: name=ktimer path=
pps1: name=pps-gpio.-1 path=/dev/ttyUSB0
```



执行 `dmesg | grep pps1`

```bash
[40849.411612] pps pps1: PPS event at 1673578229.099377717
[40849.411638] pps pps1: capture assert seq #2979
```



测试 PPS 功能

```bash
sudo ppswatch /dev/pps0
trying PPS source "/dev/pps0"
found PPS source "/dev/pps0"
timestamp: 1577777203, sequence: 83886, offset:   1984
timestamp: 1577777204, sequence: 83887, offset: -31306
timestamp: 1577777205, sequence: 83888, offset:   5836
timestamp: 1577777206, sequence: 83889, offset:   3027
timestamp: 1577777207, sequence: 83890, offset: -24220
timestamp: 1577777208, sequence: 83891, offset:   2041
```



## GPSD

```bash
gpsd -b -n -N -D3 /dev/ttyUSB0 /dev/pps0
```



```bash
gpsd -D 5 -N -n /dev/ttyUSB0 /dev/pps0
```





## Chrony

启动 Chronyd 服务

```bash
chronyd -f /etc/chrony.conf
```

chrony.conf 配置文件内容如下，包含 NTP Server、PPS、GPS 解析数据

```bash showLineNumbers title="/etc/chrony.conf"
# Use public NTP servers from the pool.ntp.org project
pool 0.ubuntu.pool.ntp.org iburst maxsources 3
# pool 0.openembedded.pool.ntp.org iburst maxsources 3

# Sync the start of the second based on the 1PPS signal
refclock PPS /dev/pps1 refid KPPS trust lock GNSS maxdispersion 3 poll 2

# Provide GNSS time samples using the SOCK interface
refclock SOCK /var/run/chrony.sock refid GNSS maxdispersion 0.2 noselect

refclock SHM 0 refid GPS precision 1e-1 offset 0.9999 delay 0.2

# Step the system clock instead of slew if the adjustment is larger than 0.1 second.
makestep 0.1 -1

# Serve time even if not synchronized to any NTP server.
local stratum 10

# Allow NTP client access from local network.
allow all
```



```bash
#若系统时间与基准时间相差大于0.1s，直接跳变系统时间，仅限前3个时钟周期
makestep 0.1 3
#允许系统时间同步rtc时间，Linux每11min同步一次
rtcsync
#允许设备作为时间同步服务器
allow
#瑞秒相关设置
leapsectz right/UTC
#指定var/lib/chrony/drift存储时间补偿增减率，每次开机增减率有效前使用存储值
driftfile /var/lib/chrony/drift
#指定测量历史记录存储目录，测量历史用于计算补偿增减率。启动读取后删除
dumpdir /var/run/chrony

#指定硬件PPS为优先时间源
refclock PPS /dev/pps0 refid PPS lock GPSD prefer precision 1e-7 poll 2
#指定硬件GPS为时间源
refclock SHM 0 refid GPSD precision 1e-1 offset 0.9999 delay 0.2 poll 2
```



chrony 将根据各时间系统准确度选择最准确的时间。

查看 chronyc 查看时间同步状态

```bash
chronyc tracking
```



```bash
chronyc sources
chronyc sources -v
```



```bash
chronyc -m 'sources -v' tracking 'sourcestats -v'
```



可以看到已经将系统时间同步到 GNSS 时间



```bash
date
```





