---
sidebar_position: 3
sidebar_label: pgAdmin 数据库管理工具
slug: /pgadmin-tool
authors: [luhuadong]
---

# pgAdmin 图形化数据库管理工具

在使用 PostgreSQL 时，除了 `psql` 命令行工具，你还可以借助 **pgAdmin** 进行图形化管理。pgAdmin 是 PostgreSQL 官方提供的可视化管理工具，适合你进行数据库连接、表结构查看、SQL 查询、用户管理等操作，界面友好、功能全面，非常适合初学者上手。

本章将带你完成 pgAdmin 的安装与配置，并展示如何通过它连接本地 PostgreSQL 数据库。



## pgAdmin 简介

**pgAdmin** 是 PostgreSQL 官方开发和维护的一款跨平台图形界面工具，支持 Windows、Linux 和 macOS。你可以使用它：

- 连接多个本地或远程数据库
- 可视化管理数据库对象（表、视图、索引等）
- 编写和执行 SQL 查询
- 创建和管理用户权限
- 监控数据库性能等



## 安装 pgAdmin

pgAdmin 不包含在默认的 PostgreSQL 安装中，你需要单独安装，下面以 Ubuntu 为例进行介绍。

### 通过包管理器直接安装

可以直接通过 [`apt`](/linux-command/apt/) 命令安装，目前最新的版本是 pgadmin4（旧系统可能不支持）：

```bash
sudo apt install pgadmin4
```

pgadmin4 软件包中包含了桌面版（desktop）和 Web 版，如果你想单独安装其中之一，可以使用如下命令：

```bash
# Install for desktop mode only
sudo apt install pgadmin4-desktop

# Install for web mode only
sudo apt install pgadmin4-web 
```

### 通过 pgAdmin 仓库安装

上面方法虽然简单，但对于比较旧的系统（如 Ubuntu 20.04）不适用（只能安装 pgadmin3）。一个解决办法是使用 pgAdmin 官方提供的仓库进行安装，确保获取最新版本。

#### 步骤 1：安装依赖

```bash
sudo apt update
sudo apt install curl ca-certificates gnupg
```

#### 步骤 2：添加 pgAdmin 仓库密钥

```bash
curl -fsS https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --dearmor -o /usr/share/keyrings/packages-pgadmin-org.gpg
```

#### 步骤 3：添加 pgAdmin 仓库

以 pgAdmin 4 为例：

```bash
sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'
```

#### 步骤 4：安装 pgAdmin（桌面版 + Web 版）

你可以选择安装桌面版或 Web 版，或者两者都装。

**安装桌面版：**

```bash
sudo apt install pgadmin4-desktop
```

**安装 Web 版（运行在浏览器中）：**

```bash
sudo apt install pgadmin4-web
sudo /usr/pgadmin4/bin/setup-web.sh
```

💡执行 `setup-web.sh` 时会提示你设置管理员邮箱和密码，用于登录 Web 界面。

### 其他平台安装

对于其他平台（如 Windows、macOS），pgAdmin 官网提供了相应的安装包。如有需要，请前往 [pgAdmin Download 页面](https://www.pgadmin.org/download/) 下载。



## 启动 pgAdmin

- **桌面版**：你可以在 Ubuntu 应用菜单中找到 `pgAdmin 4`，点击启动。
- **Web 版**：打开浏览器，访问 `http://localhost/pgadmin4`，输入安装时设置的邮箱和密码即可登录。



## 首次连接 PostgreSQL 数据库

登录 pgAdmin 后，左侧面板显示服务器列表，你可以添加本地或远程数据库连接。

步骤如下：

1. 点击左上角 **“Add New Server”**（添加新服务器）
2. 切换到 **“General”** 标签页，输入一个任意名称（例如 `Local PostgreSQL`）
3. 切换到 **“Connection”** 标签页，填写以下信息：

| 字段              | 内容                           |
| ----------------- | ------------------------------ |
| Host name/address | `localhost`                    |
| Port              | `5432`（默认 PostgreSQL 端口） |
| Maintenance DB    | `postgres`                     |
| Username          | `postgres`                     |
| Password          | 安装 PostgreSQL 时设置的密码   |

4. 点击 “Save” 保存连接

连接成功后，你就可以展开这个服务器，看到数据库、表、函数、登录角色等对象。

![pgAdmin 4 用户界面](https://static.getiot.tech/postgresql_pgadmin4_screenshot.webp#center)



## 使用 pgAdmin 的基础操作

一旦连接成功，你可以开始使用 pgAdmin 管理数据库：

- **创建数据库**：右键 `Databases` → Create → Database。
- **创建表**：展开数据库 → Schemas → Tables → 右键 Create → Table。
- **编写 SQL**：点击顶部菜单栏中的 SQL 图标（或按 Ctrl+E）打开查询工具，输入 SQL 语句进行查询、更新等操作。
- **查看表结构**：在左侧导航中点击表名 → Columns、Constraints 等标签查看结构信息。
- **导入/导出数据**：右键表名，选择 “Import/Export”，可以导入 CSV 或导出查询结果。



## 常见问题提示

- 如果你忘记了 PostgreSQL 超级用户（如 `postgres`）密码，可以通过 `sudo -u postgres psql` 命令重置。

- 如果 pgAdmin 连接失败，请检查 PostgreSQL 是否在运行，使用以下命令查看状态：

  ```bash
  sudo systemctl status postgresql
  ```

- 若你要连接远程服务器，请确保 PostgreSQL 已开启远程访问并在 `pg_hba.conf` 和 `postgresql.conf` 中正确配置。



## 小结

通过 pgAdmin，你可以方便地进行 PostgreSQL 数据库的日常管理，无需复杂的命令行操作。本文介绍了在 Ubuntu 系统下安装 pgAdmin 的方法，并带你完成了首次连接和常见操作。如果你习惯图形界面，pgAdmin 将是你学习和使用 PostgreSQL 的得力助手。
