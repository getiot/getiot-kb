---
sidebar_position: 10
---

# Ubuntu 的 GIF 录制工具

![](https://static.getiot.tech/gif-recorder-Linux.jpg#center)



有时候，我们不方便在文档或网页中插入视频，但又想要动画的表达效果，通常会使用 GIF 格式动画。实际上，GIF 是一种压缩文档，其中包含了许多帧位图。

在 Linux 系统中，其实有许多好用的 GIF 录制工具，下面我们就来逐一介绍几款 GIF 工具，包括带图形界面（GUI）和纯命令行（CLI）工具。



## Peek

Peek 的用户界面可能是带 GUI 的 GIF 记录器中最直接、最直观的。它的设计非常精巧而且易于使用。

GitHub 仓库：[https://github.com/phw/peek](https://github.com/phw/peek)

| 优点                                                   | 缺点                                               |
| ------------------------------------------------------ | -------------------------------------------------- |
| - 可调节帧率<br/>- 支持延时定时器<br/>- 优雅的用户界面 | - 有限的功能集<br/>- 不支持 Wayland 显示服务器协议 |

Peek 有自己的官方 PPA，请使用以下命令进行安装：

```bash
sudo add-apt-repository ppa:peek-developers/stable
sudo apt update
sudo apt install peek
```

这样就可以使用 Peek 啦！

![](https://static.getiot.tech/peek-recording-itself.gif#center)



## Gifine

Gifine 是一款用于录制和编辑 GIF 动画的工具。它提供了许多高级功能，但用户界面有些粗糙。

| 优点                 | 缺点                                 |
| -------------------- | ------------------------------------ |
| - 内置编辑和修剪支持 | - 不像替代品那样漂亮和精美的用户界面 |

GitHub 仓库：[https://github.com/leafo/gifine](https://github.com/leafo/gifine)

安装 Gifine 对终端用户来说不是那么友好。首先，需要安装 Gifine 的各种依赖项及其安装程序 *luarocks*。然后通过 *luarocks* 安装 Gifine。在终端窗口中仔细输入以下命令，以便在 Ubuntu 上安装 Gifine：

```bash
sudo apt install ffmpeg graphicsmagick gifsicle luarockscmake \
     compiz gengetopt slop libxext-dev libimlib2-dev mesa-utils \
     libxrender-dev glew-utils libglm-dev libglu1-mesa-dev \
     libglew-dev libxrandr-dev libgirepository1.0-dev
sudo luarocks install lgi
sudo luarocks install --server=http://luarocks.org/dev gifine
```

现在，您可以使用命令 `gifine` 运行 Gifine。

![](https://static.getiot.tech/gifine-edit-window.jpg#center)



## SilentCast

SilentCast 是一个非常轻量级的 GIF 录制工具。使用时可能感觉不是很人性化，但它的工作做得很好。

GitHub 仓库：[https://github.com/colinkeenan/silentcast](https://github.com/colinkeenan/silentcast)

| 优点               | 缺点                 |
| ------------------ | -------------------- |
| - 轻量级和最小体积 | - 不太友好的用户体验 |

如果要安装 SilentCast，那么您需要输入以下命令获取源代码，然后进行编译、安装。

```bash
cd /tmp
wget -O silentcast.tar.gz https://api.github.com/repos/colinkeenan/silentcast/tarball
mkdir silentcast
tar -zxvf silentcast.tar.gz -C silentcast --strip-components=1
cd silentcast
make
sudo ./install
sudo apt install ffmpeg imagemagick
```

现在，您可以使用命令 `silentcast` 开始和停止录制会话。

![](https://static.getiot.tech/Silencast_v3.02_Screenshot.png#center)



## Byzanz

Byzanz 是一个简单的工具，可以将正在运行的 X 桌面记录为动画 GIF。 它是 GNOME 项目的一部分。

| 优点                        | 缺点                                                         |
| --------------------------- | ------------------------------------------------------------ |
| - 非常轻量级<br/>- 完美运行 | - 作为 CLI 工具，所以您必须手动输入每个选项<br/>（意思是，无需拖动和选择屏幕区域进行录制） |

在 Ubuntu 上安装 Byzanz 只需一个命令：

```bash
sudo apt install byzanz
```

现在，你可以使用 `byzanz-record` 命令录制 GIF 动画了。

由于需要在命令行选项指定录制区域，因此在开始之前，最好先查看一下本地显示器的分辨率。

```bash
$ xdpyinfo | grep dimensions
  dimensions:    1366x768 pixels (361x203 millimeters)
```

接下来，可以通过下面命令全屏录制 30 秒的 GIF。

```bash
byzanz-record --duration=30 --x=0 --y=0 --width=1440 --height=835 escritorio.gif
```

通过选项参数的名字很容易就猜到其含义，`duration` 是录制时长，`x` 和 `y` 是起始坐标（截取画面左上角的值），`width` 和 `height` 是截取画面的宽和高，也就是画面的大小，最后就是输出文件的名字。





