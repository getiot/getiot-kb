---
sidebar_position: 4
---

# Linux 制作 rpm 包

RPM（Red Hat Package Manager）是 Red Hat 及其衍生发行版（如 CentOS、Fedora、SUSE）使用的软件包格式。它包含了软件的所有文件、元数据信息以及安装脚本，可以方便地在这些系统上安装、升级和卸载软件。

## 什么是 rpm 包

RPM 是 Red Hat Package Manager 的缩写，是 Red Hat 及其衍生发行版的标准软件包格式。rpm 包的主要特点包括：

- **标准化**：遵循 RPM 规范，确保兼容性
- **依赖管理**：自动处理软件依赖关系
- **版本控制**：支持版本管理和升级
- **安装脚本**：支持安装前后执行自定义脚本
- **广泛支持**：所有基于 Red Hat 的发行版都支持

**适用场景**：
- CentOS/RHEL/Fedora/SUSE 系统软件分发
- 系统级软件安装
- 需要依赖管理的软件
- 需要集成到包管理系统的软件

## 必备知识

在开始制作 rpm 包之前，你需要了解：

1. **Linux 基础知识**：熟悉命令行操作和文件系统结构
2. **RPM 文件系统层次标准（FHS）**：了解系统目录结构
3. **包管理基础**：了解 `rpm`、`yum`/`dnf` 等工具的基本使用
4. **Shell 脚本**：能够编写简单的安装脚本
5. **SPEC 文件**：了解 RPM SPEC 文件的语法

## rpm 包结构

rpm 包结构包含两部分：

- **RPM 头部**：包含包的元数据和安装脚本
- **CPIO 归档**：包含按照 Linux 文件系统标准组织的文件

### SPEC 文件结构

SPEC 文件是制作 rpm 包的核心，定义了包的构建规则。主要部分包括：

- **`Preamble`（前言）**：包的基本信息（名称、版本、描述等）
- **`%prep`**：准备阶段，解压源码
- **`%build`**：构建阶段，编译源码
- **`%install`**：安装阶段，将文件复制到构建根目录
- **`%files`**：文件列表，定义哪些文件要打包
- **`%changelog`**：变更日志

## 准备工作

### 安装必要工具

```bash
# CentOS/RHEL 7
sudo yum install -y rpm-build rpmdevtools

# CentOS/RHEL 8+ / Fedora
sudo dnf install -y rpm-build rpmdevtools

# SUSE
sudo zypper install -y rpm-build rpmdevtools
```

### 设置构建环境

```bash
# 创建 RPM 构建目录结构
rpmdev-setuptree

# 查看创建的目录
ls -la ~/rpmbuild/
```

创建的目录结构：

```bash
~/rpmbuild/
├── BUILD/       # 构建目录
├── BUILDROOT/   # 构建根目录（安装文件的位置）
├── RPMS/        # 构建的二进制 RPM 包
├── SOURCES/     # 源码文件
├── SPECS/       # SPEC 文件
└── SRPMS/       # 源码 RPM 包
```

## 制作 rpm 包的方法

### 方法一：使用 rpmbuild 手动创建（推荐）

这是最基础的方法，适合学习 rpm 包的结构和制作过程。

#### 步骤 1：准备源码

```bash
# 创建源码目录
mkdir -p myapp-1.0.0
cd myapp-1.0.0

# 创建简单的应用程序
cat > myapp.sh << 'EOF'
#!/bin/bash
echo "Hello from myapp!"
echo "Version: 1.0.0"
EOF

chmod +x myapp.sh

# 创建 README
echo "# MyApp" > README.md

# 创建压缩包
cd ..
tar -czf myapp-1.0.0.tar.gz myapp-1.0.0

# 复制到 SOURCES 目录
cp myapp-1.0.0.tar.gz ~/rpmbuild/SOURCES/
```

#### 步骤 2：创建 SPEC 文件

```bash showLineNumbers title="~/rpmbuild/SPECS/myapp.spec"
Name:           myapp
Version:        1.0.0
Release:        1%{?dist}
Summary:        A simple demonstration application
License:        GPLv3+
Source0:        %{name}-%{version}.tar.gz

BuildArch:      noarch

%description
This is a simple shell script application used to
demonstrate rpm package creation.

%prep
%setup -q

%build
# No build step needed for shell script

%install
mkdir -p %{buildroot}%{_bindir}
mkdir -p %{buildroot}%{_docdir}/%{name}
install -m 755 myapp.sh %{buildroot}%{_bindir}/myapp
install -m 644 README.md %{buildroot}%{_docdir}/%{name}/

%files
%{_bindir}/myapp
%doc %{_docdir}/%{name}/README.md

%changelog
* Mon Jan 01 2024 Your Name <your.email@example.com> - 1.0.0-1
- Initial release
```

#### 步骤 3：构建 rpm 包

```bash
# 构建二进制 RPM 包
rpmbuild -ba ~/rpmbuild/SPECS/myapp.spec

# 构建完成后，RPM 包位于
ls -lh ~/rpmbuild/RPMS/noarch/myapp-1.0.0-1.*.rpm
ls -lh ~/rpmbuild/SRPMS/myapp-1.0.0-1.*.src.rpm
```

#### 步骤 4：安装和测试

```bash
# 安装
sudo rpm -ivh ~/rpmbuild/RPMS/noarch/myapp-1.0.0-1.*.rpm

# 或使用 yum/dnf
sudo yum install ~/rpmbuild/RPMS/noarch/myapp-1.0.0-1.*.rpm
# 或
sudo dnf install ~/rpmbuild/RPMS/noarch/myapp-1.0.0-1.*.rpm

# 测试
myapp

# 查看包信息
rpm -qi myapp

# 查看包内容
rpm -ql myapp

# 卸载
sudo rpm -e myapp
```

### 方法二：使用 rpmdevtools 快速创建

`rpmdevtools` 提供了快速创建 SPEC 文件的工具：

```bash
# 使用 rpmdev-newspec 创建模板
cd ~/rpmbuild/SPECS
rpmdev-newspec myapp

# 编辑生成的模板
vim myapp.spec
```

### 方法三：从现有 rpm 包提取 SPEC 文件

如果需要修改现有的 rpm 包：

```bash
# 下载源码 RPM 包
wget http://example.com/myapp-1.0.0-1.src.rpm

# 安装源码包（提取 SPEC 和源码）
rpm -ivh myapp-1.0.0-1.src.rpm

# SPEC 文件会在 ~/rpmbuild/SPECS/
# 源码会在 ~/rpmbuild/SOURCES/

# 修改 SPEC 文件
vim ~/rpmbuild/SPECS/myapp.spec

# 重新构建
rpmbuild -ba ~/rpmbuild/SPECS/myapp.spec
```

## SPEC 文件详解

### Preamble（前言部分）

```bash showLineNumbers
Name:           myapp              # 包名
Version:        1.0.0              # 版本号
Release:        1%{?dist}          # 发布号
Summary:        Short description  # 简短描述
License:        GPLv3+             # 许可证
URL:            http://example.com # 项目主页
Source0:        %{name}-%{version}.tar.gz  # 源码文件
BuildArch:      noarch             # 架构（noarch 表示平台无关）
BuildRequires:  gcc, make          # 构建依赖
Requires:       bash >= 4.0        # 运行时依赖
```

### 宏定义

RPM 使用宏来定义标准路径：

- `%{_bindir}`：`/usr/bin`
- `%{_sbindir}`：`/usr/sbin`
- `%{_libdir}`：`/usr/lib64` 或 `/usr/lib`
- `%{_docdir}`：`/usr/share/doc`
- `%{_datadir}`：`/usr/share`
- `%{_sysconfdir}`：`/etc`
- `%{_localstatedir}`：`/var`

### 构建阶段

```bash showLineNumbers
%prep
# 准备阶段：解压源码、打补丁等
%setup -q

%build
# 构建阶段：编译源码
./configure
make %{?_smp_mflags}

%install
# 安装阶段：将文件复制到构建根目录
mkdir -p %{buildroot}%{_bindir}
install -m 755 myapp %{buildroot}%{_bindir}/

%files
# 文件列表：定义哪些文件要打包
%{_bindir}/myapp
%doc README.md
```

### 脚本部分

```bash showLineNumbers
%pre
# 安装前执行的脚本
echo "Preparing to install myapp..."

%post
# 安装后执行的脚本
echo "myapp installed successfully"

%preun
# 卸载前执行的脚本
echo "Preparing to remove myapp..."

%postun
# 卸载后执行的脚本
echo "myapp removed successfully"
```

## 实际示例：打包一个 C 程序

让我们创建一个完整的示例：

### 1. 准备源码

创建源码目录：

```bash
mkdir -p myapp-1.0.0
cd myapp-1.0.0
```

创建简单的 C 程序：

```c showLineNumbers title="myapp.c"
#include <stdio.h>
int main() {
    printf("Hello from myapp!\n");
    printf("Version: 1.0.0\n");
    return 0;
}
```

创建 Makefile 文件：

```makefile showLineNumbers title="Makefile"
CC=gcc
CFLAGS=-Wall
TARGET=myapp
SOURCE=myapp.c

$(TARGET): $(SOURCE)
	$(CC) $(CFLAGS) -o $(TARGET) $(SOURCE)

clean:
	rm -f $(TARGET)

install: $(TARGET)
	install -d $(DESTDIR)/usr/bin
	install -m 755 $(TARGET) $(DESTDIR)/usr/bin/

.PHONY: clean install
```

创建 README.md 文件：

```bash
echo "# MyApp" > README.md
```

创建压缩包：

```bash
cd ..
tar -czf myapp-1.0.0.tar.gz myapp-1.0.0
cp myapp-1.0.0.tar.gz ~/rpmbuild/SOURCES/
```

### 2. 创建 SPEC 文件

```bash showLineNumbers title="~/rpmbuild/SPECS/myapp.spec"
Name:           myapp
Version:        1.0.0
Release:        1%{?dist}
Summary:        A simple C application
License:        GPLv3+
Source0:        %{name}-%{version}.tar.gz

BuildRequires:  gcc, make
Requires:       glibc

%description
This is a simple C application used to demonstrate
rpm package creation.

%prep
%setup -q

%build
make %{?_smp_mflags}

%install
make install DESTDIR=%{buildroot}

%files
%{_bindir}/myapp
%doc README.md

%changelog
* Mon Jan 01 2024 Your Name <your.email@example.com> - 1.0.0-1
- Initial release
```

### 3. 构建包

```bash
rpmbuild -ba ~/rpmbuild/SPECS/myapp.spec
```

### 4. 安装测试

```bash
sudo rpm -ivh ~/rpmbuild/RPMS/*/myapp-1.0.0-1.*.rpm
myapp
```

## 版本号格式

RPM 包的版本号格式为：`version-release`

- **version**：上游版本号（如 `1.0.0`）
- **release**：RPM 发布号（如 `1`、`1.el7`、`1.fc33`）

**示例**：
- `1.0.0-1`：第一次打包
- `1.0.0-2`：只修改打包方式，上游版本不变
- `1.0.1-1`：上游发布新版本

## 常见问题排查

#### 1. 依赖问题

如果安装时提示依赖缺失：

```bash
# 检查 SPEC 文件中的 Requires 字段
grep Requires ~/rpmbuild/SPECS/myapp.spec

# 查看包的依赖
rpm -qpR ~/rpmbuild/RPMS/*/myapp-*.rpm

# 安装缺失的依赖
sudo yum install missing-package
```

#### 2. 构建失败

```bash
# 查看构建日志
cat ~/rpmbuild/BUILD/myapp-*/build.log

# 检查 SPEC 文件语法
rpmlint ~/rpmbuild/SPECS/myapp.spec

# 清理并重新构建
rpmbuild --clean ~/rpmbuild/SPECS/myapp.spec
rpmbuild -ba ~/rpmbuild/SPECS/myapp.spec
```

#### 3. 文件未包含在包中

确保 `%files` 部分列出了所有需要的文件：

```bash
%files
%{_bindir}/myapp
%doc README.md
%config(noreplace) %{_sysconfdir}/myapp.conf
```

#### 4. 权限问题

在 `%install` 阶段设置正确的权限：

```bash
%install
install -d %{buildroot}%{_bindir}
install -m 755 myapp %{buildroot}%{_bindir}/
```

## 最佳实践

1. **遵循 FHS**：按照 Linux 文件系统标准组织文件
2. **版本号管理**：使用语义化版本规范
3. **依赖最小化**：只列出必需的依赖
4. **测试充分**：在多个发行版版本上测试
5. **文档完整**：提供 README、changelog 等文档
6. **使用宏**：使用 RPM 宏而不是硬编码路径

## 总结

制作 rpm 包的基本步骤：1. **准备源码**：组织应用程序源码
2. **设置构建环境**：使用 `rpmdev-setuptree` 创建目录结构
3. **创建 SPEC 文件**：定义包的构建规则
4. **准备源码包**：将源码打包并放入 SOURCES 目录
5. **构建 rpm 包**：使用 `rpmbuild` 构建
6. **测试安装和卸载**：验证包的正确性通过正确配置 SPEC 文件，可以创建专业的 rpm 安装包，方便在 CentOS/RHEL/Fedora/SUSE 系统上分发和安装软件。## 参考- [RPM 官方文档](https://rpm.org/documentation.html)
- [Fedora 打包指南](https://docs.fedoraproject.org/en-US/packaging-guidelines/)
- [CentOS 打包指南](https://wiki.centos.org/HowTos/SetupRpmBuildEnvironment)