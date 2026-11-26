---
sidebar_position: 7
sidebar_label: 定时任务管理
slug: /linux-cron-table
authors: [luhuadong]
---

# Linux 定时任务管理



cron 是 Linux 系统中常用的任务规划软件，cron 是一个守护进程，用户可以通过 crontab 命令要求系统在特定的时间执行特定的任务。适用于需要周期性自动化执行的工作。



## 定时喂狗

在一些设备中，由于下位机（例如 STM32）可能实现了对上位机（例如 i.MX8）的看门狗监控功能，若长期无通信反馈，则会重启 Linux 系统。因此，Linux 系统需要进行喂狗，将喂狗任务添加到 cron 定时任务是一个不错的主意！

编辑 cron 任务规划列表：

```bash
crontab -e
```

添加一行任务：

```bash showLineNumbers
* * * * *    echo 1 > /dev/dev_reboot
```

表示每分钟往 /dev/dev_reboot 设备节点写一次数据。



## 定时清缓存

假设有脚本 /opt/recycle_service.sh，内容如下：

```bash showLineNumbers
#!/bin/sh
sync
echo 1 > /proc/sys/vm/drop_caches
echo 2 > /proc/sys/vm/drop_caches
echo 3 > /proc/sys/vm/drop_caches
```

编辑 cron 任务规划列表，添加一行任务，每隔 5 个小时清理一次缓存。

```bash showLineNumbers
0 */5 * * *    /usr/recycle_service.sh
```



## 定时同步时间

K37X 作为一款数采仪，时间的准确性十分重要，因此可以设置一个定时任务，每小时的第 30 分钟同步一次网络时间。

```bash showLineNumbers
30 * * * *    /usr/bin/ntpdate-sync silent
```



## 定时校准 RTC

有时候，RTC 可能因为电池电压过低等原因无法保证实时时钟的正确性，因此定期校准 RTC 时间是个好习惯。例如，设置每天 0 点到 23 点，每隔 12 小时回写一次 RTC 时间。

```bash showLineNumbers
00 0-23/12 * * * /sbin/hwclock --utc --systohc
```
