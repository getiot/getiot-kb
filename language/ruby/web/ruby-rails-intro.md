---
sidebar_position: 3
sidebar_label: Rails 简介
slug: /ruby-rails-intro
---

# Ruby on Rails 简介

Ruby on Rails，简称 Rails，是 Ruby 最著名的 Web 框架。它强调“约定优于配置”，希望你按照框架约定组织代码，从而减少重复配置和样板代码。

## Rails 提供什么

Rails 是全功能框架，包含：

- 路由系统
- Controller
- View 模板
- Active Record ORM
- 数据库迁移
- 表单和参数处理
- 测试框架
- 任务系统
- 生成器
- 中间件

这意味着 Rails 项目一开始看起来文件很多，但每个目录都有约定用途。

## 约定优于配置

例如：

- `UsersController` 默认对应 `users_controller.rb`。
- `User` model 默认对应 `users` 表。
- controller action 默认寻找对应 view。

你遵守约定时，Rails 可以替你推断很多关系。

## Rails 适合什么

Rails 适合：

- 管理后台
- SaaS 应用
- 内容管理系统
- 电商和订单系统
- RESTful API
- 数据库驱动的业务系统

如果你只是写一个小接口或单页内部工具，Sinatra 可能更轻。

## 学 Rails 前需要哪些 Ruby 基础

你最好已经理解：

- 类和对象
- Module 和 Mixin
- Hash 和 Symbol
- Block
- Bundler
- 基本 HTTP 请求/响应

## 小结

Rails 是完整 Web 框架，不只是路由库。学习 Rails 时，先理解它的约定，再理解它如何把 Web 请求组织到 MVC 中。

