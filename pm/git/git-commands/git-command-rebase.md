---
sidebar_position: 21
slug: /git-command-rebase
---

# git rebase 命令

`git rebase` 命令用于变基操作，即将当前分支的起点“移动”到指定分支的最新提交之上，重新应用提交。它的目的是让提交历史更加线性、整洁，常用于整理 feature 分支或同步主干更新。

与 [`git merge`](/git/git-command-merge/) 不同，`rebase` 不会创建新的合并提交，而是通过“复制提交”的方式，重写提交历史。



## 命令语法

```bash
git rebase [选项] <目标分支>
```

也可以变基到指定提交：

```bash
git rebase [选项] <提交ID>
```

**常用选项参数**

- `-i, --interactive`：交互式变基，可修改、压缩、重排提交。
- `--onto <新基底>`：将提交移动到指定的基底上，适合复杂操作。
- `--continue`：解决冲突后继续 rebase。
- `--skip`：跳过当前冲突的提交。
- `--abort`：放弃 rebase，回到开始前的状态。
- `--autostash`：自动 stash 工作区修改并在 rebase 后恢复。



## 使用示例

将当前分支变基到 `main` 分支的最新提交上：

```bash
git rebase main
```

交互式变基最近 3 次提交，可修改提交信息、合并提交等：

```bash
git rebase -i HEAD~3
```

将 `feature` 分支基于 `develop` 分支重新应用（用于手动 rebase 到特定提交）：

```bash
git checkout feature
git rebase develop
```

将某个提交范围移动到另一个基底：

```bash
git rebase --onto new-base old-base my-branch
```

rebase 过程中遇到冲突，解决后继续：

```bash
git rebase --continue
```

跳过当前有问题的提交，继续 rebase：

```bash
git rebase --skip
```

中止 rebase 操作，恢复到操作前状态：

```bash
git rebase --abort
```



## 小贴士

- 在变基之前，建议先运行 [`git fetch`](/git/git-command-fetch/) 获取远程最新变更，确保目标分支是最新的。

- `git rebase` 会重写提交历史，不建议在已共享的公共分支（如 `main`）上执行。

- 使用 `git rebase -i` 可以更优雅地整理提交记录，比如合并（squash）多次提交、修改提交说明。

- 若当前工作目录有未提交的更改，可以加上 `--autostash` 参数自动临时保存：

  ```bash
  git rebase main --autostash
  ```
