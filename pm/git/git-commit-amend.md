---
sidebar_position: 19
slug: /git-commit-amend
---

# Git 修改提交信息



当我们提交代码后，发现提交信息描述有误或者格式不符合要求，这时候就需要修改提交信息。修改的方法是使用 `git commit --amend` 命令。



## 操作流程

1、列出 commit 列表

```bash
git rebase -i <commit-id>
```

找到需要修改的 commit 记录，把 `pick` 修改为 `edit` 或 `e`，`:wq` 保存退出

2、修改 commit 的具体信息

```bash
git commit --amend
```

3、当你对你的修改满意后执行

```bash
git rebase --continue
```



## 操作示例

```bash
bb2b710 (HEAD -> develop, origin/develop) docs: adjusted UniProton technical analysis
329f1ab docs: adjusted the doc format to be more spec compliant
949050a (origin/master, origin/HEAD, master) !40 adapte rhealstone test for Uniproton
5bfbe56 testcases: adapte rhealstone test for Uniproton
a332b97 !44 支持cortex_m4平台qemu仿真
e74ddfc qemu: cortex_m4 support qemu
...
```



```bash
$ git rebase -i 949050a
```



```bash
  1 pick 329f1ab docs: adjusted the doc format to be more spec compliant
  2 pick bb2b710 docs: adjusted UniProton technical analysis
  3 
  4 # 变基 949050a..bb2b710 到 949050a（2 个提交）
  5 #
  6 # 命令:
  7 # p, pick <提交> = 使用提交
  8 # r, reword <提交> = 使用提交，但修改提交说明
  9 # e, edit <提交> = 使用提交，进入 shell 以便进行提交修补
 10 # s, squash <提交> = 使用提交，但融合到前一个提交
 11 # f, fixup <提交> = 类似于 "squash"，但丢弃提交说明日志
 12 # x, exec <命令> = 使用 shell 运行命令（此行剩余部分）
 13 # b, break = 在此处停止（使用 'git rebase --continue' 继续变基）
 14 # d, drop <提交> = 删除提交
 15 # l, label <label> = 为当前 HEAD 打上标记
 16 # t, reset <label> = 重置 HEAD 到该标记
 17 # m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]
 18 # .       创建一个合并提交，并使用原始的合并提交说明（如果没有指定
 19 # .       原始提交，使用注释部分的 oneline 作为提交说明）。使用
 20 # .       -c <提交> 可以编辑提交说明。
 21 #
 22 # 可以对这些行重新排序，将从上至下执行。
 23 #
 24 # 如果您在这里删除一行，对应的提交将会丢失。
 25 #
 26 # 然而，如果您删除全部内容，变基操作将会终止。
 27 #

```



```
pick 329f1ab docs: adjusted the doc format to be more spec compliant
squash bb2b710 docs: adjusted UniProton technical analysis
```

按 `:wq` 保存退出。



commit msg 提交规范由三部分组成：title, body, foot，如下：

```bash
script: this is title

this is body

Signed-off-by: xxx <xxx@yy.com>
```

- title 简明说明该次 PR 提交信息，`:` 号前面是模块名称，后面是简要信息。
- body 详细说明该次提交的信息。
- foot 由固定格式组成，第一部分是 Signed-off-by，空格后是开发者用户名，再空格后是开发者邮箱，Signed off 信息一般由 git 在提交时自动生成。



