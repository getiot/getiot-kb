---
sidebar_position: 5
slug: /lua-modules
---

# Lua 模块

当程序变大后，你不可能把所有代码都写在一个文件里。模块用于把相关函数和数据放到独立文件中，再通过 `require()` 加载。

你可以把模块理解成一个返回 table 的 Lua 文件。

## 第一个模块

创建文件 `mymath.lua`：

```lua showLineNumbers title="mymath.lua"
local mymath = {}

function mymath.add(a, b)
   return a + b
end

function mymath.sub(a, b)
   return a - b
end

return mymath
```

再创建 `main.lua`：

```lua showLineNumbers title="main.lua"
local mymath = require("mymath")

print(mymath.add(10, 5))
print(mymath.sub(10, 5))
```

把两个文件放在同一目录，运行：

```bash
lua main.lua
```

输出：

```text
15
5
```

这就是现代 Lua 模块的基本写法：模块文件最后 `return` 一个 table。

## require 做了什么

`require("mymath")` 会寻找并加载名为 `mymath` 的模块。对于纯 Lua 模块，它通常会查找类似下面的文件：

- `mymath.lua`
- `mymath/init.lua`

找到后，Lua 会执行这个文件，并把文件的返回值作为 `require()` 的结果。

```lua
local mymath = require("mymath")
```

如果同一个模块已经加载过，`require()` 通常会直接返回缓存结果，不会重复执行模块文件。

## 模块名和文件路径

如果模块在子目录中，例如：

```text
utils/stringx.lua
```

通常这样加载：

```lua
local stringx = require("utils.stringx")
```

模块名中的点号 `.` 会映射到路径分隔符。你不需要写 `.lua` 后缀。

## 模块中的私有函数

模块文件中的 `local` 变量和函数不会暴露给外部：

```lua showLineNumbers title="formatter.lua"
local formatter = {}

local function trim_prefix(text)
   return string.gsub(text, "^%s+", "")
end

function formatter.normalize(text)
   return string.lower(trim_prefix(text))
end

return formatter
```

外部只能访问返回 table 里的字段：

```lua showLineNumbers title="main.lua"
local formatter = require("formatter")

print(formatter.normalize("  LUA"))
```

输出：

```text
lua
```

`trim_prefix()` 是模块内部实现细节，不会被外部直接调用。

## package.path

Lua 使用 `package.path` 查找 Lua 模块：

```lua showLineNumbers title="main.lua"
print(package.path)
```

输出会是一长串搜索模板，例如：

```text
./?.lua;./?/init.lua;...
```

其中 `?` 会被模块名替换。比如 `require("utils.stringx")` 会尝试查找类似 `utils/stringx.lua` 的文件。

你可以临时修改 `package.path`：

```lua
package.path = package.path .. ";./libs/?.lua"
```

这样 Lua 会额外到 `libs/` 目录中查找模块。

## C 模块和 package.cpath

如果模块是 C 语言编译出来的动态库，Lua 会使用 `package.cpath` 查找。常见后缀可能是 `.so`、`.dll` 或 `.dylib`。

初学阶段你不需要深入掌握 `package.cpath`，只要知道 `require()` 不只能加载 `.lua` 文件，也能加载 C 扩展模块。

## 不推荐旧式 module 写法

你可能在旧代码里看到：

```lua
module("mymath", package.seeall)
```

这是 Lua 5.1 时代常见的旧式写法。现代 Lua 教程不建议用它作为主线，因为它会修改模块环境，容易污染命名空间，也不利于理解模块依赖。

推荐写法仍然是：

```lua
local M = {}

function M.some_function()
   -- ...
end

return M
```

## 常见错误

### 忘记 return 模块 table

如果模块文件没有 `return`，外部 `require()` 得到的结果可能不是你期望的 table。

```lua
-- bad_module.lua
local M = {}

function M.hello()
   print("hello")
end

-- 忘记 return M
```

正确写法：

```lua
return M
```

### 文件名和模块名不一致

如果文件叫 `my_math.lua`，你应该这样加载：

```lua
local my_math = require("my_math")
```

不是：

```lua
local my_math = require("mymath")
```

除非你额外配置了搜索路径或加载器。

## 小结

你需要掌握：

- 模块通常是一个返回 table 的 Lua 文件。
- 使用 `require("module_name")` 加载模块。
- 模块内部实现细节应尽量使用 `local`。
- 子目录模块通常用点号表示，例如 `require("utils.stringx")`。
- 旧式 `module(..., package.seeall)` 不建议作为现代写法。
