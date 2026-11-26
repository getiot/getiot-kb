---
sidebar_position: 3
slug: /node-version-manager
sidebar_label: NVM 版本管理工具
---

# Node.js 版本管理工具 NVM 的安装与使用



**`nvm`** 是 Node Version Manager 的缩写，是一个用于管理多个 node 版本的 shell 脚本工具。在项目开发中，我们可能需要用不同版本的 Node.js 开发和测试，nvm 就可以帮助我们设置默认 node 版本，在不同开发环境中切换不同版本。

GitHub 地址：[https://github.com/nvm-sh/nvm](https://github.com/nvm-sh/nvm)



## 安装 nvm

nvm 项目提供了一个 install.sh 脚本帮助用户快速安装，可以使用 cURL 或 Wget 等工具下载。以当前最新版本 0.40.1 为例，安装命令如下：

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
```

或者

```bash
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
```

运行上面命令中的任意一条，就会下载并运行 v0.40.1 版本的 nvm，默认安装位置为 `~/.nvm`，并会在一些配置文件中添加如下代码片段，例如 `~/.bash_profile`、`~/.zshrc`、`~/.profile` 或 `~/.bashrc`。

```bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
```

运行完安装脚本后，可以执行 `command -v nvm` 命令检查 nvm 是否安装成功。如果提示没有找到 nvm 命令，则需要重新打开 shell 终端，或者执行对应 shell 的配置文件。例如：

- bash：`source ~/.bashrc`
- zsh：`source ~/.zshrc`
- ksh：`. ~/.profile`



### 利用 Git 安装

除了使用 [curl](/linux-command/curl/) 和 [wget](/linux-command/wget/) 命令安装，我们还可以利用 Git 来安装 nvm，这样可以更好地管理 nvm 工具本身。

Git 的版本需要在 v1.7.10 以上，执行下面命令下载、安装：

```bash
# 切换到用户家目录
cd ~/
# 克隆 nvm 仓库到本地的 .nvm 目录 
git clone https://github.com/nvm-sh/nvm.git .nvm
# 切换到 ~/.nvm 目录
cd ~/.nvm
# 检出当前最新的 v0.40.1 发布版本
git checkout v0.40.1
# 激活 nvm 命令
. ./nvm.sh
```

在 `~/.bashrc`、`~/.profile` 或 `~/.zshrc` 中添加下面代码片段：

```bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
```

这样就完成 nvm 的安装了！

后续升级的话，可以参考下面步骤：

```bash
# 切换到 $NVM_DIR 目录（即 ~/.nvm 目录）
cd "$NVM_DIR"
# 拉取远程仓库中最新的更改
git fetch --tags origin
# 检出最新版本到本地
git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
# 激活 nvm 命令
. "$NVM_DIR/nvm.sh"
```



## 配置 nvm

### 设置 nvm 镜像地址

nvm 脚本可能因为网络问题无法正常工作，例如执行 `nvm ls-remote` 命令只有 iojs 列表，解决办法是设置镜像地址。

具体来说，需要修改环境变量 `NVM_NODEJS_ORG_MIRROR`，设置之前你可以先查看该变量的值：

```bash
echo $NVM_NODEJS_ORG_MIRROR
```

设置使用淘宝镜像源：

```bash
export NVM_NODEJS_ORG_MIRROR=https://npmmirror.com/mirrors/node
```

你也可以在执行 `nvm` 命令的运行时设置镜像地址，例如：

```bash
NVM_NODEJS_ORG_MIRROR=https://npmmirror.com/mirrors/node nvm ls-remote
```

如果想要长期修改环境变量，可以在 ~/.bashrc 文件末尾添加如下一行：

```bash
export NVM_NODEJS_ORG_MIRROR=https://npmmirror.com/mirrors/node
```

保存并重启终端后生效。

### 设置 nvm 默认版本

设置前先通过 `nvm list` 命令查看当前系统使用 nvm 安装的所有 node.js 版本：

```bash
$ nvm list
       v10.24.1
       v12.22.8
->     v16.13.1
       v18.18.2
       v20.17.0
         system
default -> 16.13.1 (-> v16.13.1)
...
```

可以看到当前默认的 node 版本是 v16.13.1，如果你想更改默认版本，可通过 `nvm alias default <version>` 命令设置。例如设置为最新的 v20.17.0 版本：

```bash
nvm alias default v20.17.0
```



## 使用示例

下载、编译和安装 node 的最新版本：

```bash
nvm install node  # "node" 是最新版本的别名
```

也可以指定安装版本（例如 v20.10.0）：

```bash
nvm install 20.10.0
```

下载并安装最新版本的 node：

```bash
nvm install latest
```

安装最新的 LTS 版本的 node：

```bash
nvm install lts
```

如果不知道有哪些版本，可以先列出所有可用的版本（列出所有可以从远程服务器安装的 Node.js 版本）：

```bash
nvm ls-remote
nvm list available
```

使用指定版本（可以不指定完整版本号）：

```bash
$ nvm use 18
Now using node v18.18.2 (npm v10.5.2)
$ node -v
v18.18.2

$ nvm use 16
Now using node v16.9.1 (npm v7.21.1)
$ node -v
v16.9.1

$ nvm use 14
Now using node v14.18.0 (npm v6.14.15)
$ node -v
v14.18.0
```

获取可执行文件的路径：

```bash
nvm which 18
```

卸载已安装的指定版本（语法与 `install` 命令类似），例如卸载 v10.24.1：

```bash
nvm uninstall v10.24.1
```

