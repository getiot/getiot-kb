---
sidebar_label: poweroff 命令
sidebar_position: 47
slug: /poweroff
---

# poweroff 命令 - 关闭系统电源



## 介绍

在 Linux 系统中，**poweroff** 命令用来关闭计算机操作系统并且切断系统电源。如果确认系统中已经没有用户存在且所有数据都已保存，需要立即关闭系统，可以使用 `poweroff` 命令。

**语法**：

```bash
poweroff [OPTIONS...]
```

**选项**：

- `-n`：关闭操作系统时不执行 sync 操作。
- `-w`：不真正关闭操作系统，仅在日志文件 /var/log/wtmp 中记录。
- `-d`：关闭操作系统时，不将操作写入日志文件 /var/log/wtmp 中添加相应的记录。
- `-f`：强制关闭操作系统。
- `-i`：关闭操作系统之前关闭所有的网络接口。
- `-h`：关闭操作系统之前将系统中所有的硬件设置为备用模式。



## 示例

关闭计算机操作系统并且切断系统电源：

```bash
poweroff
```

在关闭操作系统之前将系统中所有的硬件设置为备用模式：

```bash
poweroff -h
```

