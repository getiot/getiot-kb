---
sidebar_position: 3
slug: /lua-game-programming
---

# Lua 游戏编程

Lua 在游戏领域非常常见。很多游戏引擎会把 Lua 嵌入进去，让你用 Lua 编写关卡逻辑、角色行为、UI 脚本、技能配置和热更新逻辑。

如果你想直接用 Lua 做 2D 游戏，LÖVE 是一个很适合入门的框架。

## Lua 在游戏中的角色

Lua 常见用途包括：

- 游戏配置和数据表。
- 关卡脚本。
- NPC 行为逻辑。
- UI 动画和交互。
- 技能、道具、任务脚本。
- 热更新业务逻辑。

底层渲染、物理、资源加载和平台适配通常由游戏引擎负责，Lua 负责更灵活的上层逻辑。

## 使用 LÖVE 写第一个窗口

安装 LÖVE 后，创建目录：

```text
hello-love/
└── main.lua
```

`main.lua` 内容：

```lua showLineNumbers title="main.lua"
function love.draw()
   love.graphics.print("Hello, LÖVE!", 100, 100)
end
```

在目录外运行：

```bash
love hello-love
```

你会看到一个窗口，里面显示文字。

## LÖVE 的三个常用回调

LÖVE 程序通常由几个回调函数组成：

| 回调 | 说明 |
| :--- | :--- |
| `love.load()` | 程序启动时调用一次 |
| `love.update(dt)` | 每帧更新逻辑 |
| `love.draw()` | 每帧绘制画面 |

示例：

```lua showLineNumbers title="main.lua"
local x = 100
local speed = 120

function love.update(dt)
   x = x + speed * dt
end

function love.draw()
   love.graphics.circle("fill", x, 100, 20)
end
```

`dt` 表示距离上一帧经过的时间，单位是秒。使用 `dt` 可以让移动速度不依赖帧率。

## 键盘控制

```lua showLineNumbers title="main.lua"
local x = 100
local y = 100
local speed = 150

function love.update(dt)
   if love.keyboard.isDown("left") then
      x = x - speed * dt
   elseif love.keyboard.isDown("right") then
      x = x + speed * dt
   end

   if love.keyboard.isDown("up") then
      y = y - speed * dt
   elseif love.keyboard.isDown("down") then
      y = y + speed * dt
   end
end

function love.draw()
   love.graphics.circle("fill", x, y, 20)
end
```

运行后，你可以用方向键移动圆点。

## 一个简单状态机

游戏逻辑经常需要状态机。例如开始界面和游戏中：

```lua showLineNumbers title="main.lua"
local state = "menu"

function love.keypressed(key)
   if state == "menu" and key == "return" then
      state = "playing"
   elseif state == "playing" and key == "escape" then
      state = "menu"
   end
end

function love.draw()
   if state == "menu" then
      love.graphics.print("Press Enter to start", 100, 100)
   elseif state == "playing" then
      love.graphics.print("Playing... Press Esc to menu", 100, 100)
   end
end
```

Lua 的 table 和函数很适合组织这种状态逻辑。

## 其他游戏框架和引擎

除了 LÖVE，你还可能遇到：

- Defold：使用 Lua 编写游戏逻辑。
- Solar2D：面向 2D 移动游戏。
- Roblox：使用 Luau，Lua 的一种方言。
- 自研引擎：常把 Lua 嵌入到 C++ 引擎中。

不同引擎的 API 差异很大。学习 Lua 语法只是第一步，真正开发游戏时还要学习对应引擎的生命周期、资源管理和调试工具。

## 小结

你需要掌握：

- Lua 在游戏里常作为脚本语言嵌入引擎。
- LÖVE 是适合入门的 Lua 2D 游戏框架。
- `love.load()`、`love.update(dt)`、`love.draw()` 是 LÖVE 常用回调。
- 使用 `dt` 可以让运动速度与帧率解耦。
- 游戏逻辑常用 table、函数、状态机和模块组织。
