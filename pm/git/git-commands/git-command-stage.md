---
sidebar_position: 30
slug: /git-command-stage
---

# git stage 命令

`git stage` 是 [`git add`](/git/git-command-add/) 命令的一个别名，用于将工作区中的更改添加到暂存区（staging area），准备提交。它的作用和 `git add` 完全相同，只是名字不同，常用于强调“将更改送入暂存区”的概念。

`git stage` 并不是 Git 的默认命令，而是在某些 Git 安装或用户自定义别名中提供的，等价于：

```bash
git add
```



## 命令语法

```bash
git stage [选项] <路径>
```

等价于：

```bash
git add [选项] <路径>
```

**常用选项参数**

因为 `git stage` 实际上就是 `git add`，所以其支持的选项与 `git add` 完全一致：

- `-A` 或 `--all`：添加所有更改（包括新增和删除）。
- `-u`：只添加已跟踪文件的修改和删除。
- `-p`：交互式选择部分修改进行添加（patch 模式）。
- `-i`：进入交互式添加界面（interactive 模式）。
- `-n`：试运行模式，仅列出将要添加的文件。
- `-f`：强制添加被 `.gitignore` 忽略的文件。



## 使用示例

添加单个文件到暂存区：

```bash
git stage main.c
```

添加所有修改：

```bash
git stage .
```

添加所有更改（包括已删除的文件）：

```bash
git stage -A
```

使用 patch 模式逐块选择修改内容：

```bash
git stage -p
```

强制添加被忽略的文件：

```bash
git stage -f debug.log
```



## 小贴士

- 如果你输入 `git stage` 报错，说明当前系统未设置该别名，可以通过以下命令为其设置别名：

  ```bash
  git config --global alias.stage add
  ```

  之后就可以像使用 `git add` 一样使用 `git stage` 了。

- 使用 `git stage -p` 和 `git stage -i` 能帮助你更精细地控制提交内容，避免提交过多不相关改动。
