---
sidebar_position: 10
sidebar_label: FastAPI 依赖注入
slug: /fastapi-dependency-injection
authors: [luhuadong]
---

# FastAPI 依赖注入

在构建 Web 应用时，你经常需要复用一些逻辑，比如数据库连接、权限校验、配置加载等。FastAPI 提供了强大的 **依赖注入（Dependency Injection）机制**，让你可以以优雅、声明式的方式将这些共享逻辑注入到路由函数中，从而避免重复代码，提高可维护性和可测试性。

本章将介绍 FastAPI 的依赖注入原理、基本用法、作用域控制，以及在实际项目中的常见场景。



## 什么是依赖注入？

依赖注入（Dependency Injection，简称 DI）是一种设计模式，用来将一个组件所依赖的对象，从外部“注入”进来，而不是由它自己创建或管理依赖。好处包括：

- 更少的重复代码；
- 更好的测试能力（可以轻松 mock）；
- 更清晰的职责划分；
- 更好的解耦。

在 FastAPI 中，使用 `Depends` 实现依赖注入。



## 一个最简单的依赖注入示例

```python showLineNumbers
from fastapi import FastAPI, Depends

app = FastAPI()

def common_params(q: str | None = None):
    return {"q": q}

@app.get("/items/")
def read_items(params: dict = Depends(common_params)):
    return params
```

请求 `/items/?q=hello` 时，输出：

```python showLineNumbers
{"q": "hello"}
```

**说明：**

- `common_params` 是一个依赖函数；
- 使用 `Depends(common_params)` 表示将返回值注入到 `read_items` 中；
- 你可以在多个路由中复用 `common_params`，达到代码复用的目的。



## 依赖可以嵌套

依赖也可以嵌套其他依赖，就像积木一样组合：

```python showLineNumbers
def auth_header(token: str = ""):
    return {"token": token}

def get_user(auth=Depends(auth_header)):
    token = auth["token"]
    if token != "secret":
        raise HTTPException(status_code=401, detail="Unauthorized")
    return {"username": "admin"}
```

然后在路由中注入：

```python showLineNumbers
@app.get("/profile/")
def get_profile(user=Depends(get_user)):
    return {"user": user}
```



## 类作为依赖（依赖对象）

你也可以将类实例注入路由：

```python showLineNumbers
class Pagination:
    def __init__(self, page: int = 1, limit: int = 10):
        self.page = page
        self.limit = limit

@app.get("/products/")
def get_products(p: Pagination = Depends()):
    return {"page": p.page, "limit": p.limit}
```

FastAPI 会自动将请求参数映射到构造函数中，并实例化类。



## 带清理逻辑的依赖（生成器依赖）

如果你需要执行“进入”和“退出”操作（比如数据库连接的打开和关闭），可以使用 **Python 的生成器语法**：

```python showLineNumbers
from fastapi import Request
from contextlib import asynccontextmanager

@asynccontextmanager
async def db_connection():
    db = {"conn": "fake-db-connection"}
    yield db
    # 清理资源，比如关闭连接
    print("数据库连接已关闭")

@app.get("/data/")
async def read_data(db=Depends(db_connection)):
    return {"conn": db["conn"]}
```

FastAPI 会在请求结束后自动执行 `yield` 之后的清理逻辑。



## 依赖作用域（scope）

默认情况下，依赖函数在每个请求中都会重新执行一次。但你可以为生成器依赖设置作用域：

```python showLineNumbers
@asynccontextmanager
async def get_cache():
    cache = {"conn": "redis"}
    yield cache

app.dependency_overrides[get_cache] = get_cache

# 指定作用域为应用生命周期
app.dependency_overrides[get_cache].__fastapi_scope__ = "app"
```

FastAPI 支持以下作用域：

| 作用域               | 描述                         |
| -------------------- | ---------------------------- |
| `"function"`（默认） | 每个请求调用一次             |
| `"app"`              | 在应用启动时创建，只执行一次 |



## 可选依赖

你可以让某些依赖是“可选的”：

```python showLineNumbers
from typing import Annotated
from fastapi import Depends

def get_token(token: str | None = None):
    return token

@app.get("/public/")
def read(token: Annotated[str | None, Depends(get_token)] = None):
    return {"token": token}
```



## 依赖重写（测试用）

FastAPI 提供了 `.dependency_overrides` 机制，可以在测试时替换依赖：

```python showLineNumbers
def fake_get_user():
    return {"username": "test"}

app.dependency_overrides[get_user] = fake_get_user
```

这样你就可以在测试中完全 mock 掉原来的权限逻辑。



## 小结

FastAPI 的依赖注入机制非常强大，是构建高质量 Python Web 应用的核心工具之一。它不仅提高了代码复用能力，还让逻辑解耦变得简单优雅。在项目中，你可以将认证、数据库、配置、分页、日志等逻辑封装为依赖，轻松插拔、统一管理。如果你掌握了 Python 的函数和类型注解，那上手 FastAPI 的依赖注入将会非常自然。
