---
sidebar_position: 18
sidebar_label: shell 脚本示例
title: Linux Shell 脚本示例：服务脚本与 getopts 参数解析
description: 提供可复用的 Shell 脚本模板，包括 SysV 风格守护进程服务脚本，以及 getopts 解析命令行选项的完整示例。
---

# Linux Shell 脚本示例：服务脚本与 getopts 参数解析



## 守护进程服务脚本

Linux 系统的 /etc/init.d 目录下有许多脚本，这些脚本通常是将某个守护进程包装成一个服务，定义了该守护进程在启动、重启和停止时的具体行为。这样做的好处是，用户在启动相应服务时不用进行太复杂的配置，在停止该服务时也能该根据脚本设置释放相关资源，还可以将服务设置成开机自动启动。

这种服务脚本遵循特定的格式，下面是一个示例模板，可以在 [GitHub](https://github.com/getiot/shell-courses/blob/main/templates/daemon-template.sh) 找到。

```bash showLineNumbers title="daemon-template.sh"
#!/bin/sh
# Start/stop the test daemon.
#
### BEGIN INIT INFO
# Provides:          test
# Required-Start:    $remote_fs $syslog $time
# Required-Stop:     $remote_fs $syslog $time
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Execute the test command.
# Description:       Test templates
### END INIT INFO

do_start() {
    echo "start"
}

do_stop() {
    echo "stop"
}

do_restart() {
    echo "restart"
}

do_status() {
    echo "status"
}

do_fallback() {
    echo "fallback"
}

case "$1" in
start) do_start
      ;;
stop)  do_stop
      ;;
restart) do_restart
      ;;
status) do_status
      ;;
*)     do_fallback
      ;;
esac
exit 0
```

脚本开头部分是头部信息，除了介绍该服务的功能，还包含一些重要的信息。包括：

- `Required-Start` 列出在启动该服务之前，系统必须启动的其他服务；
- `Required-Stop` 列出必须在该服务结束之后才能结束的服务；
- `Default-Start` 和 `Default-Stop` 列出该服务的默认运行级别。

运行级别（Runlevel）是指 Linux 操作系统下不同的运行模式，通常分为 7 个等级，分别是从 0 到 6。定义如下：

- 0 停机，关机
- 1 单用户，无网络连接，不运行守护进程，不允许非超级用户登录
- 2 多用户，无网络连接，不运行守护进程
- 3 多用户，正常启动系统
- 4 用户自定义
- 5 多用户，带图形界面
- 6 重启

脚本的主体程序包含一个 case 分支结构，可以接收启动（start）、停止（stop）、重启（restart）和状态查询（status）等参数，并采取相应的动作。将该 test 脚本放到 /etc/init.d 目录，用户可以通过 service 命令手动切换脚本状态，例如：

```bash
$ sudo service test start
```

如果想设置开机自动启动，还需要在 /etc/rcN.d 目录下创建软链接（N 为运行级别），才能让该服务在 N 运行级别时开机启动。不用担心，Linux 系统为用户提供了 update-rc.d 命令完成这一工作。



## getopts 解析参数

getpots 是 shell 命令行参数解析工具，旨在从 shell 脚本的命令行当中解析参数。

getopts 命令被 shell 程序用来分析位置参数，option 包含需要被识别的选项字符，**如果这里的字符后面跟着一个冒号，表明该字符选项需要一个参数，其参数需要以空格分隔**。冒号和问号不能被用作选项字符。getopts每次被调用时，它会将下一个选项字符放置到变量中，OPTARG则可以拿到参数值；如果option前面加冒号，则代表忽略错误；

```bash showLineNumbers
#!/bin/bash

func() {
    echo "Usage:"
    echo "test.sh [-s S_DIR] [-d D_DIR]"
    echo "Description:"
    echo "S_DIR, the path of source."
    echo "D_DIR, the path of destination."
    exit -1
}

upload="false"

while getopts 'h:s:d:u' OPT; do
    case $OPT in
        s) S_DIR="$OPTARG"; echo "$OPTIND: $OPTARG";;
        d) D_DIR="$OPTARG"; echo "$OPTIND: $OPTARG";;
        u) upload="true"; echo "$OPTIND: $OPTARG";;
        h) func; echo "$OPTIND: $OPTARG";;
        ?) func;;
    esac
done

echo $S_DIR
echo $D_DIR
echo $upload

echo $OPTIND
shift $(($OPTIND - 1))
echo $1
```

很多脚本执行的时候我们并不知道后面参数的个数，但可以使用 `$*` 来获取所有参数。但在程序处理的过程中有时需要逐个的将 `$1`、`$2`、`$3` ... `$n` 进行处理。shift 是 shell 中的内部命令，用于处理参数位置。每次调用 shift 时，它将所有位置上的参数减一。`$2` 变成了 `$1`，`$3` 变成了 `$2`，`$4` 变成了 `$3`，依次类推。





