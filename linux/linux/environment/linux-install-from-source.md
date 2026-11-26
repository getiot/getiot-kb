---
sidebar_position: 4
sidebar_label: 从源码安装软件
slug: /linux-install-from-source
---

# Linux 从源码安装软件概览

在 Linux 中，优先使用发行版的软件包管理器安装软件。但有时你会遇到这种情况：

- 发行版仓库里的版本太旧。
- 你需要开启特定编译选项。
- 软件没有提供适合你系统的软件包。
- 你正在学习 C/C++、内核、驱动或开源项目构建。

这时就可能需要从源码安装。

## 先问自己是否真的需要

从源码安装并不总是更好。它的代价包括：

- 需要手动处理依赖。
- 升级和卸载可能不如包管理器方便。
- 编译过程可能耗时。
- 安装到系统目录时可能覆盖发行版管理的文件。

入门阶段建议优先级是：

1. 官方软件源。
2. 官方提供的包或仓库。
3. 容器或独立二进制文件。
4. 从源码构建。

## 典型源码构建流程

很多传统 C/C++ 项目使用这样的流程：

```bash
./configure
make
sudo make install
```

大致含义是：

- `./configure`：检查系统环境和依赖，生成 Makefile。
- `make`：根据 Makefile 编译。
- `sudo make install`：把编译结果安装到系统目录。

现代项目也可能使用 CMake：

```bash
cmake -S . -B build
cmake --build build
sudo cmake --install build
```

不同项目的构建方式可能差异很大。真正可靠的入口永远是项目自己的 `README`、`INSTALL` 或官方文档。

## 安装构建工具

Debian/Ubuntu 常见构建工具包是 `build-essential`：

```bash
sudo apt update
sudo apt install build-essential
```

如果项目使用 CMake：

```bash
sudo apt install cmake
```

Fedora/RHEL 系发行版通常使用 [dnf](/linux-command/dnf/) 或 [yum](/linux-command/yum/) 安装对应开发工具组。

:::note
包名和工具组名称会随发行版变化。安装前请以当前发行版文档和项目说明为准。
:::

## 使用 --prefix 控制安装位置

传统 `configure` 项目通常支持 `--prefix`：

```bash
./configure --prefix=$HOME/.local
make
make install
```

这样软件会安装到你的用户目录，而不是系统目录。好处是：

- 不需要 `sudo make install`。
- 更容易清理。
- 不容易影响系统软件包。

如果安装到 `$HOME/.local/bin`，需要确保它在 `PATH` 中：

```bash
export PATH="$HOME/.local/bin:$PATH"
```

可以把这行加入你的 Shell 配置文件。

## 不建议直接 sudo make install

很多教程会写：

```bash
sudo make install
```

它确实常见，但你要知道风险：安装过程可能把文件复制到 `/usr/local`、`/usr` 等目录，包管理器未必知道这些文件属于哪个软件。以后卸载时就麻烦了。

更稳妥的做法包括：

- 优先使用发行版包。
- 使用 `--prefix=$HOME/.local`。
- 使用项目提供的卸载目标，例如 `make uninstall`，但不是所有项目都有。
- 使用专门的打包工具把源码构建成发行版软件包。

## 阅读项目文档

下载源码后，先看这些文件：

```bash
ls
```

常见文档文件包括：

- `README`
- `README.md`
- `INSTALL`
- `BUILD`
- `docs/`

不要在没有阅读文档前机械执行构建命令。不同项目依赖、编译选项和安装方式都可能不同。

## 常见错误

### 缺少编译器

错误可能类似：

```text
cc: command not found
```

说明系统没有 C 编译器。Debian/Ubuntu 可安装 `build-essential`。

### 缺少依赖库

错误可能类似：

```text
checking for openssl... no
```

说明缺少开发头文件或库。你需要安装对应的开发包，通常包名会包含 `dev` 或 `devel`。

### 权限不足

安装到系统目录时可能提示：

```text
Permission denied
```

不要马上加 `sudo`。先确认安装目标是否应该是系统目录，是否可以用 `--prefix` 安装到用户目录。

## 小结

从源码安装不是入门阶段的首选，但你应该理解它的基本流程：

- 先读项目文档。
- 安装构建工具和依赖。
- 编译前确认安装位置。
- 尽量避免不受控地写入系统目录。
- 能用包管理器解决时，优先用包管理器。
