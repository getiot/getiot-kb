---
sidebar_position: 3
---

# Linux 制作 deb 包

`.deb` 是 Debian 及其衍生发行版（如 Ubuntu）使用的软件包格式。它包含了软件的所有文件、元数据信息以及安装脚本，可以方便地在 Debian/Ubuntu 系统上安装、升级和卸载软件。

## 什么是 deb 包

deb 包（Debian Package）是 Debian 及其衍生发行版的标准软件包格式。deb 包的主要特点包括：

- **标准化**：遵循 Debian 策略，确保兼容性
- **依赖管理**：自动处理软件依赖关系
- **版本控制**：支持版本管理和升级
- **安装脚本**：支持安装前后执行自定义脚本
- **广泛支持**：所有基于 Debian 的发行版都支持

**适用场景**：
- Debian/Ubuntu 系统软件分发
- 系统级软件安装
- 需要依赖管理的软件
- 需要集成到包管理系统的软件

## 必备知识

在开始制作 deb 包之前，你需要了解：

1. **Linux 基础知识**：熟悉命令行操作和文件系统结构
2. **Debian 文件系统层次标准（FHS）**：了解系统目录结构
3. **包管理基础**：了解 `dpkg`、`apt` 等工具的基本使用
4. **Shell 脚本**：能够编写简单的安装脚本

## deb 包结构

deb 包结构包含两部分：

- **控制信息（DEBIAN 目录）**：包含包的元数据和安装脚本
- **安装内容**：按照 Linux 文件系统标准组织的文件（etc、usr 等目录）

DEBIAN 目录通常包含以下文件：

|  文件名   | 描述                                                         |
| :-------: | ------------------------------------------------------------ |
|  control  | 主要描述软件包的名称（Package）、版本（Version）以及描述（Description）等，是 deb 包必须具备的描述性文件，以便于软件的安装管理和索引。同时为了能将软件包进行充分的管理。 |
| postinst  | 该脚本的主要任务是完成安装包时的配置工作。许多 postinst 脚本负责执行有关命令为新安装或升级的软件重启服务。 |
|  postrm   | 软件卸载后需要执行的脚本，主要负责修改软件包链接文件、或删除创建的文件。 |
|  preinst  | 在 Deb 包文件解包之前，将会运行该脚本。许多 preinst 脚本的任务是停止作用于待升级软件包的服务，直到软件包安装或升级完成。 |
|   prerm   | 软件卸载前需要执行的脚本，主要负责停止与软件包相关的 daemon 服务。 |
| copyright | 版权许可。                                                   |
| changelog | 修订记录。                                                   |
| conffiles | 配置文件列表，这些文件在卸载时会被保留。                     |

## 准备工作

安装必要工具：

```bash
# Ubuntu/Debian
sudo apt update
sudo apt install -y dpkg-dev debhelper build-essential fakeroot

# 可选：用于从源码创建 deb 包
sudo apt install -y dh-make
```

## 制作 deb 包的方法

deb 包的制作有三种主要情况：

1. **源码包制作 deb 包**：从源代码编译并打包
2. **deb-src 包制作 deb 包**：从 Debian 源码包重新构建
3. **修改现有的 deb 包制作新的 deb 包**：解包、修改、重新打包

## 方法一：使用 checkinstall（简单快速）

`checkinstall` 是一个简单的工具，可以在编译安装过程中自动生成 deb 包。

### 安装 checkinstall

```bash
sudo apt install -y checkinstall
```

### 使用步骤

假设你有一个使用 `autotools` 的源码项目：

```bash
# 1. 下载并解压源码
tar -xzf source-code.tar.gz
cd source-code

# 2. 配置、编译
./configure
make

# 3. 使用 checkinstall 打包（而不是 make install）
sudo checkinstall
```

`checkinstall` 会以交互方式询问包信息：

- 包名
- 版本号
- 描述
- 维护者信息

完成后会在当前目录生成 `.deb` 文件。

**优点**：
- 使用简单，适合快速打包
- 自动处理依赖关系

**缺点**：
- 不够灵活
- 生成的包结构可能不够标准
- 不适合复杂的打包需求

## 方法二：使用 dpkg-deb 手动打包（推荐学习）

这是最基础的方法，适合学习 deb 包的结构和制作过程。

### 创建包目录结构

```bash
# 创建临时打包目录（格式：包名_版本号）
mkdir -p myapp_1.0.0/DEBIAN
mkdir -p myapp_1.0.0/usr/local/bin
mkdir -p myapp_1.0.0/usr/share/doc/myapp
```

### 复制文件

```bash
# 复制可执行文件
cp myapp myapp_1.0.0/usr/local/bin/
chmod +x myapp_1.0.0/usr/local/bin/myapp

# 复制文档
cp README.md myapp_1.0.0/usr/share/doc/myapp/
```

### 创建 control 文件

```bash
cat > myapp_1.0.0/DEBIAN/control << EOF
Package: myapp
Version: 1.0.0
Architecture: amd64
Maintainer: Your Name <your.email@example.com>
Description: My Application
 A simple application for demonstration purposes.
 .
 This package demonstrates how to create a deb package.
Section: utils
Priority: optional
EOF
```

### 构建 deb 包

```bash
# 使用 dpkg-deb 构建
dpkg-deb --build myapp_1.0.0

# 生成的文件
ls -lh myapp_1.0.0.deb
```

### 安装和测试

```bash
# 安装
sudo dpkg -i myapp_1.0.0.deb

# 测试
myapp

# 查看包信息
dpkg -I myapp_1.0.0.deb

# 查看包内容
dpkg -c myapp_1.0.0.deb

# 卸载
sudo dpkg -r myapp
```

## 方法三：使用 dh-make 从源码创建（标准方法）

`dh-make` 是 Debian 官方推荐的工具，用于从源码创建标准的 deb 包。

### 安装 dh-make

```bash
sudo apt install -y dh-make
```

### 使用步骤

```bash
# 1. 准备源码目录
mkdir myapp-1.0.0
cd myapp-1.0.0

# 2. 将源码复制到目录中
cp -r ../source-files/* .

# 3. 创建压缩包
cd ..
tar -czf myapp_1.0.0.orig.tar.gz myapp-1.0.0

# 4. 解压并进入目录
tar -xzf myapp_1.0.0.orig.tar.gz
cd myapp-1.0.0

# 5. 运行 dh_make
dh_make -f ../myapp_1.0.0.orig.tar.gz

# 选择包类型（通常选择 's' 表示单二进制包）
```

`dh_make` 会创建 `debian/` 目录，包含模板文件：

- `debian/control`：包控制信息
- `debian/rules`：构建规则
- `debian/changelog`：变更日志
- `debian/copyright`：版权信息

### 编辑配置文件

```bash
# 编辑 control 文件
vim debian/control

# 编辑 rules 文件（如果需要自定义构建过程）
vim debian/rules
```

### 构建 deb 包

```bash
# 使用 debuild 构建（需要安装 devscripts）
sudo apt install -y devscripts
debuild -us -uc

# 或使用 dpkg-buildpackage
dpkg-buildpackage -us -uc
```

构建完成后，会在上一级目录生成 `.deb` 文件。

## 方法四：修改现有的 deb 包

如果需要修改现有的 deb 包：

### 解包

```bash
# 创建临时目录
mkdir deb-extract
cd deb-extract

# 解压 deb 包
dpkg-deb -x ../original.deb .
dpkg-deb -e ../original.deb DEBIAN
```

### 修改内容

```bash
# 修改文件
vim usr/local/bin/myapp

# 修改 control 文件
vim DEBIAN/control
```

### 重新打包

```bash
# 返回上级目录
cd ..

# 重新打包
dpkg-deb -b deb-extract modified.deb
```

## 实际示例：打包一个 Shell 脚本

让我们创建一个完整的示例：

### 1. 准备应用程序

```bash
mkdir myapp
cd myapp

# 创建简单的脚本
cat > myapp << 'EOF'
#!/bin/bash
echo "Hello from myapp!"
echo "Version: 1.0.0"
EOF

chmod +x myapp
```

### 2. 创建包目录

```bash
mkdir -p myapp_1.0.0/DEBIAN
mkdir -p myapp_1.0.0/usr/local/bin
mkdir -p myapp_1.0.0/usr/share/doc/myapp
```

### 3. 复制文件

```bash
cp myapp myapp_1.0.0/usr/local/bin/
cp README.md myapp_1.0.0/usr/share/doc/myapp/ 2>/dev/null || echo "# MyApp" > myapp_1.0.0/usr/share/doc/myapp/README.md
```

### 4. 创建 control 文件

```bash showLineNumbers title="myapp_1.0.0/DEBIAN/control"
Package: myapp
Version: 1.0.0
Architecture: all
Maintainer: Your Name <your.email@example.com>
Description: A simple demonstration application
 This is a simple shell script application used to
 demonstrate deb package creation.
Section: utils
Priority: optional
```

### 5. 构建包

```bash
dpkg-deb --build myapp_1.0.0
```

### 6. 安装测试

```bash
sudo dpkg -i myapp_1.0.0.deb
myapp
```

:::tip

更多示例请阅读《[Ubuntu 制作 deb 包](/ubuntu/make-a-deb-package/)》。

:::

## 版本号格式

deb 包的版本号格式为：`[epoch:]upstream-version[-debian-revision]`

- **简单格式**：`1.0.0` - 直接使用上游版本号（推荐用于个人项目）
- **完整格式**：`1.0.0-1` - 上游版本 + Debian 修订版本号

**示例**：
- `1.0.0`：简单格式
- `1.0.0-1`：第一次打包
- `1.0.0-2`：只修改打包方式，上游版本不变
- `1.0.1-1`：上游发布新版本

## 最佳实践

1. **遵循 FHS**：按照 Linux 文件系统标准组织文件
2. **版本号管理**：使用语义化版本规范
3. **依赖最小化**：只列出必需的依赖
4. **测试充分**：在多个 Ubuntu/Debian 版本上测试
5. **文档完整**：提供 README、changelog 等文档

## 总结

制作 deb 包的基本步骤：

1. **准备文件**：组织应用程序文件
2. **创建包目录结构**：按照 FHS 标准组织
3. **创建 control 文件**：定义包的元数据
4. **设置文件权限**：确保可执行文件有执行权限
5. **使用 dpkg-deb 构建**：生成 `.deb` 文件
6. **测试安装和卸载**：验证包的正确性

通过正确配置，可以创建专业的 deb 安装包，方便在 Debian/Ubuntu 系统上分发和安装软件。

