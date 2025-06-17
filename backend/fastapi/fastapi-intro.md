---
sidebar_position: 1
sidebar_label: FastAPI 框架简介
slug: /fastapi-intro
---

# FastAPI 框架简介

本文将带你认识 **FastAPI** —— 一个现代、高性能、易于上手的 Python Web 框架。你将了解它的背景、核心优势、适用场景，以及为什么它在近年来迅速受到开发者喜爱。如果你对 Flask 有所了解，甚至可以立刻上手；如果你是 Web 开发新手，也可以轻松入门。



## 什么是 FastAPI？

**FastAPI** 是一个现代的、基于 Python 3.7+ 的 Web 框架，用于构建 API 服务。它使用 Python 的类型提示（type hints）作为核心特性，并基于 [Starlette](https://www.starlette.io) 和 [Pydantic](https://docs.pydantic.dev) 构建，既兼具高性能，又拥有优秀的开发体验。

这个框架的目标是让你：

- 💡 编写更少的代码，做更多的事
- 📜 获得自动生成的 API 文档
- 🚀 保持高性能（媲美 Node.js、Go）
- 🛡️ 拥有类型安全的开发体验

FastAPI 被广泛用于构建 RESTful API、微服务架构，甚至可以作为完整的后端框架来使用。



## FastAPI 项目起源

FastAPI 的作者是一位哥伦比亚软件工程师 **[Sebastián Ramírez](https://github.com/tiangolo)**。他创建 FastAPI 的初衷，是为了构建一个同时拥有 **现代开发体验** 和 **高性能运行能力** 的 Python Web 框架，尤其适合构建 API 服务。

![FastAPI 作者 Sebastián Ramírez](https://static.getiot.tech/fastapi-author-tiangolo.jpeg#center-300)

在创建 FastAPI 之前，Sebastián 经常使用 Flask 和 Django，但他希望有一个框架可以：

- 自动生成交互式文档；
- 利用类型注解提高代码可维护性；
- 支持异步编程；
- 避免重复的手动验证逻辑。

于是，FastAPI 项目在 2018 年正式开源（采用 MIT 许可证，允许在商业项目中免费使用），并迅速在 Python 社区获得极高关注。得益于其强大功能和优秀设计，FastAPI 不仅获得了 GitHub 上数万颗 Star，还被多家公司（如 Netflix、Uber、Microsoft、Zulip 等）投入生产环境使用。



## FastAPI 主要特性

FastAPI 的核心特性包括：

- **高性能**：得益于 Starlette 和 Pydantic 的加持，FastAPI 拥有非常高的性能，接近 Node.js 和 Go，是现今最快的 Python Web 框架之一。
- **开发效率高**：大幅提升开发速度，功能开发效率可提高约 200%～300%（*基于作者团队在实际生产项目中的测试估算*）。
- **更少的 Bug**：通过类型检查和自动校验，能减少约 40% 的人为（开发者）错误（*同样基于实际开发测试估算*）。
- **直观易用**：出色的编辑器支持，全方位的代码补全，大幅降低调试时间。
- **上手简单**：设计上易于学习和使用，减少查阅文档的时间。
- **代码简洁**：减少重复代码。参数定义不仅决定输入格式，还自动生成校验逻辑和文档，降低出错概率。
- **稳定可靠**：快速产出可用于生产环境的代码，并自动生成交互式 API 文档。
- **标准化设计**：基于并完全兼容业界标准，如 OpenAPI（前身为 Swagger）和 JSON Schema。
- **支持多种认证机制**：FastAPI 支持多种认证授权方式，内置安全模块让你可以快速集成 OAuth2、JWT 等常见的安全机制。



## 自动生成交互式文档

FastAPI 自动根据类型注解生成 Swagger UI 和 ReDoc API 文档，无需额外配置。你只需定义数据模型，文档就自动准备好了，非常适合前后端协作开发。例如：

```python showLineNumbers
from fastapi import FastAPI

app = FastAPI()

@app.get("/hello")
def say_hello():
    return {"message": "Hello, FastAPI!"}
```

访问 `http://127.0.0.1:8000/docs`，即可看到交互式 Swagger 文档。



## FastAPI 与其他框架的对比

|  框架   |    类型系统    |          文档生成          |  性能  | 学习曲线 |
| :-----: | :------------: | :------------------------: | :----: | :------: |
|  Flask  |  ❌ 无类型支持  |        ❌ 无自动文档        |  一般  |   简单   |
| Django  | ✅（但不完整）  | ✅（Django REST Framework） |  一般  |   中等   |
| FastAPI | ✅ 完整类型系统 |         ✅ 自动文档         | 非常快 | 容易上手 |

如果你来自 Flask，FastAPI 的设计会让你感到熟悉，但同时它引入了现代开发的新方式，比如异步支持、类型注解、自动文档等。



## FastAPI 的适用场景

FastAPI 非常适合用于构建：

- RESTful API 接口
- 微服务系统（配合 Docker / Kubernetes）
- AI / ML 服务接口（如模型预测 API）
- 高并发的异步后台任务
- 快速开发原型项目

许多大型项目（如 Uber、Netflix 内部项目、Microsoft 等）都在使用 FastAPI，社区活跃，生态逐渐成熟。



## 相关链接

- [FastAPI 项目官网（文档）](https://fastapi.tiangolo.com)
- [FastAPI 代码仓库（GitHub）](https://github.com/fastapi/fastapi)



## 小结

FastAPI 是一个现代化、高性能、易于学习的 Python Web 框架，非常适合构建 API 服务。它结合了类型注解、自动文档、异步支持等现代开发优势，既适合初学者快速上手，也满足资深开发者构建可扩展系统的需求。在后续章节中，你将逐步掌握 FastAPI 的核心能力，从简单的接口开发到完整的后端项目构建。
