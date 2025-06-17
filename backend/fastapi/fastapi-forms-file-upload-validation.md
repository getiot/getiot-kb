---
sidebar_position: 8
sidebar_label: FastAPI 表单处理
slug: /fastapi-forms-file-upload-validation
authors: [luhuadong]
---

# FastAPI 表单、文件上传与请求验证

astAPI 不仅擅长处理 JSON 请求体，还可以优雅地处理表单提交和文件上传。学习本章内容，你将掌握如何使用 `Form` 和 `File` 类声明表单字段和上传文件，知道如何对这些请求参数进行验证，提升接口的健壮性和安全性。



## 表单参数：使用 `Form`

在传统 HTML 表单中，数据通常以 `application/x-www-form-urlencoded` 格式提交，FastAPI 提供了 `Form` 类来处理这种数据格式。

**示例：接收登录表单数据**

```python showLineNumbers
from fastapi import FastAPI, Form

app = FastAPI()

@app.post("/login/")
def login(username: str = Form(...), password: str = Form(...)):
    return {"username": username}
```

你可以在 Swagger 文档 `/docs` 中使用表单方式进行测试。注意：如果你尝试用 JSON 格式发送数据，将收到错误提示。



## 文件上传：使用 `File` 与 `UploadFile`

FastAPI 支持文件上传，并自动处理文件流。你可以使用 `File(...)` 接收原始二进制数据，或者使用 `UploadFile` 对象，它提供了更丰富的文件操作接口（如 `.filename`, `.file.read()` 等）。

**示例：上传一个文件**

```python showLineNumbers
from fastapi import File, UploadFile

@app.post("/uploadfile/")
async def upload_file(file: UploadFile = File(...)):
    content = await file.read()
    return {
        "filename": file.filename,
        "content_type": file.content_type,
        "size": len(content)
    }
```

你也可以使用同步的方式读取文件，但推荐使用异步 `await file.read()`。



## 同时上传多个文件

使用 `List[UploadFile]` 接收多个文件：

```python showLineNumbers
from typing import List

@app.post("/uploadfiles/")
async def upload_files(files: List[UploadFile] = File(...)):
    return {"filenames": [file.filename for file in files]}
```

Swagger 会自动生成多个文件上传框。



## 表单与文件混合上传

你也可以在同一个接口中同时接收表单字段和文件：

```python showLineNumbers
@app.post("/form-and-file/")
async def upload_form_and_file(
    name: str = Form(...),
    file: UploadFile = File(...)
):
    return {"name": name, "filename": file.filename}
```

这种方式在提交复杂数据（如表单+头像上传）时非常常见。



## 请求验证与错误提示

FastAPI 会自动对 `Form`、`File`、`UploadFile` 声明的参数进行验证：

- 如果字段缺失，返回 `422 Unprocessable Entity`；
- 如果字段类型不匹配，同样会自动提示错误；
- 支持结合 `pydantic` 模型对某些值进行更复杂的校验（如长度、格式等）。

**示例：表单字段长度校验**

```python showLineNumbers
from pydantic import BaseModel, constr
from fastapi import Form, Depends

class LoginForm(BaseModel):
    username: constr(min_length=3)
    password: constr(min_length=6)

def as_form(
    username: str = Form(...),
    password: str = Form(...)
) -> LoginForm:
    return LoginForm(username=username, password=password)

@app.post("/validate-login/")
def validate_login(form_data: LoginForm = Depends(as_form)):
    return form_data
```

通过组合 `Depends` + `Form`，你可以使用 `Pydantic` 校验复杂的表单输入。



## 文件类型限制（自定义验证）

FastAPI 不限制上传文件的格式，但你可以手动检查 `file.content_type` 来拒绝非法文件：

```python showLineNumbers
@app.post("/secure-upload/")
async def secure_upload(file: UploadFile = File(...)):
    if file.content_type not in ["image/png", "image/jpeg"]:
        return {"error": "Only PNG or JPEG files are allowed."}
    return {"filename": file.filename}
```



## 小结

FastAPI 对表单和文件上传提供了开箱即用的支持，配合类型注解和 `Pydantic` 校验机制，可以快速构建安全、强健的上传接口。你可以灵活组合使用 `Form`、`File`、`UploadFile`、`Depends` 等工具，让表单处理和文件管理更加优雅易维护。
