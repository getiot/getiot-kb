---
sidebar_position: 4
slug: /git-command-branch
---

# git branch 命令

`git branch` 命令用于管理 Git 分支。你可以使用它列出本地或远程分支、新建分支、删除分支、重命名分支，甚至查看某个分支的详细信息。

分支是 Git 的核心功能之一，它允许你在不影响主线（如 `main`）的前提下进行实验开发或新功能开发。当你完成某项工作后，可以将分支合并回主分支，从而实现灵活的版本控制。



## 命令语法

```bash
git branch [选项]
git branch [选项] <分支名>
```

**常用选项**

- `-d`：删除指定分支，前提是它已被合并。
- `-D`：强制删除，即使未合并也能删除。
- `-m`：重命名当前分支或其他指定分支。
- `-v`：显示每个分支的最后一次提交信息。
- `--merged`：查看已经被合并到当前分支的分支。
- `--no-merged`：查看尚未合并的分支。



## 使用示例

列出本地所有分支，并标出当前所在分支：

```bash
git branch
```

列出远程分支：

```bash
git branch -r
```

列出所有分支（本地 + 远程）：

```bash
git branch -a
```

创建一个名为 `feature/login` 的新分支（但不会自动切换过去）：

```bash
git branch feature/login
```

基于当前分支创建新分支并立即切换（推荐搭配 `git checkout -b` 使用）：

```bash
git checkout -b feature/login
```

重命名当前分支为 `main`：

```bash
git branch -m main
```

将 `dev` 分支重命名为 `develop`：

```bash
git branch -m dev develop
```

删除已经合并的 `feature/ui` 分支（安全删除，分支必须已合并）：

```bash
git branch -d feature/ui
```

强制删除一个未合并的分支（强制删除，分支是否合并不做检查）：

```bash
git branch -D test/temp
```

查看所有已合并到当前分支的其他分支：

```bash
git branch --merged
```

查看还未合并的分支（通常用于判断是否可以删除某分支）：

```bash
git branch --no-merged
```



## 小贴士

- `git branch` 只是**管理分支**，切换分支请使用 [`git checkout`](/git/git-command-checkout/) 或 [`git switch`](/git/git-command-switch/)。
- 不要在主分支上直接开发新功能，推荐先创建独立分支后再开发。
- 删除分支前可以用 `git branch --merged` 确保它已经被合并，避免丢失工作。
