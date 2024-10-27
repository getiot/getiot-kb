---
sidebar_label: delgroup 命令
sidebar_position: 15
slug: /delgroup
---

# delgroup 命令



## 介绍

在 Linux 系统中，**delgroup** 命令用于删除用户组（group）。`delgroup` 在不同的发行版中有不同的实现，它可能是 [`groupdel`](/linux-command/groupdel) 的别名，也可能是一个脚本程序，可以更方便地创建用户组。

:::tip

使用 `delgroup` 命令需要具有足够的权限，通常需要以超级用户（root）或具有 sudo 权限的用户身份运行。

:::

**语法**：

```bash
delgroup [options] [--only-if-empty] group
```

**选项**：

- `--quiet | -q`：不将进程信息发给 stdout。
- `--system`：只有当该用户组是系统用户组时才删除。
- `--only-if-empty`：只有当该用户组中无成员时才删除。
- `--help | -h`：显示帮助信息。
- `--version | -v`：显示版本信息。
- `--conf | -c FILE`：使用 `FILE` 作为配置文件。



## 示例

删除 students 用户组：

```bash
sudo addgroup students
```

等效于：

```bash
sudo deluser --group students
```

