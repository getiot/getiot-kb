---
sidebar_position: 1
slug: /java-project-structure
sidebar_label: Java 项目结构规范
---

# Java 项目结构规范

良好的项目结构是软件开发的基础。理解标准的项目结构规范有助于团队协作和项目维护。本章将详细介绍 Java 项目的标准结构。

## Maven 标准目录结构

### Maven 目录结构

**Maven 标准目录结构**是 Java 项目最常用的结构。

```bash showLineNumbers
project-root/
├── pom.xml                   # Maven 配置文件
├── src/
│   ├── main/
│   │   ├── java/             # 主代码目录
│   │   │   └── com/
│   │   │       └── example/
│   │   │           └── App.java
│   │   ├── resources/        # 资源文件目录
│   │   │   ├── application.properties
│   │   │   └── log4j.xml
│   │   └── webapp/           # Web 应用资源（如果适用）
│   │       └── WEB-INF/
│   └── test/
│       ├── java/             # 测试代码目录
│       │   └── com/
│       │       └── example/
│       │           └── AppTest.java
│       └── resources/        # 测试资源文件
│           └── test-config.properties
└── target/                   # 编译输出目录（自动生成）
    ├── classes/
    └── test-classes/
```

### 目录说明

**主要目录**：
- **`src/main/java`**：主源代码目录
- **`src/main/resources`**：主资源文件目录
- **`src/test/java`**：测试源代码目录
- **`src/test/resources`**：测试资源文件目录
- **`target`**：编译输出目录（Maven 自动生成）

## src/main/java / src/test/java

### 主代码目录（src/main/java）

**`src/main/java`** 存放项目的主要源代码。

**包结构示例**：

```bash showLineNumbers
src/main/java/
└── com/
    └── example/
        └── myapp/
            ├── Main.java             # 主类
            ├── model/                # 数据模型
            │   ├── User.java
            │   └── Product.java
            ├── service/              # 业务逻辑
            │   ├── UserService.java
            │   └── ProductService.java
            ├── dao/                  # 数据访问
            │   ├── UserDao.java
            │   └── ProductDao.java
            ├── controller/           # 控制器（Web 应用）
            │   └── UserController.java
            ├── util/                 # 工具类
            │   └── StringUtils.java
            └── config/               # 配置类
                └── AppConfig.java
```

### 测试代码目录（src/test/java）

**`src/test/java`** 存放测试代码，结构与主代码对应。

```bash showLineNumbers
src/test/java/
└── com/
    └── example/
        └── myapp/
            ├── service/
            │   ├── UserServiceTest.java
            │   └── ProductServiceTest.java
            ├── dao/
            │   └── UserDaoTest.java
            └── util/
                └── StringUtilsTest.java
```

### 包命名规范

**包命名规则**：
- 使用小写字母
- 使用域名倒序（如 `com.example.myapp`）
- 多个单词用点分隔
- 避免使用 Java 关键字

```java
// ✅ 正确
package com.example.myapp.service;
package org.apache.commons.lang3;

// ❌ 错误
package com.example.MyApp;  // 包含大写
package com.example.class;  // 使用关键字
```

## 资源文件与配置文件

### 资源文件目录（src/main/resources）

**`src/main/resources`** 存放资源文件，编译时会被复制到 classpath。

**常见资源文件**：

```bash showLineNumbers
src/main/resources/
├── application.properties      # 应用配置
├── application.yml             # YAML 配置
├── log4j2.xml                  # 日志配置
├── db.properties               # 数据库配置
├── messages.properties         # 国际化资源
├── spring/
│   └── applicationContext.xml  # Spring 配置
└── static/                     # 静态资源
    ├── css/
    ├── js/
    └── images/
```

### 配置文件示例

**application.properties**：

```bash showLineNumbers
# 数据库配置
db.url=jdbc:mysql://localhost:3306/mydb
db.username=root
db.password=password

# 应用配置
app.name=My Application
app.version=1.0.0

# 日志配置
logging.level.root=INFO
logging.level.com.example=DEBUG
```

**log4j2.xml**：

```xml showLineNumbers
<?xml version="1.0" encoding="UTF-8"?>
<Configuration>
    <Appenders>
        <Console name="Console" target="SYSTEM_OUT">
            <PatternLayout pattern="%d{yyyy-MM-dd HH:mm:ss} %-5level %logger{36} - %msg%n"/>
        </Console>
    </Appenders>
    <Loggers>
        <Root level="info">
            <AppenderRef ref="Console"/>
        </Root>
    </Loggers>
</Configuration>
```

### 测试资源文件（src/test/resources）

**`src/test/resources`** 存放测试用的资源文件。

```bash showLineNumbers
src/test/resources/
├── test-config.properties      # 测试配置
├── test-data.json              # 测试数据
└── test-db.properties          # 测试数据库配置
```

## 实际项目结构示例

### 示例 1：标准 Java 项目

```bash showLineNumbers
myproject/
├── pom.xml
├── README.md
├── .gitignore
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/
│   │   │       └── example/
│   │   │           └── myproject/
│   │   │               ├── Main.java
│   │   │               ├── model/
│   │   │               ├── service/
│   │   │               └── util/
│   │   └── resources/
│   │       ├── application.properties
│   │       └── log4j2.xml
│   └── test/
│       ├── java/
│       │   └── com/
│       │       └── example/
│       │           └── myproject/
│       │               └── service/
│       │                   └── ServiceTest.java
│       └── resources/
│           └── test-config.properties
└── target/
```

### 示例 2：Web 应用项目

```bash showLineNumbers
webapp/
├── pom.xml
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/
│   │   │       └── example/
│   │   │           └── webapp/
│   │   │               ├── controller/
│   │   │               ├── service/
│   │   │               ├── model/
│   │   │               └── config/
│   │   ├── resources/
│   │   │   ├── application.properties
│   │   │   └── spring/
│   │   │       └── applicationContext.xml
│   │   └── webapp/
│   │       ├── WEB-INF/
│   │       │   └── web.xml
│   │       ├── index.jsp
│   │       └── static/
│   │           ├── css/
│   │           ├── js/
│   │           └── images/
│   └── test/
│       └── java/
└── target/
```

## 项目结构的最佳实践

### 1. 遵循 Maven 标准结构

```bash showLineNumbers
# ✅ 推荐：使用标准 Maven 结构
src/main/java/
src/main/resources/
src/test/java/
src/test/resources/
```

### 2. 合理的包结构

```bash showLineNumbers
# ✅ 推荐：按功能分层
com.example.myapp.model
com.example.myapp.service
com.example.myapp.dao
com.example.myapp.controller

# ❌ 不推荐：扁平结构
com.example.myapp.User
com.example.myapp.UserService
com.example.myapp.UserDao
```

### 3. 资源文件组织

```bash showLineNumbers
# ✅ 推荐：按类型组织
resources/
  ├── config/
  ├── static/
  └── i18n/
```

### 4. 测试代码对应主代码

```bash showLineNumbers
# ✅ 推荐：测试代码结构与主代码对应
src/main/java/com/example/Service.java
src/test/java/com/example/ServiceTest.java
```

## 小结

Java 项目结构规范要点：

- **Maven 标准结构**：src/main/java、src/test/java
- **包命名规范**：域名倒序，小写字母
- **资源文件**：src/main/resources、src/test/resources
- **目录组织**：按功能分层，结构清晰
- **测试对应**：测试代码结构与主代码对应

**关键要点**：

- 遵循 Maven 标准目录结构
- 使用合理的包结构
- 资源文件放在 resources 目录
- 测试代码与主代码结构对应
- 保持项目结构清晰一致

理解了项目结构规范，你就能组织好 Java 项目。在下一章，我们将学习 Maven 构建工具基础。
