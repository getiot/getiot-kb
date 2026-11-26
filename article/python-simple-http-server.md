---
sidebar_position: 28
slug: /python-simple-http-server
---

# Python 启动 HTTP 服务器


本文介绍如何使用 Python 在本地快速启动一个简单的 HTTP 测试服务器。这个方法在局域网传输文件或者进行 HTTP 请求测试非常有帮助。

## Python 本地测试服务器

不依赖其他框架，最简单的方法之一就是使用 Python 的 `SimpleHTTPServer` 模块。所以唯一的前提条件是 —— 在你的系统中安装好 Python 环境，Python 2.x 和 Python 3.x 都行。

首先确认你的 Python 版本：

```bash
python -V
```

然后切换到你想要运行 HTTP 服务器的目录（该目录下的内容将会被分享），比如：

```bash
cd ~/workspace
```

启动 HTTP 服务器：

```bash
# 如果上面返回的 Python 版本是 3.x
python -m http.server
# 如果上面返回的 Python 版本是 2.x
python -m SimpleHTTPServer
```

默认情况下，这将在本地 Web 服务器上的端口 8000 上运行目录的内容。你可以在浏览输入 `localhost:8000` 来访问此服务器内容，你将会看到列出的目录内容。

注意：如果已经有其他程序占据了 8000 端口，或者你想指定其他端口，可以在命令后面添加端口号启动 HTTP 服务器。

例如指定 7250 端口：

```bash
# 如果上面返回的 Python 版本是 3.x
python -m http.server 7250
# 如果上面返回的 Python 版本是 2.x
python -m SimpleHTTPServer 7250
```

最后，Python 的 `SimpleHTTPServer` 模块虽然很方便，但功能有限，如果你需要一个更强大的 HTTP 服务器，可以学习 Python 的 Django 或 Flask 框架。





## 参考

- [如何设置一个本地测试服务器？](https://developer.mozilla.org/zh-CN/docs/Learn/Common_questions/set_up_a_local_testing_server)

