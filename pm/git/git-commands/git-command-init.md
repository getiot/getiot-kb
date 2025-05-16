---
sidebar_position: 14
slug: /git-command-init
---

# git init 命令

`git init` 命令用于初始化一个新的 Git 仓库。它会在当前目录下创建一个 `.git` 子目录，作为版本控制的元数据目录，使当前目录成为一个 Git 仓库。

通常在开始一个新项目、将已有目录纳入 Git 管理时，你会使用 `git init` 命令。执行此命令后，就可以开始使用其他 Git 命令（如 [`git add`](/git/git-command-add/)、[`git commit`](/git/git-command-commit/) 等）对项目进行版本控制。



## 命令语法

```bash
git init [选项] [目录]
```

如果不指定目录，默认在当前目录初始化 Git 仓库。

**常用选项参数**

- `--bare`：初始化一个“裸仓库”（bare repository），通常用于作为远程仓库，不包含工作区（工作树）。
- `--quiet` 或 `-q`：静默模式，不输出提示信息。
- `--separate-git-dir=<路径>`：指定 `.git` 目录的位置（将 Git 元数据存储到其他目录）。



## 使用示例

在当前目录初始化一个 Git 仓库：

```bash
git init
```

在指定目录（如 `myproject`）中初始化：

```bash
git init myproject
```

初始化一个裸仓库（适合作为远程仓库）：

```bash
git init --bare repo.git
```

将 Git 元数据存储到指定目录（分离 .git）：

```bash
git init --separate-git-dir=/tmp/gitdata myproject
```



## 小贴士

- `.git` 目录是 Git 仓库的核心，它包含所有版本历史和配置信息，请勿随意删除或修改其中内容。
- 初始化后的仓库不会自动添加远程仓库，如果你需要推送代码到远程，需要使用 [`git remote add`](/git/git-command-remote/) 命令。
- `git init` 不会影响目录中已有的文件，仅会添加 Git 所需的配置目录，因此在已有项目中执行是安全的。
- 如果不小心误初始化了仓库，可以通过删除 `.git` 目录撤销版本控制。

