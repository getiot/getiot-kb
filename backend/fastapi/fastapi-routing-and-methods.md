---
sidebar_position: 4
sidebar_label: FastAPI 路由请求
slug: /fastapi-routing-and-methods
---

# FastAPI 路由与请求方法

本文将带你深入了解 FastAPI 中的“路由”和“请求方法”的概念与使用方式。你将学习如何为不同的 URL 路径设置对应的请求方法（如 GET、POST、PUT、DELETE 等），并编写 RESTful 风格的接口。



## 什么是“路由”？

在 Web 开发中，“路由（Route）”指的是将 URL 路径与对应的处理逻辑（函数）关联起来。

FastAPI 中通过装饰器（如 `@app.get()`、`@app.post()` 等）来定义路由，告诉框架：当客户端访问某个路径，并使用某个方法时，应该调用哪个函数来处理请求。



## FastAPI 支持的请求方法

FastAPI 支持所有常见的 HTTP 请求方法：

|   方法    | 说明                     |
| :-------: | ------------------------ |
|   `GET`   | 获取资源                 |
|  `POST`   | 创建资源                 |
|   `PUT`   | 更新整个资源（完全替换） |
|  `PATCH`  | 部分更新资源（局部修改） |
| `DELETE`  | 删除资源                 |
| `OPTIONS` | 获取服务器支持的通信选项 |
|  `HEAD`   | 获取响应头而不返回响应体 |

常用的是前五种（GET、POST、PUT、PATCH、DELETE）。



## 定义基本路由

下面是一个最基本的例子：

```python showLineNumbers
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Hello, FastAPI!"}
```

访问 `http://127.0.0.1:8000/` 时，FastAPI 会执行 `read_root()` 函数，返回一个 JSON 响应。



## 为同一路径定义多个方法

FastAPI 支持在同一路径下定义多个方法，例如：

```python showLineNumbers
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class Item(BaseModel):
    name: str
    price: float

@app.get("/items/")
def read_items():
    return [{"name": "Apple", "price": 3.5}, {"name": "Banana", "price": 2.0}]

@app.post("/items/")
def create_item(item: Item):
    return {"message": "Item created", "item": item}
```

- 访问 `GET /items/` 会返回一个商品列表；
- 向 `POST /items/` 发送 JSON 数据，会创建一个新商品。

这种方式正是 **[RESTful API 设计](/http/http-restful-api/)** 的核心：一个路径代表一个资源，不同方法代表对该资源的不同操作。



## 使用路径参数定义路由

你可以在路径中使用变量来动态匹配内容，例如：

```python showLineNumbers
@app.get("/users/{user_id}")
def get_user(user_id: int):
    return {"user_id": user_id}
```

访问 `/users/123` 时，`user_id` 的值将为 `123`，类型为整数。

FastAPI 会自动进行类型转换和验证，如果传入的是非整数，例如 `/users/abc`，会返回 422 错误。



## 使用查询参数

查询参数是通过 URL 的 `?key=value` 形式传递的：

```python showLineNumbers
@app.get("/search/")
def search_items(keyword: str = "", limit: int = 10):
    return {"keyword": keyword, "limit": limit}
```

访问 `http://127.0.0.1:8000/search/?keyword=apple&limit=5` 会返回：

```json showLineNumbers
{
  "keyword": "apple",
  "limit": 5
}
```



## 组合路径参数与请求体参数

你可以同时使用路径参数和请求体参数，例如更新某个资源：

```python showLineNumbers
@app.put("/items/{item_id}")
def update_item(item_id: int, item: Item):
    return {"item_id": item_id, "updated": item}
```



## 响应状态码

你可以通过设置 `status_code` 参数来改变响应状态码，例如创建成功返回 201：

```python showLineNumbers
from fastapi import status

@app.post("/items/", status_code=status.HTTP_201_CREATED)
def create_item(item: Item):
    return item
```

默认情况下：

- `GET` 返回 200
- `POST` 返回 200
- `PUT` 返回 200
- `DELETE` 返回 200 或 204

你也可以通过 `Response` 对象手动控制状态码。

:::tip

关于响应状态码，可参考《[HTTP 状态码](/http/http-status-code/)》。

:::



## 多个路径指向同一个函数

你可以为不同路径设置相同的处理函数，实现路径别名的效果。例如：

```python showLineNumbers
@app.get("/home")
@app.get("/index")
def homepage():
    return {"message": "Welcome to homepage!"}
```

这样无论访问 `/home` 还是 `/index`，都会返回相同的结果。



## 完整示例

```python showLineNumbers
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class Item(BaseModel):
    name: str
    price: float

@app.get("/")
def read_root():
    return {"message": "Welcome to FastAPI"}

@app.get("/items/")
def read_items():
    return [{"name": "Apple", "price": 3.5}]

@app.get("/items/{item_id}")
def read_item(item_id: int):
    return {"item_id": item_id}

@app.post("/items/", status_code=201)
def create_item(item: Item):
    return {"message": "Item created", "item": item}

@app.put("/items/{item_id}")
def update_item(item_id: int, item: Item):
    return {"message": "Item updated", "item_id": item_id, "item": item}

@app.delete("/items/{item_id}")
def delete_item(item_id: int):
    return {"message": f"Item {item_id} deleted"}
```



## 小结

本章中，你深入学习了 FastAPI 的路由系统和常用的请求方法，掌握了路径参数、查询参数、请求体、状态码以及 RESTful 接口的设计方式。通过这些基础，你已经可以构建出一个具备完整 CRUD 功能的 API。
