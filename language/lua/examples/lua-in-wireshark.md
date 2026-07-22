---
sidebar_position: 7
slug: /lua-in-wireshark
---

# Lua 在 Wireshark 中的使用

Wireshark 支持使用 Lua 编写插件和协议解析器。对于自定义协议、IoT 设备私有报文、实验性网络协议来说，Lua dissector 是一个非常实用的工具。

这一节带你写一个最小 UDP 协议解析器，把指定端口的数据解析成 Wireshark 中可过滤的字段。

## 准备工作

你需要安装 Wireshark，并确认 Lua 支持没有被禁用。

打开 Wireshark 后，可以通过菜单查看插件目录：

```text
Help -> About Wireshark -> Folders
```

找到 Personal Lua Plugins 或 Personal Plugins 对应的目录。后面我们会把 Lua 脚本放到这个目录。

## 一个最小 dissector

创建 `getiot_demo.lua`：

```lua showLineNumbers title="getiot_demo.lua"
local p_getiot = Proto("getiotdemo", "GetIoT Demo Protocol")

local f_magic = ProtoField.uint8("getiotdemo.magic", "Magic", base.HEX)
local f_value = ProtoField.uint16("getiotdemo.value", "Value", base.DEC)

p_getiot.fields = {
   f_magic,
   f_value,
}

function p_getiot.dissector(buffer, pinfo, tree)
   if buffer:len() < 3 then
      return
   end

   pinfo.cols.protocol = "GETIOT"

   local subtree = tree:add(p_getiot, buffer(), "GetIoT Demo Protocol")

   subtree:add(f_magic, buffer(0, 1))
   subtree:add(f_value, buffer(1, 2))
end

local udp_table = DissectorTable.get("udp.port")
udp_table:add(9000, p_getiot)
```

这个 dissector 假设 UDP payload 至少有 3 字节：

- 第 0 字节：magic。
- 第 1-2 字节：value，按 16-bit unsigned integer 解析。

## 安装插件

把 `getiot_demo.lua` 放到 Wireshark 的个人 Lua 插件目录，然后重启 Wireshark。

如果插件加载成功，你可以在 display filter 中使用字段：

```text
getiotdemo.magic
getiotdemo.value
```

## 生成测试 UDP 报文

你可以用 LuaSocket 发送一个简单 UDP 包：

```lua showLineNumbers title="send_packet.lua"
local socket = require("socket")

local udp = assert(socket.udp())

local magic = string.char(0x42)
local value = string.char(0x12, 0x34)

assert(udp:sendto(magic .. value, "127.0.0.1", 9000))
udp:close()
```

运行：

```bash
lua send_packet.lua
```

然后在 Wireshark 中抓取 loopback 接口，并使用过滤器：

```text
udp.port == 9000
```

你应该能在 packet details 中看到 GetIoT Demo Protocol。

## Proto 和 ProtoField

Wireshark Lua dissector 中最常用的对象是：

- `Proto`：定义一个协议解析器。
- `ProtoField`：定义可显示、可过滤的字段。
- `DissectorTable`：把解析器注册到某个协议表，例如 UDP 端口。
- `Tvb` / `TvbRange`：表示 packet buffer 和切片。
- `pinfo`：当前 packet 信息，例如协议列、源地址、目标地址。
- `tree`：packet details 树。

## 常见错误

### buffer 长度不够

解析前应检查长度：

```lua
if buffer:len() < 3 then
   return
end
```

否则短包可能导致解析器报错。

### 端口没有注册正确

如果你把 dissector 注册到 `9000`：

```lua
udp_table:add(9000, p_getiot)
```

抓包时也要确保数据确实发往或来自 UDP 9000 端口。

### 插件目录放错

不同系统、不同 Wireshark 版本的插件目录可能不同。请优先使用 Wireshark 菜单中的 Folders 页面确认路径。

## 小结

你需要掌握：

- Wireshark 可以用 Lua 编写协议解析器。
- `Proto` 定义协议，`ProtoField` 定义字段。
- 解析器函数接收 `buffer`、`pinfo`、`tree`。
- 注册到 `udp.port` 后，Wireshark 会对指定 UDP 端口调用你的 dissector。
- 解析前要检查 buffer 长度，避免短包错误。

## 参考

- [Wireshark Lua API Reference Manual](https://www.wireshark.org/docs/wsdg_html_chunked/wsluarm_modules.html)
- [Wireshark Functions For New Protocols And Dissectors](https://www.wireshark.org/docs/wsdg_html_chunked/lua_module_Proto.html)
