---
sidebar_position: 1
slug: /python-installation
---

# Python 安装指南



Python 可应用于多个平台，包括 Windows、 Linux/Unix 和 macOS。Python 最新源码，二进制文档，新闻资讯等可以在 Python 的[官网](https://www.python.org/) 查看到。在[文档中心](https://www.python.org/doc/)可以下载 Python 的文档，包括 HTML、PDF 和 PostScript 等格式的文档。



## Python 的安装

Python 的安装很简单，找到官网的下载页面，选择你所使用的平台和 Python 版本下载即可。 如果是 Ubuntu，可以使用 `apt` 下载；如果是 CentOS，可以使用 `yum` 下载；如果是 MacOS，可以使用 `brew` 下载。这种方式的好处是安装快且不用考虑依赖问题，坏处是如果没有更新源的话，下载安装的 Python 可能比较老旧（这取决于你的操作系统）。

安装完成后，你会得到一个 Python 交互式命令行环境。因为 Linux/Unix 系统自带 Python 2.7，所以你通常需要使用 Python3 命令来启动解释器。此外，你还可以安装 ipython3 命令行工具，它是前者的增强版，有更多的提示和交互特性。 



### Windows

对于 Windows 系统，直接下载对应版本的安装包进行安装即可。根据提示 “下一步” 即可，注意选择安装 pip。安装完成后检查环境变量，把 python 的安装目录添加到 path 系统变量中，这样就在 CMD 命令行工具中也可以使用 python。

默认会安装 IDLE（Python GUI），它是一个简单的图形界面开发环境。



### MacOS

对于 MacOS，可以使用 brew 工具安装：

```shell
$ brew sreach python
$ brew install python3
# 在/usr/local/Cellar/这个目录下
```



### Linux

对于 Linux 发行版，可以通过包管理工具进行安装，比如在 Ubuntu 中：

```shell
$ sudo apt-get install python3.6
```

在类 Unix 平台，我们也常选择下载源码编译安装的方式，大致步骤如下：

- 在[下载页面](https://www.python.org/downloads/)选择适用于 Unix/Linux 的源码压缩包

- 下载到目标机器并解压压缩包

- 如果你需要自定义一些选项修改 Modules/Setup

- 配置、编译、安装

  ```bash
  ./configure
  make
  make install
  ```

执行以上操作后，Python 会安装在 /usr/local/bin 目录中，Python 库安装在 /usr/local/lib/pythonXX，XX 是对应的 python 版本号。




## Python 库的安装

### pip 方式

```bash
pip install opencv-python
```

需要注意的是，pip3 和 pip 是不同的，它们分别为 python3.x 和 python2.7 安装各自的库。



### setup.py 方式

```bash
python setup.py install
```



### Anaconda 方式

```bash
conda install keras
```

也可以指定源和版本安装

```bash
conda install -c  https://conda.binstar.org/menpo  opencv3=3.1.0
```



## 库的安装路径

Python 的可执行文件通常在 /usr/bin 目录（通过 apt 安装的应用一般会在这个目录，自行安装的一般在 /usr/local/bin 目录下）。

python3.x 的自带库目录在：

- /usr/lib/python3/dist-packages/
- /usr/lib/python3.x/

python2.7 的自带库目录在：

- /usr/lib/python2.7/dist-packages
- /usr/lib/python2.7/

通过 pip3/pip 安装的模块目录在

- ~/.local/lib/python3.x/site-packages/
- ~/.local/lib/python2.7/site-packages/ 或 /usr/local/lib/python2.7/dist-packages/




## 更改 pip 源

由于 pip 默认从官网下载文件，官网位于国外，下载速度时快时慢，还经常断线，国内的体验并不太好。因此建议国内开发者珍惜生命，手动更改 pip 源。

最常用的并且可信赖的源包括清华大学源、豆瓣源、阿里源：

- pypi 清华大学源：[https://pypi.tuna.tsinghua.edu.cn/simple](https://pypi.tuna.tsinghua.edu.cn/simple)
- pypi 豆瓣源 ：[http://pypi.douban.com/simple/](http://pypi.douban.com/simple/)
- pypi 腾讯源：[http://mirrors.cloud.tencent.com/pypi/simple](http://mirrors.cloud.tencent.com/pypi/simple)
- pypi 阿里源：[https://mirrors.aliyun.com/pypi/simple/](https://mirrors.aliyun.com/pypi/simple/)

pip 源具体修改方式是，我们以安装 python 的 markdown 模块为例，通常的方式是直接在命令行运行：

```bash
pip install markdown
```

这样会从国外官网下载 markdown 模块并安装。

若要把 pip 源换成国内的，只需要把上面的代码改成下图这样（下图以清华大学源为例）：

```bash
pip install markdown -i https://pypi.tuna.tsinghua.edu.cn/simple
```

这样我们就从清华大学源成功安装了 markdown 模块，速度会比过 pip 默认的国外源快很多。

上述做法是临时改成国内源，如果不想每次用 pip 都加上 `-i https://pypi.tuna.tsinghua.edu.cn/simple`，那么可以把国内源设为默认，做法是：

```bash
# 清华源
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

# 或：
# 阿里源
pip config set global.index-url https://mirrors.aliyun.com/pypi/simple/
# 腾讯源
pip config set global.index-url http://mirrors.cloud.tencent.com/pypi/simple
# 豆瓣源
pip config set global.index-url http://pypi.douban.com/simple/
```

