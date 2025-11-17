---
sidebar_position: 12
---

# Ubuntu 搭建 Samba 服务

![](https://static.getiot.tech/Samba-Server-in-Linux.jpg#center)



## Samba 简介

Samba 是在 UNIX/Linux 系统上实现 SMB 协议的一个免费软件，由服务器及客户端程序构成。SMB（Server Messages Block，信息服务块）是一种在局域网上共享文件和打印机的一种通信协议，它为局域网内的不同计算机之间提供文件及打印机等资源的共享服务。



## Samba 安装

```bash
sudo apt install samba
```



## Samba 配置

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

**重启服务器**

```bash
# 旧版本
sudo service smbd restart
sudo service nmbd restart

# 新版本
sudo systemctl restart smbd
sudo systemctl restart nmbd
```

**更新防火墙规则**

我们需要更新防火墙规则，通过发布这个命令来允许这个服务。

```bash
sudo ufw allow samba
```

**创建一个Samba账户**

你需要一个用户账户来访问 Samba。通常，你可以使用系统用户名。在提示时输入账户密码。

```bash
sudo smbpasswd -a $USER
```



## 访问 Samba 服务

### 在 Ubuntu 上访问

我们可以在 Ubuntu 客户端系统上访问刚刚设置的 Samba 共享服务。

- 在标准的 Ubuntu 安装中，你将打开默认的文件管理器，然后点击连接到服务器。
- 然后输入 `smb://your-ip/sambashare/`。



### 在 Windows 上访问

开始 -> 运行 -> `\\xxx.xxx.xxx.xxx`，例如 `\\192.168.31.49\shared`。

然后你会被提示输入你在设置Samba账户时创建的密码。

![](https://static.getiot.tech/windows-connect-samba.png#center)

访问 Windows 共享文件夹

```bash
sudo mount -t cifs -o username=Administrator,password=123456 //192.168.3.116/share /mnt/share
```

说明：

- share 是 Windows 系统中的一个共享文件夹（通过 cmd 命令 `net share` 或者 “计算机” -> “网络” 进行查看）
- /mnt/share 是 Linux 上的挂载点（需要事先创建 share 目录）

