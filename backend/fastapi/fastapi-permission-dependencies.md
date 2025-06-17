---
sidebar_position: 16
sidebar_label: FastAPI 权限控制
slug: /fastapi-permission-dependencies
---

# FastAPI 使用依赖项实现权限控制

在构建 API 应用时，你不仅需要验证用户身份（认证），还要控制他们是否有权限访问特定资源（授权）。本文将介绍如何利用 FastAPI 的 **依赖项机制（dependency injection）** 实现**权限控制**，例如仅允许管理员访问某些接口等。你将学会自定义权限依赖项并在路由中灵活使用。



## 权限控制简介

**权限控制（Authorization）** 是判断用户是否有权访问某个资源或操作的过程。例如：

- 普通用户只能查看自己的信息；
- 管理员可以查看所有用户信息；
- 某些接口仅限特定角色调用。

FastAPI 没有内置“角色权限系统”，但你可以使用依赖项来灵活实现这些功能。



## 实现思路

- 用户登录后通过 JWT 获取身份信息；
- 在 JWT 的 `payload` 中添加用户角色（如 `admin`、`user`）；
- 创建依赖项函数判断当前用户的权限；
- 将依赖项添加到需要权限控制的路由中。



## 示例代码

假设你已经完成了用户认证和 JWT 登录（见前文教程），我们在此基础上添加权限控制逻辑。

### 1. 用户模拟数据（users.py）

```python showLineNumbers title="users.py"
fake_users_db = {
    "alice": {
        "username": "alice",
        "hashed_password": "$2b$12$...",
        "role": "user"
    },
    "bob": {
        "username": "bob",
        "hashed_password": "$2b$12$...",
        "role": "admin"
    }
}
```



### 2. 修改 token 签发逻辑（auth.py）

```python showLineNumbers title="auth.py"
def create_access_token(data: dict, expires_delta: timedelta | None = None):
    to_encode = data.copy()
    expire = datetime.utcnow() + (expires_delta or timedelta(minutes=30))
    to_encode.update({"exp": expire})
    return jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
```

在登录逻辑中添加用户角色到 payload：

```python showLineNumbers
# 登录接口
@app.post("/token")
def login(form_data: OAuth2PasswordRequestForm = Depends()):
    user = get_user(form_data.username)
    if not user or not verify_password(form_data.password, user["hashed_password"]):
        raise HTTPException(status_code=401, detail="用户名或密码错误")

    access_token = create_access_token(data={
        "sub": user["username"],
        "role": user["role"]
    })
    return {"access_token": access_token, "token_type": "bearer"}
```



### 3. 获取当前用户及权限依赖（dependencies.py）

```python showLineNumbers title="dependencies.py"
from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer
from jose import JWTError, jwt

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

def get_current_user(token: str = Depends(oauth2_scheme)):
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        username: str = payload.get("sub")
        role: str = payload.get("role")
        if username is None or role is None:
            raise HTTPException(status_code=401, detail="无效的 token")
        return {"username": username, "role": role}
    except JWTError:
        raise HTTPException(status_code=401, detail="验证 token 失败")

# 权限依赖：仅允许管理员访问
def require_admin(current_user: dict = Depends(get_current_user)):
    if current_user["role"] != "admin":
        raise HTTPException(status_code=403, detail="权限不足，仅管理员可访问")
    return current_user
```



### 4. 使用依赖项控制接口访问权限（main.py）

```python showLineNumbers title="main.py"
from fastapi import FastAPI, Depends
from dependencies import get_current_user, require_admin

app = FastAPI()

@app.get("/user/profile")
def read_profile(current_user: dict = Depends(get_current_user)):
    return {"message": "欢迎你", "user": current_user}

@app.get("/admin/dashboard")
def admin_dashboard(current_user: dict = Depends(require_admin)):
    return {"message": "欢迎管理员", "user": current_user}
```



## 测试说明

1. 普通用户登录后访问 `/user/profile` 没问题；
2. 但如果尝试访问 `/admin/dashboard`，将收到 403 权限不足错误；
3. 管理员登录后即可访问两个接口。

你可以用 curl 或 Postman 测试：

```bash showLineNumbers
# 登录获取 token
curl -X POST http://localhost:8000/token -d "username=alice&password=xxx" -H "Content-Type: application/x-www-form-urlencoded"

# 访问用户信息
curl -H "Authorization: Bearer <token>" http://localhost:8000/user/profile

# 访问管理员面板
curl -H "Authorization: Bearer <token>" http://localhost:8000/admin/dashboard
```



## 进阶建议

- 可以使用 `Enum` 类型定义角色；
- 将权限控制封装为更通用的函数，例如 `require_role("admin")`；
- 支持多角色（如 editor、viewer）；
- 与数据库配合动态管理权限；
- 引入 [Casbin](https://github.com/casbin) 等权限框架进行细粒度控制。



## 小结

通过依赖项机制，FastAPI 能够非常优雅地实现权限控制。你可以根据当前用户的角色或身份灵活决定是否允许访问接口。相比硬编码判断，依赖注入的方式更具扩展性和复用性，是构建中大型 API 项目的推荐做法。
