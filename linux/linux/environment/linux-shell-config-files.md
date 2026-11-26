---
sidebar_position: 3
sidebar_label: Shell 配置文件
slug: /linux-shell-config-files
---

# Linux Shell 配置文件：.bashrc、.profile、.zshrc

你可能见过很多教程让你“把这一行加到 `.bashrc`”。但 `.bashrc` 是什么？为什么有时改了没生效？为什么有的人改 `.zshrc`？

这一篇会把常见 Shell 配置文件讲清楚。

## 配置文件解决什么问题

Shell 配置文件用于在打开 Shell 时自动执行一些设置，例如：

- 设置环境变量。
- 添加命令别名。
- 修改 `PATH`。
- 配置命令提示符。
- 初始化语言工具链。

比如：

```bash
export EDITOR=vim
alias ll="ls -la"
```

如果你每次打开终端都希望这些设置生效，就可以把它们写入配置文件。

## 先确认你使用的 Shell

查看登录 Shell：

```bash
echo $SHELL
```

查看当前命令解释器：

```bash
ps -p $$
```

如果你使用 Bash，常见配置文件是 `.bashrc` 和 `.profile`。如果你使用 Zsh，常见配置文件是 `.zshrc`。

## Bash 常见配置文件

Bash 会根据启动方式读取不同文件。

| 文件 | 常见用途 |
| --- | --- |
| `~/.bashrc` | 交互式非登录 Shell，打开终端时常用 |
| `~/.profile` | 登录 Shell，登录系统时读取 |
| `~/.bash_profile` | Bash 登录配置文件，存在时可能优先于 `.profile` |
| `/etc/bash.bashrc` | 系统级 Bash 配置 |
| `/etc/profile` | 系统级登录配置 |

初学阶段你可以这样处理：

- 用户自己的别名、提示符、常用函数放在 `~/.bashrc`。
- 用户级环境变量和 `PATH` 设置可以放在 `~/.profile` 或 `~/.bashrc`，根据发行版习惯选择。
- 不要随意改 `/etc` 下的系统级配置。

## Zsh 常见配置文件

如果你使用 Zsh，最常修改的是：

```bash
~/.zshrc
```

查看是否存在：

```bash
ls -la ~/.zshrc
```

如果你使用 Oh My Zsh、Prezto 等工具，它们通常也会修改 `.zshrc`。

## 修改配置文件后如何生效

编辑 `.bashrc` 后，可以重新打开终端，也可以运行：

```bash
source ~/.bashrc
```

`source` 的意思是在当前 Shell 中执行这个文件。你也可能看到等价写法：

```bash
. ~/.bashrc
```

如果你修改的是 `.profile`，通常重新登录后生效，也可以手动：

```bash
source ~/.profile
```

## 添加 PATH

`PATH` 决定 Shell 到哪些目录中查找命令。

查看当前 `PATH`：

```bash
echo $PATH
```

假设你有一个 `~/bin` 目录，想把它加入命令搜索路径，可以写：

```bash
export PATH="$HOME/bin:$PATH"
```

加到 `~/.bashrc` 后执行：

```bash
source ~/.bashrc
```

然后检查：

```bash
echo $PATH
```

## 添加别名

别名可以给常用命令起短名字：

```bash
alias ll="ls -la"
alias grep="grep --color=auto"
```

临时别名只在当前终端生效。写入 `.bashrc` 后，每次打开终端都会生效。

查看所有别名：

```bash
alias
```

取消当前 Shell 中的别名：

```bash
unalias ll
```

## 常见错误

### 写错配置导致终端报错

如果打开终端就报错，先用编辑器打开对应配置文件，检查最近添加的内容。

建议修改前先备份：

```bash
cp ~/.bashrc ~/.bashrc.bak
```

恢复：

```bash
cp ~/.bashrc.bak ~/.bashrc
```

### PATH 写错导致命令找不到

如果你把 `PATH` 覆盖成了错误值，可能很多命令都找不到。正确写法通常要保留原值：

```bash
export PATH="$HOME/bin:$PATH"
```

不要写成：

```bash
export PATH="$HOME/bin"
```

除非你非常清楚自己在做什么。

## 小结

你需要记住：

- Bash 常用 `~/.bashrc`，Zsh 常用 `~/.zshrc`。
- 修改配置后可以用 `source` 让它立即生效。
- 设置 `PATH` 时通常要保留原来的 `$PATH`。
- 先备份配置文件，再做较大修改。

Shell 配置文件是个性化 Linux 工作环境的入口，但不要一开始就堆太多复杂配置。先让每一行都可理解。
