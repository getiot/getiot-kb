---
sidebar_position: 2
---

# 嵌入式 Linux 网络环境搭建



## ssh

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



---

## Tftp

> 几种 tftp 服务：tftpd、tftpd-hpa、atftpd（advanced tftp server and client）

嵌入式 Linux 的 ftp 最常用来完成开发板和开发主机之间的文件传输功能，避免了频繁的 U 盘拷贝过程。

Linux 下的 tftp 开发环境包括两部分：

- Linux 服务器端的 tftp-server 支持
- 嵌入式目标系统的 tftp-client 支持



### 服务端（开发主机）

操作系统：Ubuntu 16.04

安装 tftp

```shell
$ sudo apt-get install tftp-hpa tftpd-hpa
```

建立 tftp 服务根目录

```shell
$ mkdir /tftpboot
$ sudo chmod 0777 /tftpboot
```

配置 /etc/default/tftpd-hpa 

```ini
# /etc/default/tftpd-hpa

TFTP_USERNAME="tftp"
TFTP_DIRECTORY="/tftpboot"
TFTP_ADDRESS=":69"
TFTP_OPTIONS="--secure"
```

重启服务（采用独立服务形式）

```shell
$ sudo service tftpd-hpa restart
```

测试

```shell
$ tftp localhost
tftp> get hello.txt
tftp> put world.txt
tftp> q
```







### 客户端（目标设备）





---

## NFS

### NFS 服务简介

NFS 是 Network File System 的缩写，即网络文件系统。一种使用于分散式文件系统的协定，由 Sun 公司开发，于1984年向外公布。功能是通过网络让不同的机器、不同的操作系统能够彼此分享个别的数据，让应用程序在客户端通过网络访问位于服务器磁盘中的数据，是在类 Unix 系统间实现磁盘文件共享的一种方法。

NFS 的基本原则是 “容许不同的客户端及服务端通过一组 RPC 分享相同的文件系统”，它是独立于操作系统，容许不同硬件及操作系统的系统共同进行文件的分享。

NFS 在文件传送或信息传送过程中依赖于 RPC 协议。RPC，远程过程调用（Remote Procedure Call）是能使客户端执行其他系统中程序的一种机制。NFS 本身是没有提供信息传输的协议和功能的，但 NFS 却能让我们通过网络进行资料的分享，这是因为 NFS 使用了一些其他的传输协议。而这些传输协议用到这个 RPC 功能。可以说 NFS 本身就是使用 RPC 的一个程序，或者说 NFS 也是一个 RPC Server。所以只要用到 NFS 的地方都要启动 RPC 服务，不论是 NFS Server 或者 NFS Client。这样 Server 和 Client 才能通过 RPC 来实现 Program Port 的对应。**可以这么理解 RPC 和 NFS 的关系：NFS 是一个文件系统，而 RPC 负责信息的传输。**

在提供 NFS 服务之前必须启动 rpcbind 服务。



### 安装 nfs 服务

```shell
sudo apt install nfs-kernel-server
```

修改配置文件，在 /etc/exports 最后面添加如下配置

```
/nfs *(rw,sync,no_subtree_check,no_root_squash)
```

这里的 `/nfs` 是 nfs 服务的根目录；`*` 表示所有 IP 地址，也可以指定客户端的 IP 或者 IP 范围，比如 `192.168.0.0/24`，使用域名也可以。

重启 nfs 服务

```shell
sudo service nfs-kernel-server restart     # 使用 service
sudo systemctl restart nfs-server.service  # 使用 systemctl
```

或者执行 `exportfs -rv` 更新配置。

在开发板挂载（挂载到 /mnt 目录）

```shell
mount -o nolock,tcp 192.168.1.100:/nfs /mnt
```

在开发板卸载

```shell
umount /mnt
```

提示：为了安全起见，建议根据您的网络环境设置 NFS 目录权限。





---

## Samba

Samba 共享服务

### 安装

```shell
sudo apt install samba
```



### 配置

在 /etc/samba/smb.conf 文件末尾添加如下配置：

```ini
[shared]
	comment=luhuadong 
	path=/home/gec/linux
	browseable=yes
	writable=yes
	guest ok=yes
```

其中，`shared` 是共享时显示的名称，`comment` 是备注，`path` 是共享目录（必须要存在），`browseable` 表示可浏览，`writable` 表示可写，`guest ok` 表示其他用户可访问。

重启服务器

```shell
sudo service smbd restart
sudo service nmbd restart
```



```shell
systemctl status smbd
systemctl status nmbd
```



```shell
sudo systemctl restart smbd
sudo systemctl restart nmbd
```



更新防火墙规则

我们需要更新防火墙规则，通过发布这个命令来允许这个服务。

```shell
sudo ufw allow samba
```

创建一个Samba账户

你需要一个用户账户来访问Samba。通常，你可以使用系统用户名。在提示时输入账户密码。

```shell
sudo smbpasswd -a $USER
```



在Ubuntu客户端系统上访问您的Samba共享。

在标准的Ubuntu安装中，你将打开默认的文件管理器，然后点击连接到服务器。然后输入smb://your-ip/sambashare/。

```shell
\\192.168.31.49\shared
```



然后你会被提示输入你在设置Samba账户时创建的密码。



![](https://static.getiot.tech/windows-connect-samba.png)



### 在 Windows 下访问

开始 -> 运行 -> `\\xxx.xxx.xxx.xxx`





## 访问 Windows 共享文件夹



```shell
sudo mount -t cifs -o username=Administrator,password=123456 //192.168.3.116/share /mnt/share
```

说明：

- share 是 Windows 系统中的一个共享文件夹（通过 cmd 命令 `net share` 或者 “计算机” -> “网络” 进行查看）
- /mnt/share 是 Linux 上的挂载点（需要事先创建 share 目录）





---

