---
sidebar_position: 10
slug: /git-push
---

# Git push 命令



## 推送本地分支

在 Git 版本管理系统中，可以使用 `git push` 命令将本地分支推送到远程仓库。

命令形式如下：

```shell
git push <remote> <branch>
```

其中 remote 参数指定要推送到哪个目标远程仓库，branch 参数指定要推送的分支。默认情况下，Git 会选择 `origin` 作为远程仓库，选择「当前分支」作为要推送的分支。

例如，当前分支为 `main`，那么 `git push` 命令将提供两个默认参数，也就等效于下面一行命令。

```shell
git push origin main
```



## 强制推送分支

通常，你推送一个分支，并添加到其提交历史记录。

但是，有时你需要强行覆盖分支的历史记录。

你这么做的原因可能有几个。

- 第一个原因是要纠正一个错误——尽管最好做一个新的提交来[还原更改](https://git-scm.com/docs/git-revert)。
- 第二种（也是更常见的情况）是在执行诸如 **[rebase](https://www.atlassian.com/git/tutorials/rewriting-history/git-rebase)** 之类的操作之后——该操作会更改提交历史记录：



