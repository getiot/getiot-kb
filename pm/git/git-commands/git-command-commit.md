---
sidebar_position: 9
slug: /git-command-commit
---

# git commit 命令

`git commit` 命令用于将暂存区（staging area）中的修改记录提交到本地仓库，形成一次新的提交（commit）。每次提交都应该包含一条清晰的提交说明，方便团队成员了解这次修改的目的和内容。

在实际开发中，`git commit` 是 Git 工作流中非常重要的一步，配合 `git add` 使用，将修改提交到版本历史中。



## 命令语法

```bash
git commit [选项]
```

**常用选项参数**

- `-m <msg>`：直接在命令中写入提交说明。
- `-a`：自动将所有已追踪的文件的修改加入暂存区，然后提交。
- `--amend`：修改上一次提交（可用于更正提交说明或添加漏掉的文件）。
- `--no-edit`：在使用 `--amend` 时，保留上次提交说明，不打开编辑器。
- `--allow-empty`：允许创建一个空提交（即使没有文件变更）。
- `--squash <commit>`：将指定的提交压缩进当前提交，通常用于整理提交历史。
- `--author="<name> <email>"`：指定提交作者信息（用于代他人提交）。



## 使用示例

提交暂存区中的所有内容，并添加提交说明：

```bash
git commit -m "修复登录功能的逻辑错误"
```

将所有已追踪文件的修改自动加入暂存区后提交（不包含新文件）：

```bash
git commit -a -m "更新样式和配置"
```

修改上一次提交（可以用于补充遗漏的文件或更正说明）：

```bash
git add new_file.cpp
git commit --amend
```

创建一个空提交，常用于触发自动化部署等流程：

```bash
git commit --allow-empty -m "触发部署"
```

使用 `--author` 指定提交作者（用于代提交或团队代理）：

```bash
git commit -m "合并 feature 分支" --author="Jane <jane@example.com>"
```

合并多个提交内容（使用 squash 合并）：

```bash
git commit --squash abc1234
```



## 小贴士

你可以使用 [`git log`](/git/git-command-log/) 查看提交历史，确保每次提交的信息都清晰有意义，有助于日后维护。
