---
sidebar_position: 14
slug: /chain-of-responsibility
sidebar_label: 责任链模式
---

# 设计模式 - 责任链模式

当你提交请假申请时，可能要先经过班主任、再到教务主任、最后到校长审核。每一级都有自己的“权限范围”，如果不能处理，就交给下一级继续处理。

组成**职责链模式**（Chain of Responsibility Pattern）的角色有：

- **Handler（抽象处理者）**：定义处理请求的接口，并持有下一个处理者。
- **ConcreteHandler（具体处理者）**：决定是否处理请求，否则转交给下一个。
- **Client（客户端）**：将请求发送到链上的第一个处理者。

:::tip 核心思想 🌟

让多个对象都有机会处理请求，形成一个链，请求沿着这条链传递，直到被某个对象处理为止。

:::



## 模式结构（UML 类图）

```scss
Client ─────► Handler1 ─────► Handler2 ─────► Handler3
            ▲           │            │
            └───────────┴────────────┘
```



## 示例场景

我们用“请假审批流程”来举例：

- 班主任可以批准 1 天以内的请假；
- 教务主任可以批准 3 天以内的请假；
- 校长可以批准任何时长的请假。



### Java 实现

```java showLineNumbers
abstract class LeaveHandler {
    protected LeaveHandler next;

    public void setNext(LeaveHandler next) {
        this.next = next;
    }

    public abstract void handleRequest(int days);
}

class ClassAdvisor extends LeaveHandler {
    public void handleRequest(int days) {
        if (days <= 1) {
            System.out.println("班主任批准了 " + days + " 天假");
        } else if (next != null) {
            next.handleRequest(days);
        }
    }
}

class Dean extends LeaveHandler {
    public void handleRequest(int days) {
        if (days <= 3) {
            System.out.println("教务主任批准了 " + days + " 天假");
        } else if (next != null) {
            next.handleRequest(days);
        }
    }
}

class Principal extends LeaveHandler {
    public void handleRequest(int days) {
        System.out.println("校长批准了 " + days + " 天假");
    }
}

public class Main {
    public static void main(String[] args) {
        LeaveHandler advisor = new ClassAdvisor();
        LeaveHandler dean = new Dean();
        LeaveHandler principal = new Principal();

        advisor.setNext(dean);
        dean.setNext(principal);

        advisor.handleRequest(1);
        advisor.handleRequest(2);
        advisor.handleRequest(5);
    }
}
```



### C++ 实现

```cpp showLineNumbers
#include <iostream>
using namespace std;

class LeaveHandler {
protected:
    LeaveHandler* next = nullptr;

public:
    void setNext(LeaveHandler* handler) {
        next = handler;
    }

    virtual void handleRequest(int days) = 0;
    virtual ~LeaveHandler() {}
};

class ClassAdvisor : public LeaveHandler {
public:
    void handleRequest(int days) override {
        if (days <= 1) {
            cout << "班主任批准了 " << days << " 天假" << endl;
        } else if (next) {
            next->handleRequest(days);
        }
    }
};

class Dean : public LeaveHandler {
public:
    void handleRequest(int days) override {
        if (days <= 3) {
            cout << "教务主任批准了 " << days << " 天假" << endl;
        } else if (next) {
            next->handleRequest(days);
        }
    }
};

class Principal : public LeaveHandler {
public:
    void handleRequest(int days) override {
        cout << "校长批准了 " << days << " 天假" << endl;
    }
};

int main() {
    ClassAdvisor advisor;
    Dean dean;
    Principal principal;

    advisor.setNext(&dean);
    dean.setNext(&principal);

    advisor.handleRequest(1);
    advisor.handleRequest(2);
    advisor.handleRequest(5);
}
```



### Python 实现

```python showLineNumbers
class LeaveHandler:
    def __init__(self):
        self.next = None

    def set_next(self, next_handler):
        self.next = next_handler

    def handle_request(self, days):
        raise NotImplementedError

class ClassAdvisor(LeaveHandler):
    def handle_request(self, days):
        if days <= 1:
            print(f"班主任批准了 {days} 天假")
        elif self.next:
            self.next.handle_request(days)

class Dean(LeaveHandler):
    def handle_request(self, days):
        if days <= 3:
            print(f"教务主任批准了 {days} 天假")
        elif self.next:
            self.next.handle_request(days)

class Principal(LeaveHandler):
    def handle_request(self, days):
        print(f"校长批准了 {days} 天假")

# 使用
advisor = ClassAdvisor()
dean = Dean()
principal = Principal()

advisor.set_next(dean)
dean.set_next(principal)

advisor.handle_request(1)
advisor.handle_request(2)
advisor.handle_request(5)
```



### TypeScript 实现

```typescript showLineNumbers
abstract class LeaveHandler {
  protected next?: LeaveHandler;

  setNext(handler: LeaveHandler): void {
    this.next = handler;
  }

  abstract handleRequest(days: number): void;
}

class ClassAdvisor extends LeaveHandler {
  handleRequest(days: number): void {
    if (days <= 1) {
      console.log(`班主任批准了 ${days} 天假`);
    } else if (this.next) {
      this.next.handleRequest(days);
    }
  }
}

class Dean extends LeaveHandler {
  handleRequest(days: number): void {
    if (days <= 3) {
      console.log(`教务主任批准了 ${days} 天假`);
    } else if (this.next) {
      this.next.handleRequest(days);
    }
  }
}

class Principal extends LeaveHandler {
  handleRequest(days: number): void {
    console.log(`校长批准了 ${days} 天假`);
  }
}

// 使用
const advisor = new ClassAdvisor();
const dean = new Dean();
const principal = new Principal();

advisor.setNext(dean);
dean.setNext(principal);

advisor.handleRequest(1);
advisor.handleRequest(2);
advisor.handleRequest(5);
```



## 小结

| 特性     | 内容                                                         |
| -------- | ------------------------------------------------------------ |
| 模式类型 | 行为型                                                       |
| 适用场景 | 多个对象可以处理同一请求，但具体由哪个处理不确定时           |
| 优点     | <ul><li>降低耦合</li><li>灵活地添加、调整处理逻辑</li><li>符合开闭原则</li></ul> |
| 缺点     | <ul><li>不保证请求一定被处理</li><li>调试链条可能变复杂</li></ul> |

职责链就像一场接力赛，每个节点判断是否接棒。你可以灵活调整顺序、增删节点，非常适合审批流程、事件处理系统、责任划分机制等场景。



