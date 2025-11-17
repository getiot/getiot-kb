---
sidebar_position: 14
---

# Ubuntu 配置 SSH 服务


## 安装 ssh

sshd 远程登录服务器

```shell
# 安装
sudo apt-get install openssh-server

# 登录 ssh：用户名@服务器IP
ssh gec@192.168.1.10
```

scp 上传和下载文件

```shell
scp main.c gec@192.168.1.10:/home/gec
scp gec@192.168.1.10:/home/gec/linux/test.tar.bz2 ./
```



### 配置

#### 设置心跳检测

平时在命令行下ssh连接了远程服务器，经常才几分钟没操作就被自动断线了，不能进行任何操作，其实这是因为 ssh 没有设置心跳检测，可以通过以下两种方法解决。

**1、客户端定时发送心跳检测**

打开 /etc/ssh/ssh_config 配置文件，在末尾添加上如下两行

```shell
ServerAliveInterval 20
ServerAliveCountMax 99
```

意思是每隔20秒向服务器发出一次心跳检测，若超过99次请求都没有成功，就主动断开与服务器端的连接。

**2、服务器端定时发送心跳检测**

打开 /etc/ssh/sshd_config 配置文件，在末尾添加上如下两行

```shell
ClientAliveInterval 30
ClientAliveCountMax 6
```

每隔30秒向客户端发出一次心跳检测，若超过6次请求都没有成功，就会主动断开与客户端的连接。

设置了ssh的心跳检测后，重启 ssh 服务才能生效，执行如下命令。

```shell
systemctl restart sshd
# 或者
service ssh restart
```



### PuTTY

Putty 提供了两个文件传输工具：

- **PSCP**（PuTTY Secure Copy client）：PSCP 通过 SSH 连接，在两台机器之间安全地传输文件，可以用于任何 SSH（包括 SSH v1、SSH v2）服务器。
- **PSFTP**（PuTTY SFTP client）：PSFTP 则是 SSH-2 中新增的特性，使用的是新的 SFTP 协议，使用上与传统的 FTP 类似。



> 实际上，如果 PSCP 发现 SFTP 可用，PSCP 就会使用 SFTP 协议来传输文件，否则还是 SCP 协议。与 PSCP 相比，PSFTP 的优点是可以与服务器进行交互，遍历服务器上的文件系统，在一个会话中上传或下载多个文件，而 PSCP 只能一次传输一个文件，传输完毕后立刻终止会话。



### PSCP

PSCP 的使用很简单，在 Windows 中打开命令行窗口即可执行 PSCP。

```
C:\>pscp
PuTTY Secure Copy client
Release 0.58
Usage: pscp [options] [user@]host:source target
          pscp [options] source [source...] [user@]host:target
          pscp [options] -ls [user@]host:filespec
Options:
     -V           print version information and exit
     -pgpfp       print PGP key fingerprints and exit
     -p           preserve file attributes
     -q           quiet, don't show statistics
     -r           copy directories recursively
     -v           show verbose messages
     -load sessname     Load settings from saved session
     -P port      connect to specified port
     -l user      connect with specified username
     -pw passw login with specified password
     -1 -2        force use of particular SSH protocol version
     -4 -6        force use of IPv4 or IPv6
     -C           enable compression
     -i key       private key file for authentication
     -batch       disable all interactive prompts
     -unsafe      allow server-side wildcards (DANGEROUS)
     -sftp        force use of SFTP protocol
     -scp         force use of SCP protocol
```



### PSFTP

PSFTP 的用法与 PSCP 大同小异，我们先执行 `psftp -h` 查看帮助

```
C:\>psftp -h
PuTTY Secure File Transfer (SFTP) client
Release 0.58
Usage: psftp [options] [user@]host
Options:
     -V           print version information and exit
     -pgpfp       print PGP key fingerprints and exit
     -b file      use specified batchfile
     -bc          output batchfile commands
     -be          don't stop batchfile processing if errors
     -v           show verbose messages
     -load sessname     Load settings from saved session
     -l user      connect with specified username
     -P port      connect to specified port
     -pw passw login with specified password
     -1 -2        force use of particular SSH protocol version
     -4 -6        force use of IPv4 or IPv6
     -C           enable compression
     -i key       private key file for authentication
     -batch       disable all interactive prompts
```

不同的是，执行 psftp 命令可以登录到服务器进行操作，操作与 FTP 差不多，这里简单的说一下吧：





其他可选的 SFTP 客户端

FileZilla : http://filezilla.sf.net
WinSCP : http://www.winscp.net



### Plink

Plink 是 PuTTY 的命令行连接工具，主要用于自动化工作的处理。用 Plink 更方便快捷的执行远程主机上的命令，直接在控制台执行 plink，可以看到 Plink 的帮助

```
C:\>plink
PuTTY Link: command-line connection utility
Release 0.58
Usage: plink [options] [user@]host [command]
          ("host" can also be a PuTTY saved session name)
Options:
     -V           print version information and exit
     -pgpfp       print PGP key fingerprints and exit
     -v           show verbose messages
     -load sessname     Load settings from saved session
     -ssh -telnet -rlogin -raw
               force use of a particular protocol
     -P port      connect to specified port
     -l user      connect with specified username
     -batch       disable all interactive prompts
The following options only apply to SSH connections:
     -pw passw login with specified password
     -D [listen-IP:]listen-port
               Dynamic SOCKS-based port forwarding
     -L [listen-IP:]listen-port:host:port
               Forward local port to remote address
     -R [listen-IP:]listen-port:host:port
               Forward remote port to local address
     -X -x        enable / disable X11 forwarding
     -A -a        enable / disable agent forwarding
     -t -T        enable / disable pty allocation
     -1 -2        force use of particular protocol version
     -4 -6        force use of IPv4 or IPv6
     -C           enable compression
     -i key       private key file for authentication
     -m file      read remote command(s) from file
     -s           remote command is an SSH subsystem (SSH-2 only)
     -N           don't start a shell/command (SSH-2 only)
```





### SecureCRT





### Tera Term

