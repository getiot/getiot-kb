---
sidebar_position: 26
slug: /git-command-revert
---

# git revert 命令

`git revert` 命令用于撤销某次提交，但它的方式并不是删除历史记录，而是通过生成一个“反向提交”来实现撤销操作。这意味着原有的提交历史依然保留，新生成的提交会对指定的提交进行“反操作”，从而达到撤销的效果。

相比 [`git reset`](/git/git-command-reset/)，`git revert` 更加安全，特别适用于团队协作或已经推送到远程仓库的历史回滚操作。因为它不会改变项目的历史，而是以一次新的提交来反映更改。



## 命令语法

```bash
git revert [选项] <提交ID>
```

**常用选项参数**

- `--no-commit`：只生成反向更改但不立即提交，允许你检查或合并多次 revert 后再一起提交。
- `--edit`：编辑默认提交信息（默认启用）。
- `--no-edit`：直接使用默认提交信息，不打开编辑器。
- `-n, --no-commit`：常用于批量撤销多个提交。
- `--mainline <数字>`：用于撤销合并提交时，必须指定主分支编号（通常是 1 或 2），以避免冲突。



## 使用示例

撤销最近一次提交（HEAD 指向的提交），并生成一个新的“反向”提交：

```bash
git revert HEAD
```

撤销指定的某次提交，例如 ID 为 `a1b2c3d` 的提交：

```bash
git revert a1b2c3d
```

撤销最近两次提交，但不立即提交（适合批量修改后再一次性提交）：

```bash
git revert --no-commit HEAD~1..HEAD
git commit -m "Revert recent changes"
```

撤销一个合并提交（如在 GitHub 上合并了一个 PR），需要使用 `--mainline` 参数：

```bash
git revert -m 1 3f2e1c4
```

其中 `-m 1` 表示主分支为第一个父提交（通常是目标分支）。



## 小贴士

- `git revert` 是一种“非破坏性撤销”，它不会移除历史提交记录，更适合已推送到远程仓库的项目。
- 如果你想彻底删除某次提交，可以使用 [`git reset`](/git/git-command-reset/)，但请注意 reset 会改变历史，慎用于公共分支。
- 使用 [`git log`](/git/git-command-log/) 查找需要撤销的提交 ID。
