---
sidebar_position: 4
sidebar_label: Rails MVC
slug: /ruby-rails-mvc
---

# Ruby on Rails MVC

Rails 使用 MVC 架构组织 Web 应用。MVC 是 Model、View、Controller 的缩写。

你可以先这样理解：

- Model 管数据和业务规则。
- Controller 管请求流程。
- View 管页面展示。

## 一个请求的流动

```text
浏览器请求 /users
        ↓
Router 找到 UsersController#index
        ↓
Controller 查询 User model
        ↓
View 渲染 HTML
        ↓
浏览器收到响应
```

## Model

Model 负责业务数据和规则。Rails 中常用 Active Record 把数据库表映射成 Ruby 对象。

```ruby
class User < ApplicationRecord
end
```

你可以写：

```ruby
User.where(active: true)
User.find(1)
```

## Controller

Controller 接收请求，准备数据，决定返回什么。

```ruby
class UsersController < ApplicationController
  def index
    @users = User.all
  end
end
```

这里 `@users` 是实例变量，View 可以读取。

## View

View 负责展示 HTML。

```erb title="app/views/users/index.html.erb"
<% @users.each do |user| %>
  <p><%= user.name %></p>
<% end %>
```

ERB 中：

- `<% ... %>` 执行 Ruby 代码，不输出。
- `<%= ... %>` 执行 Ruby 代码，并把结果输出到页面。

## 常见错误

把太多业务逻辑写进 Controller：

```ruby
def index
  # 一大堆统计、计算、权限、格式转换
end
```

更好的做法是把复杂逻辑放进 Model、service object 或专门对象。

把查询逻辑写进 View：View 应该展示数据，不应该负责复杂数据查询。

## 小结

MVC 的目标是分工。Model 管数据，Controller 管流程，View 管展示。Rails 代码清不清楚，很大程度取决于你是否尊重这个分工。

