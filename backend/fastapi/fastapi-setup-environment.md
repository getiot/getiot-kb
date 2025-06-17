---
sidebar_position: 2
sidebar_label: FastAPI 开发环境
slug: /fastapi-setup-environment
---

# FastAPI 开发环境搭建

本文将介绍如何从零开始搭建 FastAPI 的本地开发环境。你将了解如何安装 Python、创建虚拟环境、安装 FastAPI 和运行 Uvicorn 开发服务器，并推荐一些常用工具和编辑器设置，为后续开发做好准备。



## 准备工作

FastAPI 是基于 Python 语言开发的，因此首先需要安装 Python 开发环境。

FastAPI 要求 Python 版本为 **3.8 及以上**。你可以通过以下命令检查当前版本：

```bash
python --version
# 或者
python3 --version
```

如果版本低于 3.8，建议前往 [Python 官网](https://www.python.org/downloads/) 下载并安装最新版本。

:::tip

在 macOS 或 Linux 系统中，建议使用 [pyenv](https://github.com/pyenv/pyenv) 管理多个 Python 版本。

:::



## 创建项目目录与虚拟环境

我们建议你为每一个 FastAPI 项目创建一个独立的虚拟环境，避免依赖冲突。创建流程和命令如下：

```bash
# 创建项目目录
mkdir my-fastapi-app && cd my-fastapi-app

# 创建虚拟环境（推荐）
python -m venv venv

# 激活虚拟环境
# Windows
venv\Scripts\activate

# macOS/Linux
source venv/bin/activate
```

激活后，你的命令行前面会看到类似 `(venv)` 的标志，说明你已经处于虚拟环境中。



## 安装 FastAPI 和 Uvicorn

FastAPI 本身不包含运行服务器，所以你需要同时安装一个 ASGI 服务器。推荐使用 [Uvicorn](https://www.uvicorn.org/)：

```bash
pip install fastapi uvicorn
```

如果你打算使用所有常见功能（如表单、文件上传、邮箱格式校验、模板渲染等），建议使用：

```bash
pip install "fastapi[standard]"
```

如果你打算使用所有功能，可以使用：

```bash
pip install "fastapi[all]"
```



:::tip `standard` 和 `all` 有什么区别？

`fastapi[standard]` 是**官方推荐**的安装方式，用于开发大多数 API 应用。它包含了 FastAPI 的核心功能以及实现常用特性的标准依赖，例如：

- `pydantic[email]`：邮箱格式验证支持
- `python-multipart`：用于处理表单数据（如上传文件）
- `uvicorn[standard]`：带标准依赖的 Uvicorn ASGI 服务
- `aiofiles`：异步文件操作
- `requests`：常用的 HTTP 客户端（用于调试或内部调用）
- `jinja2`：用于模板渲染（如果你使用 HTML 响应）
- `python-dotenv`：支持从 `.env` 文件加载配置

这是一组经过官方挑选的、安全的、被广泛使用的依赖组合，适用于绝大多数实际项目。

而 `fastapi[all]` 包含了 FastAPI 所支持的**全部可选依赖**，除了 `standard` 中的内容，还可能包括调试工具或边缘功能所需的额外包。缺点是依赖较多，可能导致体积变大或依赖冲突。

|         适用场景          |         推荐方式         |
| :-----------------------: | :----------------------: |
|    日常开发 / 商业项目    |   `fastapi[standard]`    |
|    原型探索 / 功能尝鲜    |  `fastapi[all]`（可选）  |
| 精简依赖 / 自定义环境控制 | `fastapi` + 手动安装依赖 |

:::



## 测试：创建一个 FastAPI 应用

创建一个名为 `main.py` 的文件，并写入以下代码：

```python
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Hello, FastAPI!"}
```

运行服务器：

```bash
uvicorn main:app --reload
```

- `main`：表示 Python 文件名（不带 `.py`）。
- `app`：表示 FastAPI 应用的实例名。
- `--reload`：启用热重载，适合开发阶段使用。

访问以下地址即可看到运行结果：

- API 接口：`http://127.0.0.1:8000`
- Swagger 文档：`http://127.0.0.1:8000/docs`
- ReDoc 文档：`http://127.0.0.1:8000/redoc`



## 推荐开发工具

推荐使用 [Visual Studio Code（VS Code）](https://code.visualstudio.com/) 开发 FastAPI 项目，并搭配以下插件：

- **Python**（官方插件）
- **Pylance**（增强类型提示）
- **Black**、**isort**（自动格式化）
- **REST Client**（模拟 API 请求）

💡 提示：在 VS Code 中按 `Ctrl+Shift+P`，执行 “Python: Select Interpreter”，选择当前虚拟环境。



## 小结

本章中，你学习了如何从零搭建 FastAPI 开发环境，包括 Python 安装、虚拟环境创建、依赖选择及安装、初始项目编写与运行。推荐使用官方推荐的 `fastapi[standard]` 方式安装，既包含常用功能，又能保持依赖简洁。下一步你将编写第一个实际的 FastAPI 接口，逐步掌握参数、请求体、响应模型等核心知识。
