---
sidebar_position: 12
sidebar_label: FastAPI 项目结构
slug: /fastapi-project-structure
---

# FastAPI 构建 RESTful API 项目结构

随着项目不断增长，代码也会变得越来越复杂。为了保持清晰、可维护的架构，你需要将 FastAPI 应用拆分成多个模块，而不是将所有路由和逻辑都堆在一个 `main.py` 文件中。本章将带你搭建一个符合 RESTful API 设计风格的 FastAPI 项目结构，介绍如何组织代码、模块划分、依赖注入、模型定义等内容，帮助你为中大型项目打下坚实的基础。



## 为什么需要项目结构设计？

FastAPI 非常灵活，初学时你可以把所有内容放在一个文件中：

```bash
main.py
```

但随着接口越来越多、数据库逻辑增加、业务分层复杂，你会发现维护起来越来越困难。良好的项目结构有助于：

- 代码职责清晰
- 更容易测试和调试
- 方便多人协作开发
- 支持模块复用和拓展



## 推荐的项目结构示意图

```bash
fastapi_project/
├── app/
│   ├── api/                  # 路由模块
│   │   ├── __init__.py
│   │   ├── deps.py           # 通用依赖项
│   │   ├── v1/               # 版本化接口
│   │   │   ├── __init__.py
│   │   │   ├── items.py
│   │   │   └── users.py
│   ├── core/                 # 配置/中间件/初始化逻辑
│   │   ├── __init__.py
│   │   ├── config.py
│   │   └── middleware.py
│   ├── crud/                 # 数据库操作
│   │   ├── __init__.py
│   │   ├── crud_user.py
│   │   └── crud_item.py
│   ├── models/               # Pydantic 模型和 ORM 模型
│   │   ├── __init__.py
│   │   ├── user.py
│   │   └── item.py
│   ├── db/                   # 数据库连接与初始化
│   │   ├── __init__.py
│   │   ├── session.py
│   │   └── base.py
│   ├── services/             # 业务逻辑
│   │   └── user_service.py
│   ├── main.py               # 应用入口
├── tests/                    # 测试模块
│   ├── __init__.py
│   └── test_users.py
├── requirements.txt
└── README.md
```



## 模块示例

### 1. `main.py`

FastAPI 应用的主入口，创建 `FastAPI` 实例、注册中间件和路由。通常运行这个文件来启动开发服务器。

```python showLineNumbers title="main.py"
from fastapi import FastAPI
from app.api.v1 import users, items
from app.core.middleware import register_middleware

app = FastAPI(title="My FastAPI App")

register_middleware(app)

app.include_router(users.router, prefix="/api/v1/users", tags=["Users"])
app.include_router(items.router, prefix="/api/v1/items", tags=["Items"])
```

### 2. `app/api/v1/users.py`

定义用户相关的 API 路由，例如查询用户、注册登录等。每个资源（如 users、items）都应有独立的路由模块。

```python showLineNumbers title="app/api/v1/users.py"
from fastapi import APIRouter, Depends
from app.models.user import User
from app.crud.crud_user import get_user_by_id

router = APIRouter()

@router.get("/{user_id}", response_model=User)
def read_user(user_id: int):
    return get_user_by_id(user_id)
```

### 3. `app/models/user.py`

使用 Pydantic 定义用户数据结构，用于请求体、响应体的数据校验和文档生成。

```python showLineNumbers title="app/models/user.py"
from pydantic import BaseModel

class User(BaseModel):
    id: int
    username: str
    email: str
```

### 4. `app/crud/crud_user.py`

封装数据库的操作逻辑，例如查询用户、更新用户信息等。与业务逻辑解耦，便于维护和测试。

```python showLineNumbers title="app/crud/crud_user.py"
from app.models.user import User

def get_user_by_id(user_id: int) -> User:
    return User(id=user_id, username="alice", email="alice@example.com")
```

### 5. `app/core/config.py`

统一管理项目配置，如数据库连接、调试模式、服务名称等，使用环境变量或默认值，便于不同环境切换。

```python showLineNumbers title="app/core/config.py"
import os

class Settings:
    PROJECT_NAME = "My FastAPI App"
    DATABASE_URL = os.getenv("DATABASE_URL", "sqlite:///./test.db")

settings = Settings()
```

### 6. `app/core/middleware.py`

集中管理自定义中间件，例如请求日志、响应压缩、CORS 配置等，封装为统一注册函数。

```python showLineNumbers title="app/core/middleware.py"
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

def register_middleware(app: FastAPI):
    app.add_middleware(
        CORSMiddleware,
        allow_origins=["*"],
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )
```

### 7. `app/db/session.py`

用于创建数据库连接和 SQLAlchemy 会话对象，便于在依赖项中注入使用。

```python showLineNumbers title="app/db/session.py"
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

SQLALCHEMY_DATABASE_URL = "sqlite:///./test.db"
engine = create_engine(SQLALCHEMY_DATABASE_URL, connect_args={"check_same_thread": False})

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
```



## 版本管理与模块拆分建议

- 按照 `/api/v1/`、`/api/v2/` 组织版本，方便未来升级。
- 按“资源”拆分路由，如 `users.py`、`items.py`、`auth.py`。
- 将核心配置（日志、CORS、中间件）集中放在 `core/`。
- 数据库相关逻辑统一放在 `crud/` 和 `db/` 中，方便更换 ORM。

:::tip

将 API 接口按版本号区分（如 `/v1/`、`/v2/`）是一种**非常常见且推荐的做法**，在实际的生产环境中被广泛采用，目的是：

- **确保向后兼容性**：当你发布新版本时，不会破坏旧客户端的功能。
- **平滑过渡与升级**：允许客户端选择稳定版本，也方便开发者逐步弃用旧版本。
- **更清晰的维护策略**：每个版本可以有单独的生命周期和文档。

例如，OpenAI 的接口是典型的 `/v1/` 风格：

```bash
https://api.openai.com/v1/chat/completions    # 调用对话式语言模型（如 GPT-4）进行聊天回复生成
https://api.openai.com/v1/images/generations  # 调用 DALL·E 模型，根据文本生成图像
```

:::



## 项目初始化建议

你可以使用 `__init__.py` 文件来自动导入模块或封装初始化逻辑。

例如在 `app/api/__init__.py` 中：

```python showLineNumbers
from fastapi import APIRouter
from .v1 import users, items

api_router = APIRouter()
api_router.include_router(users.router, prefix="/users", tags=["Users"])
api_router.include_router(items.router, prefix="/items", tags=["Items"])
```

然后在 `main.py` 中统一引入：

```python showLineNumbers
from app.api import api_router

app.include_router(api_router, prefix="/api/v1")
```



## 如何逐步演进项目结构

初学者可以从 `main.py` + `models.py` + `router.py` 的简单结构开始，随着接口变多逐步引入：

1. 拆分 models / routers / services；
2. 引入数据库 session、CRUD 层；
3. 添加统一异常处理和依赖注入；
4. 最终形成清晰的模块分层。



## 小结

构建合理的项目结构是开发 FastAPI 应用的关键一步，它不仅关系到开发效率，也关系到后期的维护成本。本章提供了一套适用于中大型 RESTful API 项目的推荐结构。你可以根据自己的业务特点灵活调整，但始终建议保持“职责清晰、可复用、易测试”的设计理念。

