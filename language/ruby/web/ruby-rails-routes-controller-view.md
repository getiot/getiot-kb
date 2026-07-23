---
sidebar_position: 5
sidebar_label: Rails 路由、控制器与视图
slug: /ruby-rails-routes-controller-view
---

# Ruby on Rails 路由、控制器与视图

Rails 请求通常先进入路由，再到控制器，最后渲染视图或返回数据。这一节把这条路径走一遍。

## 路由

路由写在 `config/routes.rb`：

```ruby title="config/routes.rb"
Rails.application.routes.draw do
  get "/hello", to: "pages#hello"
end
```

这表示：当用户访问 `/hello` 时，调用 `PagesController` 的 `hello` action。

## 控制器

```ruby title="app/controllers/pages_controller.rb"
class PagesController < ApplicationController
  def hello
    @message = "Hello Rails"
  end
end
```

action 是控制器中的普通方法。这里的 `@message` 会交给视图使用。

## 视图

```erb title="app/views/pages/hello.html.erb"
<h1><%= @message %></h1>
```

Rails 默认会根据 controller 和 action 名称寻找视图模板。

## RESTful 路由

```ruby title="config/routes.rb"
resources :users
```

这会生成一组常见路由：

- `GET /users`：列表
- `GET /users/:id`：详情
- `POST /users`：创建
- `PATCH /users/:id`：更新
- `DELETE /users/:id`：删除

## 查看路由

Rails 项目中可以查看路由：

```bash
bin/rails routes
```

如果使用 Bundler 环境，也可能使用：

```bash
bundle exec rails routes
```

## 小结

Rails 请求路径可以这样记：Route 找到 Controller，Controller 准备数据，View 负责显示。理解这条路径后，Rails 就不再像黑盒。

