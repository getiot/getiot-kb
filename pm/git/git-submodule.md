---
sidebar_position: 16
slug: /git-submodule
---

# Git 子模块



开源生态非常丰富，在实际开发中，我们经常需要在某个的项目包含并使用另一个项目，它也许是第三方库，或许是其他优秀的开源项目，又或者是你自己独立开发项目。反正，你需要在一个项目依赖多个模块。那么，我们该如何管理这些既有关联，由独立的多个项目呢？

答案是 —— Git 子模块（Submodule）



## 添加子模块

使用 git 的子命令 `submodule add` 可以为 Git 仓库添加子模块，语法为：

```bash
git submodule add <git-repo> [local-path]
```

例如：

```bash
git submodule add git@github.com:luhuadong/ldal.git
```

或者指定本地的存放目录

```bash
git submodule add git@github.com:luhuadong/ldal.git lib/ldal
```

添加子模块之后，会在 Git 仓库的根目录生成一个 .gitmodules 文件，它保存了 Git 子模块的信息。

```bash
[submodule "lib/ldal"]
        path = lib/ldal
        url = git@github.com:luhuadong/ldal.git
```



## 拉取子模块

如果首次克隆仓库及其模块，使用：

```bash
git clone --recursive 仓库地址
```

对于仓库首次拉取模块，可以使用：

```bash
git submodule update --init --recursive
```

更新子模块（适用于 git 1.8.2 及以上版本）

```bash
git submodule update --recursive --remote
```

更新子模块（适用于 git 1.7.3 及以上版本）

```bash
git submodule update --recursive
```

或者

```bash
git pull --recurse-submodules
```



## 更新子模块 url

首先修改 `.gitmodules` 文件中对应模块的 url 属性值。

然后使用下面命令将新的 URL 更新到文件 .git/config。

```bash
git submodule sync
```

再使用下面命令初始化子模块。

```bash
git submodule init
```

最后使用下面命令更新子模块。

```bash
git submodule update
```



## 指定 submodule 版本

在 Git 仓库中添加子模块后，`cd` 切换到子模块目录，然后使用 `git checkout` 到指定的版本，再提交即可。





## 删除子模块

在旧版本的 Git 中，删除子模块是挺繁琐的一件事。而在新版本的 Git 中，增加了 `deinit` 命令，简化了删除子模块的流程。

- 首先是从 .git/config 中删除子模块条目：

  ```bash
  git submodule deinit -f path/to/submodule
  ```

- 然后从顶层项目的 .git/modules 目录中删除子模块目录：

  ```bash
  rm -rf .git/modules/path/to/submodule
  ```

- 最后删除 .gitmodules 中的条目并删除位于 path/to/submodule 的子模块目录：

  ```bash
  git rm -f path/to/submodule
  ```

作为对比，我们保留了旧版本 Git 中删除一个子模块的繁琐流程：

- 首先在 `.gitmodules` 文件中删除相关记录

- 提交 `.gitmodules` 文件

  ```bash
  git add .gitmodules
  ```

- 然后在 `.git/config` 中删除相关配置

- 删除暂存区数据

  ```bash
  git rm --cached path_to_submodule  # 末尾不加路径符
  ```

- 删除子模块

  ```bash
  rm --rf .git/modules/path_to_submodule #末尾不加路径符
  ```

- 提交修改

  ```bash
  git commit -m "Removed submodule "
  ```

- 删除当前工作区数据（此时为未追踪数据）

  ```bash
  rm -rf path_to_submodule
  ```

