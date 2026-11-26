---
sidebar_position: 7
---

# GitHub 拉取 PR 代码到本地



当我们在 GitHub 上开发或维护一个开源项目时，不可避免地会接收到其他开发者提交的合并请求（Pull Request，简称 PR）。而在合并之前，我们通常需要先将该 PR 的代码拉取到本地仓库，进行验证和测试。

假设我们 Fork 了一个 Git 仓库，其对应的原始仓库为 upstream，需要拉取编号为 1026 的 PR 到本地仓库，对应的本地分支名称为 pr1026。那么，具体操作命令如下：

```bash showLineNumbers
git fetch upstream pull/1026/head:pr1026
git checkout pr1026
```

这样，本地仓库的当前分支 pr1026 就包含了目标 Pull Request 的代码。

