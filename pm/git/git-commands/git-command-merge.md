---
sidebar_position: 17
slug: /git-command-merge
---

# git merge 命令

`git merge` 命令用于将另一个分支的内容合并到当前分支中。它是 Git 中实现多分支开发与集成的核心命令之一。合并操作会保留分支的历史，并将它们汇聚在一起形成一个新的提交。

常见的使用场景包括：将开发分支合并到主分支（如 `main`）、合并 bug 修复分支、在功能开发完成后合并回主线等。

如果两个分支对同一文件的同一部分进行了修改，`git merge` 会产生冲突，需手动解决后再完成合并。



## 命令语法

```bash
git merge <分支名>
```

**常用选项参数**

- `--no-ff`：禁止快进合并，始终创建一个新的合并提交，保留分支历史。
- `--ff`：允许快进合并（默认行为），若当前分支是目标分支的祖先则快进合并。
- `--squash`：将所有提交压缩成一个提交合并进来，不会自动创建合并提交。
- `--abort`：中止正在进行的合并过程，并还原到合并前的状态。
- `--continue`：在解决冲突后继续完成合并操作。
- `--no-commit`：合并后不立即创建提交，让你有机会先修改内容。
- `--edit`：允许在创建合并提交时修改默认提交信息。



## 使用示例

将分支 `dev` 合并到当前分支（通常是 `main`）：

```bash
git merge dev
```

强制保留分支记录，即使可以快进合并也创建一个新的合并提交：

```bash
git merge --no-ff dev
```

将分支的多个提交压缩成一个提交后合并（适合整理历史）：

```bash
git merge --squash dev
```

在合并发生冲突后中止操作并恢复到合并前的状态：

```bash
git merge --abort
```

在解决冲突后继续合并流程：

```bash
git merge --continue
```

合并但暂不提交（你可以在手动检查后再运行 `git commit`）：

```bash
git merge --no-commit dev
```



## 小贴士

- 使用 [`git status`](/git/git-command-status/) 可以查看当前是否处于合并状态，以及冲突文件列表。
- 合并前可以使用 [`git fetch`](/git/git-command-fetch/) 和 [`git pull`](/git/git-command-pull/) 获取远程分支最新状态。
- 合并过程中的冲突文件会被标记为冲突状态，需要手动修改后使用 [`git add`](/git/git-command-add/) 标记已解决。

