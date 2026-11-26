---
sidebar_position: 1
sidebar_label: 使用 GitHub Actions 自托管运行器
---

# 使用 GitHub Actions 自托管运行器（self-hosted runners）

Self-hosted runner（自托管运行器） 是 GitHub Actions 的一种运行器类型，用于在你自己提供的服务器上执行 GitHub Actions 工作流。

与 GitHub-hosted runners（GitHub 托管的运行器）相比，Self-hosted runners 运行在你自己的服务器上，而不是由 GitHub 提供和维护，因此可以访问你的私有网络、数据库、Docker 环境等，适合需要访问服务器资源的部署场景。同时，Self-hosted runners 不占用 GitHub 的免费额度。



## 创建 self-hosted runner

打开你需要添加的 GitHub 仓库页面，依次点击 “Settings -> Actions -> Runners”，再点击右上角的“New self-hosted runner”（新自托管运行器）。

![](https://static.getiot.tech/github-actions-self-hosted-runner-setup-01.webp)

然后选择 self-hosted runner 运行的目标服务器的操作系统和体系结构，如 Linux、x86。

![](https://static.getiot.tech/github-actions-self-hosted-runner-setup-02.webp)



## 目标服务器操作

接下来，登录到你的云服务器，完成 self-hosted runner 的安装和配置。

### 下载

首先创建一个工作空间（如 `actions-runner`）：

```bash
$ mkdir actions-runner && cd actions-runner
```

下载最新的自托管运行器软件包：

```bash
$ curl -o actions-runner-linux-x64-2.329.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.329.0/actions-runner-linux-x64-2.329.0.tar.gz
```

验证软件包 hash 值（可选）：

```bash
$ echo "194f1e1e4bd02f80b7e9633fc546084d8d4e19f3928a324d512ea53430102e1d  actions-runner-linux-x64-2.329.0.tar.gz" | shasum -a 256 -c
```

解压缩软件包：

```bash
$ tar xzf ./actions-runner-linux-x64-2.329.0.tar.gz
```

### 配置

通过配置脚本创建 runner：

```bash
$ ./config.sh --url https://github.com/getiot/xxx --token ADHYSZGSG6SRSV3IEXGNMLDJIFRAW
```

你将看到一个交互界面，在这里可以设置 runner 的分组、名称、标签等。

```bash
--------------------------------------------------------------------------------
|        ____ _ _   _   _       _          _        _   _                      |
|       / ___(_) |_| | | |_   _| |__      / \   ___| |_(_) ___  _ __  ___      |
|      | |  _| | __| |_| | | | | '_ \    / _ \ / __| __| |/ _ \| '_ \/ __|     |
|      | |_| | | |_|  _  | |_| | |_) |  / ___ \ (__| |_| | (_) | | | \__ \     |
|       \____|_|\__|_| |_|\__,_|_.__/  /_/   \_\___|\__|_|\___/|_| |_|___/     |
|                                                                              |
|                       Self-hosted runner registration                        |
|                                                                              |
--------------------------------------------------------------------------------

# Authentication


√ Connected to GitHub

# Runner Registration

Enter the name of the runner group to add this runner to: [press Enter for Default] 

Enter the name of runner: [press Enter for xxx] 

This runner will have the following labels: 'self-hosted', 'Linux', 'X64' 
Enter any additional labels (ex. label-1,label-2): [press Enter to skip] 

√ Runner successfully added

# Runner settings

Enter name of work folder: [press Enter for _work] 

√ Settings Saved.

```

配置完成后，就可以运行它了！

```bash
$ ./run.sh
```

看到如下提示，说明 self-hosted runner 成功运行。

```bash
√ Connected to GitHub

Current runner version: '2.329.0'
2025-12-16 13:40:13Z: Listening for Jobs
```



## 使用示例

在你在项目 workflow 配置文件（YAML）中，为每个作业（job）添加以下配置：

```yaml
runs-on: self-hosted
```

这样就可以使用 self-hosted runner 啦！
