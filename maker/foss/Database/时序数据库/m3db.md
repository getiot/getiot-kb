---
sidebar_position: 5
slug: /m3db
---

# M3DB

![](https://static.getiot.tech/m3db-logo.svg#center)

**M3DB** 是 Uber 公司以开源形式发布的分布式时间序列数据库，其灵感来自 Gorilla 和 Cassandra，可用于长期保存时存储实时度量。M3DB 完全用 Go 编写，没有任何必需的依赖关系。

M3DB 最优秀的是它精巧的存储模型设计。M3DB 同时利用了内存和硬盘的存储模型，介质的选择取决于数据的使用目的：频繁访问或基于查询的计算任务。对于时序数据而言，在一个请求中，绝大多数数据变换的发生，都会跨越一个时间切片的多个序列中。M3DB通过将数据进行列式存储，将不同序列的数据存储在一个内存区块内，这样大部分据数据变换工作就可以非常快速的在不同的区块内进行并行计算，因而提高了计算速度。

- 项目主页：[https://m3db.io](https://m3db.io)
- GitHub 仓库：[https://github.com/m3db/m3](https://github.com/m3db/m3)





## 参考

- [M3DB原理概述](https://blog.csdn.net/weixin_43704599/article/details/116060618)
- [你需要知道的机器学习知识 - 关于时序数据和时序数据库](https://www.jianshu.com/p/048a36a88a17)

