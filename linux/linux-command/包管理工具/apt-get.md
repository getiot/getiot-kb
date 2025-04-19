---
sidebar_label: apt-get 命令
sidebar_position: 2
slug: /apt-get
---

# Linux apt-get 命令 - APT软件包管理工具



## 介绍

**apt-get** 是基于 Debian 的操作系统（包括 Debian、Ubuntu、Linux Mint 等）中用来安装和卸载软件的包管理器命令。主要用于自动从互联网的软件仓库中搜索、安装、升级、卸载软件或操作系统。

:::warning

老版本的 Linux 系统只支持 apt-get 命令，在新版本的 Linux 系统中，[apt](/linux-command/apt/) 集成了 apt-get、apt-cache 的常用命令，因此可用 apt 命令代替 apt-get 命令。

:::

提示：apt-get 命令执行需要超级管理员权限（root）。

**语法**：

```bash
apt-get [options] [command] [package ...]
```

**选项**：

- `-h, --help`：查看帮助文档。
- `-v, --version`：查看 apt-get 的版本。
- `-y`：在需要确认的场景中回应 yes。
- `-s, --dry-run`：模拟执行并输出结果。
- `-d, --download-only`：把包下载到缓存中而不安装。
- `--only-upgrade`：更新当前版本的包而不是安装新的版本。
- `--no-upgrade`：在执行 install 命令时，不安装已安装包的更新。
- `-q, --quiet`：减少输出。
- `--purge`：配合 remove 命令删除包的配置文件。
- `--reinstall`：重新安装已安装的包或其新版本。

**子命令**：

- **update**

  update 命令用于更新软件包索引文件，/etc/apt/sources.list 文件中的配置指定了软件包索引文件的来源。更新了包索引文件后就可以得到可用的包的更新信息和新的包信息。于是系统就知道有哪些软件的哪些版本可以从什么地方（源）下载安装。在安装或升级软件包之前先执行 update 命令是一个好习惯。

- **install**

  install 命令用于安装或者升级软件包。每个软件包都有一个包名，执行子命令时需要指定包名。在安装时，该软件包所依赖的包也将被安装。

- **upgrade**

  upgrade 命令用于从 /etc/apt/sources.list 中列出的源安装系统上当前安装的所有包的最新版本。在任何情况下，当前安装的软件包都不会被删除，尚未安装的软件包也不会被检索和安装。如果当前安装的软件包的新版本不能在不更改另一个软件包的安装状态的情况下升级，则将保留当前版本。必须提前执行 update 命令以便 apt-get 知道已安装的包是否有新版本可用。

  注意 update 与 upgrade 的区别：update 是更新软件列表，upgrade 是更新软件。

- **dist-upgrade**

  除执行升级功能外，dist-upgrade 还智能地处理与新版本软件包的依赖关系的变化。apt-get 有一个 "智能" 的冲突解决系统，如果有必要，它将尝试升级最重要的包，以牺牲不那么重要的包为代价。因此，distr -upgrade 命令可能会删除一些包。因此在更新系统中的包时，建议按顺序执行下面的命令：

  ```bash
  $ apt-get update
  $ apt-get upgrade -y
  $ apt-get dis-upgrade -y
  ```

- **remove**

  remove 是 install 的反向操作，即删除软件包。值得一提的是，使用 remove 命令删除一个软件包时，会将其配置文件留在系统上。

- **purge**

  purge 命令与 remove 命令类似，purge 命令在删除包的同时也删除了包的配置文件。

- **autoremove**

  autoremove 命令用于删除自动安装的软件包，这些软件包当初是为了满足其他软件包对它的依赖关系而安装的，而现在已经不再需要了。

- **download**

  download 命令把指定包的二进制文件下载到当前目录中。注意，是类似 *.deb 这样的包文件。

- **clean**

  clean 命令清除在本地库中检索到的包。它从 /var/cache/apt/archives/ 和 /var/cache/apt/archives/partial/ 目录删除除锁文件之外的所有内容。

- **autoclean**

  与 clean 命令类似，autoclean 命令清除检索到的包文件的本地存储库。不同之处在于，它只删除不能再下载的软件包文件，而且这些文件在很大程度上是无用的。这允许长时间维护缓存，而不至于大小失控。

- **source**

  source 命令用于下载软件包的源代码。默认会下载最新可用版本的源代码到当前目录中。

- **changelog**

  changelog 命令尝试下载并显示软件包的更新日志。



## 示例

查看帮助文档：

```bash
apt-get -h
```

更新包索引文件：

```bash
sudo apt-get update
```

安装 nginx 软件包：

```bash
sudo apt-get install nginx
```

安装 nginx 软件包，并在需要确认的场景中回应 yes：

```bash
sudo apt-get install -y nginx
```

更新指定的包（注意，不是通过 upgrade 命令完成的，而是使用 intall 命令）：

```bash
sudo apt-get install vim
```

重新安装已安装的包：

```bash
sudo apt-get install --reinstall curl
```

安装指定版本的包：

```bash
sudo apt-get install tree=1.7.0-5
```

把包下载到缓存中而不安装（把软件包的下载和安装步骤分开）：

```bash
sudo apt-get install -d nginx
sudo apt-get upgrade -d
sudo apt-get dist-upgrade -d
```

删除包（只删除程序文件，保留相关的配置文件）：

```bash
sudo apt-get remove vim
```

彻底清除包（同时删除程序文件及其配置文件）：

```bash
sudo apt-get purge vim
```

在执行 remove 命令时使用 --purge 选项的效果等同于执行 purge 命令：

```bash
sudo apt-get remove --purge vim
```

删除包后执行一下 autoremove，可以自动删除不再需要的软件包：

```bash
sudo apt-get autoremvoe
```

在执行 install/remove 命令时使用 --autoremove 选项，可以同时删除无用的依赖包，类似在执行完 install/remove 命令后再执行一次 autoremove 命令：

```bash
sudo apt-get remove --autoremove vim
```

清除系统中缓存的包安装文件：

```bash
sudo apt-get clean
```

自动清除不能再下载的软件包文件：

```bash
sudo apt-get autoclean
```

查看已安装包的更改日志：

```bash
apt-get changelog tree
```

下载包的源代码：

```bash
apt-get source tree
```

