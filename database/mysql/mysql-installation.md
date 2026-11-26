---
sidebar_position: 4
---

# MySQL 安装



本文以 Ubuntu 20.04 为例，介绍如何在 Linux 系统上安装 MySQL 数据库。



## 安装软件包

简单的，我们可以使用 Linux 发行版的软件包管理工具进行安装，例如 Ubuntu 的 apt 工具。

首先更新软件包索引信息：

````bash
sudo apt update
````

然后安装 MySQL 数据库（包括服务器端和客户端）：

```bash
sudo apt install mysql-server mysql-client
```

安装完成后，MySQL 服务将作为 systemd 服务自动启动。

查看 MySQL 服务运行状态：

```bash
sudo systemctl status mysql
```

通过命令 `mysql -V` 可以查看其版本信息。



## 连接 MySQL

MySQL 安装完成后，默认添加 root 用户，可运行命令 `mysql -u root -p` 连接本地 MySQL 数据库。

不过如果当前登录到 Ubuntu 的用户不是 root，那么将无法访问 MySQL 数据库。由于 MySQL 的 root 用户默认是没有密码的，因此输入密码登录也将被拒绝连接。此时你将会收到类似于这样的消息：

```bash
ERROR 1045 (28000): Access denied for user 'root'@'localhost'。
```

这是因为在 MySQL 8.0 上，默认使用 `auth_socket` 插件对 root 用户进行身份验证。`auth_socket` 插件仅对从 `localhost` 连接到 Unix socket 文件用户进行身份验证。这意味着，我们无法通过提供密码来以 root 用户连接到 MySQL 服务器。

那该如何登录呢？实际上，只需要切换到 root 用户，或者使用 `sudo` 提权即可连接到 MySQL 数据库。

```bash
$ sudo mysql
Welcome to the MySQL monitor.  Commands end with ; or \g.
mysql>
```

