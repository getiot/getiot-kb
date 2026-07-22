---
sidebar_position: 1
slug: /lua-object-oriented
---

# Lua 面向对象

Lua 没有内置 `class` 关键字，但你可以用 table、函数和 metatable 实现面向对象写法。理解这一点后，你会发现 Lua 的对象系统不是语言硬编码出来的，而是由普通机制组合出来的。

## 对象是什么

在 Lua 中，一个对象通常就是一个 table：

```lua showLineNumbers title="main.lua"
local device = {
   id = "sensor-001",
   value = 23.5,
}

function device.show(self)
   print(self.id, self.value)
end

device.show(device)
```

输出：

```text
sensor-001	23.5
```

这种写法有点啰嗦，因为调用方法时要手动传入 `device`。

## 冒号语法

Lua 提供了冒号语法：

```lua showLineNumbers title="main.lua"
local device = {
   id = "sensor-001",
   value = 23.5,
}

function device:show()
   print(self.id, self.value)
end

device:show()
```

输出：

```text
sensor-001	23.5
```

`device:show()` 等价于：

```lua
device.show(device)
```

冒号会自动把调用者作为第一个参数 `self` 传入。

## 创建“类”

Lua 中常见的类写法是：用一个 table 保存方法，再用 `__index` 让对象查找这些方法。

```lua showLineNumbers title="device.lua"
local Device = {}
Device.__index = Device

function Device.new(id)
   local self = {
      id = id,
      value = 0,
   }

   return setmetatable(self, Device)
end

function Device:set_value(value)
   self.value = value
end

function Device:show()
   print(self.id, self.value)
end

local sensor = Device.new("sensor-001")
sensor:set_value(23.5)
sensor:show()
```

输出：

```text
sensor-001	23.5
```

这段代码的关键是：

```lua
Device.__index = Device
```

当 `sensor` 找不到 `show` 字段时，会通过 metatable 的 `__index` 到 `Device` 中查找。

## 把类写成模块

实际项目中，你通常会把类放到单独模块：

```lua showLineNumbers title="device.lua"
local Device = {}
Device.__index = Device

function Device.new(id)
   local self = {
      id = id,
      value = 0,
   }

   return setmetatable(self, Device)
end

function Device:set_value(value)
   self.value = value
end

function Device:show()
   print(self.id, self.value)
end

return Device
```

使用：

```lua showLineNumbers title="main.lua"
local Device = require("device")

local sensor = Device.new("sensor-001")
sensor:set_value(23.5)
sensor:show()
```

## 继承

Lua 没有固定的继承模型。下面是一种简单写法：

```lua showLineNumbers title="main.lua"
local Device = {}
Device.__index = Device

function Device.new(id)
   return setmetatable({id = id}, Device)
end

function Device:show()
   print("device:", self.id)
end

local Sensor = {}
Sensor.__index = Sensor
setmetatable(Sensor, {__index = Device})

function Sensor.new(id, unit)
   local self = Device.new(id)
   self.unit = unit
   return setmetatable(self, Sensor)
end

function Sensor:read()
   print("read:", self.id, self.unit)
end

local s = Sensor.new("sensor-001", "C")
s:show()
s:read()
```

输出：

```text
device:	sensor-001
read:	sensor-001	C
```

这里 `Sensor` 自己找不到 `show()` 时，会通过 `setmetatable(Sensor, {__index = Device})` 到 `Device` 里查找。

## 组合优先于复杂继承

Lua 的灵活性很高，但复杂继承层级会让代码难读。很多时候，组合更清楚。

```lua showLineNumbers title="main.lua"
local function new_logger(prefix)
   return {
      info = function(_, message)
         print(prefix .. ": " .. message)
      end,
   }
end

local device = {
   id = "sensor-001",
   logger = new_logger("sensor"),
}

device.logger:info("online")
```

输出：

```text
sensor: online
```

这里没有继承，只是把 logger 放进 device 里。

## 常见错误

### 用点号调用冒号定义的方法

```lua
function device:show()
   print(self.id)
end

device.show() -- 错误：self 没有传入
```

正确写法：

```lua
device:show()
```

或者显式传入：

```lua
device.show(device)
```

### 忘记设置 __index

如果你忘记写：

```lua
Device.__index = Device
```

对象就找不到定义在 `Device` 上的方法。

## 小结

你需要掌握：

- Lua 对象通常是 table。
- 冒号调用会自动传入 `self`。
- 常见类写法是 `Class.__index = Class` 加 `setmetatable()`。
- 继承可以用 metatable 实现，但不要滥用复杂继承。
- 实际项目中，组合往往比深层继承更容易维护。
