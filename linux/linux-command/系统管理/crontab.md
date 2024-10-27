---
sidebar_label: crontab 命令
sidebar_position: 45
slug: /crontab
---

# crontab 命令



## 介绍

**crontab**（英文全拼：cron table）命令用于查看或设定在 Linux 系统中定期执行程序。

cron 是 Linux 系统中常用的任务规划软件，cron 是一个守护进程，用户可以通过 crontab 命令要求系统在特定的时间执行特定的任务。适用于需要周期性自动化执行的工作。

**语法**：

```bash
crontab [ -u user ] file
crontab [ -u user ] [ -i ] { -e | -l | -r }
```

**选项**：

- `-u user` ：指定操作时程表（crontab）的用户，如果不指定，则使用当前用户。
- `-e` ：执行文字编辑器来设定时程表，支持多种文字编辑器，如 nano、vim、emacs 等。
- `-r` ：删除目前的时程表。
- `-l` ：列出目前的时程表。
- `-i` ：使用 -r 选项删除时程表之前提示用户输入 'y/Y' 回复。

crontab 时间格式如下所示，用户也可以将所有的设定先存放在文件中，再从 file 参数引入。

```bash
f1   f2   f3   f4   f5   program
*    *    *    *    *    *
-    -    -    -    -    - command to be executed
|    |    |    |    |
|    |    |    |    +----- day of week (0-7) (Sunday=0/7) OR sun,mon,tue,wed,thu,fri,sat
|    |    |    +---------- month (1-12) OR jan,feb,mar,apr ...
|    |    +--------------- day of month (1-31)
|    +-------------------- hour (0-23)
+------------------------- minute (0-59)
```

- 其中 f1 是表示分钟，f2 表示小时，f3 表示一个月份中的第几日，f4 表示月份，f5 表示一个星期中的第几天。program 表示要执行的程序。
- 当 f1 为 `*` 时表示每分钟都要执行 program，f2 为 `*` 时表示每小时都要执行程序，其余类推。
- 当 f1 为 a-b 时表示从第 a 分钟到第 b 分钟这段时间内要执行，f2 为 a-b 时表示从第 a 到第 b 小时都要执行，其余类推。
- 当 f1 为 `*/n` 时表示每 n 分钟个时间间隔执行一次，f2 为 `*/n` 表示每 n 小时个时间间隔执行一次，其余类推。
- 当 f1 为 a, b, c,... 时表示第 a, b, c,... 分钟要执行，f2 为 a, b, c,... 时表示第 a, b, c...个小时要执行，其余类推。



## 示例

每一分钟执行一次 getiot.sh 脚本

```bash
* * * * * /opt/getiot.sh 1>/dev/null 2>&1
```

每十分钟检查一次磁盘空间

```bash
*/10 * * * * /home/getiot/bin/check-disk-space
```

每天上午 9 点到下午 6 点，每一小时检查一次数据库

```bash
00 09-18 * * * /home/getiot/bin/check-db-status
```

每个工作日（周一到周五）上午 9 点到下午 6 点，每一小时检查一次数据库

```bash
00 09-18 * * 1-5 /home/getiot/bin/check-db-status
```

在 12 月内，每天的早上 6 点到 12 点，每隔 3 个小时执行一次 /usr/bin/backup

```bash
00 06-12/3 * 12 * /usr/bin/backup
```

周一到周五每天下午 5 点给 rudy@getiot.tech 寄一封信

```bash
00 17 * * 1-5 mail -s "hi" rudy@getiot.tech < /tmp/maildata
```



