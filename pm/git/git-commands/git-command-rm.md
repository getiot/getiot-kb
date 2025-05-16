---
sidebar_position: 27
slug: /git-command-rm
---

# git rm 命令

`git rm` 命令用于从 Git 仓库中删除文件，即将文件从工作区和暂存区一起移除。它是一个更安全、更规范的删除方式，相比使用 `rm` 命令删除文件，`git rm` 会自动追踪并记录删除操作，以便后续 [`git commit`](/git/git-command-commit/) 提交生效。

如果你只使用系统命令删除文件，再执行 [`git status`](/git/git-command-status/) 时仍会提示该文件已被删除，但不会自动添加到暂存区，此时还需用 [`git add`](/git/git-command-add/) 确认删除。而 `git rm` 则一步完成。



## 命令语法

```bash
git rm [选项] <文件路径>
```

**常用选项参数**

- `-f, --force`：强制删除，即使文件在工作区中已修改（默认不允许删除已修改文件）。
- `--cached`：只从暂存区中删除文件，不删除工作区文件（即让 Git 不再追踪该文件）。
- `-r`：递归删除目录中的文件，适用于删除整个目录。



## 使用示例

删除单个文件并将删除操作加入暂存区：

```bash
git rm config.txt
```

删除目录及其所有文件：

```bash
git rm -r assets/
```

删除已修改但未提交的文件（需强制）：

```bash
git rm -f main.cpp
```

仅取消追踪文件但保留文件在本地（如 `.env` 文件）：

```bash
git rm --cached .env
```

同时删除多个文件：

```bash
git rm README.md LICENSE.txt
```



## 小贴士

- 如果文件已被系统命令删除，也可以使用 [`git add -u`](/git/git-command-add/) 或 `git rm` 将删除操作纳入暂存区。
- `git rm --cached` 常用于将误添加的敏感文件（如密钥文件）移出版本控制，同时保留本地副本。
- 删除操作也需要配合 [`git commit`](/git/git-command-commit/) 提交后才能真正生效。
- 想恢复被删除的文件，可使用 [`git restore`](/git/git-command-restore/) 或 [`git checkout`](/git/git-command-checkout/) 找回最近一次提交中的版本。
