---
sidebar_position: 23
slug: /git-command-reflog
---

# git reflog 命令

`git reflog` 命令用于查看 Git 仓库中 HEAD 及分支引用的历史变动记录。它记录了所有对分支引用（比如切换分支、提交、重置、合并等）所做的更新操作，即使这些操作已经不在提交历史（[`git log`](/git/git-command-log/)）中显示，`git reflog` 仍然能帮你找到之前的状态。

这使得 `git reflog` 成为恢复误删提交、找回丢失分支、或者回退到某个操作之前状态的重要工具。



## 命令语法

```bash
git reflog [选项] [<ref>]
```

如果不指定 `<ref>`，默认显示 `HEAD` 的引用日志。

**常用选项参数**

- `-n <数量>`：限制显示的条目数，比如只显示最近的几条。
- `--date=relative|local|iso`：控制日期显示格式，默认为相对时间。
- `<ref>`：指定查看某个分支或引用的 reflog，比如 `git reflog master`。



## 使用示例

查看当前仓库的 HEAD 最近的引用记录：

```bash
git reflog
```

查看指定分支 `develop` 的引用日志，限制显示最近 5 条：

```bash
git reflog -n 5 develop
```

以本地时间格式显示 reflog：

```bash
git reflog --date=local
```

利用 reflog 找回误删的提交（假设你找到了提交的哈希值 `abc123`）：

```bash
git checkout abc123
```

或者重置当前分支到某次操作前的状态：

```bash
git reset --hard abc123
```



## 小贴士

- `git reflog` 是救命工具，当你误操作导致提交丢失时，第一时间用它查找之前的提交哈希。
- reflog 记录只保存在本地，不会推送到远程仓库。
- 默认情况下，reflog 记录会保存 90 天（可通过配置调整），过期后旧记录会被自动清理。
- 结合 [`git reset`](/git/git-command-reset/) 或 [`git checkout`](/git/git-command-checkout/)，你可以轻松回到之前的任何状态。



