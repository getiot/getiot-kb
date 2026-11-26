---
sidebar_position: 2
slug: /jupyter-notebook-installation
---

# Jupyter Notebook 安装

本节介绍 Jupyter Notebook 的安装，Jupyter 是从 IPython 衍生出来的一个项目，因此使用 pip 即可安装。



## 安装

```bash
$ sudo pip3 install jupyter
```

如果安装过程中出现如下错误，通常是因为之前通过 apt 安装了 ipython3。

```bash
Cannot uninstall 'ipython'. It is a distutils installed project and thus we cannot accurately determine which files belong to it which would lead to only a partial uninstall.
```

执行下面命令卸载 ipython3 后重新执行 pip 安装 jupyter 即可。

```bash
$ sudo apt-get remove ipython3
```



## 使用

执行 `jupyter notebook` 启动

```bash
$ jupyter notebook
[I 19:36:11.806 NotebookApp] 把notebook 服务cookie密码写入 /run/user/1000/jupyter/notebook_cookie_secret
[I 19:36:12.020 NotebookApp] 启动notebooks 在本地路径: /home/rudy/workspace_hd/Python_Learning/14th_week
[I 19:36:12.020 NotebookApp] 本程序运行在: http://localhost:8888/?token=e36440d9e0adb34adcfacba94f0637b3c59d204059685a78
[I 19:36:12.020 NotebookApp] 使用control-c停止此服务器并关闭所有内核(两次跳过确认).
[C 19:36:12.022 NotebookApp] 
    
    Copy/paste this URL into your browser when you connect for the first time,
    to login with a token:
        http://localhost:8888/?token=e36440d9e0adb34adcfacba94f0637b3c59d204059685a78
[I 19:36:13.661 NotebookApp] Accepting one-time-token-authenticated connection from 127.0.0.1
```

这时候会自动打开浏览器，可以看到 Jupyter Notebook 的页面如下。

![](https://static.getiot.tech/jupyter_notebook_first.png#center)

点击 “新建”，选择 Python3，在打开的单元格中就可以编写 Python 代码啦！



