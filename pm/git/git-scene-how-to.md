---
sidebar_position: 18
slug: /git-scene-how-to
---

# Git 情景速查



本文汇集一些 Git 常见情境（不常见）的使用方法，例如拉取远程分支并创建本地分支、拉取 pull request 到本地分支、恢复本地误删的文件、如何撤销 add、commit 操作、如何对比版本间的文件差异等等。



## 拉取远程分支并创建本地分支

使用如下 git 命令查看分支情况

```shell
git branch       # 查看本地分支
git branch -r    # 查看所有远程分支
git branch -a    # 查看远程和本地所有分支
```

在输出结果中，前面带 `*` 的是当前分支。

使用 checkout 命令检出分支，并建立的本地分支会和远程分支建立映射关系。

```shell
git checkout -b 本地分支名x origin/远程分支名x
```



## 拉取 pull request 到本地分支

在 GitHub 上做合并检查时，我们需要将远程仓库的 PR 拉取到本地进行 review，命令格式如下：

```bash
git fetch origin pull/PRId/head:LocalBranchName
```

其中，PRId 为该 Pull Request 的序号，LocalBranchName 为拉取到本地后的分支名称，例如：

```bash
git fetch origin pull/1300/head:pr1300
```

当然，这里的远程仓库不一定是 origin，对于大型协作项目，通常可能是 upstream，例如：

```bash
git fetch upstream pull/1300/head:pr1300
```



## 恢复本地误删的文件

通过 git 进行管理的项目，如果在本地编辑的过程中误删了某些文件或者文件夹，可以通过 git 操作来复原。

首先使用 `git status` 查看本地对改动的暂存记录，例如不小心删了工程中的 math 目录。

```shell
$ git status
位于分支 master
尚未暂存以备提交的变更：
  （使用 "git add/rm <文件>..." 更新要提交的内容）
  （使用 "git restore <文件>..." 丢弃工作区的改动）
        删除：     math/CMakeLists.txt
        删除：     math/MathFunctions.c
        删除：     math/MathFunctions.h

修改尚未加入提交（使用 "git add" 和/或 "git commit -a"）
```

由于 math 目录及其文件在之前已经提交了，因此可以通过 checkout 方式找回。

```shell
git checkout math
```

这样可以复原了。



## 如何撤销 add 操作

对于已经 add（暂存）但还没 commit（提交）的操作，可以使用如下命令取消暂存：

```shell
git reset <file>
```

或者取消所有暂存更改：

```shell
git reset
```



## 如何撤销 commit 操作

对于已经 commit 但还没 push 的操作，如果想要保留已经 add 的文件，可以使用如下命令：

```shell
git reset --soft HEAD^
```

这样就会回到 commit 之前 add 之后的状态，这里的 `HEAD^` 是上一个版本的意思，如果要回退到前 n 个，就表示为 `HEAD~n`。

如果不需要保留 add 的文件，可以使用 `--hard` 选项，直接恢复到上一个 commit 结束的样子。

```shell
git reset --hard HEAD^
```

如果想同时撤销 add 和 commit 操作，但想保留工作空间的修改，可以使用 `--mixed` 选项。

```shell
git reset --mixed HEAD^
```

而如果是 commit 之后发现注释写错了，只想修改注释，可以使用下面命令进行修改。

```shell
git commit --amend
```



## 如何更换主分支

1. 备份原来的主分支（例如 master）

   ```shell
   给master分支打一个tag
   ```

2. 设置 GitHub、Gitlab 的主分支属性

   ```shell
   1.settings->repository->Default Branch: 修改defult分支为其他分支
   2.设置Protected Branches为非保护
   ```

3. 删除主分支、推送到远端仓库

   ```shell
   git branch -D master
   git push origin :master
   ```

4. 新建分支，推送到远端仓库

   ```shell
   git checkout -b main
   git push -u origin main
   ```



## 如何查看两个版本之间修改了哪些文件

使用 `git diff` 命令可以查看任意 Git 提交之间的差异，默认会列出具体修改的内容，如果只想查看修改了哪些文件，可以使用 `--stat` 选项。

格式如下：

```bash
git diff hash1 hash2 --stat
```

hash1 和 hash2 可以是想要对比的两个 commit ID，例如：

```bash
git diff 60d7301 7e819b9 --stat
```

或者是两个 tag，例如：

```bash
git diff v0.41.0 v0.33.0 --stat
```

