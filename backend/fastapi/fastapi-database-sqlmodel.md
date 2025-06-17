---
sidebar_position: 13
sidebar_label: FastAPI 数据库连接
slug: /fastapi-database-sqlmodel
---

# FastAPI 连接数据库：SQLModel 快速入门

在本篇教程中，你将学习如何在 FastAPI 项目中使用 SQLModel 连接和操作数据库。SQLModel 是由 FastAPI 作者创建的一个 ORM 工具，它结合了 SQLAlchemy 和 Pydantic 的优势，使用体验更简洁、直观，适合初学者快速上手。

本文将介绍 SQLModel 的安装、模型定义、数据库初始化、基本的增删改查操作，以及如何与 FastAPI 路由集成。



## SQLModel 简介

SQLModel 是一个基于 SQLAlchemy 和 Pydantic 构建的 ORM 库，具有以下特点：

- 类型安全：完全基于 Python 类型提示，开发体验优秀。
- 与 FastAPI 深度集成：可以直接用于请求体和响应模型。
- 兼容 SQLAlchemy：底层基于 SQLAlchemy，功能强大。
- 自动生成表结构：支持自动建表。
- 简洁易学：API 设计简单直观，非常适合初学者。



## 安装依赖

你可以使用 `pip` 安装 SQLModel 及 SQLite 驱动：

```bash
pip install sqlmodel
```

如果你计划使用 PostgreSQL 或 MySQL，可额外安装相应的驱动，如：

```bash
pip install psycopg2-binary
# 或
pip install pymysql
```



## 定义数据模型

新建文件 `models.py`，并定义一个简单的数据模型：

```python showLineNumbers title="models.py"
from sqlmodel import SQLModel, Field
from typing import Optional

class Item(SQLModel, table=True):
    id: Optional[int] = Field(default=None, primary_key=True)
    name: str
    description: Optional[str] = None
    price: float
    in_stock: bool = True
```

说明：

- `table=True` 表示该模型将被映射为数据库中的表。
- `id` 字段设置为 `primary_key=True`，并使用 `Optional[int]` 允许其为空（用于自动递增主键）。



## 创建数据库连接和会话

你可以新建 `database.py` 来管理数据库连接：

```python showLineNumbers title="database.py"
from sqlmodel import create_engine, Session, SQLModel

DATABASE_URL = "sqlite:///./test.db"
engine = create_engine(DATABASE_URL, echo=True)

def init_db():
    SQLModel.metadata.create_all(engine)

def get_session():
    with Session(engine) as session:
        yield session
```

- `echo=True` 会在终端输出 SQL 日志，方便调试。
- `init_db()` 会根据模型创建数据库表。



## 初始化数据库

在 `main.py` 文件中引入并调用初始化函数：

```python showLineNumbers title="main.py"
from fastapi import FastAPI
from database import init_db

app = FastAPI()

@app.on_event("startup")
def on_startup():
    init_db()
```

这样，FastAPI 应用启动时会自动建表。



## 创建和查询数据接口

你可以编写一个简单的增查接口（例如放在 `routes/items.py`）：

```python showLineNumbers title="routes/items.py"
from fastapi import APIRouter, Depends
from sqlmodel import Session, select
from models import Item
from database import get_session

router = APIRouter()

@router.post("/items/", response_model=Item)
def create_item(item: Item, session: Session = Depends(get_session)):
    session.add(item)
    session.commit()
    session.refresh(item)
    return item

@router.get("/items/", response_model=list[Item])
def read_items(session: Session = Depends(get_session)):
    statement = select(Item)
    results = session.exec(statement).all()
    return results
```

然后在 `main.py` 中引入路由：

```python showLineNumbers title="main.py"
from routes import items
app.include_router(items.router)
```



## 使用测试请求

你可以使用 FastAPI 自动生成的文档界面（`http://127.0.0.1:8000/docs`）来测试 POST 和 GET 接口。

POST 示例：

```json showLineNumbers
{
  "name": "测试商品",
  "description": "这是一个示例",
  "price": 99.9,
  "in_stock": true
}
```



## 支持关系字段

SQLModel 也支持外键和关系模型，但需要使用 SQLAlchemy 风格的关系字段，这里暂时不展开讨论。



## 小结

本节你学习了如何使用 SQLModel 快速将 FastAPI 项目连接到数据库。通过定义模型、初始化数据库、创建会话以及集成 API 路由，你可以快速构建出具备数据库交互能力的 Web 应用。SQLModel 是学习 ORM 的绝佳起点，未来也可以无缝过渡到更复杂的 SQLAlchemy 模式。
