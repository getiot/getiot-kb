---
sidebar_position: 3
sidebar_label: FastAPI 快速上手
slug: /fastapi-quick-start
---

# FastAPI 快速上手

本文将带你构建第一个 FastAPI 应用程序。从最简单的“Hello, World!”开始，你将逐步理解路由（Route）、请求方法（GET、POST）、路径参数和查询参数的使用方式，并学会运行和调试你的 API。



## 创建最小可运行的 FastAPI 项目

新建 `my-fastapi-app` 目录，并激活虚拟环境

```bash
# 创建项目目录
mkdir my-fastapi-app && cd my-fastapi-app

# macOS/Linux
source venv/bin/activate
```

创建一个名为 `main.py` 的文件，输入以下内容：

```python showLineNumbers title="main.py"
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Hello, FastAPI!"}
```

你可以使用以下命令运行这个应用：

```bash
uvicorn main:app --reload
```

命令说明：

- `main`：是你的 Python 文件名（不带 `.py` 后缀）
- `app`：是 FastAPI 实例的名称
- `--reload`：开启热重载，修改代码后自动重启（适合开发阶段）

此时，打开浏览器访问 `http://127.0.0.1:8000/`，你会看到浏览器页面显示返回的 JSON 数据：

```json
{"message": "Hello, FastAPI!"}
```

这就是你的第一个 API 接口啦！😃



## 自动文档演示

FastAPI 默认会根据函数签名自动生成 API 文档，非常适合调试和接口分享。

FastAPI 提供了两种风格的 API 文档：

- `http://127.0.0.1:8000/docs`：交互式 API 文档（Swagger UI）。
- `http://127.0.0.1:8000/redoc`：另一种风格的 API 文档（ReDoc），更适合查阅与归档。



## 添加路径参数

你可以在路由路径中定义动态参数。例如，创建一个用户查询接口：

```python showLineNumbers
@app.get("/users/{user_id}")
def read_user(user_id: int):
    return {"user_id": user_id}
```

访问：`http://127.0.0.1:8000/users/42`

返回：`{"user_id": 42}`

- `{user_id}` 是路径参数
- `user_id: int` 表示它是整数类型，FastAPI 会自动进行类型转换和校验



## 添加查询参数

你还可以在 URL 中使用 `?key=value` 的形式传递查询参数：

```python showLineNumbers
@app.get("/items/")
def read_item(name: str = "default", price: float = 0.0):
    return {"name": name, "price": price}
```

访问：`http://127.0.0.1:8000/items/?name=apple&price=3.5`

返回：`{"name": "apple", "price": 3.5}`

如果你不传参数，使用默认值：`http://127.0.0.1:8000/items/` → `{"name": "default", "price": 0.0}`。



## 添加 POST 请求接口

下面我们创建一个简单的 POST 接口，接收 JSON 请求体：

```python showLineNumbers
from pydantic import BaseModel

class Item(BaseModel):
    name: str
    price: float

@app.post("/items/")
def create_item(item: Item):
    return {"received": item}
```

请求示例（使用 `curl` 或 Postman）：

```bash showLineNumbers
curl -X POST "http://127.0.0.1:8000/items/" \
     -H "Content-Type: application/json" \
     -d '{"name": "banana", "price": 2.0}'
```

返回结果：

```json showLineNumbers
{
  "received": {
    "name": "banana",
    "price": 2.0
  }
}
```

FastAPI 会自动解析请求体、校验字段类型，并生成文档说明。



## 完整代码示例

整合上述内容后的完整 `main.py` 如下：

```python showLineNumbers title="main.py"
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Hello, FastAPI!"}

@app.get("/users/{user_id}")
def read_user(user_id: int):
    return {"user_id": user_id}

@app.get("/items/")
def read_item(name: str = "default", price: float = 0.0):
    return {"name": name, "price": price}

class Item(BaseModel):
    name: str
    price: float

@app.post("/items/")
def create_item(item: Item):
    return {"received": item}
```

:::tip

在 FastAPI 中，同一个路径（例如 `/items/`）可以对应多个 HTTP 方法（如 GET、POST、PUT、DELETE 等），这也是构建符合 RESTful API 规范的常见做法。

|   方法   | 作用                       |
| :------: | -------------------------- |
|  `GET`   | 获取资源，通常用于查询     |
|  `POST`  | 创建新资源                 |
|  `PUT`   | 更新整个资源（通常是替换） |
| `PATCH`  | 部分更新资源               |
| `DELETE` | 删除资源                   |

:::



## 小结

在这一章中，你创建并运行了第一个 FastAPI 应用，初步掌握了基本路由、路径参数、查询参数和请求体的处理方式。你还了解了 FastAPI 如何自动生成交互式文档。下一章将带你深入学习请求参数和数据校验的高级特性。



