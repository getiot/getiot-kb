---
sidebar_position: 3
slug: /java-build-lifecycle
sidebar_label: Java 依赖管理与构建流程
---

# Java 依赖管理与构建流程

理解 Maven 的生命周期和依赖管理是进行高效项目构建的关键。本章将详细介绍 Java 的依赖管理与构建流程。

## Maven 生命周期阶段

### Maven 生命周期

**Maven 有三个内置生命周期**：

1. **clean**：清理项目
2. **default**：构建项目
3. **site**：生成项目站点

### default 生命周期阶段

**default 生命周期的主要阶段**（按顺序执行）：

1. **validate**：验证项目正确性
2. **compile**：编译源代码
3. **test-compile**：编译测试代码
4. **test**：运行测试
5. **package**：打包项目
6. **verify**：验证集成测试
7. **install**：安装到本地仓库
8. **deploy**：部署到远程仓库

```bash
# 执行到 compile 阶段（包括 validate、compile）
mvn compile

# 执行到 test 阶段（包括前面的所有阶段）
mvn test

# 执行到 package 阶段
mvn package

# 执行到 install 阶段
mvn install
```

### clean 生命周期阶段

**clean 生命周期阶段**：

1. **pre-clean**：清理前执行
2. **clean**：清理项目
3. **post-clean**：清理后执行

```bash
# 执行 clean 阶段
mvn clean

# 清理并打包
mvn clean package
```

## 依赖范围

**依赖范围**（scope）控制依赖在哪些阶段可用。

### compile（默认）

**`compile`** 是默认范围，编译和运行时都可用。

```xml
<dependency>
    <groupId>org.apache.commons</groupId>
    <artifactId>commons-lang3</artifactId>
    <version>3.12.0</version>
    <!-- scope 默认为 compile -->
</dependency>
```

**特点**：
- 编译时可用
- 运行时可用
- 打包时包含

### test

**`test`** 只在测试时可用。

```xml
<dependency>
    <groupId>junit</groupId>
    <artifactId>junit</artifactId>
    <version>4.13.2</version>
    <scope>test</scope>
</dependency>
```

**特点**：
- 编译测试代码时可用
- 运行测试时可用
- 编译主代码时不可用
- 打包时不包含

### provided

**`provided`** 由容器或 JDK 提供。

```xml
<dependency>
    <groupId>javax.servlet</groupId>
    <artifactId>javax.servlet-api</artifactId>
    <version>4.0.1</version>
    <scope>provided</scope>
</dependency>
```

**特点**：
- 编译时可用
- 运行时由容器提供
- 打包时不包含

### runtime

**`runtime`** 运行时可用，编译时不需要。

```xml
<dependency>
    <groupId>mysql</groupId>
    <artifactId>mysql-connector-java</artifactId>
    <version>8.0.33</version>
    <scope>runtime</scope>
</dependency>
```

**特点**：
- 编译时不可用
- 运行时可用
- 打包时包含

### 依赖范围对比

| scope | 编译时 | 测试时 | 运行时 | 打包 |
|:-----:|:-----:|:-----:|:-----:|:----:|
| compile | ✅ | ✅ | ✅ | ✅ |
| test | ❌ | ✅ | ❌ | ❌ |
| provided | ✅ | ✅ | ❌ | ❌ |
| runtime | ❌ | ✅ | ✅ | ✅ |

## 插件与构建优化

### 常用插件

#### 编译插件

```xml
<build>
    <plugins>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-compiler-plugin</artifactId>
            <version>3.8.1</version>
            <configuration>
                <source>11</source>
                <target>11</target>
                <encoding>UTF-8</encoding>
            </configuration>
        </plugin>
    </plugins>
</build>
```

#### 打包可执行 JAR

```xml
<build>
    <plugins>
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

#### 测试插件

```xml
<build>
    <plugins>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-surefire-plugin</artifactId>
            <version>2.22.2</version>
            <configuration>
                <skipTests>false</skipTests>
            </configuration>
        </plugin>
    </plugins>
</build>
```

### 构建优化

#### 1. 跳过测试

```bash
# 跳过测试
mvn package -DskipTests

# 跳过测试编译
mvn package -Dmaven.test.skip=true
```

#### 2. 并行构建

```xml
<build>
    <plugins>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-compiler-plugin</artifactId>
            <configuration>
                <compilerArgs>
                    <arg>-J-XX:+TieredCompilation</arg>
                    <arg>-J-XX:TieredStopAtLevel=1</arg>
                </compilerArgs>
            </configuration>
        </plugin>
    </plugins>
</build>
```

#### 3. 依赖优化

```xml
<!-- 排除传递依赖 -->
<dependency>
    <groupId>com.example</groupId>
    <artifactId>library</artifactId>
    <version>1.0.0</version>
    <exclusions>
        <exclusion>
            <groupId>org.unwanted</groupId>
            <artifactId>unwanted-lib</artifactId>
        </exclusion>
    </exclusions>
</dependency>
```

## 实际示例

### 示例 1：完整构建流程

```bash
# 1. 清理
mvn clean

# 2. 编译
mvn compile

# 3. 编译测试
mvn test-compile

# 4. 运行测试
mvn test

# 5. 打包
mvn package

# 6. 安装
mvn install

# 或一次性执行
mvn clean install
```

### 示例 2：依赖管理示例

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
         http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    
    <groupId>com.example</groupId>
    <artifactId>myproject</artifactId>
    <version>1.0.0</version>
    
    <properties>
        <maven.compiler.source>11</maven.compiler.source>
        <maven.compiler.target>11</maven.compiler.target>
    </properties>
    
    <dependencies>
        <!-- compile 范围（默认） -->
        <dependency>
            <groupId>org.apache.commons</groupId>
            <artifactId>commons-lang3</artifactId>
            <version>3.12.0</version>
        </dependency>
        
        <!-- test 范围 -->
        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <version>4.13.2</version>
            <scope>test</scope>
        </dependency>
        
        <!-- provided 范围 -->
        <dependency>
            <groupId>javax.servlet</groupId>
            <artifactId>javax.servlet-api</artifactId>
            <version>4.0.1</version>
            <scope>provided</scope>
        </dependency>
        
        <!-- runtime 范围 -->
        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
            <version>8.0.33</version>
            <scope>runtime</scope>
        </dependency>
    </dependencies>
    
    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.8.1</version>
                <configuration>
                    <source>11</source>
                    <target>11</target>
                </configuration>
            </plugin>
        </plugins>
    </build>
</project>
```

### 示例 3：多模块项目

**父 POM**：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
         http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    
    <groupId>com.example</groupId>
    <artifactId>parent-project</artifactId>
    <version>1.0.0</version>
    <packaging>pom</packaging>
    
    <modules>
        <module>module1</module>
        <module>module2</module>
    </modules>
    
    <dependencyManagement>
        <dependencies>
            <dependency>
                <groupId>junit</groupId>
                <artifactId>junit</artifactId>
                <version>4.13.2</version>
            </dependency>
        </dependencies>
    </dependencyManagement>
</project>
```

**子模块 POM**：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
         http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    
    <parent>
        <groupId>com.example</groupId>
        <artifactId>parent-project</artifactId>
        <version>1.0.0</version>
    </parent>
    
    <artifactId>module1</artifactId>
    
    <dependencies>
        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <!-- 版本由父 POM 管理 -->
        </dependency>
    </dependencies>
</project>
```

## 构建流程的最佳实践

### 1. 使用依赖管理

```xml
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

### 2. 合理使用依赖范围

```xml
<!-- 测试依赖使用 test scope -->
<dependency>
    <scope>test</scope>
</dependency>

<!-- 容器提供的依赖使用 provided scope -->
<dependency>
    <scope>provided</scope>
</dependency>
```

### 3. 优化构建速度

```bash
# 使用离线模式（如果依赖已下载）
mvn -o package

# 跳过测试
mvn package -DskipTests
```

## 小结

Java 依赖管理与构建流程要点：

- **Maven 生命周期**：clean、default、site
- **生命周期阶段**：validate、compile、test、package、install
- **依赖范围**：compile、test、provided、runtime
- **插件**：扩展构建功能
- **构建优化**：跳过测试、并行构建、依赖优化

**关键要点**：
- 理解 Maven 生命周期和阶段
- 合理使用依赖范围
- 使用插件扩展功能
- 优化构建速度
- 管理多模块项目

理解了依赖管理与构建流程，你就能高效地构建 Java 项目。在下一章，我们将学习 Java 日志框架。
