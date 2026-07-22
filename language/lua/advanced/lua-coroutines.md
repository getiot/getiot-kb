---
sidebar_position: 2
slug: /lua-coroutines
---

# Lua 协程（Coroutine）

coroutine 是 Lua 中的协作式并发机制。你可以把它理解成“可以暂停和继续执行的函数”。

它不是操作系统线程。coroutine 不会自动并行运行，只有当你显式 `resume()` 它时，它才继续执行；当它调用 `yield()` 时，它会主动暂停，把控制权交还给调用者。

## 创建协程

使用 `coroutine.create()` 创建协程：

```lua showLineNumbers title="main.lua"
local co = coroutine.create(function()
   print("hello from coroutine")
end)

print(coroutine.status(co))
coroutine.resume(co)
print(coroutine.status(co))
```

输出：

```text
suspended
hello from coroutine
dead
```

新创建的协程状态是 `suspended`。运行结束后变成 `dead`。

## yield 和 resume

`coroutine.yield()` 会暂停协程：

```lua showLineNumbers title="main.lua"
local co = coroutine.create(function()
   print("step 1")
   coroutine.yield()
   print("step 2")
end)

coroutine.resume(co)
print("back to main")
coroutine.resume(co)
```

输出：

```text
step 1
back to main
step 2
```

你可以看到，协程执行到 `yield()` 后暂停，主程序继续执行。第二次 `resume()` 后，协程从暂停的位置继续。

## 在 yield 和 resume 之间传值

`resume()` 可以把值传给协程，`yield()` 也可以把值返回给调用者：

```lua showLineNumbers title="main.lua"
local co = coroutine.create(function(a, b)
   print("start:", a, b)

   local value = coroutine.yield(a + b)
   print("resume value:", value)

   return "done"
end)

local ok, result = coroutine.resume(co, 2, 3)
print(ok, result)

ok, result = coroutine.resume(co, "hello")
print(ok, result)
```

输出：

```text
start:	2	3
true	5
resume value:	hello
true	done
```

这也是 coroutine 灵活的地方：暂停点可以像函数调用一样交换数据。

## 用 coroutine 实现生成器

生成器是 coroutine 的经典用途。下面这个函数逐个产生数字：

```lua showLineNumbers title="main.lua"
local function range(max)
   return coroutine.wrap(function()
      for i = 1, max do
         coroutine.yield(i)
      end
   end)
end

for value in range(3) do
   print(value)
end
```

输出：

```text
1
2
3
```

`coroutine.wrap()` 会返回一个函数。每次调用这个函数，协程会运行到下一个 `yield()`。

## resume 的错误处理

如果协程内部出错，`coroutine.resume()` 不会直接抛出错误，而是返回 `false` 和错误信息：

```lua showLineNumbers title="main.lua"
local co = coroutine.create(function()
   error("failed")
end)

local ok, err = coroutine.resume(co)

print(ok)
print(err)
```

输出类似：

```text
false
main.lua:2: failed
```

所以使用 `resume()` 时，不要忽略第一个返回值。

## coroutine 的状态

`coroutine.status(co)` 可能返回：

| 状态 | 说明 |
| :--- | :--- |
| `suspended` | 已创建或已暂停，等待恢复 |
| `running` | 正在运行 |
| `normal` | 协程恢复了另一个协程，当前不是最顶层 |
| `dead` | 执行结束或出错 |

示例：

```lua showLineNumbers title="main.lua"
local co = coroutine.create(function()
   coroutine.yield()
end)

print(coroutine.status(co))
coroutine.resume(co)
print(coroutine.status(co))
coroutine.resume(co)
print(coroutine.status(co))
```

输出：

```text
suspended
suspended
dead
```

## 适合场景

coroutine 常用于：

- 生成器。
- 状态机。
- 协作式任务调度。
- 分步执行复杂流程。
- 游戏脚本或异步流程封装。

它不适合直接替代操作系统线程。如果你需要真正并行执行 CPU 密集任务，要看宿主环境是否提供线程、进程或异步 I/O。

## 小结

你需要掌握：

- coroutine 是协作式暂停/恢复机制，不是 OS thread。
- `coroutine.create()` 创建协程。
- `coroutine.resume()` 恢复协程。
- `coroutine.yield()` 暂停协程。
- `resume()` 的第一个返回值表示是否成功。
- `coroutine.wrap()` 适合写生成器。
