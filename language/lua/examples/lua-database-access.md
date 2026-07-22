---
sidebar_position: 2
slug: /lua-database-access
---

# Lua 连接数据库

Lua 标准库不包含数据库接口。你需要使用第三方库，例如 LuaSQL，或者使用宿主环境提供的数据库能力。OpenResty 生态中也有专门的 MySQL、PostgreSQL、Redis 客户端库。

这一节用 LuaSQL + SQLite 演示最基本的数据库访问流程。

## 安装依赖

你需要先安装 LuaRocks，然后安装 SQLite 驱动：

```bash
luarocks install luasql-sqlite3
```

在某些系统上，你还需要安装 SQLite 开发库：

```bash
sudo apt install sqlite3 libsqlite3-dev
```

具体包名可能因发行版而异。

## 连接数据库

```lua showLineNumbers title="main.lua"
local luasql = require("luasql.sqlite3")

local env = assert(luasql.sqlite3())
local conn = assert(env:connect("test.db"))

print("connected")

conn:close()
env:close()
```

运行后会在当前目录创建或打开 `test.db`。

## 创建表

```lua showLineNumbers title="create-table.lua"
local luasql = require("luasql.sqlite3")

local env = assert(luasql.sqlite3())
local conn = assert(env:connect("test.db"))

assert(conn:execute([[
CREATE TABLE IF NOT EXISTS devices (
   id INTEGER PRIMARY KEY AUTOINCREMENT,
   name TEXT NOT NULL,
   value REAL NOT NULL
)
]]))

print("table ready")

conn:close()
env:close()
```

## 插入数据

```lua showLineNumbers title="insert.lua"
local luasql = require("luasql.sqlite3")

local env = assert(luasql.sqlite3())
local conn = assert(env:connect("test.db"))

assert(conn:execute([[
INSERT INTO devices (name, value)
VALUES ('temperature', 23.5)
]]))

print("insert ok")

conn:close()
env:close()
```

这个示例为了简洁直接写了 SQL 字符串。真实项目中，如果 SQL 中包含外部输入，必须使用参数绑定或库提供的转义/预处理机制，避免 SQL injection。

:::warning

不要把用户输入直接拼接到 SQL 语句中。数据库章节的示例只演示基本流程，不代表生产级安全写法。

:::

## 查询数据

```lua showLineNumbers title="select.lua"
local luasql = require("luasql.sqlite3")

local env = assert(luasql.sqlite3())
local conn = assert(env:connect("test.db"))

local cursor = assert(conn:execute("SELECT id, name, value FROM devices"))

local row = cursor:fetch({}, "a")
while row do
   print(row.id, row.name, row.value)
   row = cursor:fetch(row, "a")
end

cursor:close()
conn:close()
env:close()
```

`cursor:fetch({}, "a")` 表示以字段名作为 key，把当前行取到 table 中。

## 更新和删除

更新：

```lua
assert(conn:execute("UPDATE devices SET value = 24.0 WHERE name = 'temperature'"))
```

删除：

```lua
assert(conn:execute("DELETE FROM devices WHERE name = 'temperature'"))
```

`execute()` 对非查询语句通常返回受影响行数，具体行为取决于驱动。

## 事务

多个操作需要一起成功或一起失败时，应使用事务：

```lua showLineNumbers title="transaction.lua"
local luasql = require("luasql.sqlite3")

local env = assert(luasql.sqlite3())
local conn = assert(env:connect("test.db"))

local ok, err = pcall(function()
   assert(conn:execute("BEGIN"))
   assert(conn:execute("INSERT INTO devices (name, value) VALUES ('humidity', 60.0)"))
   assert(conn:execute("INSERT INTO devices (name, value) VALUES ('pressure', 101.3)"))
   assert(conn:execute("COMMIT"))
end)

if not ok then
   conn:execute("ROLLBACK")
   print("transaction failed:", err)
else
   print("transaction ok")
end

conn:close()
env:close()
```

## MySQL 和其他数据库

LuaSQL 也提供其他驱动，例如：

```bash
luarocks install luasql-mysql
luarocks install luasql-postgres
```

不同数据库驱动需要对应客户端开发库，连接字符串和认证方式也不同。请以驱动文档和数据库官方文档为准。

## 小结

你需要掌握：

- Lua 标准库不包含数据库接口。
- LuaSQL 是常见数据库访问库之一。
- 数据库访问流程通常是：创建环境、连接、执行 SQL、读取结果、关闭资源。
- 外部输入不能直接拼接进 SQL。
- 多条相关写操作应使用事务。
