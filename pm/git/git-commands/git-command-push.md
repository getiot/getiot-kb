---
sidebar_position: 21
slug: /git-command-push
---

# git push 命令

`git push` 命令用于将本地分支的提交记录推送到远程仓库。它是本地和远程仓库同步的关键命令，通常用于将你本地的工作成果分享给团队中的其他人。

你可以选择将当前分支、指定分支、标签，甚至是所有分支推送到远程。首次推送新分支时，需要指定远程名称和分支名；常用远程名为 `origin`。



## 命令语法

```bash
git push [选项] [远程名称] [本地分支]:[远程分支]
```

**常用选项参数**

- `-u, --set-upstream`：将本地分支与远程分支建立追踪关系（首次推送新分支时常用）。
- `--force` 或 `-f`：强制推送，会覆盖远程分支历史，**谨慎使用**。
- `--force-with-lease`：更安全的强推方式，避免误覆盖他人提交。
- `--tags`：推送所有本地标签到远程。
- `--delete`：从远程仓库删除指定分支或标签。
- `--all`：推送所有本地分支到远程。



## 使用示例

将当前分支推送到远程仓库（如果当前分支已设置 upstream）：

```bash
git push
```

将 `main` 分支推送到远程 `origin`：

```bash
git push origin main
```

首次推送新分支并设置 upstream（关联本地和远程分支）：

```bash
git push -u origin dev
```

强制推送 `main` 分支（可能会覆盖远程历史）：

```bash
git push --force origin main
```

更安全的强推，只有当远程分支没有变化时才推送成功：

```bash
git push --force-with-lease origin main
```

推送本地所有标签到远程：

```bash
git push --tags
```

删除远程的 `dev` 分支：

```bash
git push origin --delete dev
```

推送所有本地分支到远程：

```bash
git push --all origin
```



## 小贴士

- 常见错误提示 `rejected` 多与分支历史冲突有关，可通过 `--force-with-lease` 或拉取后再推送解决。
- 如果你使用 GitHub 并设置了保护分支（如 `main`），普通用户将无法使用 `--force` 强推。
- `git push` 只会推送被追踪的分支，若你新建了本地分支，记得使用 `-u` 绑定远程。
- 删除远程标签的方式：`git push origin --delete <tag>`（与删除分支类似）。
