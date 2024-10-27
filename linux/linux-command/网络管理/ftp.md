---
sidebar_label: ftp 命令
sidebar_position: 12
slug: /ftp
---

# ftp 命令



## 介绍

**ftp** 命令是 FTP 文件传输协议（File Transfer Protocol）的客户端工具，用于本地主机和远程文件服务器之间上传和下载文件。ftp 命令使用 FTP 协议和远程文件服务器进行通信。

FTP 协议使用明文传送用户的认证信息，和容易被局域网内的嗅探软件截获，所以使用 ftp 命令时要格外注意。

匿名 FTP 服务器在登录时使用“anonymous”作为用户名，用任意的电子邮件作为密码。通常，匿名 FTP 服务器只能下载文件，而不允许用户上传文件。

**语法**：

```shell
ftp [-46pinegvd] [host [port]]
```

**选项**：

- `-d` ：使用调试模式运行（会详细显示指令执行过程，便于排错或分析程序执行的情况）。
- `-i` ：关闭互动模式，在遇到问题时不询问用户而直接执行。
- `-g` ：关闭本地主机文件名称支持特殊字符的扩充特性。
- `-n` ：不使用自动登录。
- `-v` ：显示指令执行过程的详细信息。
- `-t` ：激活数据包包追踪。
- `-4` ：只使用 IPv4。
- `-6` ：只使用 IPv6。

**参数**：主机名或 IP 地址，以及端口号



## 示例

启动 vsftpd 服务（FTP 默认端口为 21）

```shell
$ sudo service vsftpd start 
```

打开 ftp 客户端，进入交互界面

```shell
$ ftp
ftp>
```

在交互界面中查看内部命令的帮助

```shell
ftp> help
```

在交互界面连接 FTP 服务器

```shell
ftp> open 192.168.1.100
```

如果端口不是 21，则需要指定端口（比如 2020）

```shell
ftp> open 192.168.1.100 2020
```

从服务器中下载文件到本地

```shell
ftp> get remote-file local-file
```

将一个本地的文件上传到服务器

```shell
ftp> put local-file remote-file
```

退出 ftp 客户端

```shell
ftp> quit
```

