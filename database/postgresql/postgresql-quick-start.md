---
sidebar_position: 4
slug: /postgresql-quick-start
authors: [luhuadong]
---

# PostgreSQL 快速上手

安装好 PostgreSQL 后，你就可以开始使用命令行工具 `psql` 与数据库交互了。作为 PostgreSQL 提供的官方客户端，`psql` 允许你执行 SQL 语句、管理数据库、查看系统信息等。它是你掌握 PostgreSQL 的第一把钥匙。

本章将带你完成一系列典型操作，包括登录数据库、创建数据库和表、插入与查询数据，并掌握一些实用的 `psql` 命令。



## 使用 psql 连接数据库

PostgreSQL 安装完成后会自动创建一个名为 `postgres` 的默认数据库用户和数据库。

你可以使用以下命令切换到该用户并进入 `psql` 命令行界面：

```bash
sudo -i -u postgres
psql
```

💡 如果你为 `postgres` 用户设置了密码，也可以这样登录：

```bash
psql -U postgres -h localhost
```

登录成功后，你将看到类似提示：

```bash
postgres=#
```

这表示你已连接到 `postgres` 数据库，并处于命令交互状态。



## 创建新数据库

使用 SQL 命令创建一个新数据库（例如：`testdb`）：

```bash
CREATE DATABASE testdb;
```

创建成功后，使用 `\c` 命令切换到该数据库：

```sql
\c testdb
```

输出：

```bash
You are now connected to database "testdb" as user "postgres".
```



## 创建用户并授权

出于安全性和多用户协作的考虑，PostgreSQL 通常不推荐一直使用超级用户（如 `postgres`）进行所有数据库操作。你可以为具体项目或开发者创建独立的数据库用户，并授予其对指定数据库的权限。

例如创建一个 `devuser` 用户，允许其操作 `testdb` 数据库：

```sql
-- 创建一个数据库（如果还没有）
CREATE DATABASE testdb;

-- 创建一个新用户（密码请自行设置强度）
CREATE USER devuser WITH PASSWORD 'devpassword';

-- 授权该用户对 testdb 拥有全部操作权限
GRANT ALL PRIVILEGES ON DATABASE testdb TO devuser;
```

`GRANT ALL PRIVILEGES` 命令赋予该用户对指定数据库的所有权限，包括连接、建表、插入、更新、删除等操作。

当你已经创建了用户 `devuser` 并授权，就可以通过该用户身份登录数据库：

```bash
psql -U devuser -d testdb -h localhost -W
```

输入密码后即可连接数据库。

:::tip

`psql` 命令中的 `-W` 选项用于**强制提示输入密码**（prompt for password before connecting），这是一个推荐使用的选项。加上 `-W` 参数后，`psql` 会**在连接前要求你手动输入密码**。

因为如果 PostgreSQL 的身份验证方式为 `trust`，你甚至可以 **不输密码** 就登录数据库。不过，如果使用 `md5` 或 `scram-sha-256` 等方式，则系统会 **自动提示密码**，即使你不写 `-W`。

因此，使用 `-W` 是一种 **明确、安全的做法**，在自动化脚本或公共终端中也可以提醒用户注意输入密码。

:::



## 创建数据表

现在你可以在 `testdb` 中创建一个数据表。例如，我们创建一个 `users` 表：

```sql
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL
);
```

- `SERIAL` 表示自动递增的整数
- `PRIMARY KEY` 表示主键
- `NOT NULL` 表示不允许为空
- `UNIQUE` 表示值不能重复



## 插入数据

向表中添加几条记录：

```sql
INSERT INTO users (name, email) VALUES
('Alice', 'alice@example.com'),
('Bob', 'bob@example.com');
```

插入完成后会提示：

```bash
INSERT 0 2
```

表示成功插入了 2 条记录。



## 查询数据

你可以使用标准 SQL 查询语句查看表中的数据：

```sql
SELECT * FROM users;
```

输出结果类似：

```sql
 id | name  |       email       
----+-------+--------------------
  1 | Alice | alice@example.com
  2 | Bob   | bob@example.com
(2 rows)
```

你还可以加上条件：

```sql
SELECT * FROM users WHERE name = 'Bob';
```



## 退出 psql

完成操作后，你可以使用以下命令退出 `psql`：

```sql
\q
```

然后你可以使用 `exit` 命令返回普通 shell：

```exit
exit
```



## psql 常用命令速查

在 `psql` 中，你可以使用 `\` 开头的命令进行数据库管理。下表列出了 psql 常用的一些命令。

| 命令           | 说明                                      |
| -------------- | ----------------------------------------- |
| `\q`           | 退出 `psql` 命令行                        |
| `\h`           | 查看 SQL 命令语法，例如 `\h CREATE TABLE` |
| `\?`           | 显示所有可用的 `psql` 命令                |
| `\l`           | 列出所有数据库                            |
| `\c dbname`    | 连接到数据库 `dbname`                     |
| `\dt`          | 列出当前数据库中的所有表                  |
| `\d tablename` | 查看指定表的结构                          |
| `\du`          | 列出所有数据库用户                        |
| `\conninfo`    | 显示当前连接信息                          |



## 小结

通过本章内容，你已经掌握了使用 `psql` 登录 PostgreSQL、创建数据库与表、插入与查询数据的基本流程。你还了解了常用的 `psql` 命令，这些都是你后续操作 PostgreSQL 的基础。无论是命令行还是图形界面（如 pgAdmin），本质上都是在执行这些核心操作。接下来，你可以进一步学习用户权限管理、表关联、数据导入导出等高级主题。
