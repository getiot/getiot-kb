---
sidebar_position: 11
slug: /git-rebase
---

# Git rebase 用法



Git 有一个子命令 `rebase`，它的作用是在另一个分支基础之上重新应用，也就是把一个分支的修改合并到当前分支。



## rebase 命令

`git rebase` 命令将复制当前分支的所有提交，并将它们移动到指定分支上。和 `git merge` 命令最大不同的是，rebase 总是保留当前分支的最新更改，不会尝试寻找哪些文件需要保留，哪些不需要。因此你不需要处理合并冲突，同时也会保持线性的 git 提交历史。

当你在 feature 分支上工作时，并且 main 分支已经更新了，那么使用 rebase 是非常合适的。因为你可以在分支上获取所有更新，防止将来合并时发生冲突。但这里有一个大问题，导致我们通常不想这么处理。因为 `git rebase` 复制提交时会产生新的哈希值，从而影响了项目的提交历史。



## 推荐流程

在不用 `git push -f` 的前提下，想维持树的整洁，方法就是：在 push 之前，先 fetch，再 rebase。

```bash
git fetch origin main
git rebase origin/main
git push
```

在 rebase 之后，需要强制推送到远端分支时，使用 `--force-with-lease` 参数来保证分支安全。

```bash
git push --force-with-lease origin feature
```





