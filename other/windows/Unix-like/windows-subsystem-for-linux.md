---
sidebar_position: 1
slug: /windows-subsystem-for-linux
---

# WSL 入门教程



本文主要介绍 WSL（Windows Subsystem for Linux）的基本概念、功能特性、安装方法以及 SSH 配置等内容。

![WSL 入门教程](https://static.getiot.tech/windwos-wsl-linux.jpg#center)



## WSL 简介

**WSL** 是 “Windows Subsystem for Linux” 的缩写，即 Windows 系统的 Linux 子系统。WSL 的初衷是为了在 Windows 系统中直接运行 Linux 工具链，而不需要安装虚拟机。

在 Windows 10（1607 版本）及更新的版本中，WSL 就以系统组件的形式出现在 Windows 系统中。用户可以像打开 CMD 命令行工具那样使用 WSL。



## 功能特性

WSL 作为宿主系统 Windows 的子系统，与虚拟机还是有些区别的。

- WSL 作为系统层的一部分，相较于应用层（虚拟机）会消耗更少的资源，并且与系统契合度更高；
- WSL 子系统“依附于”宿主系统，因此在使用上会受到一些限制，比如与 Windows 共享同一套网络端口，并且优先级低于主系统；
- WSL 会一直伴随主系统运行，不需要像虚拟机一样启动，只需要打开命令行窗口，建立 Session 即可；
- 虽然 WSL 不是完整的 Linux 系统，但它依然可以做到绝大多数在完整 Linux 系统能做的事。



## 安装配置

WSL 的安装分为两部分：

- 启动 Windows Subsystem for Linux 组件
- 安装 Linux 发行版



### 启动 WSL 组件

1、以管理员身份打开 PowerShell；

2、执行以下命令：

```bash
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
```

3、安装完成后重启电脑；

4、打开控制面板，找到“启用或关闭 Windows 功能”；

5、勾选“适用于 Linux 的 Windows 子系统”，点击“确定”。



### 安装 Linux 发行版

WSL 目前支持 Ubuntu、Kali Linux、GNU、OpenSUSE 等 Linux 系统发行版，可以通过应用商店安装。

1、打开 Microsoft Store 应用商店；

2、搜索想要安装的 Linux 发行版，例如在搜索框输入“Ubuntu”；

3、点击“安装”；（注意：通过应用商店安装的 Linux 发行版只支持安装在 C 盘）

4、安装完成后，按提示输入默认用户名和密码即可进入 Linux 子系统；

5、以后可以在 Windows “开始”菜单中找到“Ubuntu”应用，直接点击打开。



## 配置 SSH

前面提到，WSL 与 Windows 共享同一套网络端口，并且优先级低于主系统。由于 Windows 系统内置的 SSH Server For Windows 服务占用了默认的 22 号端口，因此 WSL 无法启用 SSH 服务。

解决办法是修改 WSL 中默认的 SSH 监听端口，修改步骤如下：

1、以超级用户权限打开 sshd 配置文件

```bash
sudo vi /etc/ssh/sshd_config
```

2、修改默认的监听端口（例如改为 2022）

```bash
#Port 22
Port 2022
```

3、重启 SSH 服务

```bash
sudo service ssh restart
```



## FAQs

**1、启动 Ubuntu 时出现如下错误**

```bash
The WSL optional component is not enabled. Please enable it and try again.
See https://aka.ms/wslinstall for details.
Error: 0x8007007e
Press any key to continue...
```

这是因为 WSL 没有打开，解决办法是以管理员身份打开 PowerShell，执行以下命令：

```bash
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
```

然后重新启动。

**2、重启 SSH 服务时出现如下错误**

```bash
sshd: no hostkeys available -- exiting.
```

这是因为没有 SSH key 导致的，解决办法是执行下面命令生成 key 文件：

```bash
sudo ssh-keygen -A
```

提示：执行 `sudo sshd -T` 可以测试。

**3、通过 SSH 连接 WSL 子系统时出现如下错误**

```bash
No supported authentication methods available (server sent: publickey)
```

这是因为 SSH 服务禁用密码验证登录了，解决办法是为 SSH 配置登录密钥，或者修改 sshd 配置文件以支持密码登录。

修改方法：打开 `/etc/ssh/sshd_config` 文件，将 `PasswordAuthentication no` 注释掉，或者修改为 `PasswordAuthentication yes`，然后重启 SSH 服务。

