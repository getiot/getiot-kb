---
sidebar_position: 5
---

# GitHub 无法读取远程仓库



## 问题背景

前几天准备往 GitHub 推送代码，突然就出现了 Fatal：无法读取远程仓库！OMG

错误提示如下：

```bash showLineNumbers
$ git push origin main 
ssh: connect to host ssh.github.com port 443: Connection refused
fatal: 无法读取远程仓库。

请确认您有正确的访问权限并且仓库存在。
```

我的 ~/.ssh/config 文件关于 GitHub 的配置如下：

```bash showLineNumbers
Host github.com
    User luhuadong
    HostName ssh.github.com
    PreferredAuthentications publickey
    IdentityFile ~/.ssh/id_ed25519
    Port 443
```

这个配置应该是没问题的，因为之前一直在用，查看 GitHub 的 Settings 中的 SSH Keys 也没问题。

使用 `ssh -T` 命令测试一下 GitHub 的网络连通，加 `-v` 选项打印详细信息：

```bash showLineNumbers
$ ssh -vT git@github.com
OpenSSH_8.2p1 Ubuntu-4ubuntu0.4, OpenSSL 1.1.1f  31 Mar 2020
debug1: Reading configuration data /home/rudy/.ssh/config
debug1: /home/rudy/.ssh/config line 15: Applying options for github.com
debug1: Reading configuration data /etc/ssh/ssh_config
debug1: /etc/ssh/ssh_config line 19: include /etc/ssh/ssh_config.d/*.conf matched no files
debug1: /etc/ssh/ssh_config line 21: Applying options for *
debug1: Connecting to ssh.github.com [::1] port 443.
debug1: connect to address ::1 port 443: Connection refused
debug1: Connecting to ssh.github.com [127.0.0.1] port 443.
debug1: connect to address 127.0.0.1 port 443: Connection refused
ssh: connect to host ssh.github.com port 443: Connection refused
```

额。。。看到问题没？！连接 github.com 的地址居然是 `::1` 和 `127.0.0.1`，前者是 IPv6 的 localhost 地址，后者是 IPv4 的 localhost 地址。

这应该是 DNS 解析出问题了！把 github.com 解析到了本机环回地址，于是产生了屏蔽效果。这种现象被称为“DNS 解析污染”，可能是由于 DNS 解析被运营商劫持了，或者使用了科学上网工具等原因造成的。

## 解决办法

一个解决办法是找到 GitHub 服务器的 IP 地址，手动解析。你可以通过 [ipaddress.com](https://www.ipaddress.com/) 网址来找到 IP 地址，或者在终端使用 [nslookup](/linux-command/nslookup/) 命令查询域名信息。

例如查询 github.com 的 IP 地址：

```bash showLineNumbers
$ nslookup github.com 8.8.8.8
Server:		8.8.8.8
Address:	8.8.8.8#53

Non-authoritative answer:
Name:	github.com
Address: 20.205.243.166
```

同样查询 ssh.github.com 的 IP 地址，将它们填写到 /etc/hosts 文件中，如下：

```bash showLineNumbers
127.0.0.1	localhost

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters

# GitHub
20.205.243.166  github.com
20.205.243.160  ssh.github.com
```

提示：Windows 系统的 hosts 文件位于 c:\Windows\System32\Drivers\etc\ 目录。

好了，赶紧重新 push 一下看看吧！

```bash showLineNumbers
$ git push origin main 
枚举对象中: 9, 完成.
对象计数中: 100% (9/9), 完成.
使用 8 个线程进行压缩
压缩对象中: 100% (7/7), 完成.
写入对象中: 100% (7/7), 137.52 KiB | 521.00 KiB/s, 完成.
总共 7 （差异 2），复用 0 （差异 0）
remote: Resolving deltas: 100% (2/2), completed with 2 local objects.
To github.com:getiot/example.git
   e3bf870..6c77519  main -> main
```

成功修复啦，耶！



## 其他方法

其他可尝试方法：清理 DNS 缓存、更换 DNS 服务器



