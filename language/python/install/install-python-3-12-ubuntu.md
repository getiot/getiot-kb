---
sidebar_position: 2
slug: /install-python-3-12-ubuntu
---

# Ubuntu 安装 Python 3.12



本文以 Ubuntu 20.04 为例，介绍如何在 Ubuntu 上安装当前最新的 Python 3.12 版本的两种方法，一种是使用 Deadsnakes PPA 源通过 apt 安装，另一种是从源码构建安装，根据你的需要选择其中一种即可。两种安装方法都具有一定的通用性，其他 Ubuntu 版本或 Linux 发行版亦可参考本教程。

:::tip

Python 3.12 是 Python 编程语言的最新稳定发布版（2023年），这一版本清理了一些弃用的 API，同时引入了一些令人激动的功能和改进，包括支持更灵活的“f-字符串”解析、增强的类型能力、优化的垃圾回收，以及提升了部分模块的性能等等。使用 Python 3.12，可以帮助你编写更高质量和高效的程序，这也是我们想要安装或升级 Python 3.12 的重要原因。的力量，将您的编码技能提升到新的高度。

点击[这里](https://docs.python.org/dev/whatsnew/3.12.html)了解关于 Python 3.12 的更多介绍。

:::

## 方法1：从 PPA 源安装

对于 Ubuntu 22.04、Ubuntu 20.04 及其衍生版本（例如 Linux Mint 21），[Deadsnakes PPA](https://launchpad.net/~deadsnakes/+archive/ubuntu/ppa/) 已为 amd64、arm64/armhf、ppc64el 和 s390x 等 CPU 架构制作了软件包，因此你可以直接下载安装使用。

1. 首先，通过快捷键 **Ctrl+Alt+T** 打开一种新的终端，复制并执行下面命令添加 PPA 源：

   ```bash
   sudo add-apt-repository ppa:deadsnakes/ppa
   ```

   *注意：添加的时候会让你输入用户密码，且无星号反馈，输入完按 Enter 继续即可。*
   
2. Ubuntu 20.04 在添加 PPA 时会自动刷新包缓存。但是 Linux Mint 用户可能需要通过运行命令手动完成此工作：

   ```bash
   sudo apt update
   ```

3. 最后，运行下面命令安装 Python 3.12：

   ```bash
   sudo apt install python3.12
   ```



## 方法2：从源码构建安装

如果你使用 Ubuntu 23.04 或 Ubuntu 18.04 等未支持的版本，或者不信任第三方存储库，那么可以选择从源代码构建安装，构建方法也很简单。

1. 首先从 [Python FTP Download Page](https://www.python.org/ftp/python/) 下载源码 tarball 压缩包。

2. 然后打开“Downloads（下载）”文件夹，解压源 tarball，最后右键单击解压后的源文件夹并选择“Open in Terminal（在终端中打开）”。

3. 在终端中逐一运行以下命令配置和构建 Python：

   ```bash
   ./configure --enable-optimizations
   sudo make -j4 && sudo make altinstall
   ```

*注意：构建过程中可能会提示你缺少构建依赖库，你可以按照提示安装依赖库。*



## 安装后验证

当你通过上面两种方法任意一种安装 Python 3.12 后，就可以通过运行下面命令来验证是否安装成功。

```bash
python3.12 --version && pip3.12 --version
```



## 将 Python 3.12 设为默认

通常，不建议将 Python 3.12（或其他 Python 版本）设为系统默认的 Python 解释器，因为这会破坏一些核心应用程序。我们更推荐你使用 [Python 虚拟环境](/python/python-virtualenv) 的方式。

不过，如果你确实要这么做的话，可以尝试通过下面命令来设置。

- 首先，运行下面命令找出 Python 3.12 可执行文件的安装位置：

  ```bash
  whereis python3.12
  ```

  通常是 `/usr/bin/python3.12` 或 `/usr/local/bin/python3.12`。

- 然后，添加 Python 3.12 作为 python 的替代链接（例如 `/usr/bin/python3.12`）。

  ```bash
  sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.12 1
  ```
  
- 最后，运行下面命令设置 `/usr/bin/python` 可执行文件的默认值（如果有多个可用）：

  ```bash
  sudo update-alternatives --config python
  ```



## 卸载 Python 3.12:

如果你是通过 PPA 安装的 Python 3.12，那么简单地执行下面命令即可将它卸载。

```bash
sudo apt remove --autoremove python3.12
```

另外，PPA 源信息也可以清除：

```bash
sudo add-apt-repository --remove ppa:deadsnakes/ppa
```

而如果你是从源码构建安装的 Python 3.12，则没有卸载脚本来自动执行该操作，需要你手动删除已安装的所有文件，例如：

```bash
cd /usr/local/bin && sudo rm python3.12* pip3.12 idle3.12 pydoc3.12 2to3-3.12
cd /usr/local/lib && sudo rm -R python3.12 pkgconfig libpython3.12.a
```
