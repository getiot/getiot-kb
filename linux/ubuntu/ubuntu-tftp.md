---
sidebar_position: 11
---

# Ubuntu 搭建 TFTP 服务

![](https://static.getiot.tech/tftp.png#center)

本文主要介绍如何在 Ubuntu 中搭建 TFTP 服务器，以及使用 TFTP 客户端实现文件的上传（put）和下载（get）。



## TFTP 简介

TFTP（Trivial File Transfer Protocol，简单文件传输协议）是 TCP/IP 协议族中的一个用来在客户机与服务器之间进行简单文件传输的协议，提供不复杂、开销不大的文件传输服务，端口号为 69 ，比传统的 FTP 协议要轻量级很多，适用于小型的嵌入式产品上。



## TFTP 安装

使用 apt 包管理器下载 TFTP 服务器和客户端，命令如下：

```bash
sudo apt install tftpd-hpa
sudo apt install tftp-hpa
```

其中，tftp-hpa 是客户端，作用是从 TFTP 服务器端上传或下载文件；tftpd-hpa 是服务器，字母 d 代表 daemon，作用是对外提供 TFTP 服务，供客户端上传或下载文件。



## 配置 TFTP 服务器

TFTP 服务器的配置文件位于 /etc/default/tftpd-hpa，内容如下：

```ini
# /etc/default/tftpd-hpa

TFTP_USERNAME="tftp"
TFTP_DIRECTORY="/srv/tftp"
TFTP_ADDRESS=":69"
TFTP_OPTIONS="--secure"
```

参数 `TFTP_USERNAME` 表示 TFTP 服务的用户名（安装时自动创建 tftp 用户），可以根据需要修改为 root 或当前系统用户名；`TFTP_DIRECTORY` 表示设定的 TFTP 根目录；`TFTP_ADDRESS` 表示 TFTP 服务的 IP 地址和端口号（默认使用 69 端口）；`TFTP_OPTIONS` 表示 TFTP 的启动参数。

启动参数通常使用 `-l -c -s`，意义如下：

- `-l`：以 standalone/listen 模式启动 TFTP 服务，而不是从 inetd 启动。
- `-c`：可创建新文件。默认情况下，TFTP 只允许覆盖原有文件，不能创建新文件。
- `-s`：改变 TFTP 启动的根目录。加了 -s 后，客户端使用 TFTP 时，不再需要输入指定目录，填写文件的完整路径，而是使用配置文件中写好的目录。这样也可以增加安全性。

默认的目录是 /srv/tftp，可以修改为其他目录。可以修改该目录的权限，为客户端提供读写权限，例如：

```bash
sudo chmod 777 /srv/tftp
```

修改配置后，需要重启 TFTP 服务才能生效

```bash
sudo service tftpd-hpa restart
```

查看服务运行状态

```bash
sudo service tftpd-hpa status
```



## 测试 TFTP 服务

接下来就可以测试 TFTP 服务的功能了，首先在 TFTP 根目录（例如 /srv/tftp）创建一个文件 test.txt，命令如下：

```bash
echo "Hello GetIoT.tech" > /srv/tftp/test.txt
```

然后使用 `tftp` 命令（客户端）连接 TFTP 服务器，连接时需要带上 IP 地址（例如 192.168.1.100），如果是本地服务可以使用 `localhost`。

```bash
$ tftp 192.168.1.100
tftp> 
```

在 tftp 命令行交互界面输入 `help` 可以查看支持的命令：

```bash
tftp> help
tftp-hpa 5.2
Commands may be abbreviated.  Commands are:

connect 	connect to remote tftp
mode    	set file transfer mode
put     	send file
get     	receive file
quit    	exit tftp
verbose 	toggle verbose mode
trace   	toggle packet tracing
literal 	toggle literal mode, ignore ':' in file name
status  	show current status
binary  	set mode to octet
ascii   	set mode to netascii
rexmt   	set per-packet transmission timeout
timeout 	set total retransmission timeout
?       	print help information
help    	print help information
```

我们尝试从 TFTP 服务器下载先前准备好的 test.txt 文件：

```bash
tftp> get test.txt
```

现在，在当前目录下可以看到 test.txt 文件。

我们也可以将本地文件上传到 TFTP 服务器（假设本地有一个 test2.txt 文件）：

```bash
tftp> get test2.txt
```

提示：上传或下载成功不会有任何提示，失败才会有提示。



## 常见错误

**1、get 时出现“Transfer timed out.”**

请检查 tftpd 服务是否正常启动，以及 IP 连接是否正确。

**2、get 时出现“permission denied”**

操作者权限不够，比如当前的目录是 /etc，不能随便 get 文件下来。需要提升权限。切换到 root 账户，或者直接执行 `sudo tftp` 启用客户端。

**3、get 时出现“Error code 1: File not found”**

原因是 TFTP 根目录下没有该文件。

**4、get 时出现“Error code 2: Only absolute filenamesallowed”**

原因是 TFTP 启动配置参数没有 -s 选项，或者在 DIRECTORY 中没有填写目录。

**5、put 时出现“No such file or directory”**

当前目录下没有指定的文件。

**6、put 时出现“Error code 1: File not found”**

注意，出现该错误不是因为当前目录下没有指定的文件，而是 TFTP 目录下找不到同名文件。这是由于默认情况下，TFTP 只允许覆盖原有文件，不能创建新文件。

解决办法是在 TFTP 启动配置参数增加 -c 选项，允许 TFTP 服务器创建新文件。

**7、put 时出现“Error code 2: File must have global writepermissions”**

原因是 TFTP 根目录下有同名文件，但该文件无写权限。

