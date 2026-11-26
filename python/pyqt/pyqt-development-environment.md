---
sidebar_position: 2
---

# PyQt 开发环境



本文主要介绍 PyQt 开发环境的安装，目前使用较多的版本是 PyQt5 和 PyQt6。作者在 Ubuntu 20.04 系统中进行测试，使用 [Python 虚拟环境](/python/python-virtualenv/)，但安装流程同样适用于 Windows 和 macOS 操作系统。



## 安装步骤

1、创建专用的 Python 虚拟环境

```bash
python3 -m venv ~/.venv/PyQt5
```

2、激活 Python 虚拟环境

```bash
source ~/.venv/PyQt5/bin/activate
```

3、安装 PyQt5

```bash
pip install PyQt5
```

如果你需要用 PyQt6，则使用下面命令替代：

```bash
python3 -m venv ~/.venv/PyQt6
source ~/.venv/PyQt6/bin/activate
pip install PyQt6
```

这样就安装好 PyQt 开发环境啦！只需要在 Python 代码中导入 PyQt5 或 PyQt6 模块即可使用。





