---
sidebar_label: addgroup 命令
sidebar_position: 14
slug: /addgroup
---

# addgroup 命令



## 介绍

在 Linux 系统中，**addgroup** 命令用于创建新的用户组（group）。`addgroup` 在不同的发行版中有不同的实现，它可能是 [`groupadd`](/linux-command/groupadd) 的别名，也可能是一个脚本程序，可以更方便地创建用户组。

:::tip

使用 `addgroup` 命令需要具有足够的权限，通常需要以超级用户（root）或具有 sudo 权限的用户身份运行。

:::

**语法**：

```bash
addgroup [options] group
```

**选项**：

- `--quiet | -q`：不将进程信息发给 stdout。
- `--force-badname`：允许与 `NAME_REGEX[_SYSTEM]` 配置变量不匹配的用户名。
- `--extrausers`：使用额外的用户作为数据库。
- `--help | -h`：显示帮助信息。
- `--version | -v`：显示版本信息。
- `--conf | -c FILE`：使用 `FILE` 作为配置文件。



## 示例

创建一个新用户组 students：

```bash
sudo addgroup students
```
