---
sidebar_position: 2
slug: /java-maven
sidebar_label: Maven 构建工具基础
---

# Maven 构建工具基础

Maven 是 Java 项目最常用的构建工具。理解 Maven 的使用是进行 Java 项目开发的基础。本章将详细介绍 Maven 的基础知识。

## POM 文件结构

### 什么是 POM

**POM**（Project Object Model）是 Maven 项目的核心配置文件，通常是 `pom.xml`。

### 基本 POM 结构

```xml showLineNumbers
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
         http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    
    <!-- 项目坐标 -->
    <groupId>com.example</groupId>
    <artifactId>myproject</artifactId>
    <version>1.0.0</version>
    <packaging>jar</packaging>
    
    <!-- 项目信息 -->
    <name>My Project</name>
    <description>项目描述</description>
    
    <!-- 属性 -->
    <properties>
        <maven.compiler.source>11</maven.compiler.source>
        <maven.compiler.target>11</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>
    
    <!-- 依赖 -->
    <dependencies>
        <!-- 依赖项 -->
    </dependencies>
    
    <!-- 构建配置 -->
    <build>
        <plugins>
            <!-- 插件 -->
        </plugins>
    </build>
</project>
```

### 项目坐标

**项目坐标**唯一标识一个项目：

- **`groupId`**：组织或公司标识（如 `com.example`）
- **`artifactId`**：项目标识（如 `myproject`）
- **`version`**：版本号（如 `1.0.0`）
- **`packaging`**：打包类型（jar、war、pom 等）

```xml showLineNumbers
<groupId>com.example</groupId>
<artifactId>myproject</artifactId>
<version>1.0.0</version>
<packaging>jar</packaging>
```

## 常用命令

**Maven 有三个内置生命周期**：

1. **clean**：清理项目
2. **default**：构建项目
3. **site**：生成项目站点

### compile（编译）

```bash showLineNumbers
# 编译源代码
mvn compile

# 编译源代码和测试代码
mvn test-compile
```

**作用**：将源代码编译成字节码，输出到 `target/classes`。

### package（打包）

```bash showLineNumbers
# 打包项目
mvn package
```

**作用**：编译、测试、打包项目，生成 JAR 或 WAR 文件。

### clean（清理）

```bash showLineNumbers
# 清理编译输出
mvn clean
```

**作用**：删除 `target` 目录。

### install（安装）

```bash showLineNumbers
# 安装到本地仓库
mvn install
```

**作用**：编译、测试、打包，并安装到本地 Maven 仓库。

### test（测试）

```bash showLineNumbers
# 运行测试
mvn test
```

**作用**：编译并运行测试代码。

### 组合命令

```bash showLineNumbers
# 清理并打包
mvn clean package

# 清理、编译、测试、打包
mvn clean compile test package

# 跳过测试打包
mvn clean package -DskipTests
```

## 依赖管理

### 添加依赖

**在 `pom.xml` 中添加依赖**：

```xml showLineNumbers
<dependencies>
    <!-- JUnit 测试框架 -->
    <dependency>
        <groupId>junit</groupId>
        <artifactId>junit</artifactId>
        <version>4.13.2</version>
        <scope>test</scope>
    </dependency>
    
    <!-- MySQL 驱动 -->
    <dependency>
        <groupId>mysql</groupId>
        <artifactId>mysql-connector-java</artifactId>
        <version>8.0.33</version>
    </dependency>
    
    <!-- Apache Commons Lang -->
    <dependency>
        <groupId>org.apache.commons</groupId>
        <artifactId>commons-lang3</artifactId>
        <version>3.12.0</version>
    </dependency>
</dependencies>
```

### 依赖坐标查找

**常用依赖坐标**：

```xml showLineNumbers
<!-- Spring Framework -->
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-core</artifactId>
    <version>5.3.21</version>
</dependency>

<!-- Jackson JSON -->
<dependency>
    <groupId>com.fasterxml.jackson.core</groupId>
    <artifactId>jackson-databind</artifactId>
    <version>2.13.3</version>
</dependency>

<!-- SLF4J 日志 -->
<dependency>
    <groupId>org.slf4j</groupId>
    <artifactId>slf4j-api</artifactId>
    <version>1.7.36</version>
</dependency>
```

### 依赖范围（scope）

**依赖范围**控制依赖的使用范围：

```xml showLineNumbers
<dependency>
    <groupId>junit</groupId>
    <artifactId>junit</artifactId>
    <version>4.13.2</version>
    <scope>test</scope>  <!-- 只在测试时使用 -->
</dependency>

<dependency>
    <groupId>javax.servlet</groupId>
    <artifactId>javax.servlet-api</artifactId>
    <version>4.0.1</version>
    <scope>provided</scope>  <!-- 由容器提供 -->
</dependency>
```

**常用 scope**：
- **compile**：默认，编译和运行时都可用
- **test**：只在测试时可用
- **provided**：编译时可用，运行时由容器提供
- **runtime**：运行时可用，编译时不需要

## 实际示例

### 示例 1：基本 POM 文件

```xml showLineNumbers
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
         http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    
    <groupId>com.example</groupId>
    <artifactId>myproject</artifactId>
    <version>1.0.0</version>
    <packaging>jar</packaging>
    
    <name>My Project</name>
    
    <properties>
        <maven.compiler.source>11</maven.compiler.source>
        <maven.compiler.target>11</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>
    
    <dependencies>
        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <version>4.13.2</version>
            <scope>test</scope>
        </dependency>
    </dependencies>
</project>
```

### 示例 2：Web 应用 POM

```xml showLineNumbers
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
         http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    
    <groupId>com.example</groupId>
    <artifactId>webapp</artifactId>
    <version>1.0.0</version>
    <packaging>war</packaging>
    
    <properties>
        <maven.compiler.source>11</maven.compiler.source>
        <maven.compiler.target>11</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>
    
    <dependencies>
        <!-- Servlet API -->
        <dependency>
            <groupId>javax.servlet</groupId>
            <artifactId>javax.servlet-api</artifactId>
            <version>4.0.1</version>
            <scope>provided</scope>
        </dependency>
        
        <!-- JSP API -->
        <dependency>
            <groupId>javax.servlet.jsp</groupId>
            <artifactId>jsp-api</artifactId>
            <version>2.2</version>
            <scope>provided</scope>
        </dependency>
    </dependencies>
    
    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-war-plugin</artifactId>
                <version>3.2.3</version>
            </plugin>
        </plugins>
    </build>
</project>
```

### 示例 3：使用插件

```xml showLineNumbers
<build>
    <plugins>
        <!-- 编译插件 -->
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-compiler-plugin</artifactId>
            <version>3.8.1</version>
            <configuration>
                <source>11</source>
                <target>11</target>
            </configuration>
        </plugin>
        
        <!-- 打包可执行 JAR -->
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-shade-plugin</artifactId>
            <version>3.2.4</version>
            <executions>
                <execution>
                    <phase>package</phase>
                    <goals>
                        <goal>shade</goal>
                    </goals>
                    <configuration>
                        <transformers>
                            <transformer implementation="org.apache.maven.plugins.shade.resource.ManifestResourceTransformer">
                                <mainClass>com.example.Main</mainClass>
                            </transformer>
                        </transformers>
                    </configuration>
                </execution>
            </executions>
        </plugin>
    </plugins>
</build>
```

## Maven 的最佳实践

### 1. 使用属性管理版本

```xml showLineNumbers
<properties>
    <junit.version>4.13.2</junit.version>
    <spring.version>5.3.21</spring.version>
</properties>

<dependencies>
    <dependency>
        <groupId>junit</groupId>
        <artifactId>junit</artifactId>
        <version>${junit.version}</version>
    </dependency>
</dependencies>
```

### 2. 使用依赖管理

```xml showLineNumbers
<dependencyManagement>
    <dependencies>
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-framework-bom</artifactId>
            <version>5.3.21</version>
            <type>pom</type>
            <scope>import</scope>
        </dependency>
    </dependencies>
</dependencyManagement>
```

### 3. 合理使用 scope

```xml showLineNumbers
<!-- 测试依赖 -->
<dependency>
    <scope>test</scope>
</dependency>

<!-- 容器提供的依赖 -->
<dependency>
    <scope>provided</scope>
</dependency>
```

## 小结

Maven 构建工具基础要点：

- **POM 文件**：项目配置文件，定义项目坐标和依赖
- **常用命令**：compile、package、clean、install、test
- **依赖管理**：在 pom.xml 中声明依赖
- **依赖范围**：使用 scope 控制依赖的使用范围
- **插件**：扩展 Maven 功能

**关键要点**：
- POM 文件是 Maven 项目的核心
- 使用标准命令进行构建
- 在 pom.xml 中管理依赖
- 合理使用依赖范围
- 使用插件扩展功能

理解了 Maven 基础，你就能管理 Java 项目。在下一章，我们将学习 Java 依赖管理与构建流程。
