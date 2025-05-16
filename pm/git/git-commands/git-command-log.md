---
sidebar_position: 17
slug: /git-command-log
---

# git log 命令

`git log` 命令用于查看 Git 仓库的提交历史。它是理解项目演变过程的重要工具，可以帮助你追踪每一次提交、提交者、时间、提交说明等信息。

`git log` 的输出默认按时间倒序排列（最近的提交在最前），并支持各种选项自定义显示格式，例如显示某个文件的提交记录、以图形方式展示分支合并情况等。

## 命令语法

```bash
git log [选项] [分支名/提交哈希]
```

**常用选项参数**

- `-n <number>`：限制显示最近的 n 条提交记录。
- `--oneline`：以简洁的一行格式显示提交信息。
- `--graph`：以 ASCII 图形的方式显示分支和合并历史。
- `--decorate`：在提交信息旁标注分支、标签等引用名。
- `--author=<pattern>`：只显示指定作者的提交记录。
- `--since=<date>`：只显示指定时间之后的提交。
- `--until=<date>`：只显示指定时间之前的提交。
- `--grep=<pattern>`：只显示包含指定模式的提交消息。
- `--no-merges`：不显示合并提交。
- `--pretty=<format>`：使用自定义的提交信息显示格式，如 `short`、`full`、`format:"..."`。
- `-p`：显示每次提交中具体的 diff 内容（补丁）。
- `--stat`：显示简略统计信息，包括修改的文件和行数。
- `--follow`：用于跟踪文件改名后的提交历史（需指定文件路径）。
- `--abbrev-commit`：使用短提交哈希值。



## 使用示例

查看默认的提交历史列表：

```bash
git log
```

以一行一条的简洁格式查看提交历史：

```bash
git log --oneline
```

限制显示最近的 5 条提交：

```bash
git log -n 5
```

以图形方式展示提交历史（适合查看分支合并情况）：

```bash
git log --oneline --graph --decorate
```

查看某个作者的提交记录：

```bash
git log --author="Alice"
```

查看某个文件的提交历史（`--` 用来显式分隔选项与路径，防止路径被误认为是选项）：

```bash
git log -- filename.txt
```

查看某个文件改名前后的完整提交历史：

```bash
git log --follow filename.txt
```

查看提交差异内容：

```bash
git log -p
```

查看提交统计信息（显示每次提交中哪些文件被修改了、增加/删除了多少行）：

```bash
git log --stat
```



## 小贴士

- 如果你要查看某个文件的提交历史，**建议在路径前加上 `--`**，例如：

  ```bash
  git log -- README.md
  ```

  虽然你可以直接执行 `git log README.md`，但加上 `--` 可以防止 git 将 `README.md` 误解析为参数或提交哈希，尤其在文件名与参数或引用名（如 `master`、`--help`）冲突时非常重要。

- `--` 是 git 中的通用分隔符，**表示命令选项结束、路径参数开始**。不只是 `git log`，其他命令如 [`git diff`](/git/git-command-diff/)、[`git checkout`](/git/git-command-checkout/) 也推荐使用这个惯例。
