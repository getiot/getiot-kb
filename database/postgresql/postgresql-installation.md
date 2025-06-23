---
sidebar_position: 2
slug: /postgresql-installation
draft: true
authors: [luhuadong]
---

# PostgreSQL 安装

在你开始学习 PostgreSQL 数据库开发之前，首先需要在本地环境中安装并配置好 PostgreSQL。这一步是你后续编写、执行 SQL 语句、管理数据的基础。本章将带你了解如何在不同操作系统中安装 PostgreSQL，以及如何使用默认的数据库工具连接并管理数据库。



## PostgreSQL 支持的平台

PostgreSQL 是一个跨平台的数据库系统，支持多种主流操作系统，包括：

- Linux（如 Ubuntu、CentOS、Debian 等）
- Windows
- macOS

你可以根据自己的开发环境选择合适的安装方式。PostgreSQL 的安装包可以从官网下载，也可以通过操作系统的包管理器进行安装。

官方网站下载地址：[https://www.postgresql.org/download/](https://www.postgresql.org/download/)



## 在 Linux 上安装 PostgreSQL

Linux 用户可以使用系统自带的包管理器快速安装 PostgreSQL。

以 Ubuntu 为例，你可以使用如下命令：

```bash
sudo apt update
sudo apt install postgresql postgresql-contrib
```

- `postgresql` 是核心数据库软件
- `postgresql-contrib` 包含一些常用扩展模块

安装完成后，PostgreSQL 会自动以 `postgres` 用户身份运行一个数据库服务进程。

你可以使用如下命令切换到 PostgreSQL 的默认超级用户：

```bash
sudo -i -u postgres
```

然后通过 `psql` 进入命令行界面：

```bash
psql
```



## 在 macOS 上安装 PostgreSQL

你可以通过 Homebrew 安装 PostgreSQL，这是 macOS 上常用的包管理工具。

```bash
brew update
brew install postgresql
```

安装完成后，你可以使用以下命令启动 PostgreSQL 服务：

```bash
brew services start postgresql
```

使用 `psql` 命令进入数据库交互界面：

```bash
psql postgres
```

如果提示找不到 `psql`，你可能需要将 `/opt/homebrew/bin` 或 `/usr/local/bin` 添加到环境变量中。



## 在 Windows 上安装 PostgreSQL

PostgreSQL 在 Windows 上提供了图形化安装程序，适合初学者快速部署。

步骤如下：

1. 访问 [https://www.postgresql.org/download/windows/](https://www.postgresql.org/download/windows/)
2. 点击页面上的 **"Download the installer"**，进入 EDB（EnterpriseDB）页面。
3. 选择适合的版本和操作系统架构（例如 Windows x86-64），点击下载。
4. 运行下载好的安装程序（例如 `postgresql-16.x-windows-x64.exe`），按向导进行安装。

你需要配置以下参数：

- 安装路径（Install Directory）
- 数据目录（Data Directory）
- 超级用户密码（Password）：这是 `postgres` 用户的初始密码，请妥善保存
- 端口号（默认 5432）
- 选择安装组件（建议保留默认设置）

安装完成后，你可以选择是否安装 pgAdmin（图形界面管理工具）和 StackBuilder（用于安装扩展组件）。



## 验证安装是否成功

无论你使用哪种方式安装 PostgreSQL，都可以通过以下命令验证是否安装成功：

```bash
psql --version
```

输出版本号说明安装成功，例如：

```bash
psql (PostgreSQL) 16.1
```

如果是 Linux 系统（例如 Ubuntu）还可以通过 [`systemctl`](/linux-command/systemctl/) 检查 PostgreSQL 服务是否正在运行：

```bash
sudo systemctl status postgresql
```

如果输出中包含 `active (running)`，说明数据库服务已经正常启动。

PostgreSQL 默认监听端口为 **5432**，你可以使用 [`ss`](/linux-command/ss/) 或 [`netstat`](/linux-command/netstat/) 命令确认端口是否开启：

```bash
ss -tnlp | grep 5432
# 或
netstat -tnlp | grep 5432
```



## 设置环境变量

为了在任何位置都能使用 `psql` 命令，你可以将 PostgreSQL 的 `bin` 目录添加到系统环境变量中：（如果安装时已经添加环境变量，则忽略这一步）

- Windows：将 `C:\Program Files\PostgreSQL\<version>\bin` 添加到 `PATH`
- macOS / Linux：修改 `~/.bashrc` 或 `~/.zshrc`，添加如下内容：

```bash
export PATH="/usr/local/pgsql/bin:$PATH"
```



## 小结

本文带你完成了 PostgreSQL 的安装与配置，包括 Windows、Linux 和 macOS 平台的安装方法。你还学习了 `psql` 命令行的使用，学会了如何验证 PostgreSQL 是否安装成功或是否正常运行，确保你能正常进入 PostgreSQL 环境，这是后续学习和开发的基础。接下来，我们将学习使用 pgAdmin 图形界面管理数据库，使用 SQL 创建和管理数据库对象。
