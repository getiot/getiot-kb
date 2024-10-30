---
sidebar_label: patch 命令
sidebar_position: 9
slug: /patch
---

# patch 命令 - 应用文件补丁



## 介绍

**patch** 命令用于修补文件（给文件打补丁）。Linux 早期正是使用 patch 命令来合并代码。

**语法**：

```bash
patch [options] [originalfile [patchfile]]
```

**选项**：

- `-i <patchfile>` 或 `--input=<patchfile>` ：指定补丁文件。
- `-p<num>` 或 `--strip=<num>` ：设置欲剥离几层路径名称（文件名是可以包含路径的，与 diff 命令配合）。
- `-E` 或 `--remove-empty-files` ：删除应用补丁后为空文件的文件。
- `-o <outfile>` 或 `--output=<outfile>` ：输出到一个文件而不是直接覆盖文件。



## 示例

使用 patch 命令将文件 testfile1 升级，其升级补丁文件为 testfile.patch（补丁文件可由 [diff](/linux-command/diff) 命令生成）：

```bash
patch -p0 testfile1 testfile.patch 
```

在 Linux 开发中也常常会用到 patch 命令，比如内核打上 `PREEMPT_RT` 实时补丁：

```bash
patch -p1 < patch-5.4.47-rt28.patch
```

