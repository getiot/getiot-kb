---
sidebar_position: 3
slug: /lua-file-io
---

# Lua 文件 I/O

文件 I/O 用于读取和写入文件。你可以用它保存配置、读取日志、处理传感器数据文件，或者生成结果报告。

Lua 提供两种常见文件操作方式：

- 简单函数，例如 `io.input()`、`io.read()`、`io.write()`。
- 文件句柄，例如 `io.open()` 返回的 file object。

实际项目中更推荐使用文件句柄，因为它更明确，也更容易处理错误。

## 写入文件

下面创建文件 `hello.txt` 并写入一行文本：

```lua showLineNumbers title="write-file.lua"
local file = assert(io.open("hello.txt", "w"))

file:write("Hello, Lua!\n")
file:close()
```

运行：

```bash
lua write-file.lua
```

当前目录会生成 `hello.txt`。

`io.open("hello.txt", "w")` 表示以写入模式打开文件。如果文件不存在，会创建文件；如果文件已存在，会覆盖原内容。

## 读取整个文件

```lua showLineNumbers title="read-file.lua"
local file = assert(io.open("hello.txt", "r"))
local content = file:read("*a")
file:close()

print(content)
```

输出：

```text
Hello, Lua!
```

`"*a"` 表示读取整个文件。

## 按行读取文件

如果文件可能很大，按行读取更合适：

```lua showLineNumbers title="read-lines.lua"
local file = assert(io.open("hello.txt", "r"))

for line in file:lines() do
   print(line)
end

file:close()
```

也可以直接使用 `io.lines()`：

```lua
for line in io.lines("hello.txt") do
   print(line)
end
```

`io.lines(filename)` 会在迭代结束后自动关闭文件。使用显式文件句柄时，你要自己调用 `close()`。

## 追加写入

追加模式使用 `"a"`：

```lua showLineNumbers title="append-file.lua"
local file = assert(io.open("hello.txt", "a"))

file:write("Second line\n")
file:close()
```

这会把内容写到文件末尾。

## 文件打开模式

常见模式如下：

| 模式 | 说明 |
| :--- | :--- |
| `"r"` | 只读，文件必须存在 |
| `"w"` | 只写，覆盖原文件 |
| `"a"` | 追加写入 |
| `"r+"` | 读写，文件必须存在 |
| `"w+"` | 读写，覆盖原文件 |
| `"a+"` | 读写，写入追加到末尾 |
| `"rb"` | 二进制只读 |
| `"wb"` | 二进制只写 |

在 Windows 上处理二进制文件时，应使用带 `b` 的模式。

## 处理打开失败

`io.open()` 失败时通常返回 `nil` 和错误信息：

```lua showLineNumbers title="open-error.lua"
local file, err = io.open("not-exist.txt", "r")

if not file then
   print("open failed:", err)
   return
end

file:close()
```

这种写法比直接 `assert()` 更适合需要友好报错的程序。

## seek 定位

`file:seek()` 可以移动读写位置：

```lua showLineNumbers title="seek-demo.lua"
local file = assert(io.open("hello.txt", "r"))

file:seek("set", 0)
print(file:read(5))

file:seek("set", 7)
print(file:read("*a"))

file:close()
```

`seek` 的第一个参数常见值：

| 参数 | 说明 |
| :--- | :--- |
| `"set"` | 从文件开头计算 |
| `"cur"` | 从当前位置计算 |
| `"end"` | 从文件末尾计算 |

## 标准输入输出

Lua 预定义了三个标准文件：

- `io.stdin`
- `io.stdout`
- `io.stderr`

示例：

```lua showLineNumbers title="stderr.lua"
io.stderr:write("this is an error message\n")
```

## 小结

你需要掌握：

- 使用 `io.open()` 打开文件。
- 用 `file:read()` 读取，用 `file:write()` 写入。
- 用 `file:close()` 关闭文件。
- `file:lines()` 适合逐行读取。
- 打开文件可能失败，实际项目中要处理 `nil, err`。
