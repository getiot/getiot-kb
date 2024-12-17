---
sidebar_position: 1
slug: /centreon
---

# Centreon 监控系统

## Centreon 简介

**Centreon** 是一款开源的分布式 IT 监控系统，由法国人于 2003 年开发，最初名为 Oreon，并于 2005 年正式更名为 Centreon。Centreon 的功能强大，可以通过第三方组件可以实现对网络、操作系统和应用程序的监控。

Centreon 的底层采用 nagios 作为监控软件，同时 nagios 通过 ndoutil 模块将监控到的数据定时写入数据库中，而 Centreon 实时从数据库读取该数据并通过 Web 界面展现监控数据。我们可以通过 Centreon 管理和配置 nagios，或者说 Centreon 就是 nagios 的一个管理配置工具，通过 Centreon 提供的 Web 配置界面，可以轻松完成 nagios 的各种繁琐配置。此外，Centreon 还支持 NRPE、SNMP、NSClient 等插件，可以通过这些插件构建分布式的监控报警系统。

![](https://static.getiot.tech/centreon-logo.png#center-300)

- 项目官网：[https://www.centreon.com](https://www.centreon.com)
- GitHub 仓库：[https://github.com/centreon/centreon](https://github.com/centreon/centreon)
- Centreon 文档：[https://docs.centreon.com/current/en/](https://docs.centreon.com/current/en/)



## Centreon 组成

一个典型的 Centreon 监控系统通常由四大部分组成，分别是 nagios、centstorage、centcore 和 ndoutils。

1. **nagios** 是 Centreon 的底层监控引擎，主要完成监控报警系统所需的各项功能，是 Centreon 监控系统的核心。另外，Centreon 还支持 Centreon Engine、Icinga 等监控引擎。
2. **centstorage** 是一个数据存储模块，它主要用于将日志数据及 RRDtool 生成的数据存储到数据库中，以供用户查询日志数据并快速生成曲线图，更主要的是 nagios 可以随时通过查看数据库中的记录更新监控状态。
3. **centcore** 主要用于 cnetreon 的分布式监控系统中，在系统中 centcore 是一个基于 perl 的守护进程，主要负责中心服务器（central server）和扩展节点（pollers）间的通信和数据同步等操作，例如 centcore 可以在中心服务器上执行对远程扩展节点上 nagios 服务的启动、关闭和重启操作，还可以运行、更新扩展节点上 nagios 的配置文件。
4. **ndoutils** 是将 nagios 与数据库进行连接的工具，它可以将 nagios 的实时状态写入数据库，以供其他程序去调用，最终可以实现在一个控制台上完成所有扩展节点的数据入库操作。



## Centreon 工作原理

Centreon 监控系统内部各个组成部分的工作原理如下图所示。

![](https://static.getiot.tech/centreon-working-principle.jpg#center)

通常，Centreon Web、Centrstorage、Centcore 和 Ndo2DB 位于中心服务器上，而 Nagios 和 Ndomod 可以位于一台独立的扩展节点（pollers）上，也可以位于中心服务器上。在分布式监控环境中，Nagios 和 Ndomod 都位于远程的一个扩展节点上。





## 参考

- [分布式监控报警平台Centreon之：Centreon简介](https://blog.51cto.com/ixdba/1576028)
- [Nagios+Centreon监控系统简介](https://www.daimajiaoliu.com/daima/5692457e0bc6c09)
