---
sidebar_position: 2
---

# MySQL 发展历史



MySQL 的历史可以追溯到 1979 年，它的创始人叫作 Michael Widenius，他在开发一个报表工具的时候，设计了一套 API。

后来他的客户要求他的 API 支持 sql 语句，他直接借助于 mSQL(当时比较牛)的代码，将它集成到自己的存储引擎中。但是他总是感觉不满意，萌生了要自己做一套数据库的想法。

一到 1996 年，MySQL 1.0 发布，仅仅过了几个月的时间，1996 年 10 月 MySQL 3.11.1 当时发布了 Solaris 的版本，一个月后，Linux 的版本诞生，从那时候开始，MySQL 慢慢的被人所接受。

1999 年，Michael Widenius 成立了 MySQL AB 公司，MySQL 由个人开发转变为团队开发，2000 年使用 GPL 协议开源。

2001 年，MySQL 生命中的大事发生了，那就是存储引擎 InnoDB 的诞生!直到现在，MySQL 可以选择的存储引擎，InnoDB 依然是 NO.1。

2008 年 1 月，MySQL AB 公司被 Sun 公司以 10 亿美金收购，MySQL 数据库进入 Sun 时代。

Sun 为 MySQL 的发展提供了绝佳的环境，2008 年 11 月，MySQL 5.1 发布，MySQL 成为了最受欢迎的小型数据库。

在此之前，Oracle 在 2005 年就收购了 InnoDB，因此，InnoDB 一直以来都只能作为第三方插件供用户选择。

2009 年 4 月，Oracle 公司以 74 亿美元收购 Sun 公司，MySQL 也随之进入 Oracle 时代。

2010 年 12 月，MySQL 5.5 发布，Oracle 终于把 InnoDB 做成了 MySQL 默认的存储引擎，MySQL 从此进入了辉煌时代。

然而，从那之后，Oracle 对 MySQL 的态度渐渐发生了变化，Oracle 虽然宣称 MySQL 依然尊少 GPL 协议，但却暗地里把开发人员全部换成了 Oracle 自己人。

开源社区再也影响不了 MySQL 发展的脚步，真正有心做贡献的人也被拒之门外，MySQL 随时都有闭源的可能……

先提一下 MySQL 名字的由来吧，Michael Widenius 的女儿的简称就是 MY，Michael Widenius大 概也是把 MySQL 当成自己的女儿吧。

看着自己辛苦养大的 MySQL 被 Oracle 搞成这样，Michael Widenius 非常失望，决定在 MySQL 走向闭源前，将 MySQL 进行分支化，依然是使用了自己女儿的名字 MariaDB(玛莉亚 DB)。

MariaDB 数据库管理系统是 MySQL 的一个分支，主要由开源社区在维护，采用 GPL 授权许可 MariaDB 的目的是完全兼容 MySQL，包括 API 和命令行，使之能轻松成为 MySQL 的代替品。

在存储引擎方面，使用 XtraDB 来代替 MySQL 的 InnoDB。MariaDB 由 MySQL 的创始人 Michael Widenius 主导，由开源社区的大神们进行开发。

因此，大家都认为，MariaDB 拥有比 MySQL 更纯正的 MySQL 血脉。最初的版本更新与 MySQL 同步，相对 MySQL5 以后的版本，MariaDB 也有相应的 5.1~5.5 的版本。

后来 MariaDB 终于摆脱了 MySQL，它的版本号直接从 10.0 开始，以自己的步伐进行开发，当然，还是可以对 MySQL 完全兼容。现在，MariaDB 的数据特性、性能等都超越了 MySQL。
