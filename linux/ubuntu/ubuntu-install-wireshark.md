---
sidebar_position: 21
---

# Ubuntu 安装 Wireshark 软件



Wireshark 是一个免费开源的网络嗅探器，可用于抓取和分析网络数据包。Wireshark 可以解码的协议数量巨大，不胜枚举，除了传统网络协议解码外，还支持众多主流和标准工控协议的分析与解码。

Wireshark 可以支持 Windows、Linux 和 macOS 等主流操作系统平台，本文介绍如何在 Ubuntu 中安装 Wireshark 软件。

## 安装

在 Ubuntu 系统中，我们可以通过 apt 工具直接安装 Wireshark 软件。需要注意的是，Wireshark 是社区维护的开源软件，因此需要添加 universe 软件源（默认已添加）。安装命令如下：

```bash
sudo add-apt-repository universe
sudo apt install wireshark
```

稍等片刻...... 即可安装完毕。

这种方法安装的 Wireshark 版本可能比较旧，你可以通过 `apt show` 命令查看其版本信息。

```bash
$ apt show wireshark
Package: wireshark
Version: 3.2.3-1
Priority: optional
Section: universe/net
Origin: Ubuntu
Maintainer: Balint Reczey <rbalint@ubuntu.com>
...
```

如果你想使用最新版本的 Wireshark，可以添加官方的 PPA 源，然后再安装。

```bash
sudo add-apt-repository ppa:wireshark-dev/stable
sudo apt update
sudo apt install wireshark
```

即使你已经安装了旧版本的 Wireshark，通过这种方式也可以将其更新为最新版本。



## 配置

由于 Wireshark 会捕获流经网卡的数据，因此需要 root 权限（每次都要输入 sudo 和密码），这在使用上会带来一些麻烦。为了解决这个问题，你可以执行下面命令免去 sudo 启动。

```bash
sudo dpkg-reconfigure wireshark-common
```

执行命令后会出现一个 Configuring wireshark-common 交互界面，询问你是否真的允许 non-superusers 用户捕获数据包。选择“Yes”即可。

之后还要将当前用户添加到 wireshark 用户组，命令如下：

```bash
sudo usermod -aG wireshark $(whoami)
```

或者

```bash
sudo usermod -aG wireshark $USER
```

注意：需要注销并再次登录（或重新启动计算机）才会生效，否则启动 Wireshark 时依然会出现下面提示信息。

```bash
Couldn't run /usr/bin/dumpcap in child process: 权限不够
```

一切 OK 后，现在可以在终端输入 `wireshark` 命令，或者按 Super 键搜索来启动它。

![](https://static.getiot.tech/Wireshark-on-Ubuntu.png#center)



