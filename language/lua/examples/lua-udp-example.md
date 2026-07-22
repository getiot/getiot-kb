---
sidebar_position: 5
slug: /lua-udp-example
---

# Lua UDP 示例

Lua 标准库不包含 socket API。要写 UDP 程序，常见选择是 LuaSocket。

这一节用 LuaSocket 写一个本地 UDP server 和 client。你会看到 Lua 如何发送和接收 UDP 数据包。

## 安装 LuaSocket

使用 LuaRocks：

```bash
luarocks install luasocket
```

在某些 Linux 发行版上，也可以使用系统包：

```bash
sudo apt install lua-socket
```

安装完成后测试：

```lua showLineNumbers title="check-socket.lua"
local socket = require("socket")
print(socket._VERSION)
```

运行：

```bash
lua check-socket.lua
```

如果能输出版本信息，说明 LuaSocket 可用。

## UDP server

创建 `udp_server.lua`：

```lua showLineNumbers title="udp_server.lua"
local socket = require("socket")

local udp = assert(socket.udp())
assert(udp:setsockname("127.0.0.1", 9000))
udp:settimeout(1)

print("UDP server listening on 127.0.0.1:9000")

while true do
   local data, ip, port = udp:receivefrom()

   if data then
      print("received from " .. ip .. ":" .. port .. " -> " .. data)
      udp:sendto("echo: " .. data, ip, port)
   end
end
```

运行：

```bash
lua udp_server.lua
```

这个 server 会监听本机 `9000` 端口，收到消息后回发 `echo: ...`。

## UDP client

另开一个终端，创建 `udp_client.lua`：

```lua showLineNumbers title="udp_client.lua"
local socket = require("socket")

local udp = assert(socket.udp())
udp:settimeout(2)

assert(udp:sendto("hello", "127.0.0.1", 9000))

local data, ip, port = udp:receivefrom()

if data then
   print("received from " .. ip .. ":" .. port .. " -> " .. data)
else
   print("timeout")
end

udp:close()
```

运行：

```bash
lua udp_client.lua
```

输出类似：

```text
received from 127.0.0.1:9000 -> echo: hello
```

server 终端会看到：

```text
received from 127.0.0.1:xxxxx -> hello
```

## UDP 的特点

UDP 和 TCP 不同：

- UDP 是无连接协议。
- 发送方不保证对方一定收到。
- 包可能丢失、重复或乱序。
- UDP 适合低延迟、可容忍丢包的场景。

在 IoT 场景中，UDP 常用于简单广播、局域网发现、实时数据上报等，但你需要自己设计超时、重试和数据校验。

## 设置超时

示例中使用：

```lua
udp:settimeout(2)
```

表示接收最多等待 2 秒。如果没有收到数据，`receivefrom()` 会返回 `nil` 和错误信息。

```lua
local data, err = udp:receivefrom()

if not data then
   print(err)
end
```

## 小结

你需要掌握：

- Lua 标准库不包含 socket，需要 LuaSocket 等第三方库。
- `socket.udp()` 创建 UDP socket。
- `setsockname()` 绑定本地地址和端口。
- `sendto()` 发送 UDP 数据。
- `receivefrom()` 接收 UDP 数据。
- UDP 不保证可靠传输，需要你自己处理超时和重试。
