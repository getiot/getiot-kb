---
sidebar_position: 4
sidebar_label: 443 端口的 SSH 访问异常
---

# GitHub 通过 443 端口的 SSH 访问异常



```bash showLineNumbers
$ git push origin main 
ssh: connect to host ssh.github.com port 443: Connection refused
fatal: 无法读取远程仓库。

请确认您有正确的访问权限并且仓库存在。
```

要测试通过 HTTPS 端口的 SSH 是否可行，请运行以下 SSH 命令：

```bash showLineNumbers
$ ssh -T -p 443 git@ssh.github.com
> Hi username! You've successfully authenticated, but GitHub does not
> provide shell access.
```

如果这样有效，万事大吉！ 如果无效，您可能需要[遵循我们的故障排除指南](https://docs.github.com/cn/articles/error-permission-denied-publickey)。



## 启用通过 HTTPS 的 SSH 连接

如果您能在端口 443 上通过 SSH 连接到 `git@ssh.github.com`，则可以覆盖您的 SSH 设置以强制与 GitHub.com 的任何连接均通过该服务器和端口运行。

要在 SSH 配置文件中设置此设置，请在 `~/.ssh/config` 编辑该文件，并添加以下部分：

```bash showLineNumbers
Host github.com
Hostname ssh.github.com
Port 443
User git
```

您可以通过再次连接到 GitHub.com 测试此项是否有效：

```bash showLineNumbers
$ ssh -T git@github.com
> Hi username! You've successfully authenticated, but GitHub does not
> provide shell access.
```

打印详细信息

```bash showLineNumbers
ssh -vT git@github.com
```

错误排查

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



## 参考

- [executed ssh -vT git@github.com and get "connect to 127.0.0.1"](https://stackoverflow.com/questions/72391613/executed-ssh-vt-gitgithub-com-and-get-connect-to-127-0-0-1)





