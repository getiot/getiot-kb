---
sidebar_label: mkdir 命令
sidebar_position: 10
slug: /mkdir
---

# mkdir 命令 - 创建目录



## 介绍

**mkdir**（英文全拼：make directory）命令用于创建目录。

**语法**：

```bash
mkdir [选项] dirName
```

**选项**：

- `-Z`：设置安全上下文，当使用 SELinux 时有效；
- `-m <目标属性>` 或 `--mode<目标属性>`：建立目录的同时设置目录的权限；
- `-p` 或 `--parents`：若所要建立目录的上层目录目前尚未建立，则会一并建立上层目录；
- `--version`：显示版本信息。

**参数**：

参数 `dirName` 为将要创建的目录名称。如果在目录名的前面没有加任何路径名，则在当前目录下创建由 `dirName` 指定的目录；如果给出了一个已经存在的路径，将会在该目录下创建一个指定的目录。在创建目录时，应保证新建的目录与它所在目录下的文件没有重名。



## 示例

在当前目录下创建一个名为 getiot 的子目录

```bash
mkdir getiot
```

创建并设置 getiot 目录权限为 700

```bash
mkdir -m 700 getiot
```

在当前目录下创建 getiot/linux 目录（如果 getiot 目录不存在，则创建一个）

```bash
mkdir -p getiot/linux 
```

注意：如果不加 -p 参数，且 getiot 目录不存在，会产生错误。

