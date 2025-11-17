---
sidebar_position: 22
---

# Ubuntu 安装 SmartGit 软件



SmartGit 是一个高效的跨平台 Git 图形化客户端，支持 Windows、macOS 和 Linux 操作系统，支持 GitHub、BitBucket、SVN 以及 Mercurial 等版本管理系统。 SmartGit 客户端专注于简单性，主要面向非专家和更喜欢图形界面程序而不是命令行使用 Git 的用户。



## 方法一：直接下载安装

在 [SmartGit 下载页面](https://www.syntevo.com/smartgit/download/) 下载对应操作系统平台最新版本的 SmartGit 安装包。

![](https://static.getiot.tech/smartgit-for-linux.png#center)

例如我们这里下载 smartgit-linux-21_2_3.tar.gz，执行下面命令解压缩。

```bash
tar zxvf smartgit-linux-21_2_3.tar.gz
```

切换到 smartgit/bin 目录，执行启动脚本即可启动 SmartGit 软件。

```bash
cd smartgit/bin/
./smartgit.sh
```



## 方法二：使用 deb 包

下载 SmartGit 最新的 deb  包。

```bash
wget https://www.syntevo.com/downloads/smartgit/smartgit-21_2_3.deb
```

使用 apt 命令或者 dpkg 命令安装：

```bash
sudo apt install ./smartgit-21_2_3.deb
```

或者

```bash
sudo dpkg -i smartgit-21_2_3.deb
```



## 方法三：使用 PPA 源

添加 SmartGit 的 PPA 存储库 

```bash
sudo add-apt-repository ppa:eugenesan/ppa
sudo apt update
```

接下来就可以通过 apt 直接安装 SmartGit 软件。

```bash
sudo apt install smartgit
```

成功安装后，单击桌面上的“活动”选项卡，在出现的搜索栏中键入“SmartGit”，单击搜索结果中的图标即可启动 SmartGit 软件。

![](https://static.getiot.tech/smartgit-on-ubuntu.png#center)
