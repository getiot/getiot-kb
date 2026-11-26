---
sidebar_position: 10
slug: /decorator
sidebar_label: 装饰模式
---

# 设计模式 - 装饰器模式

想象你正在做一个咖啡点单系统。一杯基础咖啡 10 元，加牛奶多 2 元，加糖多 1 元……每种配料都可以“装饰”在咖啡上，并且这些装饰是可组合的。你可能会想到用继承来实现，但如果你要支持无数种组合（加糖、加奶、加奶又加糖、加双份糖再加奶……），类会爆炸式增长。

**装饰器模式**（Decorator Pattern）正是为了解决这种“灵活组合功能”的问题而设计的。

:::tip 核心思想 🌟

装饰器模式在不改变原类定义的前提下，动态地扩展对象的功能。它通过“包装”原对象的方式，实现功能的增强。

:::



## 模式结构（UML 类图）

```scss
      Component（抽象组件）
           ▲
   ┌───────┴────────┐
ConcreteComponent  Decorator（装饰器抽象类）
                         ▲
                 ConcreteDecorator（具体装饰器）
```

- `Component`：定义对象的接口。
- `ConcreteComponent`：被装饰的原始对象。
- `Decorator`：持有一个 `Component` 并实现 `Component` 接口。
- `ConcreteDecorator`：在不修改原对象的基础上，增加功能。



## 示例场景

假设你正在实现一个咖啡店系统：

- 基础饮品：咖啡
- 可选装饰：加奶、加糖、加摩卡

你希望用户可以任意组合这些装饰，并最终得出价格和描述。



### Java 实现

```java showLineNumbers
// 抽象组件
interface Beverage {
    String getDescription();
    double cost();
}

// 具体组件
class Coffee implements Beverage {
    public String getDescription() {
        return "咖啡";
    }

    public double cost() {
        return 10.0;
    }
}

// 抽象装饰器
abstract class CondimentDecorator implements Beverage {
    protected Beverage beverage;

    public CondimentDecorator(Beverage beverage) {
        this.beverage = beverage;
    }
}

// 具体装饰器
class Milk extends CondimentDecorator {
    public Milk(Beverage beverage) {
        super(beverage);
    }

    public String getDescription() {
        return beverage.getDescription() + " + 牛奶";
    }

    public double cost() {
        return beverage.cost() + 2.0;
    }
}

class Sugar extends CondimentDecorator {
    public Sugar(Beverage beverage) {
        super(beverage);
    }

    public String getDescription() {
        return beverage.getDescription() + " + 糖";
    }

    public double cost() {
        return beverage.cost() + 1.0;
    }
}

// 使用
public class Main {
    public static void main(String[] args) {
        Beverage drink = new Coffee();
        drink = new Milk(drink);
        drink = new Sugar(drink);

        System.out.println(drink.getDescription());
        System.out.println("总价：" + drink.cost() + "元");
    }
}
```



### C++ 实现

```cpp showLineNumbers
#include <iostream>
#include <memory>
#include <string>
using namespace std;

// 抽象组件
class Beverage {
public:
    virtual string getDescription() = 0;
    virtual double cost() = 0;
    virtual ~Beverage() = default;
};

// 具体组件
class Coffee : public Beverage {
public:
    string getDescription() override {
        return "咖啡";
    }
    double cost() override {
        return 10.0;
    }
};

// 装饰器基类
class CondimentDecorator : public Beverage {
protected:
    shared_ptr<Beverage> beverage;
public:
    CondimentDecorator(shared_ptr<Beverage> b) : beverage(b) {}
};

// 具体装饰器
class Milk : public CondimentDecorator {
public:
    Milk(shared_ptr<Beverage> b) : CondimentDecorator(b) {}

    string getDescription() override {
        return beverage->getDescription() + " + 牛奶";
    }

    double cost() override {
        return beverage->cost() + 2.0;
    }
};

class Sugar : public CondimentDecorator {
public:
    Sugar(shared_ptr<Beverage> b) : CondimentDecorator(b) {}

    string getDescription() override {
        return beverage->getDescription() + " + 糖";
    }

    double cost() override {
        return beverage->cost() + 1.0;
    }
};

// 使用
int main() {
    shared_ptr<Beverage> drink = make_shared<Coffee>();
    drink = make_shared<Milk>(drink);
    drink = make_shared<Sugar>(drink);

    cout << drink->getDescription() << endl;
    cout << "总价：" << drink->cost() << "元" << endl;
}
```



### Python 实现

```python showLineNumbers
from abc import ABC, abstractmethod

# 抽象组件
class Beverage(ABC):
    @abstractmethod
    def get_description(self):
        pass

    @abstractmethod
    def cost(self):
        pass

# 具体组件
class Coffee(Beverage):
    def get_description(self):
        return "咖啡"

    def cost(self):
        return 10.0

# 装饰器基类
class CondimentDecorator(Beverage):
    def __init__(self, beverage):
        self.beverage = beverage

# 具体装饰器
class Milk(CondimentDecorator):
    def get_description(self):
        return self.beverage.get_description() + " + 牛奶"

    def cost(self):
        return self.beverage.cost() + 2.0

class Sugar(CondimentDecorator):
    def get_description(self):
        return self.beverage.get_description() + " + 糖"

    def cost(self):
        return self.beverage.cost() + 1.0

# 使用
drink = Coffee()
drink = Milk(drink)
drink = Sugar(drink)

print(drink.get_description())
print("总价：", drink.cost(), "元")
```



### TypeScript 实现

```typescript showLineNumbers
// 抽象组件
interface Beverage {
  getDescription(): string;
  cost(): number;
}

// 具体组件
class Coffee implements Beverage {
  getDescription(): string {
    return "咖啡";
  }

  cost(): number {
    return 10.0;
  }
}

// 抽象装饰器
abstract class CondimentDecorator implements Beverage {
  protected beverage: Beverage;

  constructor(beverage: Beverage) {
    this.beverage = beverage;
  }

  abstract getDescription(): string;
  abstract cost(): number;
}

// 具体装饰器
class Milk extends CondimentDecorator {
  getDescription(): string {
    return this.beverage.getDescription() + " + 牛奶";
  }

  cost(): number {
    return this.beverage.cost() + 2.0;
  }
}

class Sugar extends CondimentDecorator {
  getDescription(): string {
    return this.beverage.getDescription() + " + 糖";
  }

  cost(): number {
    return this.beverage.cost() + 1.0;
  }
}

// 使用
let drink: Beverage = new Coffee();
drink = new Milk(drink);
drink = new Sugar(drink);

console.log(drink.getDescription());
console.log("总价：" + drink.cost() + "元");
```



## 小结

| 特性     | 内容                                                         |
| -------- | ------------------------------------------------------------ |
| 模式类型 | 结构型                                                       |
| 适用场景 | 希望动态扩展类的功能、避免类继承带来的膨胀                   |
| 优点     | <ul><li>扩展功能更灵活，不需要继承</li><li>可组合多个装饰器</li><li>符合开闭原则</li></ul> |
| 缺点     | <ul><li>对象结构可能变得复杂</li><li>调试可能较困难</li></ul> |

装饰器模式非常适合在运行时为对象动态地添加功能，广泛应用于图形界面组件、IO 流包装、权限控制等场景。
