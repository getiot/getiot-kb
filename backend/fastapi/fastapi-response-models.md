---
sidebar_position: 7
sidebar_label: FastAPI 响应模型
slug: /fastapi-response-models
authors: [luhuadong]
---

# FastAPI 响应模型与状态码

在这一节中，你将学习如何使用 FastAPI 定义接口的响应模型，以及如何自定义返回的 HTTP 状态码。掌握这些内容后，你的 API 将更加规范、易用，并具有更好的可维护性和自动化文档支持。

- FastAPI 支持通过类型注解定义响应模型，让你明确告知客户端接口将返回什么数据结构。
- 此外，你还可以自定义 HTTP 状态码，以表达操作结果的不同语义，例如创建成功（201）、未授权（401）、资源未找到（404）等。



## 使用响应模型

在 FastAPI 中，你可以通过 `response_model` 参数指定接口的响应结构，它通常是一个 Pydantic 模型。

**示例：**

```python showLineNumbers
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class Item(BaseModel):
    name: str
    price: float

class ItemResponse(BaseModel):
    name: str
    price: float
    message: str

@app.post("/items/", response_model=ItemResponse)
def create_item(item: Item):
    return {"name": item.name, "price": item.price, "message": "Item created successfully"}
```

**说明：**

- 请求体结构由 `Item` 决定；
- 响应结构由 `ItemResponse` 限定，FastAPI 会自动剔除不在模型中的字段；
- 响应模型也会出现在自动生成的 Swagger 文档中（`/docs` 页面）。



:::tip 为什么需要使用响应模型？

响应模型不仅可以提升接口的**可读性**和**文档性**，还能让你在服务端强制控制返回字段，避免泄露内部信息或产生不一致的返回格式。

:::



## 自定义状态码

你可以通过 FastAPI 提供的 `status` 模块设置响应的 HTTP 状态码，常见的如：

- `200 OK`：默认成功状态；
- `201 Created`：资源创建成功；
- `204 No Content`：无返回内容；
- `400 Bad Request`：客户端请求有误；
- `404 Not Found`：资源不存在；
- `500 Internal Server Error`：服务器错误。

**示例：设置 `201 Created`**

```python showLineNumbers
from fastapi import status

@app.post("/items/", response_model=ItemResponse, status_code=status.HTTP_201_CREATED)
def create_item(item: Item):
    return {"name": item.name, "price": item.price, "message": "Item created successfully"}
```

这会使接口在成功时返回 HTTP 状态码 201，而不是默认的 200。



## 返回自定义响应（`Response` 对象）

如果你需要返回更加灵活的内容（如手动设置状态码、内容类型等），可以使用 FastAPI 的 `Response` 类。

例如：

```python showLineNumbers
from fastapi import Response

@app.post("/custom-response/")
def custom_response(item: Item, response: Response):
    response.status_code = 202
    return {"message": "Accepted but not processed yet"}
```

注意：使用 `response.status_code = ...` 是运行时动态修改状态码的一种方式。



## 控制响应字段

你可以使用 `response_model_include` 和 `response_model_exclude` 参数，控制响应模型中包含或排除哪些字段。

例如：

```python showLineNumbers
@app.post("/items/", response_model=ItemResponse, response_model_exclude={"message"})
def create_item(item: Item):
    return {"name": item.name, "price": item.price, "message": "will be excluded"}
```

上面的接口将不会返回 `message` 字段。



## 响应模型嵌套与列表

你也可以返回嵌套模型或列表类型，例如：

```python showLineNumbers
from typing import List

class ItemResponseList(BaseModel):
    items: List[ItemResponse]

@app.get("/items/", response_model=ItemResponseList)
def get_items():
    return {"items": [
        {"name": "Apple", "price": 3.5, "message": "ok"},
        {"name": "Banana", "price": 2.0, "message": "ok"}
    ]}
```



## 小结

FastAPI 的 `response_model` 能帮助你快速构建结构化、可验证的响应体，同时 `status_code` 让你精确控制接口的语义状态。通过这些工具，你的 API 不仅更健壮，而且更符合 RESTful 规范。如果你希望更进一步地自定义响应内容，也可以通过 `Response` 对象进行精细控制。
