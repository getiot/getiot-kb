---
sidebar_position: 3
---

# PyQt 快速上手



本文通过一个简单的示例，演示如何使用 PyQt 创建一个 Hello World 图形界面窗口。学习完本文，你将对 PyQt 的使用和运行方式有一个大致的认识。

项目代码存放与 GitHub 仓库 [getiot/pyqt-courses](https://github.com/getiot/pyqt-courses)，欢迎 Star！



## 示例代码

app.py 文件

```python
from PyQt5.QtWidgets import QWidget, QApplication

app = QApplication([])

mainWindow = QWidget()

mainWindow.setGeometry(0, 0, 400, 300)
mainWindow.setWindowTitle('Hello World')

mainWindow.show()

app.exec()
```



## 运行效果


激活 PyQt5 虚拟环境

```bash
$ source ~/.venv/PyQt5/bin/activate
```

运行应用程序

```bash
$ cd PyQt5/01_MainWindow
$ python app.py
```

运行效果如下图所示

![](https://static.getiot.tech/pyqt5-demo-01.png#center)
