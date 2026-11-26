---
sidebar_position: 2
---

# TDengine 安装



TDengine 官方提供的软件有 3 部分：服务端、客户端和报警模块。硬件方面支持 x64、ARM64、MIPS64、Alpha64 等处理器；软件方面，TDengine 服务端仅支持 Linux 系统，客户端支持 Linux 和 Windows 系统。

我们可以通过多种方式安装 TDengine 软件，包括通过包管理器安装、源码安装、Docker 安装等等。本文将在 Ubuntu 系统上演示如何安装 TDengine 软件套件。



## 通过安装包安装

为方便不同操作系统安装，TDengine 服务端程序提供了 rpm、deb、tar.gz 三种格式的安装包，以及稳定版、Lite 版和 Beta 版三种版本，点击[这里](https://www.taosdata.com/cn/getting-started/#%E9%80%9A%E8%BF%87%E5%AE%89%E8%A3%85%E5%8C%85%E5%AE%89%E8%A3%85)可以下载。

- **稳定版本**：标准的服务端安装包，除了服务端程序，还包含客户端程序、各种编程语言的连接器和示例代码；
- **Lite 版本**：轻量级安装包，只包含服务端程序和客户端连接的 C/C++ 语言支持；
- **Beta 版本**：测试版本安装包，包含更多的新功能，适合开发人员测试使用，正式上线建议安装稳定版。

这里使用当前最新的稳定版本 v2.2.2.0，下载到本地后执行如下命令进行安装。

- Debian/Ubuntu 系统：

  ```bash
  sudo dpkg -i TDengine-server-2.2.2.0-Linux-x64.deb
  ```

- RHEL/CentOS 6/7 系统：

  ```bash
  sudo yum install TDengine-server-2.2.2.0-Linux-x64.rpm
  ```

- RHEL/CentOS 8 和 Fedora 系统：

  ```bash
  sudo dnf install TDengine-server-2.2.2.0-Linux-x64.rpm
  ```

安装过程的提示可能如下：

```bash
正在选中未选择的软件包 tdengine。
(正在读取数据库 ... 系统当前共安装有 306398 个文件和目录。)
准备解压 TDengine-server-2.2.2.0-Linux-x64.deb  ...
正在解压 tdengine (2.2.2.0) ...
正在设置 tdengine (2.2.2.0) ...
Start to install TDengine...
Created symlink /etc/systemd/system/multi-user.target.wants/taosd.service → /etc/systemd/system/taosd.service.

System hostname is: OptiPlex-7050

Enter FQDN:port (like h1.taosdata.com:6030) of an existing TDengine cluster node to join
OR leave it blank to build one:

Enter your email address for priority support or enter empty to skip: 

To configure TDengine : edit /etc/taos/taos.cfg
To start TDengine     : sudo systemctl start taosd
To access TDengine    : taos -h OptiPlex-7050 to login into TDengine server


TDengine is installed successfully!
```

安装完成后，系统会增加 taos、taosd、taosdemo、taosdump 几个命令。其中，taos 是客户端程序，taosd 是服务端程序。另外，/etc/taos/taos.cfg 是 TDengine 的配置文件。

执行下面命令检查是否安装成功：

```bash
$ taos -V
version: 2.2.2.0

$ taosd -V
community version: 2.2.2.0 compatible_version: 2.0.0.0
gitinfo: 06c7ae903170ae964cb59da757b97b34156aec4b
gitinfoI: NULL
buildinfo: Built at 2021-11-17 15:56
```

启动服务端程序：

```bash
sudo systemctl start taosd
```

登录本地的 TDengine 服务：

```bash
taos -h $HOSTNAME
```



## 通过包管理器安装

如果使用 Debian 或 Ubuntu 系统，可以使用 apt-get 从官方仓库安装 TDengine。

1、安装包仓库配置：

```bash
wget -qO - http://repos.taosdata.com/tdengine.key | sudo apt-key add -
echo "deb [arch=amd64] http://repos.taosdata.com/tdengine-stable stable main" | sudo tee /etc/apt/sources.list.d/tdengine-stable.list
```

如果想安装 beta 版，则配置为：

```bash
echo "deb [arch=amd64] http://repos.taosdata.com/tdengine-beta beta main" | sudo tee /etc/apt/sources.list.d/tdengine-beta.list
```

2、更新下载：

```bash
sudo apt-get update
apt-get policy tdengine
sudo apt-get install tdengine
```



## 通过源码编译安装

以 Ubuntu 20.04 为例，TDengine 源代码编译及安装步骤如下：

1、安装依赖

```bash
sudo apt-get install -y gcc cmake build-essential git
sudo apt-get install -y openjdk-8-jdk
sudo apt-get install -y  maven
sudo apt install libjansson-dev libsnappy-dev liblzma-dev libz-dev pkg-config
```

2、设置 Go 语言环境（TDengine 包含少量由 Go 语言开发的组件）

```bash
go env -w GO111MODULE=on
go env -w GOPROXY=https://goproxy.cn,direct

```

3、下载源代码（建议直接从 Git 仓库拉取源代码）

```bash
git clone git@github.com:taosdata/TDengine.git
cd TDengine
```

由于 go 和 grafana 等一些工具通过独立的 Git 子仓库进行管理，所以还需要同步子仓库。

```bash
git submodule update --init --recursive
```

4、构建工程

```bash
mkdir debug && cd debug
cmake .. && cmake --build .
```

TDengine 构建脚本支持检测 x86-64、x86、arm64、arm32 和 mips64 的主机体系结构。你也可以通过 `CPUTYPE` 选项指定，例如：

```bash
cmake .. -DCPUTYPE=aarch64 && cmake --build .
```

5、安装

```bash
sudo make install
```

这样，TDengine 就安装好啦！