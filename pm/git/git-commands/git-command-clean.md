---
sidebar_position: 9
slug: /git-command-clean
---

# git clean 命令

`git clean` 命令用于清理工作区中未被 Git 跟踪的文件和目录（即那些未添加到版本控制中的文件），包括临时文件、构建产物、日志等。它常用于还原一个“干净”的工作目录，特别是在切换分支或准备提交前清理不必要的文件时非常有用。

需要注意的是，`git clean` 默认不会直接删除文件，而是需要加上选项如 `-f` 才会生效，以防误删。



## 命令语法

```bash
git clean [选项] [路径]
```

**常用选项参数**

- `-f, --force`：强制执行清理（必须显式指定，Git 默认不会删除文件）。
- `-n, --dry-run`：试运行，显示将要被删除的文件，但不会实际删除。
- `-d`：包含未跟踪的目录（默认只删除文件）。
- `-x`：删除所有未被 Git 忽略的文件（包括 `.gitignore` 中的文件）。
- `-X`：只删除 `.gitignore` 中忽略的文件。
- `-q, --quiet`：静默模式，不输出删除信息。
- `-e <模式>`：排除指定模式的文件，不清除它们。



## 使用示例

清理所有未被 Git 跟踪的文件（**需加 -f 否则无效**）：

```bash
git clean -f
```

模拟清理操作，查看将会删除哪些文件（安全预览）：

```bash
git clean -n
```

删除未跟踪的文件和目录（比如构建目录 `dist/`、临时缓存 `tmp/` 等）：

```bash
git clean -fd
```

清除所有未跟踪文件 **包括 `.gitignore` 中的文件**（慎用！）：

```bash
git clean -fx
```

仅清除被 `.gitignore` 忽略的文件：

```bash
git clean -fX
```

排除特定文件或目录（保留不清理）：

```bash
git clean -f -e config/
```



## 小贴士

- `git clean -n` 是执行清理前的必备步骤，避免误删重要文件。
- 若你只想回退已修改但未暂存的文件，应使用 [`git restore`](/git/git-command-restore/) 而非 `git clean`。
- `git clean` 不会影响已被 Git 跟踪的文件，它只处理那些从未被 [`git add`](/git/git-command-add/) 过的文件。

