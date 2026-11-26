---
sidebar_position: 3
---

# TDengine 快速上手



前面 [TDengine 安装](/tdengine/tdengine-installation/) 介绍了 3 种安装 TDengine 的方式。安装成功后，我们就可以使用 TDengine 时序数据库了，本文主要介绍 TDengine 服务端和客户端程序的使用，并通过一个简单的案例来体验 TDengine 的基本功能。



## 启动服务器

在 Linux 系统中，我们可使用 [systemctl](/linux-command/systemctl/) 命令来启动 TDengine 的服务进程。

首先查看一下 TDengine 服务的状态：

```bash
sudo systemctl status taosd
```

如果服务未启动，可以执行下面命令启动：

```bash
sudo systemctl start taosd
```

TDengine 服务的配置文件是 `/etc/taos/taos.cfg`，我们可以修改其中的配置参数来调整 TDengine 的运行。例如，telemetryReporting 参数为 1，表示允许 TDengine 采集用户的基本使用信息，以改善产品。我们可以将其设为 0，关闭该功能。

```ini
# enable/disable installation / usage report
telemetryReporting        0
```

修改后重启 TDengine 服务：

```bash
sudo systemctl restart taosd
```

如果需要停止 TDengine 服务，则执行：

```bash
sudo systemctl stop taosd
```

不过需要注意的是，执行该命令后并不会马上停止 TDengine 服务，而是会等待系统中必要的落盘工作正常完成。所以在数据量很大的情况下，这条命令可能会消耗较长时间。

另外，如果想在一些没有 systemd 服务的 Linux 系统上运行 TDengine，可以直接手动启动 taosd 服务程序。例如：

```bash
/usr/local/taos/bin/taosd
```



## 客户端登录

启动 TDengine 服务器后，接下来就可以使用 taos 客户端登录。taos 是一个命令行工具，语法如下：

```bash
taos [OPTION...]
```

它提供了一些选项参数，启动时添加特定的选项和参数来改变 TDengine 客户端的行为。常用的一下选项有：

- `-c`, `--config-dir=CONFIG_DIR`：指定配置文件目录，默认为 `/etc/taos`。
- `-h`, `--host=HOST`：指定服务的 FQDN，默认为本地服务。
- `-s`, `--commands=COMMANDS`：在不进入终端的情况下运行 TDengine 命令。
- `-u`, `--user=USER`：连接 TDengine 服务器的用户名，缺省为 root。
- `-p`, `--password`：连接 TDengine 服务器的密码，缺省为 taosdata。
- `-?`, `--help`：打印出所有命令行参数。

如果需要登录本地的 TDengine 服务器，直接执行 `taos` 即可。

```bash
taos
```

如果 TDengine 终端连接服务成功，将会打印出欢迎消息和版本信息。如果失败，则会打印错误消息出来。

```bash
$ taos

Welcome to the TDengine shell from Linux, Client Version:2.2.2.0
Copyright (c) 2020 by TAOS Data, Inc. All rights reserved.

taos> 
```



## 使用示例

因为 TDengine 支持标准 SQL 语法，所以登录 TDengine 终端后，我们就可以通过 SQL 命令来创建或删除数据库、表等，并进行插入、查询等操作。

注意：在 TDengine 终端中运行的 SQL 语句需要以分号（`;`）结束。

创建一个名为 db 的数据库：

```sql
create database db;
```

选择使用 db 数据库：

```sql
use db;
```

在 db 数据库中创建数据表 t：

```sql
create table t (ts timestamp, speed int);
```

往数据表 t 中插入两条数据：

```sql
insert into t values ('2021-12-01 00:00:00', 10);
insert into t values ('2021-12-01 01:00:00', 20);
```

查询数据表 t 的所有内容：

```sql
select * from t;
           ts            |    speed    |
========================================
 2019-07-15 00:00:00.000 |          10 |
 2019-07-15 01:00:00.000 |          20 |
Query OK, 2 row(s) in set (0.003128s)
```

是不是和 MySQL 的操作一样？当然啦，除执行 SQL 语句外，系统管理员也可以从 TDengine 终端检查系统运行状态，添加删除用户账号等。





