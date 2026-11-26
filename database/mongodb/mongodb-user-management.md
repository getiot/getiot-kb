---
sidebar_position: 5
---

# MongoDB 用户管理

在使用 MongoDB 时，用户管理是一个非常重要的环节。无论是创建用户、分配角色，还是进行认证和登录，这些操作都能帮助你更好地控制数据库的访问权限。接下来，就让我们一起学习如何在 MongoDB 中进行用户管理吧！



## 使用 MongoDB Shell 管理用户

### 1. 连接到 MongoDB

首先，你需要通过终端打开 MongoDB Shell。使用以下命令连接到 MongoDB 服务器：

```bash
mongosh --host <hostname> --port <port>
```

- `mongosh`：启动 MongoDB Shell。
- `--host <hostname>`：指定 MongoDB 服务器的主机名或 IP 地址。例如，`localhost` 或 `127.0.0.1`。
- `--port <port>`：指定 MongoDB 服务器的端口号，默认是 `27017`。

### 2. 切换到目标数据库

在 MongoDB 中，用户是针对特定数据库创建的。使用 `use` 命令切换到你要操作的数据库：

```bash
use <database_name>
```

- `<database_name>`：你要切换到的数据库名称。

### 3. 创建用户

接下来，使用 `db.createUser` 命令创建用户并分配角色。例如，创建一个名为 `testuser` 的用户，密码为 `password123`，并赋予 `readWrite` 和 `dbAdmin` 角色：

```javascript
db.createUser({
  user: "testuser",
  pwd: "password123",
  roles: [
    { role: "readWrite", db: "<database_name>" },
    { role: "dbAdmin", db: "<database_name>" }
  ]
})
```

- `user`：用户名。
- `pwd`：用户密码。
- `roles`：分配给用户的角色列表。

### 4. 验证用户

创建用户后，你可以使用 `db.auth` 命令验证用户身份：

```javascript
db.auth("testuser", "password123")
```

如果认证成功，返回值为 `1`；如果失败，返回值为 `0`。

### 5. 启用身份验证

为了确保只有经过身份验证的用户才能访问 MongoDB，你需要启用身份验证。编辑 MongoDB 配置文件 `mongod.conf`，在其中添加以下内容：

```yaml
security:
  authorization: "enabled"
```

然后重启 MongoDB 服务以应用更改：

```bash
sudo systemctl restart mongod
```

### 6. 使用用户身份登录

启用身份验证后，你需要使用创建的用户身份连接到 MongoDB：

```bash
mongosh --host <hostname> --port <port> -u "testuser" -p "password123" --authenticationDatabase "<database_name>"
```

- `-u "testuser"`：指定用户名。
- `-p "password123"`：指定用户密码。
- `--authenticationDatabase "<database_name>"`：指定认证数据库。

### 7. 删除用户

如果需要删除用户，可以使用 `db.dropUser` 命令。例如，删除名为 `testuser` 的用户：

```bash
db.dropUser("testuser")
```



## 实例操作

以下是一个完整的示例操作流程：

1. 启动 MongoDB Shell 并连接到服务器：

   ```bash
   mongosh --host localhost --port 27017
   ```

2. 切换到 `testdb` 数据库：

   ```bash
   use testdb
   ```

3. 创建 `testuser` 用户：

   ```bash
   db.createUser({
     user: "testuser",
     pwd: "password123",
     roles: [{ role: "readWrite", db: "testdb" }]
   })
   ```
   
4. 启用身份验证并重启 MongoDB 实例：

   - 编辑 `mongod.conf` 文件，添加以下内容：

     ```yaml
      security:
       authorization: "enabled"
     ```
     
   - 重启 MongoDB 服务：
   
     ```bash
     sudo systemctl restart mongod
     ```

5. 使用 `testuser` 用户进行身份验证连接：

   ```bash
   mongosh --host localhost --port 27017 -u "testuser" -p "password123" --authenticationDatabase "testdb"
   ```

6. 删除 `testuser` 用户：

   ```bash
   db.dropUser("testuser")
   ```




## 小结

通过本文，你已经学会了如何在 MongoDB 中进行用户管理，包括连接到 MongoDB、创建用户、分配角色、验证用户、启用身份验证以及使用用户身份登录。这些操作能够帮助你更好地控制数据库的访问权限，确保数据的安全性。希望这些内容能帮助你快速掌握 MongoDB 的用户管理。
