---
sidebar_position: 4
---

# TDengine 极速体验



TDengine 提供了一个 **taosdemo** 命令，执行该命令将在数据库 `test` 下面自动创建一张超级表 `meters`，这张表有以下特点：

- 该超级表下有 1 万张表，表名为 "d0" 到 "d9999"；
- 每张表有 1 万条记录，每条记录有 `(ts, current, voltage, phase)` 四个字段，时间戳从 "2017-07-14 10:40:00 000" 到 "2017-07-14 10:40:09 999"；
- 每张表带有标签 `location` 和 `groupId`，其中 `groupId` 被设置为 1 到 10，`location` 被设置为 "beijing" 或者 "shanghai"。

启动 TDengine 的服务，在 Linux 终端执行 taosdemo

```bash
$ taosdemo
```

执行这条命令大概需要几分钟，最后共插入 1 亿条记录。

在 TDengine 客户端输入查询命令，体验查询速度。

- 查询超级表下记录总条数：

```sql
taos> select count(*) from test.meters;
```

- 查询1亿条记录的平均值、最大值、最小值等：

```sql
taos> select avg(current), max(voltage), min(phase) from test.meters;
```

- 查询 `location="beijing"` 的记录总条数：

```sql
taos> select count(*) from test.meters where location="beijing";
```

- 查询 `groupId=10` 的所有记录的平均值、最大值、最小值等：

```sql
taos> select avg(current), max(voltage), min(phase) from test.meters where groupId=10;
```

- 对表 d10 按 10s 进行平均值、最大值和最小值聚合统计：

```sql
taos> select avg(current), max(voltage), min(phase) from test.d10 interval(10s);
```

**提示**：taosdemo 命令本身带有很多选项，配置表的数目、记录条数等等，请执行 `taosdemo --help`详细列出。





