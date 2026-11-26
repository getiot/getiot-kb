---
sidebar_position: 7
slug: /adapter
sidebar_label: 适配器模式
---

# 设计模式 - 适配器模式

假设你有一个插头是三脚的，但你现在手里只有两孔插座，这时候你需要一个**适配器**，把三脚插头转成可以插进两孔插座的形状。

在软件开发中也一样。当你手头有一个**现有类**，它的接口（方法）跟你要用的不一致，但功能是你想要的，这时候你就可以用**适配器模式**（Adapter Pattern）。你可以把它想成软件中的“插头转换器”。

:::tip 核心思想 🌟

适配器模式的作用是把一个类的接口转换成客户端期望的另一个接口，让原本接口不兼容的类可以协同工作。

:::



## 模式结构（UML 类图）

```markdown
 Client（客户端）
    |
 Target（目标接口）
    ▲
    |
 Adapter（适配器）
    |
 Adaptee（被适配者）
```

**类图解释**：

- **Target**：客户端期望的接口。
- **Adaptee**：已有的接口（不兼容）。
- **Adapter**：将 Adaptee 包装成 Target，适配接口。
- **Client**：调用的是 Target 接口。



## 示例场景

你有一个旧系统提供了 `OldLogger` 类，它只有 `writeLog(String msg)` 方法。而新系统期望你用 `log(String msg)` 方法。

你不想重写旧类，这时候就可以用一个适配器，把 `OldLogger` 包装起来，变成可以用 `log()` 方法的新对象。



### Java 实现

```java showLineNumbers
// 旧接口
class OldLogger {
    public void writeLog(String msg) {
        System.out.println("Old Logger: " + msg);
    }
}

// 新接口（目标接口）
interface Logger {
    void log(String msg);
}

// 适配器
class LoggerAdapter implements Logger {
    private OldLogger oldLogger;

    public LoggerAdapter(OldLogger oldLogger) {
        this.oldLogger = oldLogger;
    }

    public void log(String msg) {
        oldLogger.writeLog(msg);
    }
}

// 使用
public class Main {
    public static void main(String[] args) {
        OldLogger oldLogger = new OldLogger();
        Logger logger = new LoggerAdapter(oldLogger);
        logger.log("This is a log message.");
    }
}
```



### C++ 实现

```cpp showLineNumbers
#include <iostream>
#include <string>
using namespace std;

// 被适配者
class OldLogger {
public:
    void writeLog(const string& msg) {
        cout << "Old Logger: " << msg << endl;
    }
};

// 目标接口
class Logger {
public:
    virtual void log(const string& msg) = 0;
    virtual ~Logger() {}
};

// 适配器
class LoggerAdapter : public Logger {
    OldLogger* oldLogger;

public:
    LoggerAdapter(OldLogger* logger) : oldLogger(logger) {}

    void log(const string& msg) override {
        oldLogger->writeLog(msg);
    }
};

// 使用
int main() {
    OldLogger oldLogger;
    Logger* logger = new LoggerAdapter(&oldLogger);
    logger->log("This is a log message.");
    delete logger;
    return 0;
}
```



### Python 实现

```python showLineNumbers
# 被适配者
class OldLogger:
    def write_log(self, msg):
        print(f"Old Logger: {msg}")

# 目标接口
class Logger:
    def log(self, msg):
        raise NotImplementedError

# 适配器
class LoggerAdapter(Logger):
    def __init__(self, old_logger):
        self.old_logger = old_logger

    def log(self, msg):
        self.old_logger.write_log(msg)

# 使用
old_logger = OldLogger()
logger = LoggerAdapter(old_logger)
logger.log("This is a log message.")
```



### TypeScript 实现

```typescript showLineNumbers
// 被适配者
class OldLogger {
  writeLog(msg: string): void {
    console.log(`Old Logger: ${msg}`);
  }
}

// 目标接口
interface Logger {
  log(msg: string): void;
}

// 适配器
class LoggerAdapter implements Logger {
  constructor(private oldLogger: OldLogger) {}

  log(msg: string): void {
    this.oldLogger.writeLog(msg);
  }
}

// 使用
const oldLogger = new OldLogger();
const logger: Logger = new LoggerAdapter(oldLogger);
logger.log("This is a log message.");
```



## 小结

| 特性     | 内容                                                         |
| -------- | ------------------------------------------------------------ |
| 模式类型 | 结构型                                                       |
| 适用场景 | 需要让两个接口不兼容的类协同工作                             |
| 优点     | <ul><li>提高复用性（复用已有类）</li><li>符合开闭原则</li></ul> |
| 缺点     | <ul><li>增加系统复杂度</li><li>过度使用会导致代码混乱</li></ul> |

适配器模式非常适合在**旧系统与新接口之间“打桥梁”**。当你面对“这个类我不能改，但我想用”，适配器模式往往是最优解。
