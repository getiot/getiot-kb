---
sidebar_position: 2
---

# Django 安装



作为 Python Web 框架，Django 需要 Python，在安装 Python 同时需要安装 pip。Python 的安装可以参考 [Python 安装指南](/python/python-installation/)。

## 安装步骤

安装好 Python 和 pip 工具之后，就可以安装 Django 啦！安装步骤如下：

在线安装 Django，可以指定版本，比如 5.0

```bash
pip3 install django==5.0
```

旧版本默认会安装：`Django==1.11.11` 和 `pytz==2020.1`

## 检查版本

检测当前是否安装 Django 及版本：

```bash
$ python -m django --version
5.0
```

或者使用 `pip freeze` 命令检查：

```bash
$ pip freeze | grep Django
Django==5.0
```

另外，如果由于网络等原因无法在线安装 Django，也可以先下载安装包，再指定安装包安装。例如：

```bash
pip download django=5.0 -d ./
pip install Django-5.0-py2.py3-none-any.whl
```

