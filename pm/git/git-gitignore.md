---
sidebar_position: 22
slug: /git-gitignore
---

# Git 忽略文件

在 Git 版本管理系统中，可以通过 `.gitignore` 文件告诉 Git 要忽略项目中的哪些文件或文件夹。`.gitignore` 是一个文本文件，前面的 `.` 表示该文件为隐藏文件，默认情况下不可见。

本地 `.gitignore` 文件通常被放置在项目的根目录中。你还可以创建一个全局 `.gitignore` 文件，该文件中的所有条目都会在你所有的 Git 仓库中被忽略。

要创建本地 `.gitignore` 文件，请创建一个文本文件，并将其命名为 `.gitignore`（请记住在开头包含 `.`）。 然后根据需要编辑该文件。在每一行列出你希望 Git 忽略的文件或文件夹。

该文件中的条目也可以遵循匹配模式。

- `*` 用作通配符匹配
- `/` 用于忽略相对于 `.gitignore` 文件的路径名
- `#` 用于将注释添加到 `.gitignore` 文件

下面是一个 `.gitignore` 文件的示例：

```bash
# Ignore Mac system files
.DS_store

# Ignore node_modules folder
node_modules

# Ignore VSCode folder
.vscode

# Ignore all text files
*.txt

# Ignore files related to API keys
.env

# Ignore SASS config files
.sass-cache

# Ignore hello folder exclude one file
hello/*
!hello/readme.txt
```

要添加或更改全局 `.gitignore` 文件，请运行以下命令：

```bash
git config --global core.excludesfile ~/.gitignore_global
```


