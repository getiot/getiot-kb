---
sidebar_position: 5
---

# Django 快速入门



本文通过一个简单的示例，演示如何创建并启动一个 Django 网站项目。



## 创建项目

如果这是你第一次使用 Django，那么你必须要照顾一些初始设置。也就是说，你需要自动生成一些建立 Django 项目的代码。

打开 Shell 终端，切换到你要存储代码的目录，然后运行以下命令：

```bash
django-admin startproject mysite
```

我们来看看 startproject 创建的内容：

```bash
[root@localhost mysite]# tree
.
├── manage.py
└── mysite
    ├── __init__.py
    ├── settings.py
    ├── urls.py
    └── wsgi.py
```

关于上面自动生成的目录与文件解释如下：

- **manage.py**：一个命令行实用程序，可以让你以各种方式与此 Django 项目进行交互。
- **外部 mysite/ 根目录**：只是一个项目的容器。它的名字与 Django 无关; 你可以将其重命名为你喜欢的任何内容。
- **内部 mysite/ 目录**：这是你的项目的实际 Python 包。它的名字是你需要用来导入其中的任何内容的 Python 包名称（例如 mysite.urls）。
    - **init.py**：一个空的文件，告诉 Python 这个目录应该被认为是一个 Python 包。
    - **settings.py**：此 Django 项目的设置/配置。 Django 设置会告诉你所有关于设置的工作原理。
    - **urls.py**：该 Django 项目的 URL 声明，即驱动 Django 网站的“目录”。
    - **wsgi.py**：为 Django 项目提供 WSGI 兼容的 Web 服务器的服务入口点。



## 运行开发服务器

我们来验证你的 Django 项目的作品。更改为外部 mysite 目录，如果你还没有，并运行以下命令：

```bash
$ python manage.py runserver

# 注：若当前环境中有两个python环境，可使用python3或python3.6命令来调用3.6的环境，如：
$ python3 manage.py runserver
```

你将在命令行中看到以下输出：

```shell
Performing system checks...

System check identified no issues (0 silenced).

You have unapplied migrations; your app may not work properly until they are applied.
Run 'python manage.py migrate' to apply them.（注意：现在忽略关于未执行应用数据库迁移的警告）

August 07, 2017 - 15:50:53
Django version 1.11, using settings 'mysite.settings'
Starting development server at http://127.0.0.1:8000/
Quit the server with CONTROL-C.
```

以上说明已经开始使用 Django 的开发服务器，这是一个纯粹以 Python 编写的轻量级 Web 服务器。 我们将其与 Django 结合在一起，因此你可以快速开发，而无需处理配置生产服务器（如 Apache），直到你准备好生产环境。

默认情况下，该 runserver 命令在端口 8000 的内部 IP 上启动开发服务器。当然也可以指定端口开启服务，如 8080 端口：

```shell
$ python manage.py runserver 8080
```

如果要更改服务器的 IP，请将其与端口一起传递。例如：

```shell
$ python manage.py runserver 0:8000
```

注意：通过 IP 访问后报如下错误：

```shell
    DisallowedHost at /polls
    Invalid HTTP_HOST header: '192.168.*.*:8000'. You may need to add '192.168.*.*' to ALLOWED_HOSTS.

    HTTP_HOST标头无效：'192.168.*.*:8000'。你可能需要将“192.168.*.*”添加到ALLOWED_HOSTS
    如：ALLOWED_HOSTS = ['192.168.104.240']
```



## 创建一个应用程序

Django 自带一个实用程序，可以自动生成应用程序的基本目录结构，因此你可以专注于编写代码而不是创建目录。

要创建你的应用程序，请确保你与目录位于同一目录，manage.py 并键入以下命令：

```shell
$ python manage.py startapp polls

# 注：若当前环境中有两个python环境，可使用python3或python3.6命令来调用3.6的环境，如：
$ python3 manage.py startapp polls
```

这将创建一个目录 polls，其目录如下：此目录结构将容纳轮询应用程序。

```bash
[root@localhost demo]# tree mysite/
mysite/
├── manage.py
├── mysite
│   ├── __init__.py
│   ├── settings.py
│   ├── urls.py
│   └── wsgi.py
└── polls
    ├── admin.py
    ├── apps.py
    ├── __init__.py
    ├── migrations
    │   └── __init__.py
    ├── models.py
    ├── tests.py
    └── views.py
```



## 定义第一个视图

接着，我们来写第一个视图。打开文件 polls/views.py 并放入以下 Python 代码：

```python
from django.http import HttpResponse

def index(request):
    return HttpResponse("Hello, world. You're at the polls index.")
```

这是 Django 中最简单的视图。要调用视图，我们需要将其映射到一个 URL。为此，我们需要一个 URLconf。

要在 polls 目录中创建一个 URLconf，创建一个名为 urls.py。现在，你的应用目录应该如下所示：

```bash
└── polls
    ├── admin.py
    ├── apps.py
    ├── __init__.py
    ├── migrations
    │   └── __init__.py
    ├── models.py
    ├── tests.py
    ├── urls.py
    └── views.py
```

在 polls/urls.py 文件中包含以下代码：

```python
from django.conf.urls import url

from . import views

urlpatterns = [
    url(r'^$', views.index, name='index'),
]
```

下一步是将根 URLconf 指向 polls.urls 模块。 在 mysite/urls.py 添加一条 import 用于 django.conf.urls.include 和插入 include() 的 urlpatterns 列表，所以你必须：

```python
from django.conf.urls import include, url
from django.contrib import admin

urlpatterns = [
    url(r'^polls/', include('polls.urls')),
    url(r'^admin/', admin.site.urls),
]
```

其中 `include()` 函数允许引用其他 URLconfs。请注意，该 `include()` 函数的正则表达式 没有 `$`（字符串匹配字符），而是尾部的斜杠。 每当 Django 遇到时 `include()`，它会排除与该点匹配的任何部分，并将剩余的字符串发送到随附的 URLconf 进行进一步处理。

现在，你已经将 index 视图连接到 URLconf中。运行以下命令验证它的效果：

```bash
$ python manage.py runserver 0:8000
```

在浏览器中转到 [http://localhost:8000/polls/](http://localhost:8000/polls/)，你应该看到文本“Hello, world. You're at the polls index.”。



## url 函数说明

Django 的 `url()` 函数可以接收四个参数，分别是两个必选参数：`regex`、`view` 和两个可选参数：`kwargs`、`name`，接下来详细介绍这四个参数。

- `regex`：正则表达式，与之匹配的 URL 会执行对应的第二个参数 view。
- `view`：用于执行与正则表达式匹配的 URL 请求。
- `kwargs`：视图使用的字典类型的参数。
- `name`：用来反向获取 URL。

