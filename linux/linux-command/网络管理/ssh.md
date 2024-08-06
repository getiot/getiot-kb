---
sidebar_position: 10
slug: /ssh
---

# ssh 命令



## 介绍

**ssh**（SecureShell 的缩写）命令是 OpenSSH 套件的组成部分，是一个用于登录到远程机器并在远程机器上执行命令的客户端程序。它的目的是取代 rlogin 和 rsh，并在一个不安全的网络上提供两个不受信任的主机之间的安全加密通信。图形化应用程序 X11 连接和任意 TCP 端口也可以通过 ssh 安全通道进行转发。

除了 `ssh` 客户端命令以外，OpenSSH 套件还包括下面几个命令：

- [ssh-keygen](https://www.ssh.com/ssh/keygen)：用于为 ssh 生成、管理和转换认证密钥，它支持 RSA 和 DSA 两种认证密钥。
- [ssh-copy-id](https://www.ssh.com/ssh/copy-id)：将把本地的 ssh 公钥文件安装到远程主机对应的账户下。
- [ssh-agent](https://www.ssh.com/ssh/agent)：代理持有单点登录的私钥，可以将它理解为一个密钥管理器。
- [ssh-add](https://www.ssh.com/ssh/add)：向代理添加密钥的工具。
- [scp](https://www.ssh.com/ssh/scp)：具有类 RCP 命令接口的文件传输客户端。
- [sftp](https://www.ssh.com/ssh/sftp)：具有类 FTP 命令接口的文件传输客户端。
- [sshd](https://www.ssh.com/ssh/sshd)：OpenSSH 服务端。

:::tip SSH 的故事

SSH 在20世纪90年代取代了 Unix 和 Linux 中的一些旧命令和协议，包括 telnet、 rlogin 和 rsh。SSH 在 TCP/IP 端口22上运行，这刚好是在 ftp（21 端口）和 telnet（23 端口）之间，它们是20年前的。阅读《[The story of getting SSH port 22](https://www.ssh.com/academy/ssh/port#how-ssh-port-became-22)》 可以了解 SSH 如何获得端口22的故事。

:::

**语法**：

```bash
ssh [OPTIONS] [-p PORT] [USER@]HOSTNAME [COMMAND]
```

**选项**：

- `-1`：强制只使用协议第一版。
- `-2`：强制只使用协议第二版。
- `-4`：强制只使用 IPv4 地址。
- `-6`：强制只使用 IPv6 地址。
- `-A`：允许转发认证代理的连接。可以在配置文件中对每个主机单独设定这个参数。
- `-a`：禁止转发认证代理的连接。
- `-b BIND_ADDRESS`：在拥有多个地址的本地机器上，指定连接的源地址。
- `-C`：压缩所有数据。压缩算法与 gzip 使用的相同。
- `-c {blowfish | 3des | des}`：选择会话的密码算法。3des 是默认算法。
- `-c CIPHER_SPEC`：另外, 对于协议第二版，这里可以指定一组用逗号隔开、按优先顺序排列的加密算法。
- `-D [BIND_ADDRESS:]PORT`：指定一个本地主机动态的应用程序级的转发端口。工作原理是这样的，本地机器上分配了一个 socket 侦听 port 端口，一旦这个端口上有了连接，该连接就经过安全通道转发出去，根据应用程序的协议可以判断出远程主机将和哪里连接。目前支持 SOCKS4 和 SOCKS5 协议，而 ssh 将充当 SOCKS 服务器. 只有 root 才能转发特权端口。可以在配置文件中指定动态端口的转发。
- `-e ESCAPE_CHAR`：设置 pty 会话的转义字符，默认为字符 ~。转义字符只在行首有效，转义字符后面跟一个点表示结束连接，后跟一个 control-Z 表示挂起连接，跟转义字符自己表示输出转义字符自身。把转义字符设为 none 则禁止 转义功能，使会话完全透明。
- `-F CONFIGFILE`：指定 ssh 指令的配置文件，将忽略系统级配置文件 /etc/ssh/ssh_config 和用户级配置文件 ~/.ssh/config。
- `-f`：ssh 在执行命令前退至后台。
- `-g`：允许远端主机连接本地的转发端口。
- `-I SMARTCARD_DEVICE`：指定智能卡设备。智能卡里面存储了用户的 RSA 私钥。
- `-i IDENTITY_FILE`：指定一个 RSA 或 DSA 认证所需的身份（私钥）文件。协议第一版的默认文件是 ~/.ssh/identity 以及协议第二版的 ~/.ssh/id_rsa 和 ~/.ssh/id_dsa 文件。可以同时使用多个 -i 选项，也可以在配置文件中指定多个身份文件。
- `-K`：启用基于 GSSAPI 的身份验证和向服务器转发 GSSAPI 凭据。
- `-k`：禁用向服务器转发 GSSAPI 凭据。
- `-L [BIND_ADDRESS:]PORT:HOST:HOSTPORT`：将本地主机的地址和端口接收到的数据通过安全通道转发给远程主机的地址和端口。
- `-l LOGIN_NAME`：指定登录远程主机的用户。可以在配置文件中对每个主机单独设定这个参数。
- `-M`：将 ssh 客户端置于主模式进行连接共享。多个 -M 选项将 ssh 置于主模式，并在接受从连接之前进行确认。
- `-m MAC_SPEC`：对于协议第二版，可以指定一组用逗号隔开，按优先顺序排列的 MAC (message authentication code) 算法。
- `-N`：不执行远程命令，用于转发端口。仅限协议第二版。
- `-n`：把 stdin 重定向到 /dev/null，防止从 stdin 读取数据。在后台运行时一定会用到这个选项。
- `-O CTL_CMD`：控制主动连接多路复用主进程。参数 `CTL_CMD` 将被传递给主进程。`CTL_CMD` 可取值 check（检查主进程是否正在运行）和 exit（让主进程退出）。
- `-o OPTION`：可以在这里给出某些选项，格式和配置文件中的格式一样。它用来设置那些没有单独的命令行标志的选项。
- `-p PORT`：指定远程主机的端口。可以在配置文件中对每个主机单独设定这个参数。
- `-q`：安静模式。消除大多数的警告和诊断信息。
- `-R [BIND_ADDRESS:]PORT:HOST:HOSTPORT`：将远程主机上的地址和端口接收的数据通过安全通道转发给本地主机的地址和端口。
- `-S CTL_PATH`：指定用于连接共享的控制套接字的位置。
- `-s`：用于请求远程系统上的子系统调用。子系统是 SSH2 协议的一个特性，它有助于将 SSH 用作其他应用程序（如 sftp(1)）的安全传输。子系统通过远程命令指定。
- `-T`：禁止分配伪终端。
- `-t`：强制分配伪终端。这可用于在远程计算机上执行基于屏幕的任意程序，例如菜单服务。多个 -t  选项强制分配终端, 即使没有本地终端。
- `-V`：显示版本信息并退出。
- `-v`：冗详模式。打印关于运行情况的调试信息。在调试连接、认证和配置问题时非常有用。多个 -v 选项能够增加冗详程度，最多三个。
- `-W HOST:PORT`：将客户端上的标准输入和输出通过安全通道转发给指定主机的端口。
- `-w LOCAL_TUN[:REMOTE_TUN]`：指定客户端和服务端之间转发的隧道设备。
- `-X`：允许 X11 转发，可以在配置文件中对每个主机单独设定这个参数。
- `-x`：禁止 X11 转发。
- `-Y`：启用受信任的 X11 转发。受信任的 X11 转发不受 X11 安全扩展控制的约束。
- `-y`：使用 syslog 系统模块发送日志信息。默认情况下，此信息被发送到 stderr。



## 示例

使用指定用户名（root）登录远程主机

```bash
ssh root@192.168.1.100
```

使用指定用户名（root）和端口（3600）登录远程主机

```bash
ssh -p3600 root@192.168.1.100
```

输入用户登录密码后完成登录。

如果未指明端口和用户名，则分别由配置文件 ~/.ssh/ssh_config 和 /etc/ssh/ssh_config 中的 Port 和 User 选项决定。如果配置文件未指定，则端口默认为 22 ，用户名默认为当前用户。

也可以在 ~/.ssh/config 配置文件中设置远程服务器别名，格式如下：

```bash
Host 服务器名A
    User 用户名
    Hostname 服务器ip
    Port 端口号
    Identityfile 本地私钥地址
```

例如：

```bash
Host nanopi
	HostName 192.168.1.100
	User pi
	Port 22
	IdentityFile ~/.ssh/id_ed25519
```

这样，你就可以直接指定 nanopi 配置登录远程主机，命令如下：

```
ssh nanopi
```



## 配置说明

下面是 ~/.ssh/config 配置文件的配置选项：

- 必须配置
  - `Host`：指定配置块。
  - `User`：指定登录用户。
  - `Hostname`：指定服务器地址，通常用 `ip` 地址。
  - `Port`：指定端口号，默认值为 `22`。
- 可选
  - `Identityfile`：指定本地认证私钥地址。
  - `ForwardAgent yes`：允许 `ssh-agent` 转发。
  - `IdentitiesOnly`：指定`ssh`是否仅使用配置文件或命令行指定的私钥文件进行认证。值为 `yes` 或 `no`，默认为 `no`，该情况可在 `ssh-agent` 提供了太多的认证文件时使用。
  - `IdentityFile`：指定认证私钥文件。
  - `StrictHostKeyChecking`：有 3 种选项。
    - `ask`：默认值，第一次连接陌生服务器时提示是否添加，同时如果远程服务器公钥改变时拒绝连接。
    - `yes`：不会自动添加服务器公钥到 `~/.ssh/known_hosts` 中，同时如果远程服务器公钥改变时拒绝连接。
    - `no`：自动增加新的主机键到 `~/.ssh/known_hosts` 中。

另外，编辑 ~/.ssh/config 配置文件时还需要注意以下几点：

- 通过 `Host` 指定配置块，用 `tab` 键来区分配置头和内置参数。
- 所有参数值都可使用通配符设定，比如可以设置一个 `Host` 值为星号（`*`），用于设置全局配置。
- 配置文件不区分大小写，所以 `Host` 和 `host` 一样。
- 注释用 `#` 号开头。
