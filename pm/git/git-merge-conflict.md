---
sidebar_position: 9
slug: /git-merge-conflict
---

# Git 冲突解决

在公司项目开发过程中，在使用 Git 进行多人协作时，你一定有过这样的经历：怎么我的代码无法合并到主分支？这就是“冲突”，在多人协作的代码管理中，合并冲突是不可避免的。别担心，冲突并不意味着糟糕的事情发生了，它只是 Git 无法自动判断该如何合并不同修改时向你发出的提示。只要你理解冲突的原因，并学会正确地解决它，冲突其实并不难应对。



## 什么是 Git 冲突？

Git 冲突（merge conflict）通常发生在以下几种情况：

- 两个人**同时修改了同一个文件的同一位置**，然后尝试合并。
- 你自己在本地修改了某些内容，而远程也发生了不同的修改，拉取时冲突。
- 重写历史（如 rebase）或强推代码时，修改之间不一致。

简而言之：**Git 不知道该保留哪一份修改**，就需要你手动决定。



## 场景1：本地合并冲突

假设你在 `main` 分支上一个 hello.txt 文件，该文件有以下内容：

```bash
Hello World!
```

然后你创建了一个分支 `feature-a`，把 `Hello World!` 改成：

```bash
Hi World!
```

同时，你或你的同事又在 `main` 分支直接把内容改成：

```bash
Hello Git!
```

此时，你想在本地将 `feature-a` 分支合并到 `main` 主分支：

```bash
git checkout feature-a
git merge main
```

结果会出现冲突。Git 会把 `hello.txt` 改成这样：

```bash
<<<<<<< HEAD
Hi World!
=======
Hello Git!
>>>>>>> main
```

这就是一个冲突标记。你需要手动修改成你想要的内容，比如：

```bash
Hello Git World!
```

然后执行以下命令：

```bash
git add hello.txt
git commit
```

这样，冲突就解决啦！



## 场景2：多人直接提交到 `main`

假设你和你的同事同时在 GitHub 上克隆了同一个项目，并都在 `main` 分支上开发。

你先修改了 `README.md` 文件并推送：

```bash
git commit -am "Add intro in README"
git push origin main
```

与此同时，你的同事也修改了同一个 `README.md` 文件，但在你推送之后才尝试推送：

```bash
git commit -am "Add contact info in README"
git push origin main
```

结果会提示：

```bash
! [rejected]        main -> main (non-fast-forward)
error: failed to push some refs to 'https://github.com/xxx/your-repo.git'
```

这时候，你的同事（由于你的提交已经合并了，因此需要后面提交的人解决冲突）需要先拉取最新的 `main` 分支代码：

```bash
git pull origin main
```

如果你们修改了文件的相同区域，就会产生冲突，需手动解决（如场景1介绍），解决后：

```bash
git add README.md
git commit -m "resolve conflict in README"
git push origin main
```

🟡 **建议**：不要直接向 `main` 推送！请创建功能分支（如 `feature-login`），通过 Pull Request 合并。



## 场景3：通过 PR 合并时出现冲突

你和你的同事都基于 `main` 分支新建了分支进行开发：

- 你创建了 `feature-a`
- 同事创建了 `feature-b`

你先提交了 Pull Request 并成功合并进 `main`，而你的同事的 `feature-b` 分支也修改了同一个文件的同一行，但没有及时同步 `main` 的最新内容。

当你的同事提交 PR 时，GitHub 会自动检查合并情况。如果发现有冲突，页面上会提示：

```bash
This branch has conflicts that must be resolved
```

**这种情况该如何解决？**

有两种方式：

✅ **方式一：在线解决冲突（适合简单改动）**

在 GitHub PR 页面中点击“Resolve conflicts”，手动编辑有冲突的文件，保存并提交（会产生新的 commit）。

✅ **方式二：本地拉取合并解决冲突（推荐）**

1. 同事在本地拉取最新的 `main` 并合并到自己的分支：

   ```bash
   git checkout feature-b
   git fetch origin
   git merge origin/main
   # 或使用 rebase 命令：
   # git rebase origin/main
   ```

2. 此时如果出现冲突就要先解决（如场景1介绍），然后再提交并推送：

   ```bash
   git add .
   git commit -m "resolve merge conflict with main"
   git push origin feature-b
   ```

3. 回到 GitHub 页面，冲突已解决，PR 就可以合并了。



## 冲突解决技巧与建议

实际上，除了掌握基础的合并冲突解决流程，更重要的是掌握一些技巧来可以让你更高效地避免和解决冲突。

#### 1. 使用 `git stash` 暂存未提交的改动

使用 `git stash` 临时保存工作进度，避免冲突干扰。当你在某个分支上修改了一些内容，还没提交时需要切换分支或拉取最新代码，而这些内容可能导致冲突。这时候，你可以先用 `git stash` 保存当前的修改：

```bash
git stash
git pull origin main
git stash pop
```

这样，你的本地修改就被临时“隐藏起来”，等更新完代码再恢复，冲突的可能性就更小了。如果 `stash pop` 后仍然冲突，就按前述方式解决即可。



#### 2. 使用 `git rebase` 提前发现冲突

在 PR 合并前先 rebase 主分支，可以提前发现冲突，并在本地解决完毕在提交合并。

```bash
git checkout feature-xxx
git fetch origin
git rebase origin/main
# 出现冲突，解决后：
git add .
git rebase --continue
```

完成后推送：

```bash
git push origin feature-xxx --force
```

⚠️ 注意：使用 `--force` 推送时请确保你在自己的分支操作，避免覆盖别人的工作。

:::tip

相比 `merge`，`rebase` 可以让你的提交历史保持线性，更容易阅读，也可以在本地就解决冲突，避免 PR 阶段出现麻烦。

:::



#### 3. 采用良好的分支协作流程

对于多人协作的项目，建议一定要事先制定良好的分支协作流程，在分支策略上尽量避免多人直接操作 `main` 分支。下面是我们经历过许多痛苦后总结出来的一些建议：

- 所有人都从 `main` 创建功能分支，不直接推送到主分支。
- 所有合并操作都通过 Pull Request 完成，经过 Code Review 后才能合并。
- 定期将主分支变更同步到功能分支（`rebase`）。
- 配置 GitHub 仓库保护规则（Protected Branches），例如：
  - 禁止直接 push 到 `main`
  - 合并 PR 前必须通过 Review
  - 要求所有 PR 分支与 `main` 保持同步（自动检测冲突）

这样不仅能减少冲突，还能提升代码质量。



#### 4. 使用图形化工具辅助解决冲突

如果你不习惯命令行处理冲突，可以使用以下图形化工具辅助：

- **VS Code**：内置合并冲突高亮与选择按钮（Accept Current / Incoming / Both）
- **Sourcetree**：通过图形方式展示冲突，点选式解决
- **GitKraken**：支持直观可视化的 rebase、merge 操作
- **git mergetool**：启动外部合并工具（如 Beyond Compare、Meld）



## 小结

Git 冲突是协作开发中常见的问题，但并不复杂。只要你理解冲突的本质，掌握基本的处理方式，再结合一些进阶技巧（如 `stash`、`rebase`、图形工具），就可以从容应对各种冲突场景。

记住：**冲突不是麻烦，而是团队协作中的一种信号** —— 它提醒你及时沟通、优化流程、提高协同效率。
