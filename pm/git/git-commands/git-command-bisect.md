---
sidebar_position: 2
slug: /git-command-bisect
---

# git bisect 命令

`git bisect` 命令用于通过二分查找的方式，帮助你快速定位引入某个错误或问题的具体提交（commit）。当你发现代码出现了 bug，但不确定是哪个提交导致时，`git bisect` 可以自动帮你缩小范围，定位问题源头。

通过标记一个“坏的”提交（含错误）和一个“好的”提交（没有错误），Git 会自动在两者之间进行二分查找，反复让你测试中间的提交，直到找到导致问题的那个具体提交。

这极大地节省了手动逐个提交排查的时间，尤其适用于提交量大或多人协作的项目。



## 命令语法

```bash
git bisect start
git bisect bad <坏的提交>
git bisect good <好的提交>
```

执行上述命令之后根据提示测试指定提交的代码状态，使用 `git bisect good` 或 `git bisect bad` 标记当前代码状态，最终定位到问题提交。

**常用选项参数**

- `start`：开始二分查找过程。
- `bad <commit>`：指定包含错误的“坏”提交（默认为当前 HEAD）。
- `good <commit>`：指定没有错误的“好”提交。
- `reset`：结束二分查找，恢复到原来分支状态。
- `skip`：跳过当前提交（比如测试环境异常，无法判断状态）。
- `run <命令>`：自动执行命令判断提交状态，根据命令退出码判断是否为坏提交。



## 使用示例

假设你当前分支代码有 bug，想找到引入 bug 的提交：

```bash
git bisect start
git bisect bad HEAD
git bisect good v1.0
```

Git 会自动检出中间的提交，让你测试代码状态。

测试后，如果当前提交没问题，运行：

```bash
git bisect good
```

如果有问题，运行：

```bash
git bisect bad
```

Git 根据你的输入，继续自动切换提交，直到找到引入 bug 的那个提交。

当定位完毕，运行：

```bash
git bisect reset
```

恢复到开始二分查找之前的分支和状态。

你还可以使用自动化方式，执行脚本检测 bug：

```bash
git bisect start
git bisect bad HEAD
git bisect good v1.0
git bisect run ./test-script.sh
```

脚本执行成功（返回 0）表示“好”，失败（非 0）表示“坏”，Git 会自动完成二分查找。



## 小贴士

- 使用 `git bisect` 前，最好确认“好”和“坏”提交的界限，避免起点判断错误导致定位失败。
- `git bisect run` 非常适合自动化测试和持续集成场景。
- 如果遇到某个提交无法测试，使用 `git bisect skip` 跳过，继续查找。
