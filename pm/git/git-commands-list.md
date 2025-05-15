---
sidebar_position: 31
slug: /git-commands-list
---

# Git 命令大全

Git 是目前最流行的分布式版本控制系统，广泛应用于软件开发、项目管理等领域。通过 Git，开发者可以轻松地管理代码版本，协作开发，提高工作效率。在我过去的工作经历中，我发现许多同事对 Git 的理解和操作经验非常欠缺，因此我整理了日常开发中常用的 Git 命令，并按照功能类别进行了归类，方便大家快速查找和学习。无论你是 Git 新手，还是有一定经验的开发者，都能从中获得实用的帮助。



## Git 仓库初始化与配置

```bash
# 初始化本地git仓库（创建新仓库）
git init

# 配置用户名（全局配置）
git config --global user.name "xxx"

# 配置邮箱（全局配置）
git config --global user.email "xxx@xxx.com"

# 启用 Git 命令行颜色高亮，便于区分信息
git config --global color.ui true
git config --global color.status auto
git config --global color.diff auto
git config --global color.branch auto
git config --global color.interactive auto

# 移除 Git 代理配置
git config --global --unset http.proxy
```



## 远程仓库操作

```bash
# 克隆远程仓库
git clone git@github.com:getiot/getiot-kb.git

# 添加远程仓库地址，方便 push/pull/fetch
git remote add origin git@github.com:getiot/getiot-kb.git

# 查看所有远程分支
git branch -r

# 拉取远程分支并合并到当前分支（相当于 fetch + merge）
git pull origin master

# 只拉取远程分支最新更新（不自动合并）
git fetch

# 拉取远程分支更新并删除远程已删除的分支
git fetch --prune

# 将当前分支 push 到远程分支
git push origin master

# 删除远程分支
git push origin :hotfixes/BJVEP933

# 推送所有标签到远程仓库
git push --tags
```



## 查看仓库状态与日志

```bash
# 查看当前工作区和暂存区状态
git status

# 查看提交日志（默认按时间倒序）
git log

# 查看最近1条提交日志
git log -1

# 查看最近5条提交日志
git log -5

# 显示提交日志以及每次提交影响的文件及行数统计
git log --stat

# 显示每次提交具体的代码差异（补丁）
git log -p -m

# 以图形化方式展示提交日志
git log --pretty=format:'%h %s' --graph

# 查看某个具体提交的详细内容（完整commit id或简写）
git show dfb02e6e4f2f7b573337763e5c0013802e392818
git show dfb02

# 查看当前 HEAD 的提交
git show HEAD

# 查看 HEAD 的上一个版本提交，多个父提交用 ^ 标记（例如 ^2、^5）
git show HEAD^

# 显示所有标签
git tag

# 查看某个标签的提交详情
git show v2.0

# 查看某标签的提交日志
git log v2.0

# 显示提交历史对应的文件修改（类似 log + diff）
git whatchanged

# 显示所有提交记录，包括孤立提交
git reflog

# 查看某个时间点的分支状态，比如 HEAD 5 次之前或昨天的 master 状态
git show HEAD@{5}
git show master@{yesterday}

# 列出 git index 中包含的文件
git ls-files

# 显示当前分支历史的图示
git show-branch

# 显示所有分支的历史图示
git show-branch --all

# 查看 Git 对象树（内部命令）
git ls-tree HEAD

# 将 ref（分支、标签等）解析为 SHA1 值（内部命令）
git rev-parse v2.0

# 格式化显示某个提交（简洁原始格式）
git show -s --pretty=raw 2be7fcb476
```



## 文件操作（添加、删除、重命名）

```bash
# 添加文件到暂存区（index）
git add filename

# 添加当前目录下所有已修改文件到暂存区
git add .

# 撤销暂存（从暂存区移除但不丢弃修改）
git restore --staged filename

# 清除工作目录中的更改（慎用）
git restore filename

# 删除暂存区和工作区的文件
git rm xxx

# 递归删除目录及其下所有文件
git rm -r *

# 重命名文件
git mv README README2
```



## 提交操作

```bash
# 提交暂存区的内容到本地仓库，附带提交说明
git commit -m 'xxx'

# 将上一次提交修改的内容进行修改（修正上一次提交信息或内容）
git commit --amend -m 'xxx'

# 将所有修改过的文件自动添加并提交（相当于 git add + git commit）
git commit -am 'xxx'
```



## 分支管理

```bash
# 查看本地所有分支
git branch

# 查看包含某提交的所有分支
git branch --contains 50089

# 查看所有分支（本地 + 远程）
git branch -a

# 显示所有远程分支
git branch -r

# 显示所有已经合并到当前分支的分支
git branch --merged

# 显示所有未合并到当前分支的分支
git branch --no-merged

# 重命名本地分支
git branch -m master master_copy

# 删除本地分支（安全删除，分支合并后可用）
git branch -d hotfixes/BJVEP933

# 强制删除本地分支（无论是否合并）
git branch -D hotfixes/BJVEP933

# 新建并切换到新分支
git checkout -b master_copy

# 新建分支并基于远程分支创建跟踪关系，同时切换过去
git checkout -b devel origin/develop

# 切换到已存在的分支
git checkout features/performance

# 检出远程分支并创建本地跟踪分支
git checkout --track hotfixes/BJVEP933

# 检出某个标签（版本）
git checkout v2.0

# 检出指定文件，恢复到 HEAD 版本（用于撤销工作区修改）
git checkout -- README
```



## 合并与变基

```bash
# 合并远程分支到当前分支
git merge origin/master

# 合并指定提交的修改（Cherry-pick）
git cherry-pick ff44785404a8e

# 变基操作，将当前分支的提交变基到另一分支（常用于整理提交历史）
git rebase
```



## 差异对比（diff）

```bash
# 查看工作区和暂存区之间的差异（未暂存的修改）
git diff

# 查看暂存区和最新提交之间的差异（已暂存但未提交的修改）
git diff --cached

# 比较当前版本与上一个版本的差异
git diff HEAD^

# 比较 HEAD 版本和工作区中 lib 目录的差异
git diff HEAD -- ./lib

# 比较远程分支 origin/master 和本地分支 master 的差异
git diff origin/master..master

# 仅显示差异文件列表，不显示具体内容
git diff origin/master..master --stat
```



## 标签管理

```bash
# 添加带注释的标签
git tag -a v2.0 -m '说明文字'

# 推送标签到远程仓库
git push origin v2.0

# 推送所有标签到远程仓库
git push --tags

# 查看标签
git tag

# 删除本地标签
git tag -d v2.0

# 删除远程标签
git push origin :refs/tags/v2.0
```



## 撤销操作

```bash
# 撤销某个提交（通过新增一个反向提交）
git revert dfb02e6e4f2f7b573337763e5c0013802e392818

# 重置当前分支到指定提交状态，通常用于回退合并失败等
git reset --hard HEAD
```



## 暂存操作（stash）

```bash
# 将当前修改暂存起来，恢复工作区到最新提交状态
git stash

# 查看所有暂存列表
git stash list

# 查看某次暂存的详细内容
git stash show -p stash@{0}

# 应用某次暂存的修改（不会自动删除stash）
git stash apply stash@{0}
```



## 搜索与查询

```bash
# 在仓库文件中搜索包含指定字符串的行
git grep "delete from"

# 使用复杂表达式搜索，例如同时满足两个正则表达式
git grep -e '#define' --and -e SORT_DIRENT
```



## 垃圾回收与检查

```bash
# 清理无用对象，优化仓库
git gc

# 检查仓库对象是否完整，有无损坏
git fsck
```



## 其它常用补充命令

```bash
# 查看当前仓库引用历史（如分支切换、commit等）记录
git reflog
```



