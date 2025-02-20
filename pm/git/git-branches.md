---
sidebar_position: 8
slug: /git-branches
---

# Git 分支管理



## 查看分支

查看本地 Git 仓库分支情况：

```bash
git branch
```

查看所有分支：

```bash
git branch -a
```

查看所有远程分支：

```bash
git branch -r
```



## 切换分支

```bash
git checkout [分支名称]
```



## 创建分支

### 创建一个新的本地分支

可以使用 branch 命令在本地创建新的分支：

```bash
git branch [分支名称]
```

使用 checkout 命令加 -b 选项可以创建分支，并切换到该分支：

```bash
git checkout -b [分支名称]
```



### 拉取远程分支并创建本地分支

```bash
git checkout -b [本地分支名称] [origin/远程分支名称]
```

使用该方式会在本地新建一个分支，并自动切换到该本地分支。采用此种方法建立的本地分支会和远程分支建立映射关系。（注意：远程仓库不一定是 origin）

另一种方法是使用 fetch 命令，如：

```bash
git fetch origin 远程分支名x:本地分支名x
```

使用该方式会在本地新建一个分支，但是不会自动切换到该本地分支，需要手动 checkout 一下。采用此种方法建立的本地分支不会和远程分支建立映射关系。



### 创建一个空的分支

在 Git 中创建分支，是必须有一个父节点的，也就是说必须在已有的分支上来创建新的分支，如果工程已经进行了一段时间，这个时候是无法创建空分支的。但是有时候就是需要创建一个空白的分支。

使用 `git checkout` 的 `-orphan` 参数

```shell
git checkout --orphan emptybranch
```

该命令会生成一个叫 `emptybranch` 的分支，该分支会包含父分支的所有文件。但新的分支不会指向任何以前的提交，就是它没有历史，如果你提交当前内容，那么这次提交就是这个分支的首次提交。

如果想要空分支，可以把当前内容全部删除

```shell
git rm -rf .
```

然后重新添加文件并提交

```shell
echo '# new branch' >> README.md
git add README.md
git commit -m 'new branch'
```

接下来就可以 push 到远程仓库，这样一个新的空分支就创建完成了。

```shell
git push origin emptybranch
```



## 删除分支

大多数情况下，删除 Git 分支是很简单的。



### 删除本地分支

命令如下：

```shell
git branch -d <branch>
```

如果你还在一个分支上，那么 Git 是不允许你删除这个分支的。应该先退出该分支再删除，例如删除当前的 fix/authentication 分支：

```shell
git checkout master
git branch -d fix/authentication
```

当一个分支被推送并合并到远程分支后，`-d` 才会本地删除该分支。如果一个分支还没有被推送或者合并，那么可以使用 `-D` 强制删除它。



### 删除远程分支

命令如下：

```shell
git push <remote> --delete <branch>
```

还是以上面例子为例，删除远程 origin 仓库的 fix/authentication 分支：

```shell
git push origin --delete fix/authentication
```

如果觉得这行命令太长，也可以通过如下简短命令来操作：

```shell
git push origin :fix/authentication
```





## 思考

### 什么时候需要删除分支

一个 Git 仓库常常有不同的分支，开发者可以在各个分支处理不同的特性，或者在不影响主代码库的情况下修复 bug。

仓库常常有一个主分支（master 或 main）分支，表示主代码库。开发人员创建其他分支，处理不同的特性。

开发人员完成处理一个特性之后，常常会删除相应的分支。



