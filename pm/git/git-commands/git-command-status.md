---
sidebar_position: 33
slug: /git-command-status
---

# git status 命令

`git status` 命令用于查看当前 Git 仓库的状态信息。它会显示哪些文件处于修改状态、哪些文件已添加到暂存区、哪些文件未被跟踪（untracked），以及当前分支的合并/提交状态等。

这是使用频率最高的 Git 命令之一，常用于在每次提交前检查变更情况，避免遗漏或误操作。



## 命令语法

```bash
git status [选项]
```

**常用选项参数**

- `-s, --short`：以精简格式显示状态信息（简洁明了，适合脚本处理或查看概览）。
- `-b, --branch`：显示当前分支信息。
- `--ignored`：显示被 `.gitignore` 忽略的文件。
- `--untracked-files[=<mode>]`：控制未跟踪文件的显示方式。可选值：
  - `no`：不显示 untracked 文件；
  - `normal`：默认显示（只显示一层）；
  - `all`：递归显示所有未跟踪文件。
- `--show-stash`：显示当前是否存在存储（stash）记录。



## 使用示例

查看当前工作区的完整状态信息（默认格式）：

```bash
git status
```

以简洁模式显示状态（每个文件状态只显示两个字符）：

```bash
git status -s
# 或
git status --short
```

显示当前分支信息及状态：

```bash
git status -b
# 或
git status --branch
```

同时显示被忽略的文件：

```bash
git status --ignored
```

隐藏未跟踪文件（仅显示已追踪文件的状态）：

```bash
git status --untracked-files=no
```



## 小贴士

- `git status` 是了解当前 Git 仓库状况的首选命令，建议在每次执行 `add`、`commit`、`checkout` 等命令前先运行一次。
- 精简输出模式 `-s` 非常适合在终端中快速查看状态，对自动化脚本也非常友好。
- 想配合 Git 图形工具使用时，先通过 `git status` 了解哪些文件将被提交更为安全。
- 文件前的标记含义（精简模式下）：
  - `A`：新添加到暂存区的文件（Added）
  - `M`：被修改的文件（Modified）
  - `D`：被删除的文件（Deleted）
  - `??`：未被 Git 跟踪的新文件（Untracked）
