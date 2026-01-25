---
sidebar_position: 8
---

# Ubuntu 制作 deb 包

`.deb` 是 Debian 及其衍生发行版（如 Ubuntu）使用的软件包格式。它包含了软件的所有文件、元数据信息以及安装脚本，可以方便地在 Debian/Ubuntu 系统上安装、升级和卸载软件。

为了方便演示，本文将通过两个不同类型的项目来详细介绍如何在 Ubuntu 系统中制作 `.deb` 安装包：

1. **hello-deb** - 一个简单的 shell 脚本工具（纯脚本项目）
2. **sysinfo** - 一个 C 语言编写的系统信息查看工具（需要编译的项目）

通过对比这两种不同类型的项目，你可以了解不同场景下的 deb 包制作流程和差异。

:::tip

这两个工具都是专门为教程创建的演示工具：
- `hello-deb` 完整代码位于 [https://github.com/getiot/hello-deb](https://github.com/getiot/hello-deb)
- `sysinfo` 完整代码位于 [https://github.com/getiot/sysinfo](https://github.com/getiot/sysinfo)

它们结构简单，非常适合学习和实践。两个项目都包含了完整的构建脚本和配置文件，可以直接使用。

:::

## 快速开始

如果你想快速体验 deb 包的制作过程，可以直接使用项目中的构建脚本：

**hello-deb（Shell 脚本项目）**

```bash
git clone git@github.com:getiot/hello-deb.git
cd hello-deb
./build-deb.sh
```

**sysinfo（C 语言项目）**

```bash
git clone git@github.com:getiot/sysinfo.git
cd sysinfo
./build-deb.sh
```

构建完成后，会生成对应的 `.deb` 文件，可以直接安装测试。

:::tip

**推荐学习路径**：
1. **快速体验**：先运行构建脚本，快速生成 deb 包并安装测试
2. **理解原理**：阅读下面的详细步骤说明，理解每个步骤的作用
3. **查看源码**：查看 `build-deb.sh` 脚本源码，了解构建流程
4. **自定义修改**：根据需要修改配置 `debian/control` 文件自定义包信息，以及源代码，创建自己的工具

:::

## 准备工作

在开始制作 deb 包之前，你需要：

1. 准备好要打包的软件文件（可执行文件、配置文件、资源文件等）
2. 了解软件的基本信息（名称、版本、依赖关系等）
3. 确保系统已安装 `dpkg-deb` 工具（Ubuntu 系统通常已预装）
4. 对于需要编译的项目，确保已安装编译工具（gcc、cmake 等）

## 案例一：打包 Shell 脚本工具（hello-deb）

`hello-deb` 是一个简单的 shell 脚本工具，这个案例展示如何为纯脚本项目制作 deb 包，不需要编译步骤，流程相对简单。

因为 `hello-deb` 项目已经包含了完整的构建脚本和配置文件，因此你可以直接使用下面命令自动完成所有步骤，生成如 `hello-deb_1.0.0.deb` 这样的文件。

```bash
cd hello-deb
./build-deb.sh
```

如果你想手动执行每个步骤，或者理解打包的底层原理，可以按照以下步骤操作。

### 创建包目录结构

首先，你需要创建一个**临时文件夹**来存放包的所有内容。这个文件夹的名称格式通常是 `包名_版本号`，例如 `hello-deb_1.0.0`。这个文件夹的结构将对应目标系统的根目录结构。

:::important

**重要说明**：`hello-deb_1.0.0/DEBIAN` 这个目录是**打包时临时创建的**，不是源代码项目的一部分。打包完成后可以删除这个临时目录。`DEBIAN` 目录是 deb 包格式要求的特殊目录，用于存放包的元数据文件（如 `control` 文件）。

:::

#### 1. 创建基本目录

```shell
mkdir -p hello-deb_1.0.0/DEBIAN
```

`-p` 参数会确保创建目录时，如果父目录不存在也会一并创建，避免出现"文件或目录不存在"的错误。

#### 2. 放置可执行文件

二进制文件或可执行文件通常放在 `/usr/local/bin` 或 `/usr/bin` 目录下。对于用户级安装，推荐使用 `/usr/local/bin`。

假设我们有一个名为 `hello-deb` 的可执行脚本（位于 `hello-deb/` 目录下）：

```shell
mkdir -p hello-deb_1.0.0/usr/local/bin
cp hello-deb/hello-deb hello-deb_1.0.0/usr/local/bin/
chmod +x hello-deb_1.0.0/usr/local/bin/hello-deb
```

**注意**：确保可执行文件具有执行权限，可以使用 `chmod +x` 命令设置。

#### 3. 放置资源文件

其他资源文件（如配置文件、数据文件、脚本等）通常放在 `/usr/local/share/包名` 或 `/usr/share/包名` 目录下。

假设我们有一个配置文件 `config.conf`（位于 `hello-deb/` 目录下）：

```shell
mkdir -p hello-deb_1.0.0/usr/local/share/hello-deb
cp hello-deb/config.conf hello-deb_1.0.0/usr/local/share/hello-deb/
```

#### 4. 其他常见目录

根据软件需要，你可能还需要创建以下目录：

- **配置文件**：`/etc/包名/` - 系统级配置文件
- **文档文件**：`/usr/share/doc/包名/` - 文档、README、许可证等
- **手册页**：`/usr/share/man/man1/` - man 手册
- **图标文件**：`/usr/share/icons/` - 应用程序图标
- **桌面文件**：`/usr/share/applications/` - 桌面启动器

### 创建 control 文件

`control` 文件是 deb 包的核心，包含了包的元数据信息。它必须放在 `DEBIAN` 目录下，如 `hello-deb_1.0.0/DEBIAN/control`。

#### control 文件示例

```ini showLineNumbers title="DEBIAN/control"
Package: hello-deb
Version: 1.0.0
Architecture: all
Maintainer: Your Name <your.email@example.com>
Description: Deb 包制作演示工具
 这是一个简单的演示工具，用于展示如何制作 Ubuntu deb 安装包。
 它包含一个可执行脚本和一个配置文件，非常适合学习和演示。
```

#### control 文件字段说明

- **Package**（必需）：包的名称，只能包含小写字母、数字和连字符
- **Version**（必需）：包的版本号，格式为 `[epoch:]上游版本[-修订版本]`
  - **上游版本**：软件本身的版本号，如 `1.0.0`、`2.1.3`、`2.4.21` 等
  - **修订版本**（可选）：Debian/Ubuntu 打包的修订号，从 `1` 开始
  - **两种格式**：
    - **简单格式**：`1.0.0` - 适用于个人项目、简单打包，不需要修订版本号
    - **完整格式**：`1.0.0-1` - 适用于需要多次重新打包的情况
  - **版本升级示例**：
    - 简单格式：`1.0.0` → `1.0.1`（上游发布新版本）
    - 完整格式：`1.0.0-1` → `1.0.1-1`（上游发布新版本）或 `1.0.0-2`（只修改打包方式）
- **Architecture**（必需）：目标架构，如 `amd64`、`i386`、`arm64`、`all` 等
  - 对于编译的二进制文件，使用具体架构（如 `amd64`）
  - 对于脚本、文档等平台无关的文件，使用 `all`
- **Depends**：运行时依赖的包，多个依赖用逗号分隔
- **Maintainer**（推荐）：维护者的姓名和邮箱
- **Description**（推荐）：包的简短描述
  - 第一行是简短描述（不超过 60 个字符）
  - 后续行是详细描述，每行必须以一个空格开头

:::tip 版本号格式说明

**简单格式（推荐用于个人项目）**：
- `1.0.0` - 直接使用上游版本号，简洁明了
- 适用于：个人项目、简单工具、不需要多次重新打包的情况
- 示例：`cursor_2.4.21_amd64.deb` 使用的就是 `2.4.21`

**完整格式（适用于需要重新打包的情况）**：
- `1.0.0-1` - 上游版本号 + 修订版本号
- `-1` 表示该上游版本的第一次打包
- 适用于：需要修复打包错误、更新依赖关系、进入官方仓库等情况
- 版本升级：
  - 上游发布新版本：`1.0.0-1` → `1.0.1-1`（修订号重置为 1）
  - 只修改打包方式：`1.0.0-1` → `1.0.0-2`（修订号递增）

**选择建议**：
- 对于个人项目或简单打包，使用简单格式 `1.0.0` 即可
- 如果以后需要重新打包（修复打包错误），再改为 `1.0.0-1`、`1.0.0-2` 等

:::

#### 其他常用字段

```ini showLineNumbers
Section: utils
Priority: optional
Homepage: https://example.com/hello-deb
Installed-Size: 1024
Conflicts: other-package
Replaces: old-package
Provides: alternative-name
Recommends: recommended-package
Suggests: optional-package
```

更多字段说明请参考 [Debian 控制字段文档](https://www.debian.org/doc/debian-policy/ch-controlfields.html)。

### 设置文件权限

在打包前，确保所有文件具有正确的权限：

```shell
# 设置可执行文件权限
chmod 755 hello-deb_1.0.0/usr/local/bin/hello-deb

# 设置资源文件权限
chmod 644 hello-deb_1.0.0/usr/local/share/hello-deb/*
```

### 构建 deb 包

使用 `dpkg-deb` 命令构建 deb 包：

```shell
dpkg-deb --build hello-deb_1.0.0
```

如果成功，你会看到类似输出：

```
dpkg-deb: building package 'hello-deb' in 'hello-deb_1.0.0.deb'.
```

高级构建选项：

```shell
# 显示详细信息
dpkg-deb --build --verbose hello-deb_1.0.0

# 指定输出文件名
dpkg-deb --build hello-deb_1.0.0 hello-deb-custom.deb
```

### 安装和测试

你可以使用 apt 或 dpkg 命令安装 deb 包，例如：

```shell
sudo apt install ./hello-deb_1.0.0.deb
```

或者使用 `dpkg` 命令：

```shell
sudo dpkg -i hello-deb_1.0.0.deb
```

如果遇到依赖问题，可以使用：

```shell
sudo apt install -f
```

安装完成后，可以通过下面方法验证是否安装成功：

```shell
# 检查包是否已安装
dpkg -l | grep hello-deb

# 查看包信息
dpkg -s hello-deb

# 查看包包含的文件
dpkg -L hello-deb

# 测试可执行文件
hello-deb
hello-deb "测试"
```



## 案例二：打包 C 语言项目（sysinfo）

`sysinfo` 是一个简单的 C 语言编写的系统信息查看工具，这个案例展示如何为需要编译的 C 项目制作 deb 包。与脚本项目不同，C 项目需要先编译生成二进制文件，然后再打包。

因为 `sysinfo` 项目已经包含了完整的构建脚本和配置文件，所以你可以直接使用下面命令自动完成所有编译和构建步骤，构建完成后会生成如 `sysinfo_1.0.0.deb` 这样的 deb 文件。

```bash
cd sysinfo
./build-deb.sh
```

构建脚本会自动完成所有步骤：
1. 检查编译工具（cmake、gcc）
2. 编译项目生成可执行文件
3. 创建 deb 包目录结构
4. 复制文件并设置权限
5. 构建 deb 包

如果你想手动执行每个步骤，或者理解打包的底层原理，可以按照以下步骤操作。

### 编译项目

首先，我们需要编译 C 源代码生成可执行文件：

```shell
cd sysinfo
mkdir build
cd build
cmake ..
make
```

编译成功后，会在 `build` 目录下生成 `sysinfo` 可执行文件。

### 创建包目录结构

与脚本项目类似，我们需要创建包目录结构：

```shell
mkdir -p sysinfo_1.0.0/DEBIAN
```

### 放置编译后的可执行文件

将编译好的二进制文件复制到包目录中：

```shell
mkdir -p sysinfo_1.0.0/usr/local/bin
cp sysinfo/build/sysinfo sysinfo_1.0.0/usr/local/bin/
chmod +x sysinfo_1.0.0/usr/local/bin/sysinfo
```

### 放置文档文件

将 README 等文档文件放入文档目录：

```shell
mkdir -p sysinfo_1.0.0/usr/share/doc/sysinfo
cp sysinfo/README.md sysinfo_1.0.0/usr/share/doc/sysinfo/
```

### 创建 control 文件

创建 `sysinfo_1.0.0/DEBIAN/control` 文件，对于编译的二进制文件，需要注意 `Architecture` 字段应该设置为具体的架构（如 `amd64`），而不是 `all`。

```ini showLineNumbers title="DEBIAN/control"
Package: sysinfo
Version: 1.0.0
Architecture: amd64
Maintainer: Your Name <your.email@example.com>
Description: 系统信息查看工具
 一个简单的 C 语言编写的系统信息查看工具。
 可以显示系统名称、CPU 信息、内存信息、运行时间等。
```

**重要提示**：

- `Architecture: amd64` - 因为这是编译的二进制文件，必须指定具体架构
- 如果需要支持多个架构，需要分别为每个架构编译和打包
- `Version: 1.0.0` - 使用简单格式，详见下面的版本号管理说明

### 设置文件权限

```bash
# 设置可执行文件权限
chmod 755 sysinfo_1.0.0/usr/local/bin/sysinfo

# 设置文档文件权限
chmod 644 sysinfo_1.0.0/usr/share/doc/sysinfo/*
```

### 构建 deb 包

```bash
dpkg-deb --build sysinfo_1.0.0
```

### 安装和测试

```bash
# 安装
sudo dpkg -i sysinfo_1.0.0.deb

# 测试
sysinfo
sysinfo --help
sysinfo --version
```

## 两种打包方式对比

通过以上两个案例，我们可以清楚地看到两种打包方式的差异：

| 特性 | Shell 脚本项目 | C 编译项目 |
|:----:|:-------------:|:---------:|
| **编译步骤** | 不需要 | 需要先编译 |
| **Architecture** | `all`（平台无关） | 具体架构（如 `amd64`） |
| **文件类型** | 脚本文件 | 二进制可执行文件 |
| **依赖关系** | 通常较少 | 可能需要编译工具链 |
| **打包复杂度** | 简单 | 相对复杂 |
| **跨平台性** | 好（脚本可移植） | 需要为每个架构编译 |

### 选择建议

- **使用 Shell 脚本方式**：适合简单的工具、配置脚本、纯文本处理工具等
- **使用 C 编译方式**：适合需要高性能、系统级工具、有复杂依赖的项目

### 项目中的构建脚本

两个演示项目都已经包含了完整的构建脚本和配置文件：

#### hello-deb 项目结构

```bash
hello-deb/
├── hello-deb              # 主可执行脚本
├── config.conf            # 配置文件
├── build-deb.sh           # deb 包构建脚本（已包含）
├── debian/
│   └── control            # deb 包元数据文件（已包含）
└── README.md              # 说明文档
```

#### sysinfo 项目结构

```bash
sysinfo/
├── CMakeLists.txt         # CMake 构建配置
├── build-deb.sh           # deb 包构建脚本（已包含）
├── debian/
│   └── control            # deb 包元数据文件（已包含）
├── source/
│   └── main.c             # 主程序源代码
└── README.md              # 说明文档
```

#### 使用构建脚本

两个项目都提供了 `build-deb.sh` 脚本，可以直接使用：

```bash
# hello-deb 项目
cd hello-deb
./build-deb.sh

# sysinfo 项目
cd sysinfo
./build-deb.sh
```

#### 自定义配置

构建脚本会从 `debian/control` 文件读取包信息，你可以直接编辑这个文件来修改：

- **包名和版本**：修改 `Package` 和 `Version` 字段
- **维护者信息**：修改 `Maintainer` 字段
- **包描述**：修改 `Description` 字段
- **架构**（仅 sysinfo）：修改 `Architecture` 字段

#### 版本号管理

**Deb 包版本号格式**：
- 格式：`[epoch:]上游版本[-修订版本]`
- **简单格式**（推荐）：`1.0.0` - 直接使用上游版本号
- **完整格式**：`1.0.0-1` - 上游版本 + 修订版本号

**何时使用修订版本号**：
- **不需要**：个人项目、简单工具、一次性打包
- **需要**：需要多次重新打包、修复打包错误、进入官方仓库

**版本号升级规则**：
- 简单格式：`1.0.0` → `1.0.1`（上游发布新版本）
- 完整格式：
  - 上游发布新版本：`1.0.0-1` → `1.0.1-1`（修订号重置为 1）
  - 只修改打包方式：`1.0.0-1` → `1.0.0-2`（修订号递增）

**C 代码中的版本号**（仅 sysinfo）：
- `sysinfo` 的 C 代码中定义了 `VERSION` 宏（在 `source/main.c` 中）
- 构建脚本会自动从 `debian/control` 提取版本号并同步到 C 代码
- 如果使用简单格式（`1.0.0`），程序显示的版本号与 deb 包版本号完全一致
- 如果使用完整格式（`1.0.0-1`），程序显示的是上游版本号（`1.0.0`），deb 包版本号包含修订信息

**版本号同步机制**（仅 sysinfo）：
- `sysinfo/build-deb.sh` 脚本会自动从 `debian/control` 读取版本号
- 如果版本号包含 `-`（如 `1.0.0-1`），会提取上游版本部分（去掉修订号）
- 如果版本号不包含 `-`（如 `1.0.0`），直接使用该版本号
- 使用 `sed` 命令更新 `source/main.c` 中的 `VERSION` 定义
- 确保程序运行时显示的版本号与软件本身的版本一致

#### 查看脚本源码

如果你想了解构建脚本的实现细节，可以查看：
- `hello-deb/build-deb.sh` - Shell 脚本项目的打包脚本
- `sysinfo/build-deb.sh` - C 项目的打包脚本（包含编译步骤）

这些脚本展示了如何自动化整个打包流程，你可以基于它们创建自己的打包脚本。

## 小结

本文详细介绍制作 deb 包的方法，基本步骤如下：

1. **准备文件**：对于脚本项目直接使用，对于编译项目需要先编译
2. **创建临时打包目录**：创建一个 `包名_版本号` 的临时目录（如 `hello-deb_1.0.0`）
3. **创建 `DEBIAN` 目录**：在打包目录下创建 `DEBIAN` 目录（这是 deb 包格式要求的特殊目录）
4. **将文件放置到正确的位置**：按照 Linux 文件系统标准组织文件（可执行文件、配置文件、文档等）
5. **创建 `DEBIAN/control` 文件**：包含包的元数据信息
6. **设置正确的文件权限**：确保可执行文件有执行权限
7. **使用 `dpkg-deb --build` 构建包**：生成 `.deb` 文件
8. **测试安装和卸载**：验证包的正确性
9. **清理临时目录**：打包完成后可以删除临时打包目录

为了便于读者理解，我们准备了两个演示项目（`hello-deb` 和 `sysinfo`），它们已经包含了完整的构建脚本和配置文件，你可以查看 `build-deb.sh` 和 `debian/control` 了解实现细节，或者可以基于这些项目创建自己的工具和打包流程。

通过以上步骤和两个案例的对比，相信你已经掌握制作 deb 包的方法，接下来你可以尝试为自己的项目创建专业的 deb 安装包了！


