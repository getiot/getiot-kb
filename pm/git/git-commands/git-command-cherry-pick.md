---
sidebar_position: 7
slug: /git-command-cherry-pick
---

# git cherry-pick 命令

`git cherry-pick` 命令用于将其他分支上的某个提交（或多个提交）“复制”到当前分支。它会把指定的提交应用为新的提交添加到当前分支中，通常用于挑选 bug 修复或特性提交，而不是整个分支的合并。

这个命令在多人协作、补丁迁移或选择性引入改动时非常有用，避免了通过 [`git merge`](/git/git-command-merge/) 或 [`git rebase`](/git/git-command-rebase/) 带来的全部变更。



## 命令语法

```bash
git cherry-pick [选项] <提交ID>...
```

**常用选项参数**

- `-e, --edit`：在应用提交前允许编辑提交信息。
- `-x`：在提交信息中附加原提交 ID，常用于开源协作中标注来源。
- `-n, --no-commit`：应用改动但不自动提交，让你有机会修改。
- `--continue`：在发生冲突并解决后继续 cherry-pick。
- `--skip`：跳过当前 cherry-pick 的提交。
- `--abort`：中止 cherry-pick 操作，回到操作前的状态。



## 使用示例

将某个提交引入到当前分支（以提交 ID 为 `abc123` 为例）：

```bash
git cherry-pick abc123
```

连续挑选多个提交：

```bash
git cherry-pick abc123 def456
```

挑选一个范围内的提交（不包括结束点）：

```bash
git cherry-pick abc123^..def456
```

应用某个提交，但不自动提交（你可以修改文件后再手动 `git commit`）：

```bash
git cherry-pick -n abc123
```

添加原始提交信息（推荐用于保留提交来源信息）：

```bash
git cherry-pick -x abc123
```

应用提交并编辑提交信息：

```bash
git cherry-pick -e abc123
```



## 小贴士

- 如果 cherry-pick 时遇到冲突，可以先手动解决冲突，再运行：

  ```bash
  git cherry-pick --continue
  ```

- 若想放弃本次 cherry-pick（例如冲突太多或选错提交），可以使用：

  ```bash
  git cherry-pick --abort
  ```

- 与 [`git rebase`](/git/git-command-rebase/) 类似，`git cherry-pick` 会更改提交历史。请在公用分支（如 `main`）上谨慎使用。

- 为了获得提交 ID，可以使用 [`git log`](/git/git-command-log/) 或 `git log --oneline` 查看提交历史。
