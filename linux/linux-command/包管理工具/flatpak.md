---
sidebar_position: 9
slug: /flatpak
---

# flatpak 命令



## 介绍

**flatpak** 是各种不同的 Linux 发行版上分发和运行应用程序的全新打包格式，并且使用该格式打包的软件可安全运行。你可以访问[官网](https://flatpak.org)以获得关于 flatpak 打包格式的详细介绍。

想要在你的计算机上体验 Flatpak 格式的安装包，首先需要安装 flatpak 命令，它通常不会预先安装，但可在大多数 Linux 发行版的默认仓库中找到。例如，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install flatpak
```

**语法**：

```bash
flatpak [OPTION...] {COMMAND}
```

**选项**：

- `-h`, `--help`：显示帮助信息并退出。Show help options and exit.
- `-v`, `--verbose`：在命令处理期间打印调试信息。使用 -vv 获取更多详细信息。
- `--ostree-verbose`：在命令处理期间打印 OSTree 调试信息。
- `--version`：打印版本信息并退出。
- `--default-arch`：打印默认的体系架构（如 x86_64 ）并退出。
- `--supported-arches`：按优先顺序打印支持的体系架构并退出。
- `--gl-drivers`：打印活动的 GL 驱动程序列表并退出。

**命令**：

| Flatpak 命令                  | 描述                                             |
| ----------------------------- | ------------------------------------------------ |
| `flatpak build-bundle`        | 从本地存储库创建单文件包。                       |
| `flatpak build-commit-from`   | 基于现有提交（可能来自另一个存储库）创建新提交。 |
| `flatpak build-export`        | 从构建目录创建存储库。                           |
| `flatpak build-finish`        | 完成构建目录。                                   |
| `flatpak build-import-bundle` | 将文件包导入本地存储库。                         |
| `flatpak build-init`          | 初始化构建目录。                                 |
| `flatpak build-sign`          | 签署应用程序或运行时。                           |
| `flatpak build-update-repo`   | 从构建目录创建存储库。                           |
| `flatpak build`               | 在目录中构建。                                   |
| `flatpak config`              | 管理配置。                                       |
| `flatpak create-usb`          | 将应用程序和/或运行时复制到可移动媒体上。        |
| `flatpak document-export`     | 将文件导出到沙盒应用程序。                       |
| `flatpak document-info`       | 显示有关导出文件的信息。                         |
| `flatpak document-list`       | 列出导出的文件。                                 |
| `flatpak document-unexport`   | 停止导出文件。                                   |
| `flatpak permission-remove`   | 列出权限。                                       |
| `flatpak permission-list`     | 列出权限。                                       |
| `flatpak permission-show`     | 列出权限。                                       |
| `flatpak permission-reset`    | 重置权限。                                       |
| `flatpak enter`               | 输入应用程序。                                   |
| `flatpak info`                | 显示有关已安装应用程序或运行时的信息。           |
| `flatpak install`             | 安装应用程序或运行时。                           |
| `flatpak list`                | 列出已安装的应用程序和/或运行时。                |
| `flatpak make-current`        | 使特定版本的应用程序成为最新版本。               |
| `flatpak override`            | 覆盖应用程序要求。                               |
| `flatpak remote-add`          | 添加远程仓库。                                   |
| `flatpak remote-delete`       | 删除远程仓库。                                   |
| `flatpak remote-info`         | 在远程显示有关应用程序或运行时的信息。           |
| `flatpak remote-ls`           | 显示可用的运行时和应用程序。                     |
| `flatpak remote-modify`       | 修改远程仓库。                                   |
| `flatpak remotes`             | 列出远程仓库。                                   |
| `flatpak repair`              | 修复 flatpak 安装。                              |
| `flatpak repo`                | 显示有关本地存储库的信息。                       |
| `flatpak run`                 | 在 runtime 中运行应用程序或打开 shell。          |
| `flatpak search`              | 搜索应用程序和运行时。                           |
| `flatpak uninstall`           | 卸载应用程序或运行时。                           |
| `flatpak update`              | 更新应用程序或运行时。                           |



## 示例

列出在系统中已经配置好远程仓库：

```bash
flatpak remotes
```

使用 `.flatpakrepo` 文件添加远程仓库：（ `.flatpakrepo` 文件包含远程仓库的信息和 GPG 秘钥）

```bash
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
```

移除远程仓库 flathub：

```bash
flatpak remote-delete flathub
```

查找远程仓库中的 GIMP 应用：

```bash
flatpak search gimp
```

以 Flatpak 包的形式安装 GIMP 图像处理软件：

```bash
flatpak install https://flathub.org/repo/appstream/org.gimp.GIMP.flatpakref
```







