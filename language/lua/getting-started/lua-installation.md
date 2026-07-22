---
sidebar_position: 2
slug: /lua-installation
---

# Lua 安装

本文带你安装 Lua，并确认 `lua` 和 `luac` 两个命令可用。初学阶段你只需要能运行 Lua 脚本，不必急着安装所有第三方库。

## 安装方式怎么选

你有两种常见选择：

- 使用系统包管理器安装，最省事，适合快速学习。
- 从源码编译安装，版本可控，适合需要指定 Lua 版本的场景。

如果你只是跟着教程学习，建议先用包管理器安装。等你需要嵌入 Lua、交叉编译或控制版本时，再学习源码编译。

## 在 Ubuntu / Debian 安装

在 Ubuntu 或 Debian 上，可以使用 `apt` 安装：

```bash
sudo apt update
sudo apt install lua5.4
```

安装完成后检查版本：

```bash
lua5.4 -v
```

输出类似如下：

```bash
Lua 5.4.8  Copyright (C) 1994-2025 Lua.org, PUC-Rio
```

不同发行版仓库中的版本可能不同。如果你的系统没有 `lua5.4` 包，可以先搜索可用包：

```bash
apt search '^lua[0-9]'
```

有些系统会把默认解释器命名为 `lua`，有些会命名为 `lua5.4`。后续教程默认使用 `lua`，如果你的系统只有 `lua5.4`，可以把命令替换为 `lua5.4`。

## 在 macOS 安装

macOS 用户可以使用 Homebrew：

```bash
brew install lua
```

检查版本：

```bash
lua -v
```

## 在 Windows 安装

Windows 上可以选择以下方式：

- 使用 MSYS2 / MinGW 安装 Lua。
- 下载预编译的 Lua 二进制包。
- 使用 Windows Subsystem for Linux，在 Linux 环境中学习。

如果你是初学者，并且后续会学习 Linux、嵌入式或网络服务，建议使用 Windows Subsystem for Linux，这样教程中的命令更容易对齐。

## 从源码编译安装

如果你希望安装指定版本，可以从 Lua 官方下载源码。下面以 Lua 5.4.8 为例：

```bash
curl -R -O https://www.lua.org/ftp/lua-5.4.8.tar.gz
tar zxvf lua-5.4.8.tar.gz
cd lua-5.4.8
make all test
```

编译完成后，`src/` 目录下会生成：

- `lua`：Lua 解释器，用于运行脚本或进入交互式模式。
- `luac`：Lua 编译器，用于把 Lua 源码编译成字节码。

安装到系统目录：

```bash
sudo make install
```

确认安装结果：

```bash
lua -v
```

输出类似如下：

```bash
Lua 5.4.8  Copyright (C) 1994-2025 Lua.org, PUC-Rio
```

:::warning

`sudo make install` 会把文件安装到系统目录，可能覆盖已有 Lua 版本。如果你的电脑上已经有项目依赖旧版 Lua，建议先确认安装路径，或者使用源码目录中的 `src/lua` 直接运行。

:::

## 运行交互式解释器

执行：

```bash
lua
```

如果进入下面这样的提示符，就说明解释器工作正常：

```text
>
```

输入一行代码：

```lua
print("Hello, Lua!")
```

输出：

```text
Hello, Lua!
```

退出解释器：

```lua
os.exit()
```

## 运行脚本文件

创建 `hello.lua`：

```lua showLineNumbers title="hello.lua"
print("Hello, Lua!")
```

运行：

```bash
lua hello.lua
```

输出：

```text
Hello, Lua!
```

## 常见问题

### lua: command not found

说明系统找不到 `lua` 命令。你可以先尝试：

```bash
lua5.4 -v
```

如果 `lua5.4` 可用，就说明解释器已经安装，只是命令名不同。

### 多个 Lua 版本并存

很多系统可以同时安装 `lua5.1`、`lua5.3`、`lua5.4`。你可以使用具体版本命令运行脚本：

```bash
lua5.4 main.lua
```

在工程项目中，建议把目标 Lua 版本写进 README 或构建脚本，避免团队成员使用不同版本运行同一份代码。

## 小结

你现在应该已经能完成三件事：

- 安装 Lua。
- 使用 `lua -v` 或 `lua5.4 -v` 查看版本。
- 运行交互式解释器和 `.lua` 脚本文件。

下一节我们会写几个小程序，让你真正开始使用 Lua。
