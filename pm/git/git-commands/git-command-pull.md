---
sidebar_position: 20
slug: /git-command-pull
---

# git pull 命令

`git pull` 命令用于从远程仓库获取最新的提交记录并将其合并到当前分支。它是 [`git fetch`](/git/git-command-fetch/) 和 [`git merge`](/git/git-command-merge/) 的组合命令，意味着你不仅拉取了最新内容，还自动将其合并进本地分支。

你通常会在开始一天的工作前执行 `git pull`，确保你的本地代码是最新的。如果远程有新提交，而你的本地也有修改，可能会出现冲突，此时你需要手动解决冲突后再提交。



## 命令语法

```bash
git pull [<远程仓库名>] [<远程分支名>]
```

**常用选项参数**

- `--rebase`：拉取远程更改后不使用合并，而是使用变基（rebase）方式。
- `--no-rebase`：强制使用合并（默认行为）。
- `--ff-only`：只在可以快进合并时执行，否则会报错。
- `--no-commit`：合并远程更改时不自动提交，允许你修改合并内容后再提交。
- `--verbose`：显示详细拉取信息。
- `--depth <n>`：执行浅拉取，仅获取最近的 n 次提交。



## 使用示例

从默认远程仓库 `origin` 拉取并合并当前分支对应的远程分支内容：

```bash
git pull
```

指定远程仓库和分支进行拉取合并（例如从 `origin` 的 `dev` 分支）：

```bash
git pull origin dev
```

使用 rebase 的方式拉取更新（避免生成额外的合并提交）：

```bash
git pull --rebase
```

只允许快进合并（避免出现合并提交，强制线性历史）：

```bash
git pull --ff-only
```

拉取远程更新，但不自动提交（适合需要人工修改合并结果的场景）：

```bash
git pull --no-commit
```

进行浅层拉取，只获取最近 5 次提交：

```bash
git pull --depth 5
```



## 小贴士

- 如果你希望保持项目提交历史更干净，推荐使用 `git pull --rebase`，它不会创建额外的合并提交。

- `git pull` 前建议先执行 [`git status`](/git/git-command-status/)，确认当前分支是否干净，避免未提交的本地更改干扰合并。

- 若使用 rebase 时出现冲突，你需要解决冲突后执行 [`git rebase --continue`](/git/git-command-rebase/) 来完成整个流程。

- 可以通过配置让所有 `git pull` 默认使用 rebase 模式：

  ```bash
  git config --global pull.rebase true
  ```

