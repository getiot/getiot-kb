---
sidebar_position: 29
slug: /git-command-stash
---

# git stash 命令



如果我们在本地工作区作了修改，但还没有提交或者暂存，那么当执行 `git pull` 同步远程仓库时，会出现类似如下的提示：

```bash
更新 3f0ce92..65e1b98
error: 您对下列文件的本地修改将被合并操作覆盖：
	CMakeLists.txt
	demo/demo_online.cpp
	src/common/version.hpp
	src/driver/decoder/decoder.hpp
请在合并前提交或贮藏您的修改。
正在终止
```

这种情况通常出现在多人协同开发中，由于别人修改了文件并且提交到远程仓库，同时你也修改了此文件并且没有 add 和 commit，然后你想在 pull 或 merge 远程仓库时就会出现此提示。

执行 `git status` 命令，查看此时的仓库状态，输出可能如下：

```bash
$ git status
位于分支 master
您的分支落后 'origin/master' 共 5 个提交，并且可以快进。
  （使用 "git pull" 来更新您的本地分支）

尚未暂存以备提交的变更：
  （使用 "git add <文件>..." 更新要提交的内容）
  （使用 "git restore <文件>..." 丢弃工作区的改动）
	修改：     CMakeLists.txt
	修改：     demo/demo_online.cpp
	修改：     src/common/version.hpp
	修改：     src/driver/decoder/decoder.hpp

未跟踪的文件:
  （使用 "git add <文件>..." 以包含要提交的内容）
	CMakeLists.txt.user

修改尚未加入提交（使用 "git add" 和/或 "git commit -a"）
```

如果不想舍弃对本地的修改，就需要在合并前提交或贮藏你的修改。而贮藏修改，就要用到 `git stash` 命令。

操作步骤如下：

- 首先，执行 `git stash`，将本地工作区备份（即放入 Git 存储堆栈中），此时当前工作目录和暂存区是干净的，恢复到上一个提交的状态；
- 然后，使用 `git pull` 或者 `git merge` 命令拉取最新修改；
- 最后，执行 `git stash pop` 取出备份，这个过程自动合并。如果成功，则自动将此备份从暂存区中删除；如果有冲突，则需要手动解决冲突，然后执行 `git stash drop` 从存储堆栈中移除该储藏项。

请注意，执行 `git stash drop` 命令后，储藏项中的更改将无法恢复。如果你仍然需要这些更改，请在删除储藏项之前使用 `git stash apply` 命令或 `git stash pop` 命令将其应用到工作目录。

