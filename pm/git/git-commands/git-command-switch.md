---
sidebar_position: 30
slug: /git-command-switch
---

# git switch 命令

`git switch` 命令用于在 Git 分支之间切换，是 `git checkout` 命令的简化替代，专注于“切换分支”这一用途。该命令在 Git 2.23 中引入，使分支切换操作更清晰、更直观。

使用 `git switch` 可以切换到已有分支，也可以新建并切换到一个分支。相比旧命令 `git checkout`，它的语义更明确，推荐用于日常分支操作。

## 命令语法

```bash
git switch [选项] <分支名>
```

创建并切换到新分支：

```bash
git switch -c <新分支名>
```

从远程分支创建本地分支并切换：

```bash
git switch --track <远程分支名>
```

**常用选项参数**

- `-c <新分支名>`：创建新分支并切换。
- `-C <新分支名>`：强制创建新分支并切换（如果已存在则覆盖）。
- `--track`：创建本地分支并与远程分支建立追踪关系。
- `--detach`：进入“分离 HEAD”状态，切换到某个提交而非分支。



## 使用示例

切换到已有分支 `dev`：

```bash
git switch dev
```

新建分支 `feature/ui` 并切换：

```bash
git switch -c feature/ui
```

强制新建分支 `fix/bug01` 并切换（如果已存在则覆盖）：

```bash
git switch -C fix/bug01
```

从远程分支 `origin/test` 创建本地分支并切换：

```bash
git switch --track origin/test
```

切换到某个提交的分离 HEAD 状态（可以查看该提交，但不在任何分支上）：

```bash
git switch --detach abc123
```



## 小贴士

- `git switch` 无法用于恢复文件内容，若需撤销文件修改，请使用 [`git restore`](/git/git-command-restore/)。
- 相比于 [`git checkout`](/git/git-command-checkout/)，`git switch` 更安全、易懂，推荐用于所有分支相关操作。
- 分离 HEAD 状态下的修改不会自动保存到任何分支上，如有需要请及时创建新分支或提交。

