---
sidebar_position: 3
slug: /java-environment-setup
sidebar_label: Java 开发环境搭建
---

# Java 开发环境搭建（JDK / IDE）

在开始编写 Java 程序之前，你需要先搭建好开发环境。本章将详细介绍如何在不同的操作系统上安装和配置 JDK，以及如何选择合适的 IDE。

## JDK 安装与配置

### 什么是 JDK

**JDK（Java Development Kit，Java 开发工具包）** 是开发 Java 应用程序所需的软件包，包含：

- **JRE（Java Runtime Environment）**：Java 运行环境
- **编译器（javac）**：将 Java 源代码编译为字节码
- **工具**：javadoc、jar、jdb 等
- **类库**：Java 标准库

### 选择 JDK 版本

**推荐版本**：
- **Java 17**：当前推荐的 LTS（长期支持）版本
- **Java 21**：最新的 LTS 版本
- **Java 11**：另一个 LTS 版本，仍在使用

**LTS 版本说明**：
- LTS（Long Term Support）版本会提供长期支持
- 生产环境推荐使用 LTS 版本
- 非 LTS 版本每 6 个月发布一次

### Windows 安装

#### 方法 1：Oracle JDK

1. **下载 JDK**：
   - 访问 [Oracle JDK 下载页面](https://www.oracle.com/java/technologies/downloads/)
   - 选择 Windows x64 Installer
   - 下载并运行安装程序

2. **安装**：
   - 运行安装程序
   - 选择安装路径（默认：`C:\Program Files\Java\jdk-17`）
   - 完成安装

3. **验证安装**：
   ```bash
   java -version
   javac -version
   ```

#### 方法 2：OpenJDK（推荐）

1. **下载 OpenJDK**：
   - 访问 [Adoptium](https://adoptium.net/)（原 AdoptOpenJDK）
   - 选择 Windows x64，JDK 17
   - 下载 `.msi` 安装包

2. **安装**：
   - 运行安装程序
   - 选择安装路径
   - **重要**：勾选 "Set JAVA_HOME variable" 和 "Add to PATH"

3. **验证**：
   ```bash
   java -version
   javac -version
   ```

### macOS 安装

#### 方法 1：使用 Homebrew（推荐）

```bash showLineNumbers
# 安装 Homebrew（如果还没有）
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 安装 OpenJDK
brew install openjdk@17

# 链接
sudo ln -sfn /opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-17.jdk
```

#### 方法 2：直接下载

1. 访问 [Adoptium](https://adoptium.net/)
2. 选择 macOS，下载 `.pkg` 安装包
3. 运行安装程序
4. 验证安装

### Linux 安装

#### Ubuntu/Debian

```bash showLineNumbers
# 更新包列表
sudo apt update

# 安装 OpenJDK 17
sudo apt install openjdk-17-jdk

# 验证
java -version
javac -version
```

#### CentOS/RHEL

```bash showLineNumbers
# 安装 OpenJDK 17
sudo yum install java-17-openjdk-devel

# 或使用 dnf（较新版本）
sudo dnf install java-17-openjdk-devel
```

## 配置环境变量

### Windows 配置

#### 方法 1：通过系统设置

1. **打开环境变量设置**：
   - 右键"此电脑" → "属性"
   - "高级系统设置" → "环境变量"

2. **设置 JAVA_HOME**：
   - 在"系统变量"中点击"新建"
   - 变量名：`JAVA_HOME`
   - 变量值：JDK 安装路径（如：`C:\Program Files\Java\jdk-17`）

3. **配置 PATH**：
   - 编辑"系统变量"中的 `Path`
   - 添加：`%JAVA_HOME%\bin`
   - 添加：`%JAVA_HOME%\jre\bin`

4. **验证**：
   ```bash
   echo %JAVA_HOME%
   java -version
   javac -version
   ```

#### 方法 2：通过命令行（临时）

```bash showLineNumbers
# 设置 JAVA_HOME（当前会话有效）
set JAVA_HOME=C:\Program Files\Java\jdk-17
set PATH=%JAVA_HOME%\bin;%PATH%
```

### macOS/Linux 配置

#### 方法 1：编辑 shell 配置文件

```bash showLineNumbers
# 编辑 ~/.bashrc 或 ~/.zshrc
nano ~/.bashrc

# 添加以下内容
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
export PATH=$JAVA_HOME/bin:$PATH

# 使配置生效
source ~/.bashrc

# 验证
echo $JAVA_HOME
java -version
```

#### 方法 2：使用 jenv（多版本管理）

```bash showLineNumbers
# 安装 jenv
brew install jenv

# 配置
echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(jenv init -)"' >> ~/.zshrc

# 添加 JDK
jenv add /usr/lib/jvm/java-17-openjdk
jenv global 17
```

### 环境变量说明

#### JAVA_HOME

- **作用**：指向 JDK 安装目录
- **用途**：IDE 和构建工具使用
- **示例**：`C:\Program Files\Java\jdk-17`

#### PATH

- **作用**：让系统能找到 `java` 和 `javac` 命令
- **内容**：`%JAVA_HOME%\bin` 或 `$JAVA_HOME/bin`

## 常用 IDE

### IntelliJ IDEA（推荐）

**最流行的 Java IDE**：

#### 特点

- **智能代码补全**：AI 辅助编程
- **强大的重构**：安全重构代码
- **集成工具**：Maven、Gradle、Git
- **插件丰富**：扩展功能

#### 版本选择

- **Community Edition（社区版）**：免费，功能足够
- **Ultimate Edition（旗舰版）**：付费，功能更强大

#### 安装

1. 访问 [JetBrains 官网](https://www.jetbrains.com/idea/)
2. 下载 Community Edition
3. 安装并启动
4. 创建新项目测试

#### 创建第一个项目

1. **New Project** → **Java**
2. 选择 JDK 版本
3. 选择项目模板
4. 输入项目名称
5. 创建并运行

### Eclipse

**经典的 Java IDE**：

#### 特点

- **免费开源**
- **插件丰富**
- **广泛使用**
- **轻量级**

#### 安装

1. 访问 [Eclipse 官网](https://www.eclipse.org/)
2. 下载 Eclipse IDE for Java Developers
3. 解压即可使用（无需安装）

### VS Code

**轻量级编辑器**：

#### 特点

- **轻量快速**
- **插件支持**
- **跨平台**
- **免费**

#### 配置 Java 开发环境

1. **安装扩展**：
   - Extension Pack for Java（Microsoft）
   - 包含多个 Java 相关扩展

2. **配置 JDK**：
   - 打开设置
   - 搜索 "java.home"
   - 设置 JDK 路径

3. **创建项目**：
   - 使用命令面板（Ctrl+Shift+P）
   - "Java: Create Java Project"

### 选择建议

| IDE | 适用场景 | 推荐度 |
|:---:|:-------:|:------:|
| IntelliJ IDEA | 专业开发、大型项目 | ⭐⭐⭐⭐⭐ |
| Eclipse | 学习、小型项目 | ⭐⭐⭐ |
| VS Code | 简单项目、多语言开发 | ⭐⭐⭐⭐ |

## 验证安装

### 检查 Java 版本

```bash showLineNumbers
# 检查 Java 运行时版本
java -version

# 输出示例：
# openjdk version "17.0.8" 2023-07-18
# OpenJDK Runtime Environment (build 17.0.8+7)
# OpenJDK 64-Bit Server VM (build 17.0.8+7, mixed mode, sharing)
```

### 检查编译器版本

```bash showLineNumbers
# 检查 Java 编译器版本
javac -version

# 输出示例：
# javac 17.0.8
```

### 测试编译和运行

创建测试文件 `Test.java`：

```java showLineNumbers title="Test.java"
public class Test {
    public static void main(String[] args) {
        System.out.println("Java 环境配置成功！");
    }
}
```

编译和运行：

```bash showLineNumbers
# 编译
javac Test.java

# 运行
java Test

# 输出：Java 环境配置成功！
```

## 常见问题

### 问题 1：`java` 命令找不到

**原因**：PATH 环境变量未配置或配置错误

**解决**：
1. 检查 JAVA_HOME 是否正确
2. 检查 PATH 是否包含 `%JAVA_HOME%\bin`
3. 重启终端或命令行窗口

### 问题 2：版本不匹配

**原因**：安装了多个 JDK 版本

**解决**：
1. 检查当前使用的版本：`java -version`
2. 确认 JAVA_HOME 指向正确的版本
3. 使用 `jenv` 或类似工具管理多版本

### 问题 3：IDE 找不到 JDK

**原因**：IDE 未配置 JDK 路径

**解决**：
1. 在 IDE 设置中配置 JDK 路径
2. IntelliJ IDEA：File → Project Structure → SDKs
3. Eclipse：Window → Preferences → Java → Installed JREs

## 小结

Java 开发环境搭建要点：

- **JDK 安装**：选择 LTS 版本（推荐 Java 17）
- **环境变量**：配置 JAVA_HOME 和 PATH
- **IDE 选择**：IntelliJ IDEA（推荐）、Eclipse、VS Code
- **验证安装**：使用 `java -version` 和 `javac -version`

**关键步骤**：
1. 下载并安装 JDK
2. 配置环境变量
3. 选择并安装 IDE
4. 验证安装成功

搭建好开发环境后，你就可以开始编写 Java 程序了。在下一章，我们将学习 Java 程序的基本结构。
