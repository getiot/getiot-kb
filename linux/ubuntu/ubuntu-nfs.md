---
sidebar_position: 13
---

# Ubuntu 配置 NFS 服务

![Ubuntu 配置 NFS 服务](https://static.getiot.tech/nfs-in-linux.png#center)

## NFS 服务简介

NFS 是 Network File System 的缩写，即网络文件系统。一种使用于分散式文件系统的协定，由 Sun 公司开发，于1984年向外公布。功能是通过网络让不同的机器、不同的操作系统能够彼此分享个别的数据，让应用程序在客户端通过网络访问位于服务器磁盘中的数据，是在类 Unix 系统间实现磁盘文件共享的一种方法。

NFS 的基本原则是 “容许不同的客户端及服务端通过一组 RPC 分享相同的文件系统”，它是独立于操作系统，容许不同硬件及操作系统的系统共同进行文件的分享。

NFS 在文件传送或信息传送过程中依赖于 RPC 协议。RPC，远程过程调用（Remote Procedure Call）是能使客户端执行其他系统中程序的一种机制。NFS 本身是没有提供信息传输的协议和功能的，但 NFS 却能让我们通过网络进行资料的分享，这是因为 NFS 使用了一些其他的传输协议。而这些传输协议用到这个 RPC 功能。可以说 NFS 本身就是使用 RPC 的一个程序，或者说 NFS 也是一个 RPC Server。所以只要用到 NFS 的地方都要启动 RPC 服务，不论是 NFS Server 或者 NFS Client。这样 Server 和 Client 才能通过 RPC 来实现 Program Port 的对应。**可以这么理解 RPC 和 NFS 的关系：NFS 是一个文件系统，而 RPC 负责信息的传输。**

在提供 NFS 服务之前必须启动 rpcbind 服务。



## 安装 nfs 服务

```bash
sudo apt install nfs-kernel-server
```

修改配置文件，在 /etc/exports 最后面添加如下配置

```bash
/nfs *(rw,sync,no_subtree_check,no_root_squash)
```

这里的 `/nfs` 是 nfs 服务的根目录；`*` 表示所有 IP 地址，也可以指定客户端的 IP 或者 IP 范围，比如 `192.168.0.0/24`，使用域名也可以。

重启 nfs 服务

```bash
sudo service nfs-kernel-server restart     # 使用 service
sudo systemctl restart nfs-server.service  # 使用 systemctl
```

或者执行 `exportfs -rv` 更新配置。

在开发板挂载（挂载到 /mnt 目录）

```bash
mount -o nolock,tcp 192.168.1.100:/nfs /mnt
```

在开发板卸载

```bash
umount /mnt
```

提示：为了安全起见，建议根据你的网络环境设置 NFS 目录权限。

