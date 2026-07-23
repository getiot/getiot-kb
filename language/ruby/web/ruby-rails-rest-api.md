---
sidebar_position: 7
sidebar_label: Rails RESTful API
slug: /ruby-rails-rest-api
---

# Ruby on Rails RESTful API

Rails 很适合编写 RESTful API。RESTful API 通常把业务对象看作资源，用 HTTP 方法表达操作。

## 资源和路由

```ruby title="config/routes.rb"
resources :users
```

这会生成常见资源路由：

- `GET /users`：获取用户列表
- `GET /users/:id`：获取单个用户
- `POST /users`：创建用户
- `PATCH /users/:id`：更新用户
- `DELETE /users/:id`：删除用户

## 返回 JSON

```ruby
class UsersController < ApplicationController
  def index
    render json: User.all
  end
end
```

## 状态码

成功创建资源：

```ruby
render json: user, status: :created
```

资源不存在：

```ruby
render json: { error: "not found" }, status: :not_found
```

参数不合法：

```ruby
render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
```

## strong parameters

Rails 通常使用 strong parameters 限制允许传入的字段：

```ruby
def user_params
  params.require(:user).permit(:name, :email)
end
```

不要把客户端传来的所有参数都直接用于创建或更新记录。

## API 设计建议

- URL 表达资源，不表达动作。
- HTTP 方法表达动作。
- 使用合适状态码。
- 错误响应格式保持一致。
- 不在响应中泄漏敏感字段。

## 小结

Rails API 的核心是资源、路由、控制器、JSON 和状态码。设计 API 时，你要明确资源是什么、操作是什么、失败时如何表达。

