---
sidebar_position: 11
slug: /git-command-config
---

# git config 命令

`git config` 命令用于查看和修改 Git 的配置项。你可以用它来设置用户名、邮箱、编辑器、换行符行为、别名等，确保 Git 按照你的喜好工作。

Git 的配置分为三个级别：

- **系统级**（`--system`）：对系统上所有用户生效，通常需要管理员权限。
- **用户级**（`--global`）：当前用户生效，配置写入 `~/.gitconfig` 文件。
- **项目级**（默认）：当前 Git 仓库有效，配置写入 `.git/config` 文件。

如果没有指定级别，默认操作的是项目级配置。



## 命令语法

```bash
git config [选项] <key> <value>
```

查看配置：

```bash
git config [选项] <key>
```

**常用选项参数**

- `--global`：设置用户级配置。
- `--system`：设置系统级配置。
- `--local`：设置项目级配置（默认）。
- `--list`：列出所有可见的 Git 配置项。
- `--get`：获取指定配置项的值。
- `--unset`：移除指定配置项。
- `--edit`：直接编辑配置文件。
- `--show-origin`：在输出中显示配置来源文件路径。



## 使用示例

设置用户名和邮箱（常用于提交记录）：

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

设置默认文本编辑器（如使用 VS Code）：

```bash
git config --global core.editor "code --wait"
```

为常用命令创建简写别名：

```bash
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.st status
```

查看所有当前有效的 Git 配置项：

```bash
git config --list
```

获取某个具体配置项的值：

```bash
git config user.name
```

取消某个配置项：

```bash
git config --global --unset user.name
```

查看配置来源：

```bash
git config --list --show-origin
```



## 小贴士

- 如果你使用 Git 前没有设置用户名和邮箱，Git 在提交时会提示你配置它们。
- 全局配置写入 `~/.gitconfig`，项目配置写入当前仓库的 `.git/config`，可以直接用文本编辑器修改这些文件。
- 可以使用 `git config --edit` 快速打开配置文件进行手动编辑。
