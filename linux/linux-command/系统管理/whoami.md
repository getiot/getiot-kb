---
sidebar_label: whoami 命令
sidebar_position: 32
slug: /whoami
---

# whoami 命令



## 介绍

在 Linux 系统中，**whoami** 命令可用于打印与当前有效用户 ID 关联的用户名。这个工具可以用来获取本地系统上当前用户（访问令牌）的用户名和组信息，以及相应的安全标识符（SID）、声明、本地系统上当前用户的权限、登录标识符（登录 ID）。

:::tip

whoami 命令显示自身的用户名称，本指令相当于执行 `id -un` 指令。

:::

**语法**：

```bash
whoami [OPTION]...
```

**选项**：

- `--help`：显示帮助信息。
- `--version`：显示版本信息。



## 示例

查询当前登录的用户名：

```bash
whoami
```
