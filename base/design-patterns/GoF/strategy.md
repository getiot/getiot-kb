---
sidebar_position: 22
slug: /strategy
sidebar_label: 策略模式
---

# 设计模式 - 策略模式

想象一下你在开发一个电商系统，用户在结账时可以选择不同的支付方式：微信支付、支付宝、银行卡……

你当然可以用 if-else 来判断用户选择了哪种支付方式，然后分别调用相应的方法。但随着支付方式的增加，代码会越来越混乱。

🤔 有没有更优雅的方式，让每种支付方式都有自己的算法类，实现统一的调用接口？

这就是**策略模式**（Strategy Pattern）大显身手的时候！



:::tip 核心思想 🌟

将一组算法封装为独立的策略类，使它们可以互相替换，并且客户端可以灵活地选择使用哪种算法。

也就是说：

- 把不同的“算法”独立成类
- 它们实现同一个接口（例如 `PaymentStrategy`）
- 客户端只依赖接口，不关心具体实现

:::



## 模式结构（UML 类图）

```scss
        +--------------------+
        |     Context        |
        +--------------------+
        | strategy: Strategy |
        +--------------------+
        | setStrategy()      |
        | executeStrategy()  |
        +--------------------+
                  ▲
                  |
        +--------------------+
        |     Strategy       |<-------------------+
        +--------------------+                    |
        | execute()          |                    |
        +--------------------+                    |
        |               +--------------------+    |
        |               |  ConcreteStrategyA |    |
        |               +--------------------+    |
        |               | execute()          |<---+
        |               +--------------------+
```



## 示例场景：支付方式选择

你要实现一个系统，支持以下支付策略：

- 支付宝支付
- 微信支付
- 银行卡支付



### Java 实现

```java showLineNumbers
// 策略接口
interface PaymentStrategy {
    void pay(int amount);
}

// 具体策略
class Alipay implements PaymentStrategy {
    public void pay(int amount) {
        System.out.println("使用支付宝支付：" + amount + " 元");
    }
}

class WeChatPay implements PaymentStrategy {
    public void pay(int amount) {
        System.out.println("使用微信支付：" + amount + " 元");
    }
}

class BankCardPay implements PaymentStrategy {
    public void pay(int amount) {
        System.out.println("使用银行卡支付：" + amount + " 元");
    }
}

// 上下文类
class PaymentContext {
    private PaymentStrategy strategy;

    public void setStrategy(PaymentStrategy strategy) {
        this.strategy = strategy;
    }

    public void pay(int amount) {
        strategy.pay(amount);
    }
}

// 使用示例
public class Main {
    public static void main(String[] args) {
        PaymentContext context = new PaymentContext();
        context.setStrategy(new Alipay());
        context.pay(100);

        context.setStrategy(new WeChatPay());
        context.pay(200);
    }
}
```



### C++ 实现

```cpp showLineNumbers
#include <iostream>
using namespace std;

class PaymentStrategy {
public:
    virtual void pay(int amount) = 0;
};

class Alipay : public PaymentStrategy {
public:
    void pay(int amount) override {
        cout << "使用支付宝支付：" << amount << " 元" << endl;
    }
};

class WeChatPay : public PaymentStrategy {
public:
    void pay(int amount) override {
        cout << "使用微信支付：" << amount << " 元" << endl;
    }
};

class BankCardPay : public PaymentStrategy {
public:
    void pay(int amount) override {
        cout << "使用银行卡支付：" << amount << " 元" << endl;
    }
};

class PaymentContext {
private:
    PaymentStrategy* strategy;

public:
    void setStrategy(PaymentStrategy* strategy) {
        this->strategy = strategy;
    }

    void pay(int amount) {
        strategy->pay(amount);
    }
};

int main() {
    PaymentContext context;
    Alipay alipay;
    WeChatPay wechat;

    context.setStrategy(&alipay);
    context.pay(100);

    context.setStrategy(&wechat);
    context.pay(200);

    return 0;
}
```



### Python 实现

```python showLineNumbers
from abc import ABC, abstractmethod

# 策略接口
class PaymentStrategy(ABC):
    @abstractmethod
    def pay(self, amount):
        pass

class Alipay(PaymentStrategy):
    def pay(self, amount):
        print(f"使用支付宝支付：{amount} 元")

class WeChatPay(PaymentStrategy):
    def pay(self, amount):
        print(f"使用微信支付：{amount} 元")

class BankCardPay(PaymentStrategy):
    def pay(self, amount):
        print(f"使用银行卡支付：{amount} 元")

class PaymentContext:
    def __init__(self, strategy: PaymentStrategy):
        self.strategy = strategy

    def set_strategy(self, strategy: PaymentStrategy):
        self.strategy = strategy

    def pay(self, amount):
        self.strategy.pay(amount)

# 使用示例
context = PaymentContext(Alipay())
context.pay(100)

context.set_strategy(WeChatPay())
context.pay(200)
```



### TypeScript 实现

```typescript showLineNumbers
interface PaymentStrategy {
  pay(amount: number): void;
}

class Alipay implements PaymentStrategy {
  pay(amount: number): void {
    console.log(`使用支付宝支付：${amount} 元`);
  }
}

class WeChatPay implements PaymentStrategy {
  pay(amount: number): void {
    console.log(`使用微信支付：${amount} 元`);
  }
}

class BankCardPay implements PaymentStrategy {
  pay(amount: number): void {
    console.log(`使用银行卡支付：${amount} 元`);
  }
}

class PaymentContext {
  private strategy: PaymentStrategy;

  constructor(strategy: PaymentStrategy) {
    this.strategy = strategy;
  }

  setStrategy(strategy: PaymentStrategy): void {
    this.strategy = strategy;
  }

  pay(amount: number): void {
    this.strategy.pay(amount);
  }
}

// 使用示例
const context = new PaymentContext(new Alipay());
context.pay(100);

context.setStrategy(new WeChatPay());
context.pay(200);
```



## 小结

| 特性     | 内容                                                         |
| -------- | ------------------------------------------------------------ |
| 模式类型 | 行为型                                                       |
| 适用场景 | 有多种可替换算法或行为的情况，如支付方式、排序方式、折扣计算等 |
| 优点     | <ul><li>消除条件语句</li><li>策略之间可以自由切换</li><li>符合开闭原则</li></ul> |
| 缺点     | <ul><li>客户端必须了解所有策略</li><li>增加了类的数量</li></ul> |

当你遇到“很多 if-else 判断算法逻辑不同，但接口一样”的情况，策略模式往往是个理想的解决方案。它让代码更清晰、更灵活。
