---
sidebar_position: 29
slug: /git-command-stash
---

# git stash 命令


`git stash` 命令用于临时保存当前工作区和暂存区的修改内容，让你可以先切换到其他分支或执行其他操作，之后再恢复这些修改。

它的作用类似于“临时抽屉”，适合在你还没完成当前修改但又需要切换分支或处理紧急任务时使用。被保存的修改不会被提交，但也不会丢失，而是存放在 Git 的一个栈（stack）中，稍后可选择恢复。



## 命令语法

```bash
git stash [选项]
```

**常用选项参数**

- `save "<message>"`：为 stash 添加说明信息（已过时，但仍被支持）。
- `push [-m "<message>"]`：保存修改并添加说明信息。
- `list`：列出所有 stash。
- `pop`：恢复最近一次 stash 并将其从栈中移除。
- `apply [<stash@{n}>]`：恢复指定 stash，但不会将其删除。
- `drop [<stash@{n}>]`：删除指定 stash。
- `clear`：删除所有 stash。
- `show [-p]`：查看 stash 内容（可加 `-p` 查看具体差异）。



## 使用示例

临时保存当前的修改内容：

```bash
git stash
```

保存当前修改，并添加说明信息（推荐写明 stash 的目的）：

```bash
git stash push -m "修复 bug 前保存当前开发状态"
```

查看所有保存的 stash：

```bash
git stash list
```

恢复最近一次 stash，并将其从列表中移除：

```bash
git stash pop
```

恢复指定 stash，但保留在列表中（适合多次使用）：

```bash
git stash apply stash@{1}
```

删除指定 stash：

```bash
git stash drop stash@{0}
```

清空所有 stash：

```bash
git stash clear
```

查看某个 stash 的改动内容（默认显示最近一次）：

```bash
git stash show -p
```



## 小贴士

- 如果你 stash 的内容包含未跟踪文件或被 `.gitignore` 忽略的文件，可以加上 `-u` 或 `-a` 参数来一并保存它们：

  ```bash
  git stash -u  # 包含未跟踪文件
  git stash -a  # 包含所有文件（包括忽略文件）
  ```

- `git stash` 适用于快速切换分支时暂存未完成的修改，但不要将其当作长期保存方案。

- `git stash pop` 会尝试将修改套用到当前分支上，如有冲突需手动解决。

- 每次 `stash` 都会创建一条记录，可通过 `git stash list` 找到并管理多个保存点。
