---
sidebar_position: 29
slug: /git-command-show
---

# git show 命令

`git show` 命令用于显示 Git 对象的详细信息，最常见的用途是查看某个提交（commit）的具体内容，包括提交信息、作者、日期、变更的文件和具体的差异（diff）。它也可以用于查看标签、树（tree）或其他对象的内容。

如果不带参数，`git show` 默认显示最近一次提交的详细信息。



## 命令语法

```bash
git show [选项] <对象>
```

其中 `<对象>` 可以是提交 ID、分支名、标签名，甚至是文件路径。

**常用选项参数**

- `--stat`：显示文件的简要修改统计信息。
- `--patch` 或 `-p`：显示差异补丁（默认行为）。
- `--name-only`：仅列出发生变更的文件名。
- `--name-status`：列出文件名及其变更状态（如新增 A、修改 M、删除 D）。
- `--pretty`：自定义提交信息的显示格式，如 `--pretty=oneline`、`--pretty=short`。
- `--no-patch`：不显示差异内容，仅显示提交信息。
- `<对象>^`、`<对象>~1`：用于指定父提交或提交历史。



## 使用示例

查看最近一次提交的完整信息（包括改动 diff）：

```bash
git show
```

查看某个提交的详情（替换为实际提交 ID）：

```bash
git show 4d5e6a1
```

仅查看改动的文件列表：

```bash
git show --name-only 4d5e6a1
```

查看文件修改状态（新增、删除、修改）：

```bash
git show --name-status 4d5e6a1
```

查看提交信息，不显示 diff 内容：

```bash
git show --no-patch 4d5e6a1
```

使用单行格式显示提交信息：

```bash
git show --pretty=oneline 4d5e6a1
```

查看某个分支最近的提交内容：

```bash
git show dev
```

查看某个标签指向的提交详情：

```bash
git show v1.0.0
```

查看某个文件在某次提交中的修改内容：

```bash
git show 4d5e6a1:README.md
```



## 小贴士

- `git show` 也可用于查看某个文件在某个历史版本中的内容，如 `git show HEAD~2:README.md`。
- 如果只想查看提交信息而不看差异，可以用 `--no-patch` 或结合 [`git log`](/git/git-command-log/) 使用。
- 结合 `--pretty` 和 `--name-status` 选项，可以快速浏览提交简况。
