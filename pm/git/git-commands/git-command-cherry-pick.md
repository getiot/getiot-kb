---
sidebar_position: 7
slug: /git-command-cherry-pick
---

# git cherry-pick 命令



当某个分支中的提交包含了当前活动分支需要更改时，可以使用 `cherry-pick` 命令。cherry-pick 一个提交时，会在活动分支上创建一个新的提交，其中包含了 cherry-pick 提交引入的更改。

假如 dev 分支的 `76d12` 提交在 index.js 文件添加了更改，而 master 分支刚好需要这些更改。但是 master 关心的只是这个提交，并不关心整个 dev 分支。



