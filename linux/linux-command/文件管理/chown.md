---
sidebar_position: 5
slug: /chown
---

# chown 命令



## 介绍

**chown**（英文全拼：change owner）是 Linux 系统中用于改变文件所有者和文件关联组的一个命令。chown 是 Linux 系统中关于权限的重要命令之一，另外一个是 [`chmod`](/linux-command/chmod) 命令。

**语法**：

```bash
chown [OPTION]... [OWNER][:[GROUP]] FILE...
```

注意，这里的文件名可以使用空格分开的文件列表，在文件名中可以包含通配符。

**选项**：

- `OWNER`：新的文件拥有者的用户名或用户 ID。
- `GROUP`：新的文件拥有者的用户组名或组 ID。
- `-c`：显示更改的部分的信息。
- `-f`：忽略错误信息。
- `-h`：修复符号链接。
- `-v`：显示详细的处理信息。
- `-R`：递归处理指定目录以及其子目录下的所有文件。
- `--help`：显示帮助信息并退出。
- `--version`：显示版本信息并退出。



## 示例

将文件 getiot 的拥有者权限修改为 rudy：

```bash
chown rudy:rudy getiot
```

将 /opt/data 目录的拥有者权限修改为 rudy：

```bash
chown -R rudy:rudy /opt/data
```

