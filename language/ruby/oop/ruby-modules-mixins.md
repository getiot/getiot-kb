---
sidebar_position: 6
sidebar_label: Module 与 Mixin
slug: /ruby-modules-mixins
---

# Ruby 模块 Module 与 Mixin

Module 是 Ruby 中非常重要的结构。它可以用来组织命名空间，也可以通过 Mixin 把一组方法混入类中。

## Module 作为命名空间

```ruby
module MyApp
  class User
  end
end

user = MyApp::User.new
```

命名空间可以避免类名冲突。例如不同项目里都可能有 `User`，放进 `MyApp` 后就变成 `MyApp::User`。

## include：混入实例方法

```ruby
module Loggable
  def log(message)
    puts "[LOG] #{message}"
  end
end

class Worker
  include Loggable

  def run
    log("started")
  end
end

Worker.new.run
```

`include` 会把模块中的方法作为实例方法加入类。

## extend：给对象增加方法

```ruby
module Loggable
  def log(message)
    puts "[LOG] #{message}"
  end
end

class Worker
  extend Loggable
end

Worker.log("class level")
```

在类上使用 `extend` 时，模块方法会变成类方法。

## Mixin 表达能力

继承表达“是什么”，Mixin 表达“具备什么能力”。

例如：

```ruby
module JsonSerializable
  def to_json
    require "json"
    instance_variables.to_h do |name|
      [name.to_s.delete_prefix("@"), instance_variable_get(name)]
    end.to_json
  end
end
```

任何类只要 `include JsonSerializable`，就获得 `to_json` 能力。

## ancestors 中的模块

```ruby
puts Worker.ancestors.inspect
```

你会看到模块也出现在方法查找链里。

## 常见错误

把 Module 当成类实例化：

```ruby
module Tools
end

# Tools.new 不存在
```

Module 不能直接创建实例。

混入过多模块导致方法来源难查。Mixin 很强，但也需要克制。

## 小练习

1. 定义一个 `Loggable` 模块并 `include` 到类中。
2. 使用 `extend` 给类添加类方法。
3. 查看包含模块后的 `ancestors`。

## 小结

Module 是 Ruby 复用能力的重要工具。命名空间让代码不冲突，Mixin 让对象获得能力。继承和 Mixin 要按语义选择。

