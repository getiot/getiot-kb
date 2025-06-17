---
sidebar_position: 14
sidebar_label: FastAPI 前端交互
slug: /fastapi-with-frontend
authors: [luhuadong]
---

# FastAPI 与前端交互

在这一篇中，你将学习 FastAPI 如何与前端页面交互，包括跨域配置（CORS）、请求响应格式、前端常见调用方式（如 Fetch 和 Axios）、以及返回 HTML 的方法。无论你是用 React、Vue 还是原生 JS，只要你使用 HTTP 请求，FastAPI 都能轻松对接。



## 前端如何调用 FastAPI 接口？

FastAPI 提供标准的 RESTful 接口，你可以通过前端的 `fetch`、`axios`、`XMLHttpRequest` 等方式调用。例如：

```javascript showLineNumbers
// 使用 Fetch 调用 FastAPI POST 接口
fetch("http://localhost:8000/items/", {
  method: "POST",
  headers: {
    "Content-Type": "application/json"
  },
  body: JSON.stringify({
    name: "前端商品",
    price: 12.5
  })
})
.then(response => response.json())
.then(data => console.log(data));
```



## 处理跨域请求（CORS）

不同端口或不同域名间的请求会触发浏览器的“跨域策略”，为了让前端页面能访问 FastAPI 接口，你需要添加 CORS 中间件。

```python showLineNumbers
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

# 允许访问的来源地址（可用 "*" 开放所有，或指定域名）
origins = [
    "http://localhost:3000",  # React/Vue 本地服务
    "http://127.0.0.1:5500",  # 纯 HTML 静态页
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,             # 允许的来源
    allow_credentials=True,
    allow_methods=["*"],               # 允许所有方法
    allow_headers=["*"],               # 允许所有请求头
)
```

⚠️ 注意：`allow_origins=["*"]` 虽然开发中方便，但生产环境建议改为具体域名。除非是公共只读 API（如天气查询），否则应限制特定域名。

:::tip

跨域资源共享（CORS）是浏览器的一项安全机制 —— 当前端页面通过 JavaScript 向不同源的服务端发起请求时，是否被允许，是由服务端说了算。因此：

- **前端不需要也无法“配置 CORS”**，前端只是发出请求，能不能被允许，是浏览器在请求返回后判断响应头来决定的。
- **CORS 是服务端的责任**，也就是说，只需要在 **FastAPI（或其他后端）中配置**，前端就可以愉快访问了。

:::



## 接受前端发送的数据

FastAPI 支持多种数据接收方式：

### 1. JSON 请求体

```python showLineNumbers
from pydantic import BaseModel
from fastapi import FastAPI

app = FastAPI()

class Item(BaseModel):
    name: str
    price: float

@app.post("/items/")
def create_item(item: Item):
    return {"message": "Item created", "item": item}
```

对应前端请求：

```javascript showLineNumbers
fetch("/items/", {
  method: "POST",
  headers: { "Content-Type": "application/json" },
  body: JSON.stringify({ name: "苹果", price: 3.5 })
});
```

### 2. 表单数据（Form）

```python showLineNumbers
from fastapi import Form

@app.post("/login")
def login(username: str = Form(...), password: str = Form(...)):
    return {"username": username}
```

对应 HTML 表单请求：

```html showLineNumbers
<form action="http://localhost:8000/login" method="post">
  <input name="username" />
  <input name="password" type="password" />
  <button type="submit">登录</button>
</form>
```



## 返回前端的数据格式

默认情况下，FastAPI 会返回 JSON 格式数据：

```python showLineNumbers
@app.get("/status")
def status():
    return {"status": "ok", "time": "2025-06-17"}
```

但如果需要，FastAPI 也可以返回 HTML 页面（适用于服务静态网页），例如：

```python showLineNumbers
from fastapi.responses import HTMLResponse

@app.get("/", response_class=HTMLResponse)
def index():
    return """
    <html>
      <body>
        <h1>Hello, Frontend</h1>
      </body>
    </html>
    """
```

或者通过 `Jinja2` 模板返回页面（推荐用于服务 SSR 页面）：

```python showLineNumbers
from fastapi import Request
from fastapi.templating import Jinja2Templates

templates = Jinja2Templates(directory="templates")

@app.get("/hello")
def hello(request: Request):
    return templates.TemplateResponse("hello.html", {"request": request, "name": "FastAPI"})
```

需安装 `jinja2`：

```bash
pip install jinja2
```



## 前后端协作建议

| 前端框架 | 常见请求方式  | 是否需要 CORS |
| :------: | :-----------: | :-----------: |
|   Vue    |     Axios     |      是       |
|  React   | Fetch / Axios |      是       |
| 原生 JS  |     Fetch     |      是       |

📌 提示：

- 接口返回统一结构（如 `{ code, message, data }`）更有利于前后端解耦。
- 推荐将后端接口统一挂载前缀，如 `/api/v1`。
- 可使用 `.env` 管理后端地址，避免前后硬编码。



## 小结

FastAPI 与前端的交互主要通过标准的 HTTP 接口完成，得益于 FastAPI 出色的类型支持和自动文档生成，你可以快速构建与前端配合的高效 API 服务。通过合理配置 CORS、中间件、统一响应格式等措施，你可以让前后端分离开发更顺畅、更专业。下一篇，我们将介绍如何为这些 API 添加认证与权限控制。
