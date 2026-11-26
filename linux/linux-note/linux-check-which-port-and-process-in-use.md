---
sidebar_position: 4
---

# Linux 查看端口与进程占用情况



在日常 Linux 运维、开发过程中，我们常常需要查看进程信息，比如该进程使用了哪些端口？或者反过来，需要确定某个端口是被哪个进程所占用的，从而解决一些系统问题、性能问题。因此，本文将介绍如何使用简单的 Linux 命令，查看端口与进程的占用情况。



## 已知端口号查找占用进程

假设当我准备启动某个程序时，提示 1883 端口已被占用，因此我需要知道到底是哪个进程占用了 1883 端口。

既然我们已经知道端口号，那么就可以使用 [netstat](/linux-command/netstat/) 命令进行查询，由于我们并不知道 1883 端口是 TCP 还是 UDP 连接，因此使用 -a 选项查询所有。

```bash
$ sudo netstat -nap | grep 1883
tcp      0    0 0.0.0.0:1883    0.0.0.0:*     LISTEN    1327/mosquitto      
tcp6     0    0 :::1883         :::*          LISTEN    1327/mosquitto
```

可以看到，1883 端口被 mosquitto 进程占用了。更进一步，我们可以查看该进程的状况。

```bash
$ ps -ef | grep 1327 | grep -v "grep"
mosquit+  1327   1  0 09:10 ?    00:00:02 /usr/sbin/mosquitto -c /etc/mosquitto/mosquitto.conf
```



## 已知进程号查找占用端口

反过来，假设我们现在知道了 mosquitto 的进程号是 1327，我们想进一步了解该进程占用了哪些端口。

```bash
$ sudo netstat -nap | grep 1327
tcp   0    0 0.0.0.0:1883     0.0.0.0:*     LISTEN    1327/mosquitto      
tcp6  0    0 :::1883          :::*          LISTEN    1327/mosquitto      
unix  3    [ ]         流        已连接     44364    1327/mosquitto
```

可以看到，该进程占用了 1883 端口，是一个 TCP 连接，另外还有一个 UNIX 域的本地连接。


