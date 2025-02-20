---
sidebar_position: 12
slug: /git-rollback
---

# Git 版本回退



在实际开发中，有时候我们可能需要将项目版本回退到某个版本，例如发现某些提交存在 Bug 等情况。在 Git 版本管理系统中，当然支持版本的回退（回滚），而且是相对比较简单、方便的操作。

本文将演示在 Git 仓库中，如何使用 reset 和 revert 命令回退到某个版本（提交），并且让远程分支也回退到历史版本。



## 使用 git reset 命令

首先克隆一个 HelloRepo 仓库：

```bash
git clone https://github.com/luhuadong/HelloRepo.git
```

查看该仓库的历史版本信息：

```bash
git log --pretty=oneline
```

先把本地的分支回退到历史版本（例如上一个提交版本）：

```bash
git reset --hard HEAD^
```

提示：上一个版本就是 `HEAD^`，上上一个版本就是 `HEAD^^`，当然往上 100 个版本写 100 个 `^` 比较容易数不过来，所以写成 `HEAD~100`。

把当前分支推送到远程仓库，并且让远程仓库和当前分支保持一致：

```bash
git push -f origin master
```

现在，你已经完成了一次 Git 版本回退，并让本地分支和远程分支都回滚到上一个历史版本。



## 使用 git revert 命令

先把本地的分支恢复到历史版本（例如上一个提交版本）：

```bash
git revert HEAD^
```

或者恢复到某个 commit（例如 b691045）：

```bash
git revert b691045
```

执行该命令后，并不会对已经提交的代码产生影响，而是叠加一个 `Revert "xxx"` 描述的提交。

把当前分支推送到远程仓库，并且让远程仓库和当前分支保持一致：

```bash
git push origin master
```

现在，你已经完成了一次 Git 版本回退，并让本地分支和远程分支都回滚到上一个历史版本。



## reset 和 revert 区别

- 重设（reset）被设计为重新设置本地更改，支持 --mixed、--soft、--hard 三种方式。
- 撤销（revert）被设计为撤销公开的提交（比如已经 push）的安全方式，本质是用某次 commit 时的代码再做一次 commit 提交，所以 git revert 不会对已经提交的代码产生影响。 



