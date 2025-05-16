---
sidebar_position: 25
slug: /git-command-restore
---

# git restore 命令

`git restore` 命令用于还原工作区或暂存区中的文件内容，是 Git 2.23 中引入的一个新命令，目的是让文件恢复操作更明确、更加安全。它取代了原先使用 [`git checkout`](/git/git-command-checkout/) 命令来撤销更改的方式，使 Git 操作的语义更加清晰。

你可以使用 `git restore` 来撤销未提交的修改，或从暂存区、某次提交中还原文件内容到工作区。

## 命令语法

```bash
git restore [选项] <路径>
```

从暂存区恢复文件到工作区：

```bash
git restore <文件>
```

从某次提交中恢复文件到当前目录：

```bash
git restore --source=<提交ID> <文件>
```

将工作区中的更改撤销为暂存区版本（也就是撤销本地修改）：

```bash
git restore --staged <文件>
```

**常用选项参数**

- `--staged`：将文件从暂存区移除，恢复到工作区修改状态。
- `--source=<提交ID>`：指定要恢复的源版本（提交对象）。
- `--worktree`：恢复工作区的内容（默认行为）。
- `--patch`：交互式选择要还原的内容块。
- `-s`：`--source` 的简写。



## 使用示例

撤销对某个文件的修改（恢复为暂存区的版本）：

```bash
git restore main.js
```

撤销所有文件的修改（不影响未暂存的新文件）：

```bash
git restore .
```

将某个文件从暂存区移除（即“取消暂存”）：

```bash
git restore --staged app.js
```

从某次提交中恢复某个文件内容：

```bash
git restore --source=HEAD~1 index.html
```

交互式恢复文件内容的部分修改：

```bash
git restore --patch style.css
```



## 小贴士

- 如果你想撤销暂存操作，请用 `git restore --staged`，相当于取消 [`git add`](/git/git-command-add/)。
- 如果你修改了某些文件但不想保留，可以直接使用 `git restore <文件>` 撤销修改。
- 想恢复旧版本内容时，可以结合 `--source` 使用，例如 `git restore --source=HEAD^`。
- `git restore` 不会影响已经提交的内容，只用于撤销或还原未提交的更改。
- 与 [`git checkout`](/git/git-command-checkout/) 相比，`git restore` 更明确地用于“还原文件内容”，建议优先使用。

