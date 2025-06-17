---
sidebar_position: 9
sidebar_label: FastAPI 中间件
slug: /fastapi-middleware
authors: [luhuadong]
---

# FastAPI 中间件机制

在 FastAPI 中，中间件（Middleware）是一种非常实用的机制，它允许你在请求进入和响应返回之间插入自定义逻辑。通过中间件，你可以统一处理日志、性能监控、身份验证、错误捕获、响应头设置等跨请求功能。本节将系统介绍中间件的原理、两种写法（函数式和类式）、典型用法及注意事项。



## 什么是中间件？

中间件（Middleware）是介于请求进入应用与响应返回客户端之间的一段可插入逻辑。你可以把它想象成一个“过滤器”或“拦截器”，在每一次请求或响应时都能自动运行。

中间件的典型应用场景包括：

- 请求日志记录
- 性能分析（记录耗时）
- 全局错误处理
- 添加/修改响应头
- 统一身份认证与权限校验
- 实现自定义跨域处理等

FastAPI 支持两种中间件写法：

- 函数式中间件（使用 `@app.middleware("http")` 装饰器）
- 类式中间件（使用 `app.add_middleware()` 注册 Starlette 中间件类）



## 函数式中间件

对于自定义的中间件，FastAPI 支持使用装饰器方式注册。例如，下面示例使用 `@app.middleware("http")` 装饰器注册中间件函数。

```python showLineNumbers
from fastapi import FastAPI, Request
import time

app = FastAPI()

@app.middleware("http")
async def log_request_time(request: Request, call_next):
    start_time = time.time()
    response = await call_next(request)  # 将请求传递给下一个处理器
    duration = time.time() - start_time
    response.headers["X-Process-Time"] = str(duration)
    print(f"{request.method} {request.url.path} - 耗时 {duration:.4f} 秒")
    return response
```

**函数式中间件结构说明：**

```python showLineNumbers
@app.middleware("http")
async def custom_middleware(request: Request, call_next):
    # 在这里处理“请求前”的逻辑，例如记录日志、验证 token 等
    response = await call_next(request)  # 调用下一个处理器（如路由处理函数）
    # 在这里处理“响应后”的逻辑，例如添加响应头、记录耗时等
    return response
```

- `request`：表示当前请求对象，可以从中读取请求方法、路径、头信息等；
- `call_next(request)`：表示将请求传递给下一个处理器（通常是对应的路由函数）；
- `response`：得到的响应对象，可以在返回前修改内容或响应头。

**参数说明：**

- `@app.middleware("http")` 中的 `"http"` 是中间件类型的标识，目前 FastAPI 只支持 `"http"` 类型的中间件。它的意思是：这个中间件将 **应用于所有的 HTTP 请求**，包括 GET、POST、PUT、DELETE 等方法的请求。也就是说，只要有 HTTP 请求进入你的应用，这个中间件就会被触发。

:::tip

FastAPI 基于 [Starlette](https://www.starlette.io/) 构建，而 `"http"` 类型中间件是 Starlette 定义的一种标准，用于处理 HTTP 请求/响应流程。

:::



## 类式中间件

对于标准化或封装好的中间件（如 CORS、GZip 等），FastAPI 支持使用 `add_middleware` 注册类的方式注册中间件。

例如，如果你的前后端分离应用遇到跨域问题，可以添加官方提供的 `CORSMiddleware`。

```python showLineNumbers
from fastapi.middleware.cors import CORSMiddleware

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
```

这种方式的底层实现是 **Starlette 的中间件类**，与函数式中间件功能类似，但写法更适合标准中间件组件。



## 中间件应用场景

### 1. 日志记录

```python showLineNumbers
@app.middleware("http")
async def log_requests(request: Request, call_next):
    print(f"请求路径：{request.url.path}")
    response = await call_next(request)
    return response
```

### 2. 请求耗时统计

```python showLineNumbers
@app.middleware("http")
async def timer(request: Request, call_next):
    start = time.time()
    response = await call_next(request)
    response.headers["X-Time"] = f"{time.time() - start:.2f}s"
    return response
```

### 3. 全局异常捕获（高级用法）

虽然 FastAPI 提供了异常处理机制，但你也可以用中间件统一捕获错误日志：

```python showLineNumbers
@app.middleware("http")
async def catch_errors(request: Request, call_next):
    try:
        return await call_next(request)
    except Exception as e:
        print(f"捕获异常：{e}")
        return JSONResponse(status_code=500, content={"detail": "服务器错误"})
```



## 自定义类中间件

你也可以自己封装类中间件（继承 `BaseHTTPMiddleware`）：

```python showLineNumbers
from starlette.middleware.base import BaseHTTPMiddleware
from starlette.requests import Request
from starlette.responses import Response

class AddHeaderMiddleware(BaseHTTPMiddleware):
    async def dispatch(self, request: Request, call_next):
        response = await call_next(request)
        response.headers["X-Custom-Header"] = "Hello"
        return response

app.add_middleware(AddHeaderMiddleware)
```

:::tip

相对于函数式中间件，类式中间件支持更多高级特性，比如构造函数中传入参数等。

:::



## 中间件执行顺序说明

中间件的执行顺序遵循“洋葱模型”：

1. 注册顺序决定嵌套层级；
2. 请求从外向里传递，响应从里向外传递。

举例：

```python showLineNumbers
@app.middleware("http")
async def outer(request, call_next):
    print("outer: before")
    response = await call_next(request)
    print("outer: after")
    return response

@app.middleware("http")
async def inner(request, call_next):
    print("inner: before")
    response = await call_next(request)
    print("inner: after")
    return response
```

请求顺序为 `outer before` → `inner before` → … → `inner after` → `outer after`。



## 类式中间件 vs 函数式中间件

|   特性   |    函数式中间件    |          类式中间件           |
| :------: | :----------------: | :---------------------------: |
|   写法   |     使用装饰器     |    使用 `add_middleware()`    |
| 适合场景 | 自定义逻辑简单处理 | 引入已有组件（如 CORS、GZip） |
|   性能   |      非常高效      |         稍有额外开销          |
|  灵活性  |         高         |       更标准化、可配置        |



## 小结

中间件是 FastAPI 提供的重要扩展机制，它让你可以在请求与响应之间插入自定义逻辑，实现跨路由功能如日志、鉴权、性能分析等。你可以选择函数式快速定义简单逻辑，也可以使用类式方式集成第三方中间件或封装通用逻辑。掌握中间件的用法，将大大增强你的 Web 应用的灵活性和可维护性。
