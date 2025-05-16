---
sidebar_position: 25
slug: /git-command-reset
---

# git reset 命令

`git reset` 命令用于将当前分支的指针（HEAD）重置到指定的提交，同时可以根据不同的参数选择是否影响暂存区和工作区。

这是 Git 中非常强大也非常“危险”的命令之一，常用于撤销提交、修改历史、取消暂存等操作。根据使用方式不同，它既可以只改变 HEAD 的指向，也可以连带修改暂存区或工作区的内容。



## 命令语法

```bash
git reset [选项] [<提交ID>]
```

常见用法包括：

```
git reset HEAD~1
git reset --hard <提交ID>
git reset --soft HEAD^
```

**常用选项参数**

- `--soft`：重置 HEAD 到指定提交，但保留暂存区和工作区的更改。
- `--mixed`（默认）：重置 HEAD 和暂存区，保留工作区的更改。
- `--hard`：彻底重置 HEAD、暂存区和工作区（慎用！会丢弃所有未保存的更改）。
- `--merge`：在保留合并冲突的情况下重置。
- `--keep`：保留当前工作区中未提交的更改（如果不会引起冲突）。



## 使用示例

撤销暂存，将文件从暂存区移除（保留工作区修改）：

```bash
git reset HEAD index.html
```

回退一次提交，但保留修改（即撤销 commit，只是还没提交）：

```bash
git reset --soft HEAD~1
```

回退一次提交，撤销提交并取消暂存（但保留工作区文件）：

```bash
git reset --mixed HEAD~1
```

彻底回退一次提交，清除所有更改（包括工作区，危险操作！）：

```bash
git reset --hard HEAD~1
```

仅重置某个文件的暂存状态，不影响其它文件：

```bash
git reset HEAD main.js
```



## 理解 HEAD 指针

在 Git 中，`HEAD` 是一个指针，表示你当前所在分支的最新提交。可以理解为「你当前所处的位置」。

例如：

- `HEAD`：当前分支的最新提交（当前指针位置）。
- `HEAD~1`：当前提交的上一个提交（也就是父提交）。
- `HEAD~2`：当前提交的上上个提交，以此类推。

这些语法都可以替代具体的提交 ID（也称为哈希值，如 `5f1d3b2`）来引用提交。你可以通过 [`git log`](/git/git-command-log/) 查看这些提交的 ID 和历史记录。

举个例子：

```bash
git reset --soft HEAD~2
```

这条命令表示：将当前分支回退到当前提交的“上上次提交”，保留修改内容。

等价于：

```bash
git reset --soft <提交ID>
```

其中 `<提交ID>` 是 `HEAD~2` 所对应的那一条提交的哈希值。



## 小贴士

- `git reset` 是撤销提交和取消暂存的常用工具，但使用 `--hard` 时请务必小心，最好在重置前用 [`git status`](/git/git-command-status/) 或 [`git log`](/git/git-command-log/) 检查状态。
- `git reset` 和 [`git checkout`](/git/git-command-checkout/) / [`git restore`](/git/git-command-restore/) 的区别在于：`reset` 修改的是提交历史或暂存区指针，而 `checkout/restore` 更偏向于还原文件内容。
- 如果你误用了 `git reset --hard`，可以尝试使用 [`git reflog`](/git/git-command-reflog/) 找回被删除的提交。
- `HEAD~1` 通常用于回退最近一次提交，非常适合搭配 `git reset` 使用。

