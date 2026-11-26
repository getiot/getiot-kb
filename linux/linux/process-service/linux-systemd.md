---
sidebar_position: 5
sidebar_label: systemd 系统服务管理
slug: /linux-systemd
authors: [luhuadong]
---

# Linux systemd 系统服务管理



## Systemd 介绍

Systemd 是目前 Linux 系统上主要的系统守护进程管理工具，由于 init 一方面对于进程的管理是串行化的，容易出现阻塞情况，另一方面 init 也仅仅是执行启动脚本，并不能对服务本身进行更多的管理。所以许多 Linux 发行版都由 systemd 取代了 init 作为默认的系统进程管理工具。



## 设置开机自动执行

假设需要在系统开机时自动运行一个基于 Qt 图形界面的应用程序，那么可以在 /etc/systemd/system 目录添加一个 autorun.service 文件，内容如下：

```ini showLineNumbers
[Unit]
Description=Test Qt Application
After=multi-user.target local-fs.target weston.service

[Service]
User=root
Restart=no
Type=simple
EnvironmentFile=/opt/root_env
ExecStart=/opt/autorun.sh
StandardOutput=console

[Install]
WantedBy=multi-user.target weston.service
```

/opt/root_env 包含一系列环境变量（包括 Qt 的一些配置），该文件可由 env 命令生成。

```bash
env > /opt/root_env
```

执行脚本 /opt/autorun.sh 的内容如下，其中 /opt/mainwindow 是一个 Qt 自带的 example 程序。

```bash showLineNumbers
#!/bin/sh

# Run a simple Qt application
/opt/mainwindow
```

准备好上述几个文件后，即可执行下面命令将其加入 systemd 系统管理。

```bash
systemctl enable autorun.service
```

重启系统，mainwindow 程序就会自动运行。



## 设置关机自动执行

既然可以设置开机自动执行，那能不能设置关机自动执行呢？例如在关机之前记录当前的时间，以便下次启动时能获知上次关机时间。

为了达到这个目的，可以在 /etc/systemd/system 目录添加一个 before-shutdown.service 文件，内容如下：

```ini showLineNumbers
[Unit]
Description=Do something before shutdown
After=getty@tty1.service display-manager.service plymouth-start.service
Before=systemd-poweroff.service systemd-reboot.service systemd-halt.service
DefaultDependencies=no

[Service]
ExecStart=/opt/shutdown.sh
Type=forking

[Install]
WantedBy=poweroff.target
WantedBy=reboot.target
WantedBy=halt.target
```

执行脚本 /opt/shutdown.sh 的内容如下，其实就是将 date 命令获取的时间写入一个文件里面。

```bash showLineNumbers
#!/bin/bash

# record shutdown time
echo `date +"%Y-%m-%d %H:%M:%S"` > /home/root/shutdown_time
```

将 before-shutdown 服务加入 systemd 系统管理。

```bash
systemctl enable before-shutdown.service
```

这样，当系统关机（包括 poweroff、reboot 或 halt）的时候，就会先执行 /opt/shutdown.sh 脚本，记录系统时间。
