---
sidebar_position: 11
sidebar_label: FastAPI 异常处理
slug: /fastapi-exception-handling
authors: [luhuadong]
---

# FastAPI 异常处理与统一错误响应

在 Web 开发中，异常处理是不可或缺的一环。FastAPI 提供了灵活且优雅的异常处理机制，既可以使用内置的 HTTPException 抛出错误，也可以自定义异常类和全局异常处理器来构建统一的错误响应结构。掌握这些特性，可以让你的 API 更加健壮、易于调试，同时也便于前端统一处理错误提示。



## 使用 `HTTPException` 抛出错误

最常见的做法是使用 FastAPI 提供的 `HTTPException`，它允许你直接抛出一个带有状态码、错误信息的响应：

```python showLineNumbers
from fastapi import FastAPI, HTTPException

app = FastAPI()

@app.get("/items/{item_id}")
def read_item(item_id: int):
    if item_id != 42:
        raise HTTPException(status_code=404, detail="Item not found")
    return {"item_id": item_id}
```

**响应示例：**

请求 `/items/1`，返回：

```json showLineNumbers
{
  "detail": "Item not found"
}
```

你也可以添加响应头：

```python showLineNumbers
raise HTTPException(
    status_code=403,
    detail="Forbidden",
    headers={"X-Error": "AccessDenied"},
)
```



## 处理请求验证错误（RequestValidationError）

FastAPI 使用 Pydantic 来自动校验请求参数和请求体。如果校验失败，会自动返回 `422 Unprocessable Entity` 错误。

例如：

```python showLineNumbers
from pydantic import BaseModel

class Item(BaseModel):
    name: str
    price: float

@app.post("/items/")
def create_item(item: Item):
    return item
```

请求体中如果 `price` 为字符串，FastAPI 会自动返回校验错误信息。



## 自定义异常类

你可以定义自己的异常类型，便于分类处理：

```python showLineNumbers
class TokenExpiredException(Exception):
    def __init__(self, token: str):
        self.token = token
```



## 添加全局异常处理器

使用 `@app.exception_handler(...)` 可以定义某个异常类型的统一处理逻辑：

```python showLineNumbers
from fastapi.responses import JSONResponse
from fastapi.requests import Request

@app.exception_handler(TokenExpiredException)
def handle_token_expired(request: Request, exc: TokenExpiredException):
    return JSONResponse(
        status_code=401,
        content={"error": "Token expired", "token": exc.token},
    )
```

使用方式：

```python showLineNumbers
@app.get("/secure/")
def secure(token: str):
    if token != "valid-token":
        raise TokenExpiredException(token)
    return {"message": "Access granted"}
```



## 统一错误响应结构（推荐做法）

在生产环境中，建议你返回统一结构的错误响应，方便前端处理。例如：

```json showLineNumbers
{
  "code": 1001,
  "message": "资源未找到",
  "data": null
}
```

你可以定义一个公共异常响应函数：

```python showLineNumbers
def error_response(code: int, message: str, status_code: int = 400):
    return JSONResponse(
        status_code=status_code,
        content={"code": code, "message": message, "data": None},
    )
```

然后在处理器中使用：

```python showLineNumbers
@app.exception_handler(HTTPException)
def custom_http_exception_handler(request: Request, exc: HTTPException):
    return error_response(code=exc.status_code * 10, message=exc.detail, status_code=exc.status_code)
```

或者用于自定义异常：

```python showLineNumbers
@app.exception_handler(TokenExpiredException)
def handle_expired_token(request: Request, exc: TokenExpiredException):
    return error_response(code=1002, message="登录已过期")
```



## 处理请求验证错误格式（RequestValidationError）

FastAPI 默认返回的校验错误结构较复杂，但你可以自定义格式：

```python showLineNumbers
from fastapi.exceptions import RequestValidationError
from fastapi.exception_handlers import request_validation_exception_handler

@app.exception_handler(RequestValidationError)
async def validation_exception_handler(request: Request, exc: RequestValidationError):
    return error_response(code=1003, message="参数校验失败")
```



## 日志记录建议

你还可以在异常处理器中打印日志，便于调试：

```python showLineNumbers
import logging
logger = logging.getLogger(__name__)

@app.exception_handler(Exception)
async def all_exception_handler(request: Request, exc: Exception):
    logger.exception(f"服务异常: {exc}")
    return error_response(code=9999, message="服务器内部错误", status_code=500)
```



## 小结

FastAPI 提供了强大而灵活的异常处理机制，既能快速抛出常规异常，也支持注册全局异常处理器，实现统一格式响应。建议你在项目中统一所有错误响应格式，并结合日志记录与分类处理，以构建一个用户友好且易维护的 API 服务。
