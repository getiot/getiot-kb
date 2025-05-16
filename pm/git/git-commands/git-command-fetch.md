---
sidebar_position: 14
slug: /git-command-fetch
---

# git fetch 命令

`git fetch` 命令用于从远程仓库获取最新的更新（分支、标签、提交等），并下载到本地，但不会自动合并到当前工作分支。它是一个“只读”的操作，不会修改你的工作区或本地分支，非常适合在合并或拉取代码前先查看远程变化。

你可以将 `git fetch` 看作是“检查远程仓库有没有更新”的方式，它会将远程分支的最新状态同步到本地的 `origin/分支名` 路径下。



## 命令语法

```bash
git fetch [<远程仓库名>] [<分支名>]
```

**常用选项参数**

- `--all`：从所有远程仓库拉取数据。
- `--prune`：在拉取时自动删除远程仓库中已被删除的分支。
- `--dry-run`：显示将要拉取的内容，但不实际执行。
- `--verbose`：显示详细的执行信息。
- `--tags`：拉取所有远程标签。
- `--depth <n>`：进行浅克隆，只获取最近的 n 次提交，常用于加快速度。



## 使用示例

从默认远程仓库（通常是 origin）获取所有分支和提交：

```bash
git fetch
```

从远程仓库 `origin` 拉取所有分支，并自动清理已删除的远程分支：

```bash
git fetch --prune origin
```

从远程仓库拉取某个特定分支（例如 `dev`）的更新：

```bash
git fetch origin dev
```

从所有远程仓库拉取所有更新：

```bash
git fetch --all
```

获取所有远程标签（不合并）：

```bash
git fetch --tags
```

查看 fetch 将会执行哪些操作，而不实际执行（安全预览）：

```bash
git fetch --dry-run
```

获取远程分支的最新更改后，查看差异：

```bash
git fetch origin
git diff origin/main
```



## 小贴士

- `git fetch` 是查看远程更新的首选命令，不会影响当前分支状态，适合用作团队协作中的“更新前检查”。
- 如果你想获取远程更新并立即合并到当前分支，请使用 [`git pull`](/git/git-command-pull/)，它相当于 `fetch + merge`。
- 执行 [`git branch -r`](/git/git-command-branch/) 可以查看所有远程分支，使用 [`git checkout -b 新分支名 origin/远程分支名`](/git/git-command-checkout/) 可基于远程分支创建本地分支。
