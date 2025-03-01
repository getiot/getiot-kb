---
sidebar_position: 13
slug: /git-compress-commits
---

# Git 合并多个提交



我们知道使用 `git merge` 可以将一个分支的更改添加到另一个分支。除了这种方式，我们还可以使用 `git rebase` 命令来完成这个工作。掌握使用 `git rebase` 合并多个提交的技巧，可以让项目的历史提交记录保持干净整洁，这对于大型开源项目尤其重要。



## 交互式 rebase 命令

我们知道，`git rebase` 命令可以将复制当前分支的所有提交，并将它们移动到指定分支上。当你在 feature 分支上工作时，并且 main 分支已经更新，这时候就可以使用 rebase 命令来同步 main 分支。

除此之外，我们还可以通过 `-i` 选项进入 rebase 的交互式界面，对 commit 提交进行修改。例如选择当前提交路径上的前 3 个提交：

```bash
git rebase -i HEAD~3
```

当你想修改正在使用的分支上的某些提交时，交互式 rebase 就非常有用。例如在 push 之前将多个提交合并为一个。



## rebase 操作方法

rebase 交互式命令提供了多种操作方法，下面是常用的几种操作：

| 操作     | 缩写 | 作用                                               |
| -------- | ---- | -------------------------------------------------- |
| `pick`   | `p`  | 保留该提交                                         |
| `reword` | `r`  | 修改提交附带消息                                   |
| `edit`   | `e`  | 修改提交                                           |
| `squash` | `s`  | 将提交合并到上一个提交中                           |
| `fixup`  | `f`  | 将提交合并到上一个提交中，并且不保留提交的日志消息 |
| `exec`   | `x`  | 在我们 rebase 的每一个提交的基础上运行命令         |
| `drop`   | `d`  | 删除提交                                           |

有了这些方法，我们就可以完全控制 git 提交。例如，如果想修改提交信息，就可以使用 `edit`；如果想和并提交，就可以使用 `squash`；如果想删除提交，就可以使用 `drop`。



## 压缩多个提交

下面通过示例演示如何将多个提交压缩为一个提交，以获得更清晰的历史记录。

假设当前活动分支有 3 个待处理的提交，我们使用交互式 rebase 对它们进行控制：

```bash
git rebase -i HEAD~3
```

此时会打开默认文本编辑器，内容如下：

```bash
pick 82974d2 第一次提交
pick 650b25e 第二次提交
pick 9c4aa57 第三次提交

# 变基 b1f2bf8..9c4aa57 到 b1f2bf8（3 个提交）
```

现在，将“第二次提交”的 pick 修改为 squash，表示将该提交合并到上一个提交，即“第一次提交”。以此类推，将“第三次提交”的 pick 修改为 squash。

```bash
pick 82974d2 第一次提交
squash 650b25e 第二次提交
squash 9c4aa57 第三次提交

# 变基 b1f2bf8..9c4aa57 到 b1f2bf8（3 个提交）
```

简单起见，你也可以使用缩写 `s` 替代 squash，因此下面修改是等效的。

```bash
pick 82974d2 第一次提交
s 650b25e 第二次提交
s 9c4aa57 第三次提交

# 变基 b1f2bf8..9c4aa57 到 b1f2bf8（3 个提交）
```

修改完成后保存退出，例如在 Vim 中使用 `:wq` 指令保存并退出。

此时会打开另一个文本编辑器，让你为这次压缩合并填写 commit 信息。

```bash
# 这是一个 3 个提交的组合。
# 这是第一个提交说明：

第一次提交

# 这是提交说明 #2：

第二次提交

# 这是提交说明 #3：

第三次提交
```

这里以 `#` 开始的行将会被忽略，你可以删除它，或者保留也无所谓。删除多余的信息，重新输入提交信息，例如：

```bash
# 这是一个 3 个提交的组合。

合并第一次+第二次+第三次提交
```

注意，如果输入一个空的提交说明将会终止提交。

在 Vim 中再次输入 `:wq` 命令保存并退出。现在，使用 `git log --oneline` 命令，查看当前分支的历史提交记录：

```bash
d8703bf (HEAD -> master) 合并第一次+第二次+第三次提交
b1f2bf8 just test
d118ff2 first commit
```

这样，你已经成功将 3 个提交压缩成 1 个提交啦！



