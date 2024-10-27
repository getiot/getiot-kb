---
sidebar_label: nfsstat 命令
sidebar_position: 37
slug: /nfsstat
---

# nfsstat 命令



## 介绍

**nfsstat**（英文全拼：NFS statistics）命令用于显示关于 NFS 客户机和服务器活动的统计信息。

**语法**：

```bash
nfsstat [OPTION]...
```

**选项**：

- `-s` ：仅列出 NFS 服务器端状态。
- `-c` ：仅列出 NFS 客户端状态。
- `-n` ：仅列出 NFS 状态，默认显示 nfs 客户端和服务器的状态。
- `-m` ：打印以加载的 nfs 文件系统状态。
- `-r` ：仅打印 rpc 状态。



## 示例

显示关于客户机发送和拒绝的 RPC 和 NFS 调用数目的信息

```bash
nfsstat -c
```

显示和打印与客户机 NFS 调用相关的信息

```bash
nfsstat -cn
```

显示和打印客户机和服务器的与 RPC 调用相关的信息

```bash
nfsstat -r
```

显示关于服务器接收和拒绝的 RPC 和 NFS 调用数目的信息

```bash
nfsstat -s
```

