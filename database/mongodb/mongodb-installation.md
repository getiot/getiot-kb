---
sidebar_position: 2
---

# MongoDB 安装

在上一章中，你已经了解了 MongoDB 的基本概念和优势。现在是时候亲自动手，搭建一个本地 MongoDB 环境，开始实践了。本章将指导你如何在 Windows 和 Linux 系统上安装 MongoDB，并学习如何启动数据库和使用 Mongo Shell。



## MongoDB 下载

你可以从 [MongoDB 官方网站](https://www.mongodb.com/try/download/community)免费获取 MongoDB 数据库系统的安装包。请根据你的操作系统（如 Linux 或 Windows）选择 Community Server 版本（不是 Atlas 或 Enterprise 版本），这是适合本地学习与开发的免费版本。

![MongoDB 下载（选择你要的版本）](https://static.getiot.tech/MongoDB_download_linux_20250426.jpg#center)



## 在 Linux 上安装 MongoDB

在 Linux 系统安装 MongoDB 数据库的方式有很多种，最简单的是通过包管理器进行安装。

#### 包管理器

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

<Tabs>
  <TabItem value="ubuntu" label="Debian/Ubuntu 系统" default>
```bash
sudo apt install mongodb
```
  </TabItem>
  <TabItem value="redhat" label="RedHat/CentOS 系统">
```bash
sudo yum install mongodb-org
```
  </TabItem>
</Tabs>

#### 手动安装

通过包管理器可能无法安装最新版本的 MongoDB，这种情况下，你可以下载对应平台的安装包，再从本地进行安装。例如我们下载 Ubuntu 系统最新版本（8.0.8）的软件包，通过 [`dpkg`](/linux-command/dpkg/) 命令安装：

```bash
sudo dpkg -i ~/Downloads/mongodb-org-server_8.0.8_amd64.deb
```

#### 启动测试

安装完成后，使用以下命令启动 MongoDB 服务：

```bash
sudo systemctl start mongodb
```

设置开机启动（可选）：

```bash
sudo systemctl enable mongodb
```

检查服务是否运行：

```bash
sudo systemctl status mongodb
```

连接到 Mongo Shell：

```bash
mongo
```

你可以在 Mongo Shell 中执行一个简单的命令来验证安装情况：

```javascript
db.version()
```

这会返回你当前使用的 MongoDB 版本号，表示安装成功。



:::tip

`mongosh` 是较新版本的 MongoDB Shell，而 `mongo` 是较早版本的 Shell 工具。6.0 版本开始使用 `mongosh` 替代 `mongo` 命令作为客户端连接工具。

`mongosh` 需要单独安装，你可以在[这里](https://www.mongodb.com/zh-cn/docs/mongodb-shell/)下载对应的安装包，安装到你的系统。然后执行下面命令检查是否安装成功：

```bash
$ mongosh --version
2.5.0
```

:::



## 在 Windows 上安装 MongoDB

#### 安装步骤

1. 下载适用于 Windows 的安装程序（.msi 文件）。
2. 双击安装包，按照向导进行安装：
   - 建议选择 **Complete** 模式安装。
   - 勾选安装 **MongoDB Compass**（MongoDB 的图形化界面工具），方便后续查看数据。
3. 安装完成后，MongoDB 默认会被安装在如下路径（例如 `C:\Program Files\MongoDB\Server\7.0\`）：

```bash
C:\Program Files\MongoDB\Server\<version>\
```

#### 配置环境变量

为了在命令行中直接使用 MongoDB 工具（如 `mongod` 和 `mongo`），你需要将 MongoDB 的 bin 目录（`C:\Program Files\MongoDB\Server\<version>\bin`）添加到系统环境变量中。具体操作：

- 进入系统设置 → 高级 → 环境变量 → 系统变量 → Path → 添加路径。

#### 启动测试

完成后重新打开命令行窗口，输入以下命令检查是否配置成功：

```bash
mongod --version
mongo --version
```

MongoDB 默认使用 `C:\data\db` 作为数据存储目录。在连接之前，你需要手动创建这个目录，否则 MongoDB 启动时会报错。

```bash
mkdir C:\data\db
```

然后打开命令行，运行以下命令启动 MongoDB：

```bash
mongod
```

默认情况下，MongoDB 会在端口 `27017` 上运行，并监听连接请求。

如果看到如下信息，说明 MongoDB 已成功启动：

```bash
waiting for connections on port 27017
```

打开另一个终端，运行 Mongo Shell：

```bash
mongo
```

你现在已经进入了 MongoDB 的交互式命令行环境，可以开始操作数据库了！



## MongoDB Compass 图形工具

如果你喜欢图形化界面，也可以使用 MongoDB 官方提供的 Compass 工具。你可以在安装 MongoDB 时一并安装，或者从官网单独下载：

👉 [https://www.mongodb.com/try/download/compass](https://www.mongodb.com/try/download/compass)

Compass 允许你查看数据库、集合、文档结构，以及运行查询、聚合操作等，非常适合初学者使用。



## 小结

本章介绍了如何在本地搭建 MongoDB 开发环境，包括 Windows 和 Linux 系统的安装方法、环境变量配置、数据目录设置以及 MongoDB 的启动与连接。你已经可以通过 Mongo Shell 与 MongoDB 进行交互了。下一章，我们将深入了解 MongoDB 的数据模型，为你的 MongoDB 之旅打下坚实基础。
