---
sidebar_position: 4
---

# MongoDB 连接服务

在开始使用 MongoDB 之前，你需要先学会如何连接到 MongoDB 服务。无论是通过命令行工具，还是使用各种编程语言的驱动程序，连接 MongoDB 都是操作数据库的第一步。接下来，就让我们一起了解如何连接 MongoDB 服务吧！



## 启动 MongoDB 服务

在连接 MongoDB 之前，首先要确保 MongoDB 服务已经启动。你可以在 MongoDB 安装目录的 `bin` 文件夹下找到 `mongod` 可执行文件，并运行它来启动服务。启动后，MongoDB 会在输出一些必要信息后等待连接的建立，当有客户端连接时，就会开始打印日志信息。



## 使用 MongoDB Shell 连接

MongoDB Shell 是一个命令行工具，用于与 MongoDB 服务进行交互。你可以通过在终端或命令提示符中输入 `mongosh` 来启动 MongoDB Shell：

```bash
$ mongosh
```

默认情况下，它会尝试连接到本地运行的 MongoDB 服务（默认端口为 `27017`）。如果连接成功，你会看到类似以下的输出：

```bash
Current Mongosh Log ID:    66792d6b87657ebec9ed70f1
Connecting to:        mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.2.9
Using MongoDB:        7.0.11
Using Mongosh:        2.2.9
```



## 标准 URI 连接语法

MongoDB 使用标准的 URI 格式来连接数据库，这种格式非常灵活，可以包含多种连接选项。标准的连接 URI 格式如下：

```bash
mongodb://[username:password@]host1[:port1][,...hostN[:portN]][/[defaultauthdb][?options]]
```

- `mongodb://`：协议头，表示使用 MongoDB。
- `[username:password@]`：（可选）认证信息，包括用户名和密码。
- `host1[:port1][,...hostN[:portN]]`：服务器地址和端口，可以是一个或多个 MongoDB 服务器的地址和端口。
- `/[defaultauthdb]`：（可选）默认认证数据库。
- `[?options]`：（可选）连接选项，例如 `authSource`（指定认证数据库）、`replicaSet`（指定副本集名称）、`ssl`（启用 SSL 连接）等。



## MongoDB 数据库连接示例

连接到本地 MongoDB 实例（默认端口 27017）：

```bash
mongodb://localhost
```

连接到本地 MongoDB 实例并指定数据库：

```bash
mongodb://localhost/mydatabase
```

使用用户名和密码连接到本地 MongoDB 实例：

```bash
mongodb://username:password@localhost/mydatabase
```

连接到远程 MongoDB 实例：

```bash
mongodb://remotehost:27017
```

连接到副本集（Replica Set）：

```bash
mongodb://host1:27017,host2:27017,host3:27017/mydatabase?replicaSet=myReplicaSet
```

使用 SSL 连接到 MongoDB：

```bash
mongodb://username:password@localhost:27017/mydatabase?ssl=true
```

使用多个选项连接：

```bash
mongodb://username:password@localhost:27017/mydatabase?authSource=admin&ssl=true
```



## 使用编程语言连接 MongoDB

### 使用 Python（PyMongo）连接

```python showLineNumbers
from pymongo import MongoClient

client = MongoClient('mongodb://user:password@localhost:27017/mydatabase?authSource=admin')
db = client['mydatabase']
```



### 使用 Node.js（Mongoose）连接

```javascript showLineNumbers
const mongoose = require('mongoose');

mongoose.connect('mongodb://user:password@localhost:27017/mydatabase?authSource=admin', {
    useNewUrlParser: true,
    useUnifiedTopology: true
});

const db = mongoose.connection;
db.on('error', console.error.bind(console, 'connection error:'));
db.once('open', function() {
    console.log('Connected to MongoDB');
});
```



### 使用 PHP 连接

```php showLineNumbers
<?php
require 'vendor/autoload.php'; // 引入 Composer 自动加载文件

$client = new MongoDB\Client("mongodb://localhost:27017"); // 连接到本地 MongoDB 实例
$database = $client->selectDatabase('mydatabase'); // 选择数据库
$collection = $database->selectCollection('mycollection'); // 选择集合

// 插入文档
$result = $collection->insertOne(['name' => 'Alice', 'age' => 30]);
echo "Inserted with Object ID '{$result->getInsertedId()}'";

// 查询文档
$document = $collection->findOne(['name' => 'Alice']);
echo "Found document: " . json_encode($document);
?>
```



### 使用 Java 连接

```java showLineNumbers
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoDatabase;

public class MongoDBConnection {
    public static void main(String[] args) {
        String uri = "mongodb://user:password@localhost:27017/mydatabase?authSource=admin";
        try (MongoClient mongoClient = MongoClients.create(uri)) {
            MongoDatabase database = mongoClient.getDatabase("mydatabase");
            System.out.println("Connected to MongoDB");
        }
    }
}
```



## 小结

通过本文，你已经了解了如何启动 MongoDB 服务以及如何通过 MongoDB Shell 和各种编程语言连接到 MongoDB 服务。标准的 URI 连接格式为你提供了灵活的连接选项，无论是连接到本地实例、远程实例还是副本集，都可以轻松实现。希望这些内容能帮助你快速上手 MongoDB 的连接操作。
