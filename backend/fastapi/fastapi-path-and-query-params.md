---
sidebar_position: 5
sidebar_label: FastAPI 路径参数
slug: /fastapi-path-and-query-params
authors: [luhuadong]
---

# FastAPI 路径参数与查询参数

本章将带你深入理解 FastAPI 中的两种常见参数：**路径参数** 和 **查询参数**。你将学会如何声明参数、指定类型、添加默认值以及自动文档生成，帮助你构建灵活、可控的 API 接口。



## 什么是路径参数？

路径参数（Path Parameter）是 URL 路径中的一部分，用来表示某个资源的标识。通常用于获取某个特定实体的信息，例如用户 ID、文章 ID 等。

**示例：**

```python showLineNumbers
from fastapi import FastAPI

app = FastAPI()

@app.get("/users/{user_id}")
def get_user(user_id: int):
    return {"user_id": user_id}
```

访问 `http://127.0.0.1:8000/users/100` 将返回：

```json showLineNumbers
{
  "user_id": 100
}
```

- `{user_id}` 是路径参数，FastAPI 会自动将 URL 中的部分提取出来并传给函数。
- `user_id: int` 指定了类型为整数，如果传入字符串等类型不匹配的值，FastAPI 会自动返回 422 错误，表示请求验证失败。



## 路径参数类型转换

FastAPI 会根据类型提示自动完成转换与验证，支持的类型包括：

|  类型   | 示例                      |
| :-----: | ------------------------- |
|  `int`  | `/items/123`              |
| `float` | `/price/12.5`             |
|  `str`  | `/search/keyword`         |
| `bool`  | `/flag/true` 或 `/flag/0` |

如果传入参数与类型不匹配，FastAPI 会自动返回验证失败的响应，无需你手动处理。



## 路径参数中的路径顺序

路径参数中的路径顺序很重要，你不能在两个路径参数不明确区分的情况下定义多个路径。例如：

```python showLineNumbers
@app.get("/files/{file_path}")
def read_file(file_path: str):
    return {"file_path": file_path}

@app.get("/files/static")
def static_file():
    return {"message": "Static file"}
```

访问 `/files/static` 时会优先匹配 `/files/{file_path}`，因为它更早被声明。因此建议将更“具体”的路径放在前面，或使用 `Path(..., regex=...)` 来更精确地控制。



## 什么是查询参数？

查询参数（Query Parameter）是 URL 中以 `?` 开头，`key=value` 形式出现的部分，常用于过滤、排序、分页等可选参数。

**示例：**

```python showLineNumbers
@app.get("/items/")
def list_items(category: str = "all", limit: int = 10):
    return {"category": category, "limit": limit}
```

访问 `http://127.0.0.1:8000/items/?category=fruit&limit=5` 将返回：

```json showLineNumbers
{
  "category": "fruit",
  "limit": 5
}
```

**查询参数特点：**

- **无需写在路径中**，而是通过 URL `?key=value` 的方式传递；
- 可以有默认值，也可以声明为必填项（使用 `= Query(...)`）；
- 不存在参数时会使用默认值。



## 路径参数与查询参数组合使用

你可以同时使用路径参数和查询参数，例如：

```python showLineNumbers
@app.get("/users/{user_id}/orders")
def get_orders(user_id: int, limit: int = 5):
    return {"user_id": user_id, "limit": limit}
```

访问 `http://127.0.0.1:8000/users/42/orders?limit=10`，你将得到：

```json showLineNumbers
{
  "user_id": 42,
  "limit": 10
}
```



## 路径参数的高级用法

FastAPI 支持你通过 `path` 类型获取包含 `/` 的路径内容：

```python showLineNumbers
from fastapi import Path

@app.get("/files/{file_path:path}")
def read_file(file_path: str = Path(...)):
    return {"file_path": file_path}
```

访问 `/files/docs/intro.md` 会返回：

```json showLineNumbers
{
  "file_path": "docs/intro.md"
}
```

`:path` 表示该参数可以包含斜杠 `/`，适合表示文件路径、嵌套资源等场景。



## FastAPI 自动文档中的体现

FastAPI 会将你声明的所有参数自动列入 API 文档中，且根据类型推导展示输入框：

- `http://127.0.0.1:8000/docs`（Swagger UI）
- `http://127.0.0.1:8000/redoc`（ReDoc）

通过文档界面，你可以清晰地看到路径参数、查询参数，以及默认值和数据类型。



## 完整示例

```python showLineNumbers
from fastapi import FastAPI, Path

app = FastAPI()

@app.get("/users/{user_id}")
def read_user(user_id: int = Path(..., description="用户的唯一 ID")):
    return {"user_id": user_id}

@app.get("/search/")
def search_items(keyword: str = "", page: int = 1, size: int = 10):
    return {"keyword": keyword, "page": page, "size": size}

@app.get("/files/{file_path:path}")
def read_file(file_path: str):
    return {"file_path": file_path}
```



## 小结

本章你学习了 FastAPI 中两类非常基础也非常重要的参数类型：**路径参数** 与 **查询参数**。它们帮助你构建灵活、类型安全的 API 接口。在实际开发中，你会频繁使用它们处理用户请求、实现分页、搜索、分类等功能。
