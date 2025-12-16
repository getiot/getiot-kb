---
sidebar_position: 4
slug: /timescaledb
---

# TimescaleDB

![](https://static.getiot.tech/timescaledb-logo.png#center)

**TimescaleDB** 是 timescale.inc 开发的一款兼容 SQL 的时序数据库，其底层存储架构基于 PostgreSQL 数据库，作为一个 PostgreSQL 的扩展提供服务。可随着 PostgreSQL 的版本升级而升级，不会因为另立分支带来麻烦。

- 项目主页：[https://www.timescale.com](https://www.timescale.com)
- GitHub 仓库：[https://github.com/timescale/timescaledb](https://github.com/timescale/timescaledb)

在 TimescaleDB 上数据必须抽象为一张二维表。关于怎么设计这张二维表，TimescaleDB 给出了 narrow table 和 wide table 的两个范式。

- Narrow table 就是 metric 分开记录，每行的 unique key 为 metricvalue + timestamp；
- Wide table 的 unique key 只有 timestamp，如果一个设备有多个 metric，则将多个 metric 合并到同一行。



## 参考

- [时序数据库 timescaledb](https://zhuanlan.zhihu.com/p/69282774)
- [mysql和timescale联合查询_TimescaleDB-基于PostgreSQL开发的时序数据库](https://blog.csdn.net/weixin_42291186/article/details/113605889)

