---
sidebar_position: 4
slug: /lua-script-test
---

# Lua 脚本测试

测试能帮你确认代码行为是否符合预期。Lua 项目可以从最简单的 `assert()` 开始测试，也可以使用 Busted 这类测试框架组织更完整的测试集。

这一节先带你写一个简单函数，再给它补测试。

## 使用 assert 做最小测试

创建 `mathx.lua`：

```lua showLineNumbers title="mathx.lua"
local mathx = {}

function mathx.clamp(value, min_value, max_value)
   if value < min_value then
      return min_value
   end

   if value > max_value then
      return max_value
   end

   return value
end

return mathx
```

创建 `test_mathx.lua`：

```lua showLineNumbers title="test_mathx.lua"
local mathx = require("mathx")

assert(mathx.clamp(5, 0, 10) == 5)
assert(mathx.clamp(-1, 0, 10) == 0)
assert(mathx.clamp(20, 0, 10) == 10)

print("all tests passed")
```

运行：

```bash
lua test_mathx.lua
```

输出：

```text
all tests passed
```

如果某个断言失败，Lua 会直接报错并指出失败位置。

## 写一个简单测试函数

你可以给断言加上更清楚的错误信息：

```lua showLineNumbers title="test_mathx.lua"
local mathx = require("mathx")

local function equals(actual, expected, message)
   if actual ~= expected then
      error(string.format(
         "%s: expected %s, got %s",
         message,
         tostring(expected),
         tostring(actual)
      ))
   end
end

equals(mathx.clamp(5, 0, 10), 5, "inside range")
equals(mathx.clamp(-1, 0, 10), 0, "below range")
equals(mathx.clamp(20, 0, 10), 10, "above range")

print("all tests passed")
```

这样失败时，你能更快知道哪个场景出问题。

## 使用 Busted

Busted 是 Lua 生态中常见测试框架。安装：

```bash
luarocks install busted
```

创建目录：

```text
project/
├── mathx.lua
└── spec/
    └── mathx_spec.lua
```

`spec/mathx_spec.lua`：

```lua showLineNumbers title="spec/mathx_spec.lua"
local mathx = require("mathx")

describe("mathx.clamp", function()
   it("returns the original value inside range", function()
      assert.are.equal(5, mathx.clamp(5, 0, 10))
   end)

   it("returns min value when below range", function()
      assert.are.equal(0, mathx.clamp(-1, 0, 10))
   end)

   it("returns max value when above range", function()
      assert.are.equal(10, mathx.clamp(20, 0, 10))
   end)
end)
```

在项目目录运行：

```bash
busted
```

输出会显示测试是否通过。

## 测试错误情况

如果你的函数会抛出错误，也应该测试错误路径：

```lua showLineNumbers title="sensor.lua"
local sensor = {}

function sensor.normalize(value)
   assert(type(value) == "number", "value must be a number")
   return value / 100
end

return sensor
```

Busted 测试：

```lua showLineNumbers title="spec/sensor_spec.lua"
local sensor = require("sensor")

describe("sensor.normalize", function()
   it("normalizes number", function()
      assert.are.equal(0.5, sensor.normalize(50))
   end)

   it("rejects non-number value", function()
      assert.has_error(function()
         sensor.normalize("50")
      end)
   end)
end)
```

## 测试建议

初学阶段你可以先测这些内容：

- 普通输入是否返回正确结果。
- 边界值是否正确，例如 0、空字符串、空 table。
- 错误输入是否能给出明确错误。
- 函数是否意外修改传入 table。
- 模块是否返回预期 table。

## 小结

你需要掌握：

- `assert()` 可以完成最小测试。
- 测试文件本身也是 Lua 脚本。
- Busted 适合组织更完整的测试套件。
- 好测试应覆盖正常路径、边界情况和错误路径。
