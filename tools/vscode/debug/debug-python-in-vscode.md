---
sidebar_position: 2
slug: /debug-python-in-vscode
authors: [luhuadong]
---

# VS Code 运行和调试 Python 程序

本文以 Ubuntu 系统为例，介绍如何在 VS Code 上配置 Python 的编程环境，并把 Python 程序运行、调试起来。由于 Python 是解释型语言，并且 VS Code 中提供了内置的调试器可用于调试 Python 代码，因此配置和操作流程比调试 C/C++ 代码要简单一些。



## 准备工作

### 安装 Python 解释器

如果你的本地环境还没有 Python，需要先安装 Python 相关开发工具，可以参考 [Python 安装指南](/python/python-installation/) 安装或升级 Python 解释器。如无特殊需求，建议安装当前最新的稳定版本。



### 安装 VS Code 插件

确保已经在 VS Code 中安装了 Python 扩展。你可以在 Extensions 视图中搜索 "Python" 并安装 Microsoft 提供的 Python 扩展。

![](https://static.getiot.tech/vscode-extensions-python-debugging.png#center)



### 下载示例代码

在 VS Code 中打开你的 Python 文件，或者使用我们这里提供的示例代码，本示例完整工程代码可在 [GitHub](https://github.com/getiot/vscode-courses/tree/main/project/python-demo) 获取。

```python showLineNumbers title="python-demo"
from datetime import datetime
import sys

class User:
    def __init__(self, name, email):
        self._name = name
        self._email = email

    def get_name(self):
        return self._name

    def get_email(self):
        return self._email
     
    def do_something_cool(self):
        current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        print (self._name + ", Welcome to GetIoT (" + current_time + ")")

    def __str__(self):
        return self._name + " , " + self._email

if __name__ == "__main__":
    print("Python Version:", sys.version)

    users = [ User("Rudy", "rudy@getiot.tech"), User("Tina", "tina@getiot.tech")]

    for user in users:
        user.do_something_cool()
```



## 配置调试器

由于 Python 是解释型语言，因此在 VS Code 中调试 Python 程序不需要 `tasks.json` 文件，只需要 `launch.json` 文件配置调试器即可。

但其实，`launch.json` 文件也不是必须的，如果你使用 VS Code 的默认配置，并且你的 Python 文件在当前工作区中，VS Code 可以在没有 `launch.json` 文件的情况下执行简单的 Python 调试。

1. 选择 VS Code 左侧的调试图标，或者使用快捷键 `Ctrl + Shift + D`，打开 "Run and Debug" 视图。
2. 在顶部选择 "Python" 作为环境。
3. 如果你是第一次使用，VS Code 可能会提示你选择一个调试器。在这里，选择 "Python File" 即可。

### 创建 launch.json 文件

不过使用 `launch.json` 文件还是有很多好处的，它可以为调试器提供更多的配置选项，允许你定义自定义的调试配置，例如调试启动时的环境变量、工作目录、启动参数等内容。

创建 `launch.json` 文件的方法是在 "Run and Debug" 视图，点击 “创建 launch.json 文件”，然后选择一个调试配置模板，例如 “Python 文件”。

![](https://static.getiot.tech/vscode-create-launch-json-file-for-python.png#center)

此时，`launch.json` 文件的内容如下。其中 `"program"` 字段可设置为你要调试的 Python 文件的路径。

```json showLineNumbers title="launch.json"
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Python: Current File",
            "type": "python",
            "request": "launch",
            "program": "${file}",
            "console": "integratedTerminal"
        }
    ]
}
```



## 运行调试

现在，可以开始调试你的 Python 程序了。选择 VS Code 左侧的调试图标，或者使用快捷键 `Ctrl + Shift + D`，打开 "Run and Debug" 视图。

在你想要设置断点的行上点击编辑器左侧的行号，或者直接按 `F9` 设置断点。断点将在调试时暂停执行，允许你逐步执行代码并查看变量的值。

点击编辑器顶部的绿色调试按钮（或按 `F5`）开始调试。VS Code 将运行你的 Python 文件，并在遇到断点时暂停执行。你可以使用调试器工具栏进行单步调试、查看变量、评估表达式等。

![](https://static.getiot.tech/vscode-debugging-python-project.png#center)

在终端窗口，可以看到 Python 程序的打印信息，如下：

```bash
Python Version: 3.12.1 (main, Dec 10 2023, 15:16:41) [GCC 9.4.0]
Rudy, Welcome to GetIoT (2024-01-20 15:37:55)
Tina, Welcome to GetIoT (2024-01-20 15:38:03)
```



## 设置虚拟环境

有时候，我们可能需要使用指定的 Python 环境，使用不同版本的 Python 解释器，下面介绍 Python 解释器的设置方法。

首先，按快捷键 `Ctrl + Shift + P` 打开执行命令的输入框，输入 “python select”，选择 “Python: 选择解析器”。

![](https://static.getiot.tech/vscode-select-python-interpreter-01.png#center)

在这里，可以看到你的系统已安装的 Python 版本。如果有你想要的，直接选择即可。如果是 Python 虚拟环境，选择 “输入解释器路径...” 手动添加。

![](https://static.getiot.tech/vscode-select-python-interpreter-02.png#center)

你可以通过浏览器文件系统查找的方式添加，选择你所需 Python 虚拟环境的解释器路径即可。

![](https://static.getiot.tech/vscode-select-python-interpreter-03.png#center)

不过对于隐藏目录来说，这种方式不太方便。所以直接将路径复制、粘贴过去就可以了。

![](https://static.getiot.tech/vscode-select-python-interpreter-04.png#center)

现在，按 `F5` 重新运行程序，可以看到 Python 的版本从原来的 3.12.1 变成了 3.8.10，说明配置已经生效了。

```bash
Python Version: 3.8.10 (default, Nov 22 2023, 10:22:35) [GCC 9.4.0]
Rudy, Welcome to GetIoT (2024-01-20 15:50:15)
Tina, Welcome to GetIoT (2024-01-20 15:50:23)
```

