---
sidebar_position: 4
slug: /lua-operating-system-facilities
---

# Lua 操作系统接口

Lua 的 `os` 库提供了一些与操作系统交互的函数，例如获取时间、读取环境变量、执行系统命令、删除文件、重命名文件等。

这些函数很实用，但也要谨慎使用。尤其是 `os.execute()`，如果参数来自用户输入，可能带来安全风险。

## 常用函数

| 函数 | 说明 |
| :--- | :--- |
| `os.date(format, time)` | 格式化日期时间 |
| `os.time(table)` | 获取或构造时间戳 |
| `os.difftime(t2, t1)` | 计算时间差 |
| `os.clock()` | 获取 CPU 时间 |
| `os.getenv(name)` | 读取环境变量 |
| `os.execute(command)` | 执行系统命令 |
| `os.exit(code)` | 退出程序 |
| `os.remove(filename)` | 删除文件 |
| `os.rename(old, new)` | 重命名文件 |
| `os.tmpname()` | 生成临时文件名 |

日期时间相关函数已经在日期时间章节讲过，这里重点看系统相关能力。

## 读取环境变量

```lua showLineNumbers title="main.lua"
local home = os.getenv("HOME")

if home then
   print("HOME:", home)
else
   print("HOME is not set")
end
```

在 Windows 上，你可能更常读取 `USERPROFILE`：

```lua
print(os.getenv("USERPROFILE"))
```

环境变量是否存在取决于系统和运行环境。

## 执行系统命令

`os.execute()` 可以执行系统命令：

```lua showLineNumbers title="main.lua"
local ok, reason, code = os.execute("lua -v")

print(ok)
print(reason)
print(code)
```

不同 Lua 版本和平台上返回值细节可能不同，但你可以用它判断命令是否成功。

:::warning

不要把未经检查的用户输入拼接进 `os.execute()`。例如 `os.execute("ping " .. host)` 如果 `host` 来自外部输入，就可能产生命令注入风险。

:::

如果你只是需要读取命令输出，`os.execute()` 不适合。可以考虑 `io.popen()`，但同样要注意安全。

## 退出程序

`os.exit()` 用于退出程序：

```lua showLineNumbers title="main.lua"
local ok = false

if not ok then
   print("failed")
   os.exit(1)
end
```

退出码 `0` 通常表示成功，非 `0` 通常表示失败。

## 删除和重命名文件

```lua showLineNumbers title="main.lua"
local ok, err = os.rename("old.txt", "new.txt")

if not ok then
   print("rename failed:", err)
end
```

删除文件：

```lua showLineNumbers title="main.lua"
local ok, err = os.remove("new.txt")

if not ok then
   print("remove failed:", err)
end
```

:::warning

删除文件前请确认路径正确。教程中不会给出批量删除或危险路径操作示例。

:::

## 临时文件名

`os.tmpname()` 返回一个临时文件名：

```lua showLineNumbers title="main.lua"
local name = os.tmpname()
print(name)
```

不同平台行为可能不同。安全敏感场景中，临时文件创建应由宿主环境或专门库处理，避免竞争条件。

## 小结

你需要掌握：

- `os.getenv()` 读取环境变量。
- `os.execute()` 能执行系统命令，但要谨慎处理输入。
- `os.exit()` 用于退出程序。
- `os.remove()` 和 `os.rename()` 会修改文件系统，要处理失败情况。
- 某些宿主环境可能禁用 `os` 库中的危险函数。
