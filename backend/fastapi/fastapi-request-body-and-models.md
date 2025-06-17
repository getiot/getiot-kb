---
sidebar_position: 6
sidebar_label: FastAPI 请求体和数据模型
slug: /fastapi-request-body-and-models
authors: [luhuadong]
---

# FastAPI 请求体和数据模型

本章将带你掌握 FastAPI 中如何处理 **请求体**（Request Body），以及如何使用 **Pydantic 模型** 来定义、验证和自动文档化请求数据。你将学会接收 JSON 格式的对象数据，并构建强类型、安全的 API 接口。



## 什么是请求体？

在 HTTP 协议中，**请求体**是指通过 POST、PUT、PATCH 等方法发送的数据内容，通常是以 JSON、Form 表单或其他格式传输。

在 FastAPI 中，你可以通过定义函数参数为一个 **Pydantic 模型**，来接收请求体中的 JSON 数据。



## 使用 Pydantic 模型接收请求体

FastAPI 与 Pydantic 深度集成，推荐使用它来定义数据结构、自动校验类型。

**示例：**

```python showLineNumbers
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class Item(BaseModel):
    name: str
    description: str | None = None
    price: float
    in_stock: bool = True

@app.post("/items/")
def create_item(item: Item):
    return {"message": "Item received", "item": item}
```

请求示例：

```json showLineNumbers
{
  "name": "Apple",
  "description": "Fresh red apple",
  "price": 3.5,
  "in_stock": true
}
```

发出 POST 请求：

```bash showLineNumbers
curl -X POST "http://127.0.0.1:8000/items/" \
-H "Content-Type: application/json" \
-d '{"name": "Apple", "description": "Fresh red apple", "price": 3.5, "in_stock": true}'
```

**说明：**

- `Item` 是一个继承自 `BaseModel` 的类，表示请求数据的结构。
- FastAPI 会自动解析请求体为 `Item` 实例，并做类型校验。
- 如果缺少必须字段，或者字段类型不匹配，会自动返回 `422 Unprocessable Entity` 错误。



## 请求体参数的类型说明

在 FastAPI 中，**请求体参数** 是通过 `Pydantic` 模型定义的，而 `Pydantic` 使用 Python 的类型注解来自动完成类型验证和转换。下面我们来详细了解每种常用类型及其用途。

### 基本类型

|  类型   | 描述                                 | 示例输入值                |
| :-----: | ------------------------------------ | ------------------------- |
|  `str`  | 字符串类型                           | `"apple"`                 |
|  `int`  | 整数类型                             | `100`                     |
| `float` | 浮点数类型                           | `3.14`                    |
| `bool`  | 布尔值类型，支持 `true/false`、`1/0` | `true`、`false`、`1`、`0` |

这些是最常用的基本类型，适用于大多数表单或 JSON 接口的数据字段。

```python showLineNumbers
from pydantic import BaseModel

class Item(BaseModel):
    name: str
    price: float
    count: int
    available: bool
```

### 可选类型

有时候你希望某个字段是可选的（Optional），可以使用 Python 3.10+ 的联合类型语法 `str | None`，或旧版本的 `Optional[str]`。

```python showLineNumbers
from typing import Optional

class Item(BaseModel):
    description: Optional[str] = None
```

等价于：

```python showLineNumbers
class Item(BaseModel):
    description: str | None = None  # Python 3.10+
```

如果你不给 `description` 赋值，请求体中也不包含该字段，也不会触发验证错误。

### 默认值

你可以为字段设置默认值，如果请求中不传该字段，就使用默认值。

```python showLineNumbers
class Item(BaseModel):
    in_stock: bool = True
```

这在设置布尔开关、分页参数等场景中非常常见。

### 复合类型

Python 中的复合类型也可以作为 FastAPI 请求体的参数类型，包括枚举（`Enum`）、列表（`List`）、集合（`Set`）、字典（`Dict`）、联合（`Unit`）、`Any`，以及时间类型（自动解析 ISO 8601 格式字符串）等。

**示例1**：如果某个字段只允许几个固定值，可以使用枚举。

```python showLineNumbers
from enum import Enum

class Color(str, Enum):
    red = "red"
    green = "green"
    blue = "blue"

class Item(BaseModel):
    color: Color
```

请求体中：

```json showLineNumbers
{ "color": "green" }
```

如果传入非枚举值（如 `"yellow"`），将返回验证错误。

**示例2**：使用 `Dict[str, int]` 表示键值对的结构。

```python showLineNumbers
from typing import Dict

class Inventory(BaseModel):
    stock: Dict[str, int]
```

请求体：

```json showLineNumbers
{
  "stock": {
    "apple": 100,
    "banana": 80
  }
}
```



## 嵌套模型

你可以在模型中嵌套另一个模型，用于表达更复杂的数据结构。例如：

```python showLineNumbers
from typing import List

class User(BaseModel):
    username: str
    email: str

class Order(BaseModel):
    order_id: int
    items: List[str]
    buyer: User

@app.post("/orders/")
def create_order(order: Order):
    return {"order": order}
```

请求体：

```json showLineNumbers
{
  "order_id": 1001,
  "items": ["apple", "banana"],
  "buyer": {
    "username": "alice",
    "email": "alice@example.com"
  }
}
```

FastAPI 会自动递归校验嵌套字段，保证数据完整性。



## 请求体参数与路径/查询参数

你可以将请求体与路径参数、查询参数一起使用：

```python showLineNumbers
@app.put("/items/{item_id}")
def update_item(item_id: int, item: Item, notify: bool = False):
    return {"item_id": item_id, "item": item, "notify": notify}
```

访问：

```bash
PUT /items/1?notify=true
```

请求体：

```json showLineNumbers
{
  "name": "Apple",
  "description": "Updated",
  "price": 3.8,
  "in_stock": true
}
```

FastAPI 会将：

- `item_id` 当作路径参数；
- `notify` 解析为查询参数；
- `item` 从请求体中解析 JSON 数据。



## Pydantic 校验机制

Pydantic 会对所有字段进行严格校验，包括类型、格式、范围等。如果验证失败，FastAPI 会返回详细的错误响应，例如：

```json showLineNumbers
{
  "detail": [
    {
      "loc": ["body", "item", "price"],
      "msg": "value is not a valid float",
      "type": "type_error.float"
    }
  ]
}
```



## 模型中的文档描述

你可以使用 `pydantic.Field()` 提供字段描述信息、默认值、约束等，优化自动生成的文档：

```python showLineNumbers
from pydantic import BaseModel, Field

class Item(BaseModel):
    name: str = Field(..., title="商品名称", max_length=50)
    description: str | None = Field(None, title="商品描述", max_length=300)
    price: float = Field(..., gt=0, description="必须大于 0")
    in_stock: bool = Field(default=True, description="是否有库存")
```

这样，自动生成的 Swagger 文档就会更加清晰易用。



## 自动文档示例效果

当你访问 `http://127.0.0.1:8000/redoc`，你会看到：

- 每个字段的类型和说明；
- 表单自动生成示例 JSON；
- 输入错误时的提示非常清晰；
- 非常适合团队协作与调试 API。

![FastAPI 自动文档示例效果（ReDoc）](https://static.getiot.tech/fastapi-redoc-example.webp#center)



## 完整示例

```python showLineNumbers
from fastapi import FastAPI
from pydantic import BaseModel, Field

app = FastAPI()

class Item(BaseModel):
    name: str = Field(..., title="商品名称", max_length=50)
    price: float = Field(..., gt=0, description="价格必须大于 0")
    in_stock: bool = True

@app.post("/items/")
def create_item(item: Item):
    return {"item": item}
```

请求示例：

```json showLineNumbers
{
  "name": "Banana",
  "price": 2.5,
  "in_stock": true
}
```



## 小结

在本章中，你学习了如何使用 Pydantic 定义请求体的数据模型，并了解了如何接收、校验复杂 JSON 数据结构。Pydantic 与 FastAPI 的深度集成，使得你无需手动解析请求体，也不需要手动编写校验逻辑，就能获得强类型、自动文档、安全高效的 API 接口。下一章将继续介绍请求参数的高级验证方式（如 Query、Path、Body 的详细用法），进一步提升你的 FastAPI 编程能力。
