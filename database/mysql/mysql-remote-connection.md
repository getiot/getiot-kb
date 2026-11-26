---
sidebar_position: 7
---

# MySQL 远程连接



如果您要使用外部程序，例如 phpMyAdmin。以 root 用户连接到 MySQL 服务器，则有两个选择。

第一个是将身份验证方法从 `auth_socket` 更改为 `mysql_native_password`。可以通过运行 `ALTER USER` SQL 语句命令来做到这一点。

第二个选项是创建一个新的专用管理用户，该用户可以访问所有数据库。

下面将使用第一个选项运行 `ALTER USER` SQL 语句使 root 用户使用密码进行身份验证。

```sql
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '你的密码';
FLUSH PRIVILEGES;
```

如果你需要配置 MySQL 用户的远程访问，可参考我们的教程[如何允许MySQL数据库服务器的远程连接](https://www.myfreax.com/mysql-remote-access/)**。**

