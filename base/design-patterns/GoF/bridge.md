---
sidebar_position: 8
slug: /bridge
sidebar_label: 桥接模式
---

# 设计模式 - 桥接模式

当你设计一个系统时，是否遇到过这样的困扰：

> 有两个维度的变化，比如 “形状” 和 “颜色”，一开始你以为只会有几个组合，结果后续新增一个形状或颜色，类的数量就迅速爆炸！

这时候，你可以使用**桥接模式**（Bridge Pattern）。它的作用是**将抽象部分和实现部分分离开来，使它们可以独立变化**。



:::tip 核心思想 🌟

桥接模式就是把一个类拆成两个独立变化的维度，通过“组合关系”连接起来，而不是“继承”。

你可以理解为：把“抽象（接口/抽象类）”和“实现”用桥连接起来。

:::



## 模式结构（UML 类图）

```scss
        Abstraction（抽象类）
               ▲
       RefinedAbstraction（扩展抽象）
               |
         +-----+------+
         |            |
Implementor（实现接口）<—— ConcreteImplementor（具体实现）
```

类图解释：

- **Abstraction**：定义抽象接口，持有 Implementor 的引用。
- **Implementor**：定义底层实现接口（可变部分）。
- **ConcreteImplementor**：真正的实现类。
- **RefinedAbstraction**：Abstraction 的扩展（可以有多个子类）。
- 通过组合关系连接 Abstraction 和 Implementor，而非继承。



## 示例场景

我们实现一个“消息发送系统”，消息类型有多种（普通消息、紧急消息），发送渠道也有多种（邮件、短信、微信）。

传统做法会导致类的组合爆炸：EmailNormalMessage、EmailUrgentMessage、SMSNormalMessage、SMSUrgentMessage……

桥接模式可以把“消息内容”和“发送渠道”两个维度分离开来，互不影响。



### Java 实现

```java showLineNumbers
// 实现接口
interface MessageSender {
    void send(String message);
}

// 具体实现
class EmailSender implements MessageSender {
    public void send(String message) {
        System.out.println("发送邮件：" + message);
    }
}

class SMSSender implements MessageSender {
    public void send(String message) {
        System.out.println("发送短信：" + message);
    }
}

// 抽象类
abstract class Message {
    protected MessageSender sender;

    public Message(MessageSender sender) {
        this.sender = sender;
    }

    abstract void send(String text);
}

// 扩展抽象
class NormalMessage extends Message {
    public NormalMessage(MessageSender sender) {
        super(sender);
    }

    void send(String text) {
        sender.send("[普通] " + text);
    }
}

class UrgentMessage extends Message {
    public UrgentMessage(MessageSender sender) {
        super(sender);
    }

    void send(String text) {
        sender.send("[紧急] " + text);
    }
}

// 使用
public class Main {
    public static void main(String[] args) {
        MessageSender email = new EmailSender();
        Message msg = new UrgentMessage(email);
        msg.send("服务器宕机！");
    }
}
```



### C++ 实现

```cpp showLineNumbers
#include <iostream>
#include <string>
using namespace std;

// 实现接口
class MessageSender {
public:
    virtual void send(const string& msg) = 0;
    virtual ~MessageSender() {}
};

class EmailSender : public MessageSender {
public:
    void send(const string& msg) override {
        cout << "发送邮件：" << msg << endl;
    }
};

class SMSSender : public MessageSender {
public:
    void send(const string& msg) override {
        cout << "发送短信：" << msg << endl;
    }
};

// 抽象类
class Message {
protected:
    MessageSender* sender;
public:
    Message(MessageSender* s) : sender(s) {}
    virtual void send(const string& text) = 0;
    virtual ~Message() {}
};

class NormalMessage : public Message {
public:
    NormalMessage(MessageSender* s) : Message(s) {}
    void send(const string& text) override {
        sender->send("[普通] " + text);
    }
};

class UrgentMessage : public Message {
public:
    UrgentMessage(MessageSender* s) : Message(s) {}
    void send(const string& text) override {
        sender->send("[紧急] " + text);
    }
};

// 使用
int main() {
    EmailSender email;
    Message* msg = new UrgentMessage(&email);
    msg->send("数据库被删了！");
    delete msg;
    return 0;
}
```



### Python 实现

```python showLineNumbers
# 实现接口
class MessageSender:
    def send(self, message):
        raise NotImplementedError

class EmailSender(MessageSender):
    def send(self, message):
        print(f"发送邮件：{message}")

class SMSSender(MessageSender):
    def send(self, message):
        print(f"发送短信：{message}")

# 抽象类
class Message:
    def __init__(self, sender: MessageSender):
        self.sender = sender

    def send(self, text):
        raise NotImplementedError

class NormalMessage(Message):
    def send(self, text):
        self.sender.send(f"[普通] {text}")

class UrgentMessage(Message):
    def send(self, text):
        self.sender.send(f"[紧急] {text}")

# 使用
email = EmailSender()
msg = UrgentMessage(email)
msg.send("系统异常！")
```



### TypeScript 实现

```typescript showLineNumbers
// 实现接口
interface MessageSender {
  send(message: string): void;
}

class EmailSender implements MessageSender {
  send(message: string): void {
    console.log(`发送邮件：${message}`);
  }
}

class SMSSender implements MessageSender {
  send(message: string): void {
    console.log(`发送短信：${message}`);
  }
}

// 抽象类
abstract class Message {
  constructor(protected sender: MessageSender) {}

  abstract send(text: string): void;
}

class NormalMessage extends Message {
  send(text: string): void {
    this.sender.send(`[普通] ${text}`);
  }
}

class UrgentMessage extends Message {
  send(text: string): void {
    this.sender.send(`[紧急] ${text}`);
  }
}

// 使用
const sender = new EmailSender();
const msg = new UrgentMessage(sender);
msg.send("服务宕机！");
```



## 小结

| 特性     | 内容                                                         |
| -------- | ------------------------------------------------------------ |
| 模式类型 | 结构型                                                       |
| 适用场景 | 多维度变化，想让每个维度都能独立扩展                         |
| 优点     | <ul><li>抽象与实现解耦</li><li>减少类的数量组合爆炸</li><li>各维度可独立扩展</li></ul> |
| 缺点     | <ul><li>增加系统复杂度</li><li>设计上需要提前规划两个维度</li></ul> |

桥接模式常用于需要将**类的多个变化维度分离**，比如设备种类 × 控制方式、消息类型 × 发送方式、UI 控件 × 渲染平台等。

