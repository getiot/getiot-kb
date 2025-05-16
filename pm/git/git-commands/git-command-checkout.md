---
sidebar_position: 6
slug: /git-command-checkout
---

# git checkout 命令

`git checkout` 命令用于切换分支或恢复工作区的文件内容。在旧版本 Git 中，它是一个多用途命令，既可以切换分支，也可以检出特定版本的文件。但从 Git 2.23 起，官方推荐将其功能拆分为更明确的命令：[`git switch`](/git/git-command-switch/)（用于切换分支）和 [`git restore`](/git/git-command-restore/)（用于恢复文件），不过 `git checkout` 仍然是完全有效的命令。



## 命令语法

```bash
git checkout [选项] <分支名>
```

切换到某个提交的指定文件内容：

```bash
git checkout [提交或分支] -- <路径>
```

**常用选项参数**

- `-b <新分支名>`：在切换分支前创建一个新分支。
- `--track`：与远程分支建立追踪关系。
- `--`：分隔路径和提交名，避免混淆。



## 使用示例

切换到已有分支 `dev`：

```bash
git checkout dev
```

新建并切换到分支 `feature/login`：

```bash
git checkout -b feature/login
```

切换到上一个分支：

```bash
git checkout -
```

恢复 `README.md` 文件到最新提交版本（撤销对该文件的修改）：

```bash
git checkout -- README.md
```

恢复某个提交时的某个文件版本（不切换分支，仅替换文件内容）：

```bash
git checkout abc123 -- src/config.js
```

将远程分支 `origin/dev` 检出为本地分支 `dev` 并建立追踪关系：

```bash
git checkout --track origin/dev
```



## 小贴士

- 从 Git 2.23 起，如果你只是切换分支，可以使用 [`git switch`](/git/git-command-switch/)；如果只是恢复文件，可以使用 [`git restore`](/git/git-command-restore/)。但 `git checkout` 依然是常用的经典命令。

- 使用 `git checkout -- <文件>` 可以撤销对文件的修改，但无法恢复删除文件的操作。如果文件被删除了，可使用 `git restore` 更方便地还原。

- 如果路径名可能与分支或提交 ID 冲突，请使用 `--` 显式分隔，例如：

  ```bash
  git checkout main -- README.md
  ```
