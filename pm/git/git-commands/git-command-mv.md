---
sidebar_position: 19
slug: /git-command-mv
---

# git mv 命令

`git mv` 命令用于在 Git 仓库中重命名或移动文件。它相当于先执行 `mv`（移动或改名）系统命令，再执行一次 [`git add`](/git/git-command-add/) 添加新路径，同时 [`git rm`](/git/git-command-rm/) 移除旧路径，简化了多步骤操作。

这种方式可确保 Git 正确追踪文件的移动或重命名，有助于后续查看历史记录和变更差异。



## 命令语法

```bash
git mv <旧路径> <新路径>
```

**常用选项参数**

- `-f, --force`：强制执行重命名/移动操作，即使目标文件已存在。
- `-k`：保留已存在的目标文件，跳过发生冲突的文件而不中断整个命令。
- `-n, --dry-run`：预览操作但不真正执行，用于查看将发生的文件变动。
- `-v, --verbose`：显示详细操作过程。



## 使用示例

将文件重命名：

```bash
git mv old-name.txt new-name.txt
```

将文件移动到子目录下：

```bash
git mv app.js src/app.js
```

重命名并移动目录中的文件：

```bash
git mv src/utils.js lib/utils.js
```

重命名多个文件（可结合 Shell 批量处理）：

```bash
git mv README README.md
git mv index index.html
```

使用 `-f` 强制覆盖目标路径已有文件：

```bash
git mv -f config.example.js config.js
```



## 小贴士

- 使用 `git mv` 而不是系统命令 `mv` 可以确保 Git 自动追踪到移动或重命名的操作。
- 如果使用系统 `mv` 命令后再执行 [`git status`](/git/git-command-status/)，你仍需手动用 [`git add`](/git/git-command-add/) 和 [`git rm`](/git/git-command-rm/) 来告诉 Git 文件的移动操作。
- Git 会尝试基于内容自动检测文件的重命名，但明确使用 `git mv` 更有助于保持历史记录清晰。
- 移动或重命名后仍需执行 [`git commit`](/git/git-command-commit/) 才会生效。
