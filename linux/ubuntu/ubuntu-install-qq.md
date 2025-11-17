---
sidebar_position: 24
---

# Ubuntu 安装 QQ 软件



腾讯 QQ Linux 版目前支持 x64（x86_64、amd64）、arm64（aarch64）两种硬件架构，每种架构都提供了 Debian 系、Red Hat 系以及其他 Linux 发行版的安装包，分别对应 deb、rpm、AppImage 格式安装包。

目前最新版本是2022年12月30日发布的 v3.0.0 版本，点击 [QQ Linux 版](https://im.qq.com/linuxqq/index.shtml) 即可下载对应版本的安装包，例如 Ubuntu 系统则下载 deb 软件包。



## 软件版本

| 安装包格式 | 安装包管理器 | 支持发行版                                      |
| ---------- | ------------ | ----------------------------------------------- |
| RPM        | rpm/yum      | Red Hat 系（RedHat、Fedora、CentOS）            |
| DEB        | dpkg/apt     | Debian 系（Debian、Ubuntu、银河麒麟、统信 UOS） |
| AppImage   |              | 其他 Linux 发行版版本                           |



## 更新功能

相比于上一个 v2.0.0 版本，QQ Linux 版 3.0.0 有如下更新：

1、新增夜间模式并支持跟随系统，享受更沉浸的聊天体验；
2、新增 QQ 截图能力，快捷方便，提升办公效率；
3、新增群应用功能，图片、文件轻松传送，群聊更高效；
4、新增全局搜索能力，进一步提升内容搜索效率。



## 安装步骤

每一个安装包会按照形如如下的格式命名：

```bash
[产品名]_[版本号]_[架构].[格式]
```

例如，我们这里使用 Ubuntu 20.04 桌面版（amd64），因此下载当前最新的 linuxqq_3.0.0-571_amd64.deb。

然后使用 dpkg 命令进行安装：

```bash
$ sudo dpkg -i linuxqq_3.0.0-571_amd64.deb
```

如果是 RedHat 系，则可用 rpm 命令安装：

```bash
$ sudo rpm -ivh linuxqq_3.0.0-571_amd64.rpm
```

AppImage 格式软件包则无需安装，增加可执行权限后即可启动：

```bash
$ chmod +x linuxqq_3.0.0-571_amd64.AppImage
$ ./linuxqq_3.0.0-571_amd64.AppImage
```



## 启动 QQ

在终端输入 `qq` 命令即可启动：

```bash
$ qq
```

或者按 Win 键启用搜索栏，输入 `qq`：

![](https://static.getiot.tech/linuxqq-search.png#center)

启动程序后，可以看到如下登录界面：

![](https://static.getiot.tech/linuxqq-login.png#center)



## 卸载程序

如果想卸载 QQ Linux 版，Ubuntu（Debian 系）可以通过以下命令卸载：

```bash
sudo dpkg -r linuxqq
```

RedHat 系可以通过以下命令卸载：

```bash
sudo rpm -e linuxqq
```

