---
sidebar_position: 21
---

# MongoDB 状态监控

在部署 MongoDB 时，了解应用在生产环境中的表现至关重要。为了确保系统稳定运行，你需要提前规划并测试部署环境，避免在生产环境中出现意外问题。MongoDB 提供了一些工具来帮助你监控系统状态，接下来就让我们一起学习如何使用这些工具吧！



## 使用 `mongostat` 监控状态

**`mongostat`** 是一个命令行工具，用于监控 MongoDB 实例的运行状态。它会显示 MongoDB 实例的实时状态信息，包括插入、查询、更新、删除等操作的计数器，以及锁的使用情况和内存使用情况等。这些信息可以帮助你了解系统是否内存不足、写入容量是否达到极限或是否存在性能问题。

**使用方法：**

启动你的 `mongod` 实例后，在另一个命令提示符中，进入 MongoDB 安装目录的 `bin` 文件夹，然后运行以下命令：

```bash
mongostat
```

**示例输出：**

运行 `mongostat` 命令后，你将看到类似以下的输出：

```bash showLineNumbers
insert  query update delete getmore command flushes mapped  vsize    res faults locked % idx miss %     qr|qw   ar|aw  netIn netOut  conn       time
     *0     *0      *0      *0       *0     1|0       0  2.0G  4.0G   128m      0    0.0%       0%       0|0     0|0    62b     88b     1 12:34:56
```

**输出字段说明：**

- **`insert/query/update/delete/getmore/command`**：表示每秒的插入、查询、更新、删除、获取更多结果和命令操作的次数。
- **`flushes`**：每秒将数据从内存刷新到磁盘的次数。
- **`mapped/vsize/res/faults`**：映射的内存大小、虚拟内存大小、常驻内存大小和页面错误次数。
- **`locked %`**：锁定的百分比，表示 MongoDB 实例被锁定的时间比例。
- **`idx miss %`**：索引未命中百分比。
- **`qr|qw/ar|aw`**：查询队列和写入队列的长度。
- **`netIn/netOut`**：每秒进入和离开网络的字节数。
- **`conn`**：当前连接数。
- **`time`**：当前时间。



## 使用 `mongotop` 监控读写活动

**`mongotop`** 是一个命令行工具，用于跟踪和报告 MongoDB 实例在集合级别的读写活动。默认情况下，`mongotop` 每秒返回一次信息，但你可以根据需要调整这个频率。通过检查读写活动，你可以确保应用的读写操作符合预期，避免对数据库进行过多的写入操作、过于频繁地从磁盘读取数据或超出工作集大小。

**使用方法：**

启动你的 `mongod` 实例后，在另一个命令提示符中，进入 MongoDB 安装目录的 `bin` 文件夹，然后运行以下命令：

```bash
mongotop
```

**调整输出频率：**

如果你希望 `mongotop` 返回信息的频率更低，可以在命令后指定一个数字，表示返回信息的时间间隔（以秒为单位）。例如：

```bash
mongotop 30
```

上述命令将每 30 秒返回一次值。

**示例输出：**

运行 `mongotop` 命令后，你将看到类似以下的输出：

```bash showLineNumbers
ns                  total|w  read|w   write|w
local.oplog.rs       0|0       0|0       0|0
admin.system.version 0|0       0|0       0|0
test.mycol           10|0      5|0       5|0
```

**输出字段说明：**

- **`ns`**：命名空间，表示数据库和集合的名称。
- **`total|w`**：总操作时间（毫秒）。
- **`read|w`**：读操作时间（毫秒）。
- **`write|w`**：写操作时间（毫秒）。



## 其他监控工具

除了 MongoDB 提供的工具外，MongoDB 官方还提供了一个免费的托管监控服务 —— MongoDB Management Service（MMS）。MMS 提供了一个仪表板，可以让你查看整个集群的指标。



## 小结

通过本文，你已经了解了如何使用 `mongostat` 和 `mongotop` 来监控 MongoDB 的运行状态和读写活动。这些工具可以帮助你提前发现潜在的性能问题，确保系统在生产环境中的稳定运行。希望这些内容能帮助你更好地管理和监控 MongoDB 数据库！

