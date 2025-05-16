---
sidebar_position: 33
slug: /git-command-tag
---

# git tag 命令

`git tag` 命令用于为 Git 仓库中的某个提交打标签，常用于标记软件的发布版本（如 `v1.0`、`v2.0.1`）。标签本质上是一个指向特定提交的引用，它不会随着提交的变动而改变。

标签分为两种类型：

- **轻量标签（lightweight tag）**：只是某个提交的引用，不含额外信息；
- **附注标签（annotated tag）**：保存了打标签者、时间、备注信息等元数据，推荐用于正式发布。

标签默认只存在于本地，需通过 [`git push`](/git/git-command-push/) 命令手动推送到远程仓库。



## 命令语法

```bash
git tag [选项] [标签名] [提交ID]
```

**常用选项参数**

- `-a <tag>`：创建附注标签。
- `-m "<message>"`：为附注标签添加备注信息。
- `-d <tag>`：删除本地标签。
- `-l [<模式>]`：列出标签，支持通配符过滤。
- `-f`：强制覆盖已存在的标签。
- `-n[N]`：列出标签并显示前 N 行标签信息。
- `--sort=<key>`：按指定方式排序标签（如 `version:refname`）。



## 使用示例

列出所有标签：

```bash
git tag
```

列出所有以 `v1` 开头的标签：

```bash
git tag -l "v1*"
```

为当前提交创建轻量标签：

```bash
git tag v1.0.0
```

为当前提交创建附注标签，并添加备注信息：

```bash
git tag -a v1.0.0 -m "发布版本 v1.0.0"
```

为历史提交创建标签（例如给指定提交 ID 打标签）：

```bash
git tag -a v1.0.1 1a2b3c4d -m "补丁版本 v1.0.1"
```

删除本地标签：

```bash
git tag -d v1.0.0
```

将本地标签推送到远程仓库：

```bash
git push origin v1.0.0
```

一次性推送所有本地标签到远程：

```bash
git push origin --tags
```

删除远程标签：

```bash
git push origin --delete tag v1.0.0
```



## 小贴士

- 标签默认不会随 [`git push`](/git/git-command-push/) 自动同步，记得用 `git push origin <tag>` 或 `--tags` 手动推送。
- 附注标签比轻量标签更推荐用于发布版本，因其包含作者、时间、说明等信息。
- 如果需要修改标签所指向的提交，可先删除原标签再重新创建（使用 `-f` 强制覆盖）。
