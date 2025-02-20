---
sidebar_position: 4
slug: /git-ssh-configuration
---

# Git SSH 配置

当我们安装好 Git 之后，首先要做第一件事情就是配置用户名和电子邮件地址，这也是你的 Git 身份证，非常重要。同时，强烈推荐配置 SSH 密钥。使用 SSH 协议会更加安全，你可以连接到远程服务器和服务并对其进行身份验证，同时也会更方便，无需在每次访问时提供你的用户名和密码。



## 配置邮箱

以 Windows 为例，Git 安装完成后，在“开始”菜单中会增加 Git GUI 和 Git CMD 两个软件。点击 Git CMD 打开 Git 命令行工具，配置用户名和邮箱信息。如下所示：

```bash
git config --global user.name "hi"
git config --global user.email "hi@getiot.tech"
```

注意：将上述用户名称和邮箱地址替换成你自己的信息。



## 配置 SSH Key

你可以通过 HTTP 协议登录和访问 Git 仓库，但为了更加安全和便捷，建议配置 SSH Key，具体配置方法如下。



### 生成 SSH 密钥对

在 Git CMD 中输入如下命令，生成 SSH 密钥对。

```bash
ssh-keygen -t ed25519 -C "hi@getiot.tech"
```

说明：`-C` 后面的参数是 Key 的标识字符串，建议使用你的邮箱地址。

:::tip

`-t` 选项指定加密算法，这里使用的是 ED25519 算法。比较常见的还有 RSA 算法：

```bash
ssh-keygen -t rsa
```

我们建议你使用 ED25519，因为它相较于 RSA 算法具有更高的安全性、更快的密钥生成速度，以及更少的存储空间。

在数学原理上，RSA 加密算法的安全性基于大质数的难以分解性质，而 ED25519 则使用椭圆曲线密码学，因此具有更好的密码学属性。

:::

连续按回车，将在本地的 ~/.ssh 目录保存密钥对 id_ed25519 和 id_ed25519.pub。

```shell
$ ls ~/.ssh/
id_ed25519       # 私钥
id_ed25519.pub   # 公钥
```



### 提交 SSH 公钥

以 GitHub 为例，登录 [https://github.com](https://github.com)，点击右上方头像处，选择 *Settings*，然后选择左侧边栏的 *SSH and GPG keys*，点击“New SSH key”按钮。

在 Git CMD 中执行如下命令查看公钥内容：

```bash
cat ~/.ssh/id_ed25519.pub
```

将 SSH 公钥 id_ed25519.pub 的内容粘贴到 Key 的位置，点击 “Add key” 按钮完成添加。

![GitHub 配置 SSH 密钥](https://static.getiot.tech/github-add-sshkey-01.png#center)



## 连接测试

配置完成后，可通过 `ssh -T` 命令来测试访问连通性。例如：

```bash
$ ssh -T git@github.com
Hi 阿基米东(@luhuadong)! You've successfully authenticated, but GitHub does not provide shell access.
```

