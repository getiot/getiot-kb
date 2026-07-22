---
sidebar_position: 7
slug: /lua-package-manager
---

# Lua 包管理器

Lua 标准库很小，很多工程能力需要第三方模块。例如网络通信常用 LuaSocket，JSON 处理常用 lua-cjson 或 dkjson，数据库访问可能用 LuaSQL。Lua 生态中最常见的包管理器是 LuaRocks。

## LuaRocks 是什么

LuaRocks 是 Lua 模块的包管理器。它可以下载、编译、安装和管理 Lua 模块。LuaRocks 中的包通常称为 rock。

官方网站：

- [LuaRocks](https://luarocks.org/)
- [LuaRocks GitHub](https://github.com/luarocks/luarocks)

## 安装 LuaRocks

在 Ubuntu / Debian 上可以使用：

```bash
sudo apt update
sudo apt install luarocks
```

macOS 可以使用 Homebrew：

```bash
brew install luarocks
```

安装完成后检查版本：

```bash
luarocks --version
```

不同系统仓库中的 LuaRocks 版本可能不同。如果你需要最新版本，可以参考 LuaRocks 官方安装文档。

## 安装模块

安装 LuaSocket：

```bash
luarocks install luasocket
```

在 Lua 中使用：

```lua showLineNumbers title="main.lua"
local socket = require("socket")

print(socket._VERSION)
```

如果 `require("socket")` 成功，说明模块已经能被 Lua 找到。

## 本地安装

如果你没有系统目录写权限，或者不希望污染全局环境，可以使用本地安装：

```bash
luarocks install --local luasocket
```

本地安装后，可能需要让当前 shell 加载 LuaRocks 给出的路径：

```bash
eval "$(luarocks path)"
```

你也可以查看 LuaRocks 建议设置的环境变量：

```bash
luarocks path
```

## 搜索模块

搜索模块：

```bash
luarocks search json
```

查看已经安装的模块：

```bash
luarocks list
```

卸载模块：

```bash
luarocks remove luasocket
```

## 指定 Lua 版本

如果系统里有多个 Lua 版本，你需要确认 LuaRocks 正在为哪个版本安装模块：

```bash
luarocks config lua_version
```

有些系统提供带版本后缀的命令，例如：

```bash
luarocks --lua-version=5.4 install luasocket
```

具体是否可用取决于你的 LuaRocks 安装方式。

## C 扩展和编译依赖

很多 LuaRocks 包是纯 Lua 模块，安装很简单。但有些包包含 C 扩展，需要编译器和系统开发库。

例如安装数据库驱动时，你可能还需要安装数据库客户端开发包：

```bash
sudo apt install build-essential
```

具体依赖要看模块文档。

:::note

如果 LuaRocks 安装失败，不要只看最后一行。通常真正原因在日志中间，例如缺少头文件、找不到编译器、Lua 版本不匹配。

:::

## 常用模块举例

| 模块 | 用途 |
| :--- | :--- |
| `luasocket` | TCP / UDP 网络通信 |
| `lua-cjson` | JSON 编码和解析 |
| `dkjson` | 纯 Lua JSON 库 |
| `luafilesystem` | 文件系统操作 |
| `luasql-*` | 数据库访问 |
| `busted` | Lua 测试框架 |

安装前请查看模块页面，确认支持的 Lua 版本和系统依赖。

## 小结

你需要掌握：

- LuaRocks 是 Lua 常用包管理器。
- 使用 `luarocks install <module>` 安装模块。
- 本地安装可以使用 `--local`。
- 多 Lua 版本共存时，要确认 LuaRocks 目标版本。
- 包含 C 扩展的模块可能需要额外编译依赖。
