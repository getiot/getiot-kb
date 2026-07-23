---
sidebar_position: 5
sidebar_label: RSpec 测试
slug: /ruby-rspec
---

# Ruby RSpec 测试

RSpec 是 Ruby 社区常用测试框架。和 Minitest 相比，RSpec 的语法更强调行为描述，读起来像在说明“这个对象应该怎样表现”。

## 一个最小例子

```ruby title="spec/calculator_spec.rb"
RSpec.describe "Calculator" do
  it "adds two numbers" do
    expect(2 + 3).to eq(5)
  end
end
```

运行：

```bash
bundle exec rspec
```

实际项目中，RSpec 通常通过 Bundler 安装和运行。

## describe、context 和 it

```ruby
RSpec.describe User do
  context "when name is present" do
    it "returns display name" do
      user = User.new("Alice")
      expect(user.display_name).to eq("Alice")
    end
  end
end
```

常见约定：

- `describe` 描述类、方法或功能。
- `context` 描述上下文。
- `it` 描述具体行为。

## expect

```ruby
expect(value).to eq(10)
expect(list).to include("Ruby")
expect(user).not_to be_nil
```

RSpec 有很多 matcher。初学时先掌握 `eq`、`include`、`be_nil`、`be_truthy`、`be_falsey`。

## let

```ruby
RSpec.describe User do
  let(:user) { User.new("Alice") }

  it "has a name" do
    expect(user.name).to eq("Alice")
  end
end
```

`let` 会延迟创建测试数据。不要在一个测试里堆太多 `let`，否则可读性会下降。

## Minitest 还是 RSpec

Minitest 简洁、标准库自带。

RSpec 描述性强、生态丰富。

初学者任选一个先用起来更重要。不要把时间都花在比较框架上。

## 小结

RSpec 适合用行为描述组织测试。你要掌握 `describe`、`context`、`it`、`expect` 和常用 matcher。

