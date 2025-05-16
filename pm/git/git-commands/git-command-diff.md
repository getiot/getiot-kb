---
sidebar_position: 11
slug: /git-command-diff
---

# git diff 命令

`git diff` 命令用于比较 Git 仓库中的不同内容，显示未暂存的更改、已暂存但未提交的更改、不同分支之间的差异，或者任意两个提交之间的差异。

该命令不会修改任何内容，只用于查看代码的差异，是理解和管理代码变更的重要工具。



## 命令语法

```bash
git diff [选项] [<路径>...]
```

也可以比较两个提交：

```bash
git diff [选项] <提交1> <提交2> [--] [<路径>...]
```

**常用选项参数**

- `--cached`：比较暂存区与最新一次提交之间的差异。
- `--staged`：`--cached` 的别名。
- `--name-only`：只显示文件名，而不显示具体内容差异。
- `--name-status`：显示新增、修改、删除的文件状态。
- `--stat`：以统计信息形式显示差异，包括每个文件变更的行数。
- `--color`：强制彩色显示差异结果。
- `--word-diff`：按单词而非行显示差异，更细粒度的对比。
- `--`：用于分隔提交或参数和路径，避免路径被误识别为选项或提交 ID。



## 使用示例

查看工作区与暂存区之间的差异（即哪些修改还没有被 `git add`）：

```bash
git diff
```

查看暂存区与最后一次提交之间的差异（即哪些修改已被 `git add`，但还未 `commit`）：

```bash
git diff --cached
```

只查看变更了哪些文件：

```bash
git diff --name-only
```

显示每个文件修改了多少行（统计信息）：

```bash
git diff --stat
```

比较两个提交之间的差异：

```bash
git diff HEAD~1 HEAD
```

比较当前分支和其他分支之间的差异（例如 `feature` 分支与当前分支的差异）：

```bash
git diff feature
```

比较两个提交之间某个特定文件的差异，使用 `--` 分隔提交和路径：

```bash
git diff commit1 commit2 -- src/main.c
```



## 小贴士

- `git diff` 是调试和代码审查的重要工具，建议在提交代码前使用它来检查修改内容是否符合预期。

- 使用 `git diff --cached` 可以预览即将提交的内容，有助于避免遗漏修改或误提交。

- 如果路径名可能与参数或分支名冲突，建议使用 `--` 显式分隔，例如：

  ```bash
  git diff HEAD -- README.md
  ```

- 如果你只关心改动了哪些文件，可以搭配 `--name-only` 或 `--name-status` 使用，更加清晰。
