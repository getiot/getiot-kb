---
sidebar_position: 8
---

# Shell 脚本定期检查服务是否正常运行

小标题：Shell 脚本检查服务运行状态

---

以 MySQL 服务为例，假设我们想定期检查该服务是否正常运行，如果运行异常则重启该服务，从而确保服务尽快恢复。

在 Linux 系统中，如果我们想查看某个服务的运行状态，可以使用 `systemctl status` 命令，例如：

```bash
$ systemctl status mysql
● mariadb.service - MariaDB 10.3.34 database server
     Loaded: loaded (/lib/systemd/system/mariadb.service; enabled; vendor preset: enabled)
     Active: active (running) since Sat 2022-08-13 19:34:07 CST; 2h 32min ago
     ......
```

如果 Active 一栏显示 “active”，则表示服务运行正常。

如果你只想关心 Active 状态，还可以使用 `systemctl is-active` 命令，这样返回的结果会更加简洁。

```bash
$ systemctl is-active mysql
active
```

为了实现文章开头的需求，我们可以编写一个 Shell 脚本程序 [keep_mysql_active.sh](https://github.com/getiot/shell-courses/blob/main/monitor/keep_mysql_active.sh)，内容如下：

```bash showLineNumbers
#!/bin/bash

function keep_mysql_service_active()
{
    result=`systemctl is-active mysql`

    # result: active or inactive
    if [[ $result = "active" ]]; then
        echo "[-] MySQL is active"
        exit
    fi

    echo "[-] MySQL is inactive"
    echo "[-] Restart now"
    sudo systemctl restart mysql
    echo "[-] Done!"
}

function main()
{
    keep_mysql_service_active
}

main
```

如果 MySQL 服务为 active 状态，则结束本次检测；如果为 inactive 状态，则尝试重启 MySQL 服务。

为了让该程序自动定期运行，例如每隔一分钟检查一次，我们可以使用 [Linux 定时任务管理](/linux/linux-cron-table/)。打开一个终端，输入 `crontab -e` 命令，编辑 cron 任务规划列表，在末尾加上如下一行：

```bash
* * * * * /opt/keep_mysql_active.sh
```

这里假设 keep_mysql_active.sh 脚本文件存放于 /opt 目录，并且具有可执行权限。

这样，我们就实现了 MySQL 服务的自动定期检测和重启的功能！

