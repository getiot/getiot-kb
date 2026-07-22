---
sidebar_position: 6
slug: /lua-proto-example
---

# Lua Proto 示例

Protocol Buffers，常简称 protobuf，是一种结构化数据序列化格式。它常用于网络通信、设备消息、日志、存储和跨语言接口。

Lua 标准库不包含 protobuf 支持。这里使用 `lua-protobuf` 演示最小编码和解码流程。

## 安装 lua-protobuf

使用 LuaRocks：

```bash
luarocks install lua-protobuf
```

`lua-protobuf` 是 C 扩展模块，如果安装失败，通常需要检查编译器、Lua 开发头文件和 LuaRocks 目标版本。

## 定义消息

下面在 Lua 代码中直接加载 `.proto` 定义：

```lua showLineNumbers title="main.lua"
local pb = require("pb")
local protoc = require("protoc")

assert(protoc:load([[
syntax = "proto3";

message SensorData {
   string device_id = 1;
   double temperature = 2;
   int32 battery = 3;
}
]]))

local bytes = assert(pb.encode("SensorData", {
   device_id = "sensor-001",
   temperature = 23.5,
   battery = 95,
}))

local data = assert(pb.decode("SensorData", bytes))

print(data.device_id)
print(data.temperature)
print(data.battery)
```

运行：

```bash
lua main.lua
```

输出：

```text
sensor-001
23.5
95
```

## 从 .proto 文件加载

实际项目中，你通常会把 schema 放到独立文件。例如 `sensor.proto`：

```protobuf title="sensor.proto"
syntax = "proto3";

message SensorData {
   string device_id = 1;
   double temperature = 2;
   int32 battery = 3;
}
```

Lua 代码：

```lua showLineNumbers title="main.lua"
local pb = require("pb")
local protoc = require("protoc")

assert(protoc:loadfile("sensor.proto"))

local bytes = assert(pb.encode("SensorData", {
   device_id = "sensor-001",
   temperature = 23.5,
   battery = 95,
}))

local data = assert(pb.decode("SensorData", bytes))
print(data.device_id, data.temperature, data.battery)
```

## 编码后的数据不是文本

`pb.encode()` 返回的是二进制字符串。你不能直接把它当普通可读文本打印：

```lua
print(bytes)
```

如果需要调试，可以打印长度或转换成十六进制：

```lua showLineNumbers title="hex.lua"
local function to_hex(bytes)
   return (string.gsub(bytes, ".", function(char)
      return string.format("%02X ", string.byte(char))
   end))
end

print(#bytes)
print(to_hex(bytes))
```

## 版本和兼容性

protobuf 的兼容性依赖 field number，而不是字段顺序。演进 schema 时要特别注意：

- 不要随意改变已有字段的编号。
- 删除字段后，最好保留编号，避免后续复用造成兼容问题。
- 新增字段通常比修改字段类型更安全。
- 不同语言端需要使用同一份 `.proto` 或兼容版本。

## 适用场景

protobuf 适合：

- 设备和云端之间传输结构化数据。
- 多语言系统之间共享消息格式。
- 比 JSON 更紧凑的二进制协议。
- 对 schema 有明确约束的系统。

如果你只是写简单配置文件，JSON、TOML 或 YAML 可能更直观。

## 小结

你需要掌握：

- Lua 标准库不包含 protobuf，需要第三方模块。
- `pb.encode()` 把 table 编码为二进制字符串。
- `pb.decode()` 把二进制字符串解码为 table。
- `.proto` 中的 field number 是兼容性关键。
- 调试 protobuf 时要记住编码结果是二进制数据。
