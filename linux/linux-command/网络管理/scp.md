---
sidebar_label: scp 命令
sidebar_position: 11
slug: /scp
---

# Linux scp 命令 - 远程安全复制文件



## 介绍

**scp**（SecureCopy 的缩写）命令是 OpenSSH 套件的组成部分，是一个具有类 RCP 命令接口的文件传输客户端。用于在 Linux 下进行远程拷贝文件的命令，和它类似的命令有 [`cp`](/linux-command/cp/)，不过 `cp` 只是在本机进行拷贝不能跨服务器，而且 scp 传输是加密的。

scp 占用资源少，不会对系统负荷造成太大影响，与之类似的 [`rsync`](/linux-command/rsync/) 虽然速度相当快，但会导致硬盘 I/O 非常高，而 scp 基本不影响系统正常使用。

**语法**：

```bash
scp [OPTION] source ... target
```

**选项**：

- `-1`：强制 scp 命令使用协议 ssh1
- `-2`：强制 scp 命令使用协议 ssh2
- `-4`：强制 scp 命令只使用 IPv4 寻址
- `-6`：强制 scp 命令只使用 IPv6 寻址
- `-B`：使用批处理模式（传输过程中不询问传输口令或短语）
- `-C`：允许压缩（将 -C 标志传递给 ssh，从而打开压缩功能）
- `-p`：保留原文件的修改时间，访问时间和访问权限。
- `-q`：不显示传输进度条。
- `-r`：递归复制整个目录。
- `-v`：详细方式显示输出。scp 和 ssh 会显示出整个过程的调试信息。这些信息用于调试连接，验证和配置问题。
- `-c cipher`：以 cipher 将数据传输进行加密，这个选项将直接传递给 ssh。
- `-F ssh_config`：指定一个替代的 ssh 配置文件，此参数直接传递给 ssh。
- `-i identity_file`：从指定文件中读取传输时使用的密钥文件，此参数直接传递给 ssh。
- `-l limit`：限定用户所能使用的带宽，以 Kbit/s 为单位。  
- `-o ssh_option`：可用于以 ssh_config 中使用的格式将选项传递给 ssh。
- `-P port`：注意是大写的P，port 是指定数据传输用到的端口号
- `-S program`：指定加密传输时所使用的程序。此程序必须能够理解 ssh 的选项。



## 示例

假设远程服务器 IP 地址为 192.168.1.100，用户名为 root。

将本地文件（例如 /opt/file.tar.gz）复制到远程服务器的 /opt 目录：

```bash
scp /opt/file.tar.gz root@192.168.1.100:/opt/
```

从远程服务器复制文件 file.tar.gz 到本地 /opt 目录：

```bash
scp root@192.168.1.100:/opt/file.tar.gz /opt/
```

将本地目录（例如 /var/www/html）复制到远程服务器的 /opt 目录：

```bash
scp -r /var/www/html root@192.168.1.100:/opt/
```

