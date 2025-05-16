---
sidebar_position: 8
slug: /git-command-clone
---

# git clone 命令

`git clone` 命令用于从远程仓库复制整个项目，包括所有代码、分支、提交历史等，创建一个本地副本。它是你参与一个 Git 项目协作时最常用的起点。

克隆操作不仅会复制仓库内容，还会自动设置好远程地址（默认名称为 `origin`），方便你后续进行 `git fetch`、`git pull`、`git push` 等操作。



## 命令语法

```bash
git clone [选项] <仓库地址> [本地目录名]
```

**常用选项**

- `-b <分支名>`：克隆指定的分支，而不是默认的 `main` 或 `master`。
- `--depth <数字>`：创建浅克隆，只获取最近 N 次提交。
- `--single-branch`：只克隆指定分支（配合 `-b` 使用），不获取其他分支历史。
- `--no-checkout`：克隆但不自动检出工作目录内容。
- `--recursive`：递归克隆子模块（如果仓库中使用了 Git Submodule）。
- `--origin <名称>`：设置远程仓库的名字（默认是 `origin`）。



## 使用示例

从 GitHub 上克隆一个公开仓库到当前目录下：

```bash
git clone https://github.com/getiot/Hello-World.git
```

将仓库克隆到指定目录名 `myproject`：

```bash
git clone https://github.com/getiot/Hello-World.git myproject
```

克隆一个使用 SSH 地址的私有仓库（你需要配置好 SSH 密钥）：

```bash
git clone git@github.com:yourname/private-repo.git
```

克隆时只拉取某个分支（节省带宽和空间）：

```bash
git clone -b develop --single-branch https://github.com/getiot/Hello-World.git
```

克隆时不要自动检出工作区，只获取 `.git` 信息（适用于后续构建自动化场景）：

```bash
git clone --no-checkout https://github.com/getiot/Hello-World.git
```



## 小贴士

- 克隆完成后，本地仓库会自动关联远程地址 `origin`，你可以通过 `git remote -v` 查看。

- 若仓库较大，可结合 `--depth=1` 创建浅克隆（只保留最近一次提交）以加快速度：

  ```bash
  git clone --depth=1 https://github.com/getiot/Hello-World.git
  ```

- 克隆下来的仓库是完整的 Git 仓库，可以独立使用，也可以推送到其他远程地址。

