---
sidebar_position: 5
slug: /java-module
sidebar_label: Java 模块系统
---

# Java 模块系统（Java 9）

Java 模块系统（Java Platform Module System，JPMS）是 Java 9 引入的重要特性，用于管理代码组织和依赖关系。理解模块系统的使用是进行大型项目开发的基础。本章将详细介绍 Java 中的模块系统。

## module-info.java

### 什么是模块

**模块**是一个命名的、自描述的代码和数据的集合。

**模块的特点**：
- 有明确的边界
- 声明依赖关系
- 控制导出和访问

### module-info.java 文件

**`module-info.java`** 是模块描述文件，位于模块根目录。

```java
module com.example.mymodule {
    // 模块声明
}
```

**文件结构**：
```
mymodule/
├── module-info.java
└── com/
    └── example/
        └── mymodule/
            └── MyClass.java
```

## 模块声明与导出

### 基本模块声明

```java
module com.example.mymodule {
    // 模块体
}
```

### 导出包（exports）

**`exports`** 用于导出包，使其他模块可以访问。

```java
module com.example.mymodule {
    // 导出包
    exports com.example.mymodule.api;
    exports com.example.mymodule.util;
    
    // 其他模块可以访问这些包中的 public 类
}
```

### 导出到特定模块（exports ... to）

```java
module com.example.mymodule {
    // 只导出给特定模块
    exports com.example.mymodule.internal to com.example.othermodule;
}
```

### 依赖模块（requires）

**`requires`** 用于声明模块依赖。

```java
module com.example.mymodule {
    // 依赖其他模块
    requires java.base;  // 隐式依赖，可以省略
    requires java.sql;
    requires com.example.othermodule;
    
    // 传递依赖
    requires transitive com.example.common;
}
```

### 使用服务（uses）

**`uses`** 用于声明使用的服务。

```java
module com.example.mymodule {
    uses com.example.service.MyService;
}
```

### 提供服务（provides ... with）

**`provides`** 用于提供服务实现。

```java
module com.example.mymodule {
    provides com.example.service.MyService 
        with com.example.service.impl.MyServiceImpl;
}
```

### 打开包（opens）

**`opens`** 用于开放包，允许反射访问。

```java
module com.example.mymodule {
    // 开放包给所有模块
    opens com.example.mymodule.reflection;
    
    // 开放包给特定模块
    opens com.example.mymodule.reflection to com.example.othermodule;
}
```

## 模块依赖示例

### 示例 1：简单模块

**模块 A（com.example.modulea）**：

```java
// module-info.java
module com.example.modulea {
    exports com.example.modulea.api;
}

// com/example/modulea/api/ServiceA.java
package com.example.modulea.api;

public class ServiceA {
    public void doSomething() {
        System.out.println("ServiceA 执行");
    }
}
```

**模块 B（com.example.moduleb）**：

```java
// module-info.java
module com.example.moduleb {
    requires com.example.modulea;
}

// com/example/moduleb/ClientB.java
package com.example.moduleb;

import com.example.modulea.api.ServiceA;

public class ClientB {
    public void useService() {
        ServiceA service = new ServiceA();
        service.doSomething();
    }
}
```

### 示例 2：传递依赖

**模块 Common（com.example.common）**：

```java
// module-info.java
module com.example.common {
    exports com.example.common.util;
}

// com/example/common/util/Logger.java
package com.example.common.util;

public class Logger {
    public void log(String message) {
        System.out.println("日志：" + message);
    }
}
```

**模块 A（com.example.modulea）**：

```java
// module-info.java
module com.example.modulea {
    requires transitive com.example.common;  // 传递依赖
    exports com.example.modulea.api;
}

// com/example/modulea/api/ServiceA.java
package com.example.modulea.api;

import com.example.common.util.Logger;

public class ServiceA {
    private Logger logger = new Logger();
    
    public void doSomething() {
        logger.log("ServiceA 执行");
    }
}
```

**模块 B（com.example.moduleb）**：

```java
// module-info.java
module com.example.moduleb {
    requires com.example.modulea;
    // 不需要显式 requires com.example.common
    // 因为 modulea 使用了 requires transitive
}

// com/example/moduleb/ClientB.java
package com.example.moduleb;

import com.example.modulea.api.ServiceA;
import com.example.common.util.Logger;  // 可以直接使用

public class ClientB {
    public void useService() {
        ServiceA service = new ServiceA();
        service.doSomething();
        
        Logger logger = new Logger();
        logger.log("ClientB 执行");
    }
}
```

### 示例 3：服务提供者模式

**服务接口模块（com.example.service）**：

```java
// module-info.java
module com.example.service {
    exports com.example.service;
}

// com/example/service/MyService.java
package com.example.service;

public interface MyService {
    void execute();
}
```

**服务实现模块（com.example.serviceimpl）**：

```java
// module-info.java
module com.example.serviceimpl {
    requires com.example.service;
    provides com.example.service.MyService 
        with com.example.serviceimpl.MyServiceImpl;
}

// com/example/serviceimpl/MyServiceImpl.java
package com.example.serviceimpl;

import com.example.service.MyService;

public class MyServiceImpl implements MyService {
    @Override
    public void execute() {
        System.out.println("MyServiceImpl 执行");
    }
}
```

**客户端模块（com.example.client）**：

```java
// module-info.java
module com.example.client {
    requires com.example.service;
    uses com.example.service.MyService;
}

// com/example/client/Client.java
package com.example.client;

import com.example.service.MyService;
import java.util.ServiceLoader;

public class Client {
    public static void main(String[] args) {
        ServiceLoader<MyService> services = ServiceLoader.load(MyService.class);
        for (MyService service : services) {
            service.execute();
        }
    }
}
```

### 示例 4：开放反射访问

```java
// module-info.java
module com.example.mymodule {
    // 开放包给所有模块（反射访问）
    opens com.example.mymodule.reflection;
    
    // 或开放给特定模块
    opens com.example.mymodule.reflection to com.example.othermodule;
}

// 其他模块可以使用反射访问该包中的类
```

## 编译和运行模块

### 编译模块

```bash
# 编译模块
javac -d mods/com.example.mymodule \
    module-info.java \
    com/example/mymodule/**/*.java

# 编译多个模块
javac -d mods --module-source-path src \
    --module com.example.mymodule,com.example.othermodule
```

### 运行模块

```bash
# 运行模块
java --module-path mods -m com.example.mymodule/com.example.mymodule.Main

# 或使用简写
java -p mods -m com.example.mymodule/com.example.mymodule.Main
```

### 打包模块

```bash
# 创建模块 JAR
jar --create --file mymodule.jar \
    --module-version 1.0 \
    -C mods/com.example.mymodule .

# 创建模块化 JAR（包含 module-info.class）
jar --create --file mymodule.jar \
    --module-version 1.0 \
    --main-class com.example.mymodule.Main \
    -C mods/com.example.mymodule .
```

## 模块系统的最佳实践

### 1. 明确模块边界

```java
// ✅ 推荐：明确导出需要的包
module com.example.mymodule {
    exports com.example.mymodule.api;
    // 不导出内部实现
}
```

### 2. 使用传递依赖

```java
// ✅ 推荐：使用 requires transitive
module com.example.mymodule {
    requires transitive com.example.common;
    // 使用该模块的模块自动获得 common 的访问权限
}
```

### 3. 避免过度开放

```java
// ❌ 不推荐：过度开放
module com.example.mymodule {
    opens com.example.mymodule;  // 开放整个模块
}

// ✅ 推荐：只开放需要的包
module com.example.mymodule {
    opens com.example.mymodule.reflection;  // 只开放需要的包
}
```

### 4. 使用服务提供者模式

```java
// ✅ 推荐：使用服务提供者模式实现解耦
module com.example.mymodule {
    provides com.example.service.MyService 
        with com.example.serviceimpl.MyServiceImpl;
}
```

## 小结

Java 模块系统要点：

- **module-info.java**：模块描述文件
- **exports**：导出包
- **requires**：声明依赖
- **opens**：开放反射访问
- **provides/uses**：服务提供者模式

**关键要点**：
- 模块有明确的边界和依赖
- 使用 exports 控制包的可见性
- 使用 requires 声明依赖关系
- 使用传递依赖简化依赖管理
- 使用服务提供者模式实现解耦

理解了模块系统，你就能更好地组织大型项目。在下一章，我们将学习 Java 记录类（record）。
