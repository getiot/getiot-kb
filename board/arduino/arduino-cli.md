---
sidebar_position: 18
authors: [luhuadong]
---

# Arduino 命令行工具



**Arduino CLI** 是一个命令行工具，它包含围绕 Arduino 生态系统轻松构建应用程序所需的一切，包括管理库、编译、验证和上传草图到 Arduino 开发板。以及执行与 Arduino 生态系统相关的其他操作，例如解析 CLI 的 JSON 输出，或者将其实现为一个在线服务，通过 gRPC 接口接受命令。

本文主要以 Ubuntu 操作系统为例，介绍 Arduino 命令行工具 arduino-cli 的安装和使用。



## 安装步骤

从 Arduino 官方网站下载最新的 .tar.gz 安装包

```bash
wget -qO arduino-cli.tar.gz \
https://downloads.arduino.cc/arduino-cli/arduino-cli_latest_Linux_64bit.tar.gz
```

将 arduino-cli 包解压缩到 `/usr/local/bin` 目录

```bash
sudo tar xf arduino-cli.tar.gz -C /usr/local/bin arduino-cli
```

这样我们就安装好了 arduino-cli 命令行工具，你可以打开任意一个终端使用它。

例如，查看版本信息

```bash
$ arduino-cli version
arduino-cli  Version: 0.20.2 Commit: 13783819 Date: 2021-12-09T13:32:05Z
```

如果你想更新 arduino-cli 工具，只需要重复上述步骤，覆盖原来的可执行文件即可。



## 命令格式

arduino-cli 命令支持许多参数，其语法格式如下：

```bash
arduino-cli <命令> [参数...]
```

可用的命令有：

| 命令            | 描述                            |
| --------------- | ------------------------------- |
| board           | Arduino 开发板命令              |
| burn-bootloader | 上传引导加载程序                |
| cache           | Arduino 缓存命令                |
| compile         | 编译 Arduino 项目               |
| completion      | 已生成脚本                      |
| config          | Arduino 配置命令                |
| core            | Arduino 内核操作                |
| daemon          | 在端口 50051 上作为守护进程运行 |
| debug           | 调试 Arduino 项目               |
| help            | 显示帮助信息                    |
| lib             | Arduino 关于库的命令            |
| monitor         | 开启开发板的通信端口            |
| outdated        | 列出可以升级的内核和库          |
| sketch          | Arduino CLI 项目命令            |
| update          | 更新内核和库的索引              |
| upgrade         | 升级已安装的内核和库            |
| upload          | 上传 Arduino 项目。             |
| version         | 显示 Arduino CLI 的版本号       |

各个命令中又包含了子命令，你可以通过 `-h` 选项来查看具体的子命令用法，例如：

```bash
arduino-cli board -h
```



## 使用方法

### 查看 Arduino 板信息

如果你的电脑已经连接了 Arduino 开发板，那么可以使用 `arduino-cli board list` 命令查看板的信息。

```bash
$ arduino-cli board list
Port         Protocol Type              Board Name      FQBN                 Core
/dev/ttyACM0 serial   Serial Port (USB) Arduino MKRZERO arduino:samd:mkrzero arduino:samd
```

一共六个字段，分别表示端口、协议、类型、开发板名、FQBN、内核。

备注：FQBN 是 Fully Qualified Board Name 的首字母缩写。



### 创建草图

使用 `sketch new` 命令为 Arduino 项目创建一个新的草图（sketch）

```bash
arduino-cli sketch new helloworld
```

这样，我们就创建了一个名为 helloworld 的项目，在 helloworld 目录中包含了一个 `helloworld.ino` 文件。它的内容如下，你可以在这里开始编写 Arduino 代码。

```cpp showLineNumbers
void setup() {
}
 
void loop() {
}
```



### 上传固件

将项目 mySketch 写入 Arduino 开发板上

```bash
arduino-cli board attach serial:///dev/ttyACM0 mySketch
```





