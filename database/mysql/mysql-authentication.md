---
sidebar_position: 5
---

# MySQL 身份验证



unix_socket认证插件允许用户通过本地Unix套接字文件连接到MariaDB的时候使用操作系统的凭证。

通俗的讲就是用Linux操作系统的账号，去登录MariaDB/MySQL数据库。

这个功能是在 MariaDB 10.4.6版本里添加的，目前也支持在MySQL 8.0.18版本中。



安装插件

```mysql
INSTALL PLUGIN auth_socket SONAME 'auth_socket.so';
```

创建账户

```mysql
CREATE USER 'hechunyang'@'localhost' IDENTIFIED WITH auth_socket;
```



## 免密登录

免密登录--配置 ".my.cnf"文件
