---
sidebar_position: 6
sidebar_label: Active Record 与迁移
slug: /ruby-rails-active-record-migrations
---

# Ruby on Rails Active Record 与数据库迁移

Active Record 是 Rails 的 ORM。ORM 是 Object-Relational Mapping 的缩写，意思是把数据库表和 Ruby 对象关联起来。

## Model 和表

```ruby
class User < ApplicationRecord
end
```

按照 Rails 约定，`User` model 默认对应数据库中的 `users` 表。

## 创建记录

```ruby
User.create(name: "Alice", email: "alice@example.com")
```

这会尝试向 `users` 表插入一条记录。

更严谨的写法是检查是否成功：

```ruby
user = User.new(name: "Alice", email: "alice@example.com")

if user.save
  puts "saved"
else
  puts user.errors.full_messages
end
```

## 查询记录

```ruby
users = User.where(active: true)
user = User.find(1)
```

`find` 找不到记录时会抛出异常。你也可以使用：

```ruby
user = User.find_by(email: "alice@example.com")
```

找不到时返回 `nil`。

## 数据库迁移

迁移用于描述数据库结构变化。示例：

```ruby
class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.boolean :active, default: true
      t.timestamps
    end
  end
end
```

`ActiveRecord::Migration[8.0]` 中的版本号会随 Rails 项目版本变化，你在实际项目里按生成器生成的内容为准。

运行迁移：

```bash
bin/rails db:migrate
```

## 小结

Active Record 让你用 Ruby 对象操作数据库，迁移让数据库结构变化可以被版本管理。初学时要区分“数据记录”和“表结构变化”。

