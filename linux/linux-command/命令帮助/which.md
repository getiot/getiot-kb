---
sidebar_position: 5
slug: /which
---

# which 命令



## 介绍

**which** 命令的作用是在 PATH 变量指定的路径中，搜索某个系统命令的位置，并且返回第一个搜索结果。

运维人员在日常工作中经常使用 which 命令来检查某个系统命令是否存在，或者找出所执行命令所对应的具体位置。

**语法**：

```bash
which [-a] filename ...
```

**选项**：

- `-a` ：显示所有匹配的路径名



## 示例

查找 mysql 命令的路径

```bash
$ which mysql
/usr/bin/mysql
```

查看所有匹配 mysql 的路径

```bash
$ which -a mysql
/usr/bin/mysql
/bin/mysql
```

