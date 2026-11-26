---
sidebar_position: 6
draft: true
---

# Django 快速上手 2



## 1. Django是什么

Django 是一个高级的 Python Web 框架，它最初是加拿大劳伦斯出版集团用于管理旗下新闻网站内容的设计。它鼓励快速开发和清洁，负责 Web 开发的许多麻烦，因此开发人员可以专注于编写应用程序，而不需要重新制作轮子。Django 于2005年7月在BSD许可证下发布。

以下优点可能会让你考虑 Django 框架：

- Django 是免费和开源的；
- Django 很全面，被称为完美主义者的 Web 框架；
- 可以更快地构建更好的 Web 应用程序并减少代码；（Django 的宗旨在于帮助开发人员快速从概念到完成应用程序）
- Django 的 MVC 设计十分优美；
- Django 提供快速、灵活扩展的能力；
- 可以在 Django 中使用原始的 SQL 语句；
- Django 自带一个管理界面......

**Django 是一个大而全的 Web 框架，但是定制起来需要花费一些学习时间。**



## 2. MVC 和 MVT

MVC 是典型的网站开发设计模式，MVC 是 Model-View-Controller 的缩写，其中：

- **Model**，模型建模：其指将对象资源间的关系映射到数据库表格中，主要封装对数据库层的访问，对数据库中的数据进行 CURD 操作；
- **View**，视图：其指我们看到的网页外观，同时还需要使用网页模板，用于封装结果，生成 HTML 页面；
- **Controller**，控制器：每个网页需要实现的功能，由对应于该网页路径的函数实现，该函数就是控制器，用于接收请求、处理业务逻辑、整合模型（数据库）和视图（网页）。

但是呢，Django 的 MVC 与传统的 MVC 有所不同，属于 MVT 架构，其中：

- **M** 表示 Model：与 MVC 中的 M 功能相同，负责与数据库交互、进行数据处理；
- **V** 表示 View：与 MVC 中的 C 功能相同，负责接收请求、获取数据、返回结果；
- **T** 表示 Template：与 MVC 中的 V 功能相同，负责封装构造要返回的 HTML 页面。

注意：处理客户端和服务器之间的 http 请求响应需要实现 wsgi 协议。

> Python Web 服务器网关接口（Python Web Server Gateway Interface，缩写为 WSGI）是 Python 应用程序或框架和 Web 服务器之间的一种接口，已经被广泛接受，基本达成可移植性方面的目标。

## 3. 安装Django

打开 Django 官网的 [download 页面](https://www.djangoproject.com/download/)，上面有详细的安装方法。我们要注意的是版本的选择，以下是官方的版本发布计划：

![Django versions](https://img-blog.csdn.net/20180412094904756)

开发环境可以使用较新的版本，但生产环境建议使用 LTS 版本。

我的实验环境是 64位 Ubuntu 16.04，Python 版本 3.5.2，pip 版本 9.0.3，准备安装的 Django 版本为 1.11.11。安装过程如下：

使用 pip 在线安装：

```bash
$ pip install django==1.11.11
```

这样安装的话，会安装到 Python 的默认目录中，我们可以用 `pip show` 查看：

```bash
$ pip show django
Name: Django
Version: 1.11.11
Summary: A high-level Python Web framework that encourages rapid development and clean, pragmatic design.
Home-page: https://www.djangoproject.com/
Author: Django Software Foundation
Author-email: foundation@djangoproject.com
License: BSD
Location: /usr/local/lib/python3.5/dist-packages
Requires: pytz
```

也可以先下载安装包，再指定目录安装：

```bash
$ pip download django=1.11.11 -d ./
$ pip install Django-1.11.11-py2.py3-none-any.whl
```

检查一下，确保安装成功：

```bash
$ pip freeze
$ python3 -m django --version
```

## 4. 项目的创建与运行

### 4.1 创建项目

如果你和我一样，第一次使用 Django，那么现在进入你的工作目录，然后执行如下命令，这会自动生成一些建立 Django 项目的代码。

```bash
$ django-admin startproject myweb
```

进入 myweb 目录，看看 startproject 创建了什么东西：

```bash
$ tree
.
├── manage.py
└── myweb
    ├── __init__.py
    ├── settings.py
    ├── urls.py
    └── wsgi.py
```

这些目录和文件的作用如下：

- `外部 myweb/` 根目录只是一个项目的容器。它的名字与 Django 无关; 您可以将其重命名为您喜欢的任何内容。
- `manage.py`：一个命令行实用程序，可以让您以各种方式与此 Django 项目进行交互。你可以阅读所有的细节 manage.py 在 Django 的管理和 manage.py。
- `内部 myweb/` 目录是您的项目的实际 Python 包。它的名字是您需要用来导入其中的任何内容的 Python 包名称（例如myweb.urls）。
- `myweb/__init__.py`：一个空的文件，告诉 Python 这个目录应该被认为是一个 Python 包。
- `myweb/settings.py`：此 Django 项目的设置/配置。 Django 设置会告诉你所有关于设置的工作原理。
- `myweb/urls.py`：该 Django 项目的 URL 声明; 您的 Django 动力网站的“目录”。
- `myweb/wsgi.py`：WSGI 兼容的 Web 服务器为您的项目提供服务的入口点。

### 4.2 运行开发服务器

在外部 myweb/ 目录下，执行如下命令：

```bash
$ python3 manage.py runserver
```

此时，我们的 Django 开发服务器就运行起来了，但是可能会出现如下警告：

```bash
You have unapplied migrations; your app may not work properly until they are applied.
Run 'python manage.py migrate' to apply them.
```

这是因为服务器默认连接 SQLite 数据库，而我们当前还没有数据库或者没有正确配置，暂时忽略。

然后打开浏览器，输入 `http://127.0.0.1:8000/` ，看到如下页面说明我们的 Django 开发服务器已经运行起来了。

![Django worked](https://img-blog.csdn.net/20180412110104598)

默认情况下，`runserver` 命令在 8000 端口的内部 IP 上启动开发服务器。如果想指定端口开启服务，如 8080 端口，可以这样：

```bash
$ python3 manage.py runserver 8080
```

当然，我们还可以指定 IP，比如我的实验环境的 IP 是 192.168.66.169，可以这样：

```bash
$ python3 manage.py runserver 192.168.66.169:8080
```

或者是：

```bash
$ python3 manage.py runserver 0:8080
```

注意：0 是 0.0.0.0 的简写，是一个特殊的 IP 地址，代表的是本机所有 IP 地址，而不管有多少个网口，多少个 IP，监听本机的 0.0.0.0 上的 8080 端口就等于监听机器上的所有 IP 的 8080 端口。

但是这个时候，我们在浏览器输入 `http://192.168.66.169:8000/`，可能会看到如下页面：


![Django DisallowedHost](https://img-blog.csdn.net/20180412112421844)

这是因为 Django 开发服务器默认只能本地访问，所有我们还要配置下 myweb/settings.py 中的 `ALLOWED_HOSTS`，比如：

```python
ALLOWED_HOSTS = ['192.168.66.169','localhost','127.0.0.1']
```
或者干脆这样，表示支持所有：

```python
ALLOWED_HOSTS = ['*']
```

> 注意：这里启动的是一个纯粹以Python编写的轻量级Web服务器，其与 Django 结合在一起，因此开发人员可以快速开发，而无需处理配置生产服务器（如Apache），直到您准备好生产。

## 5. 应用的创建与使用

### 5.1 创建一个应用程序

Django 自带一个实用程序，可以自动生成应用程序的基本目录结构，因此您可以专注于编写代码而不是创建目录。在外部 myweb/ 目录，执行如下命令：

```bash
$ python3 manage.py startapp myapp
```

我们发现多了一个 myapp/ 目录，展开如下：

```bash
$ tree myapp/
myapp/
├── admin.py
├── apps.py
├── __init__.py
├── migrations
│   └── __init__.py
├── models.py
├── tests.py
└── views.py

```

### 5.2 编写第一个视图

打开 `myapp/views.py` 文件，并添加以下 Python 代码：

```python
from django.http import HttpResponse

def index(request):
    return HttpResponse("Hello, world. You're at the myapp index. 喵")
```

这是 Django 中最简单的视图，要调用视图，我们需要将其映射到一个URL。因此，我们需要一个 URLconf —— 在 myapp 目录中创建一个 URLconf，创建一个名为 urls.py 的文件。

编辑 `myapp/urls.py` 文件，内容如下：

```python
from django.conf.urls import url
from . import views

urlpatterns = [
    url(r'^$', views.index, name='index'),
]

```

紧接着，我们还要将根 URLconf 指向 myapp.urls 模块。编辑 `myweb/urls.py` 中的 urlpatterns 列表，如下：

```python
from django.conf.urls import include, url
from django.contrib import admin

urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^myapp/', include('myapp.urls')),
]
```

这里用到了 include() 函数，所以我们需要 import `django.conf.urls.include` ，include() 函数允许引用其他的 URLconfs。

注意：include() 函数的正则表达式没有`$`（字符串匹配字符），而是尾部的斜杠。每当 Django 遇到时 include()，它会排除与该点匹配的任何部分，并将剩余的字符串发送到随附的 URLconf 做进一步处理。

好啦，现在重新运行 django 开发服务器：

```bash
$ python3 manage.py runserver 0:8000
```

浏览器输入 `http://localhost:8000/myapp/`，可以看到如下页面：

![这里写图片描述](https://img-blog.csdn.net/20180412131522984)

### 5.3 url() 函数介绍

Django 的 `url()` 函数可以接收四个参数，分别是两个必选参数：regex、view，以及两个可选参数：kwargs、name。

>  - regex：正则表达式，与之匹配的 URL 会执行对应的第二个参数 view
>  - view：用于执行与正则表达式匹配的 URL 请求
>  - kwargs：视图使用的字典类型的参数
>  - name：用来反向获取 URL

## 6. 项目的模型

### 6.1 连接MySQL数据库设置

在 `myweb/settings.py` 中，有如下代码：

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
    }
}
```

也就是说，Django 默认配置使用 SQLite。如果不使用 SQLite 作为数据库，则需要额外的设置，例如我们本示例中使用 MySQL 数据库，必须添加 USER，PASSWORD 和 HOST 等配置信息。

在我的本地 MySQL 中，已经提前创建了一个名为 `django-test` 的数据库用于测试。


![这里写图片描述](https://img-blog.csdn.net/20180412135044608)

最终的 DATABASES 配置如下：

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'django-test',
        'USER': 'root',
        'PASSWORD': '',
        'HOST': 'localhost',
        'PORT': '3306',
    }
}
```

注意：Django 使用 MySQL 数据库需要安装 PyMySQL，如果小伙伴们还没安装的话，可以执行如下命令安装：

```bash
$ pip install pymysql
```

然后在 `myweb/__init__.py` 中添加以下代码，导入 pymysql：

```python
import pymysql
pymysql.install_as_MySQLdb()
```

### 6.2 创建模型

下面，在我们的前面创建的应用程序中，创建一个 stu 表信息操作的 Model 类。编辑 `myapp/models.py` 文件，内容如下：

```python
from django.db import models

# Create your models here.

class Stu(models.Model):
    '''自定义Stu表对应的Model类'''
    #定义属性：默认主键自增id字段可不写
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=16)
    age = models.SmallIntegerField()
    sex = models.CharField(max_length=1)
    classid=models.CharField(max_length=8)

    # 定义默认输出格式
    def __str__(self):
        return "%d:%s:%d:%s:%s"%(self.id,self.name,self.age,self.sex,self.classid)

    # 自定义对应的表名，默认表名：myapp_stu
    class Meta:
        db_table="stu"
```

### 6.3 激活模型

激活模型，也就是要将该应用程序包括在我们的项目中，需要在设置中添加对其配置类的引用 `INSTALLED_APPS`。**MyappConfig** 类在 `myapp/apps.py` 文件中，所以它的路径 应该是“`myapp.apps.MyappConfig`”。

编辑 `myweb/settings.py` 文件，并将该路径添加到该 `INSTALLED_APPS` 设置，如下：

```python
INSTALLED_APPS  =  [ 
    'django.contrib.admin' ，
    'django.contrib.auth' ，
    'django.contrib.contenttypes' ，
    'django.contrib.sessions' ，
    'django.contrib.messages' ，
    'django.contrib.staticfiles' ，
    'myapp.apps.MyappConfig',  #或者直接写 myapp
]
```

### 6.4 使用模型

下面展示如何获取模型的数据，在此之前，我们已经在 django-test 数据库中创建好 stu 数据表，并且添加里一些数据。如下所示：

![这里写图片描述](https://img-blog.csdn.net/20180412153239823)

接下来我们通过两种方法来使用该模型。

**6.4.1 进入交互式的Python shell 使用Django的API操作**

进入 Python Shell 交互界面：

```bash
$ python3 manage.py shell
```

一个简单的交互过程如下所示，先导入 Stu，然后获取模型所有信息，接着把所有记录打印出来，我们也可以获取单条信息。

```python
Python 3.5.2 (default, Nov 23 2017, 16:37:01) 
Type "copyright", "credits" or "license" for more information.

IPython 2.4.1 -- An enhanced Interactive Python.
?         -> Introduction and overview of IPython's features.
%quickref -> Quick reference.
help      -> Python's own help system.
object?   -> Details about 'object', use 'object??' for extra details.

In [1]: from myapp.models import Stu

In [2]: mod = Stu.objects

In [3]: lists = mod.all()

In [4]: for v in lists:
   ...:     print(v)
   ...:     
1:Apple:8:female:1
2:Rudy:10:male:1
3:Tina:9:female:1
4:Alexander:6:male:1
5:Carrie:5:female:1
6:Joe:7:female:1
7:Elsa:11:female:1
8:Blaise:12:male:1
9:Lisa:12:female:2
10:Jhon:12:male:2

In [5]: mod.get(id=1)
Out[5]: <Stu: 1:Apple:8:female:1>

In [6]: mod.get(id=2)
Out[6]: <Stu: 2:Rudy:10:male:1>

In [7]: mod.get(id=3)
Out[7]: <Stu: 3:Tina:9:female:1>

In [8]: quit
```

注意：我这里安装里 ipython，它是一个增强版的 Python Shell，所以跟你操作的提示可能不一样。Ubuntu 安装 ipython 的方法很简单：`$ sudo apt-get install ipython`。

**6.4.2 在myapp应用的视图中使用**

编辑 `myapp/views.py` 文件，导入 Stu，实现 stu 函数：

```python
from django.shortcuts import render
from django.http import HttpResponse
from myapp.models import Stu

# Create your views here.

def index(request):
    return HttpResponse("Hello, world. You're at the myapp index. 喵")
    #return render(request, "index.html")

def stu(request):
    #获取所有stu表信息
    lists = Stu.objects.all()
    print(lists)
    #获取单条学生信息
    print(Stu.objects.get(id=1))

    return HttpResponse("ok")

```

别忘了！还要在 `myapp/urls.py` 中配置 stu 函数的访问路由：

```python
url(r'^stu$', views.stu),
```

重启 django 开发服务器，在浏览器输入 [http://localhost:8000/myapp/stu](http://localhost:8000/myapp/stu) 。

## 7. 启用网站后台管理

Django 框架中有一个非常强大的应用功能——自动管理界面，常被 Web 平台管理者使用，用以管理整个 Web 平台。

### 7.1 数据迁移

第一次启用后台管理，首先要进行数据迁移。数据迁移就是将 Django 提供的后台管理模块的数据迁移至 myweb 的数据库，所以如果你的 myweb 还没有连接数据库，赶紧回到 6.1 节吧。

默认情况下，在 settings.py 配置文件中 `INSTALLED_APPS` 包含以下应用程序，这些应用程序都是由 Django 提供：

>  - django.contrib.admin - 管理网站。你会很快使用它。
>  - django.contrib.auth - 认证系统。
>  - django.contrib.contenttypes - 内容类型的框架。
>  - django.contrib.sessions - 会话框架
>  - django.contrib.messages - 消息框架。
>  - django.contrib.staticfiles - 管理静态文件的框架。

使用这些 Django 自带的应用程序，需要我们在数据库中创建一些数据表对应，然后才能使用它们。因此，我们运行以下命令进行数据结构迁移：

```bash
$ python3 manage.py migrate
```

`migrate` 命令会查看 `INSTALLED_APPS` 设置，并根据 myweb/settings.py 文件中的数据库设置和应用程序随附的数据库迁移创建任何必需的数据库表。

看看 MySQL，多了好多张数据表：

![这里写图片描述](https://img-blog.csdn.net/20180412185735145)


这时，访问 [http://localhost:8000/admin/](http://localhost:8000/admin/)，进入后台登录界面，咦~ 帐号/密码呢？

![这里写图片描述](https://img-blog.csdn.net/20180412191221607)


### 7.2 创建管理员用户

没错，我们还需要创建一个可以登录管理站点的用户（superuser）！执行如下命令：

```bash
$ python3 manage.py createsuperuser
```

根据提示输入用户名和密码等信息即可。

### 7.3 启动开发服务器

默认情况下，Django 管理员已经激活，我们重启开发服务器就可以了：

```bash
$ python3 manage.py runserver 0:8000
```

再登录管理后台，输入刚刚创建的用户名和密码，登录成功！

![这里写图片描述](https://img-blog.csdn.net/20180412191321317)


### 7.4 设置时区和语言

但是英文看不太习惯呀，切换成中文呗！编辑 myweb/settings.py 配置文件：

```python
LANGUAGE_CODE = 'zh-hans'
TIME_ZONE = 'Asia/Shanghai'
```

刷新，看到中文啦~

![这里写图片描述](https://img-blog.csdn.net/20180412191448487)

### 7.5 将自定义的应用程序加入到后台管理

但是，我们的自定义应用程序在哪里？并没有显示在后台管理索引页面上。要做到这一点，打开 myapp/admin.py 文件，并编辑代码如下：

```python
from django.contrib import admin
from myapp.models import Stu

admin.site.register(Stu)
```

刷新：

![这里写图片描述](https://img-blog.csdn.net/20180412192102684)

### 7.6 更深入设计后台管理

编辑 myapp/models.py 文件，在 Stu 类中添加如下信息，让后台管理显示中文字段：

```python
class Stu(models.Model):
    '''自定义Stu表对应的Model类'''
    #定义属性：默认主键自增id字段可不写
    id = models.AutoField("学号",primary_key=True)
    name = models.CharField("姓名",max_length=16)
    age = models.SmallIntegerField("年龄")
    sex = models.CharField("性别",max_length=1)
    classid=models.CharField("班级",max_length=8)

    # 定义默认输出格式
    def __str__(self):
        return "%d:%s:%d:%s:%s"%(self.id,self.name,self.age,self.sex,self.classid)

    # 自定义对应的表名，默认表名：myapp_stu
    class Meta:
        db_table="stu"
        verbose_name = '浏览学生信息'  
        verbose_name_plural = '学生信息管理'
```

编辑 myapp/admin.py 文件，实现信息管理的个性化定制：

```python
from django.contrib import admin

# Register your models here.
from myapp.models import Stu

#Stu模型的管理器(装饰器写法)
@admin.register(Stu)
class StuAdmin(admin.ModelAdmin):
    #listdisplay设置要显示在列表中的字段（id字段是Django模型的默认主键）
    list_display = ('id','name','age','sex','classid')

    #设置哪些字段可以点击进入编辑界面
    list_display_links = ('id','name')

    #list_per_page设置每页显示多少条记录，默认是100条
    list_per_page = 10

    #ordering设置默认排序字段，负号表示降序排序
    ordering = ('id',)  #-id降序

    #list_editable 设置默认可编辑字段
    #list_editable = ['age','sex','classid']
```

　　没有对比就没有伤害！好看太多了呀~

![这里写图片描述](https://img-blog.csdn.net/20180412192803544)

>（修改前）

![这里写图片描述](https://img-blog.csdn.net/20180412192816820)
>（修改后）


----------

好啦，这篇 Django 框架快速入门就到这吧，内容也不少了呀！好好消化吧~



