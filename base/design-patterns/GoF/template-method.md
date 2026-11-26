---
sidebar_position: 23
slug: /template-method
sidebar_label: 模板方法模式
---

# 设计模式 - 模板方法模式

当你在开发一套业务流程时，某些步骤是固定的，而某些步骤会因子类而异。为了避免重复代码，同时保持流程结构不变，你就可以使用“模板方法模式”（Template Method Pattern）。

通俗点说就是：**你写好一份流程模板，把具体步骤交给子类实现。**

假设你正在做一个咖啡和茶的冲泡程序，它们的整体流程类似：

1. 烧水
2. 冲泡饮料（咖啡 or 茶）
3. 倒入杯中
4. 加入调料（糖、柠檬、奶……）

虽然流程是固定的，但第 2 步和第 4 步是不同的。如果你为每种饮料都手写一份流程，那重复度就很高。用模板方法模式就很适合！

:::tip 核心思想 🌟

将固定流程写在抽象类的模板方法中，流程中的可变部分定义为抽象方法，由子类实现。

:::



## 模式结构（UML 类图）

```scss
        +---------------------+
        |  AbstractClass      | <- 定义模板方法
        +---------------------+
        | + templateMethod()  |
        | + step1()           |
        | + step2() (抽象)     |
        | + step3()           |
        +---------------------+
                  ▲
                  |
        +----------------------+
        |  ConcreteClass       |
        +----------------------+
        | + step2()（具体实现）  |
        +----------------------+
```



## 示例场景

你要实现一个咖啡和茶的冲泡程序，操作流程如下：

1. 烧水
2. 冲泡饮料（咖啡 or 茶）
3. 倒入杯中
4. 加入调料（糖、柠檬、奶……）

### Java 实现

```java showLineNumbers
abstract class CaffeineBeverage {
    // 模板方法：定义冲泡流程
    public final void prepareRecipe() {
        boilWater();
        brew();           // 不同饮品不同
        pourInCup();
        addCondiments();  // 不同饮品不同
    }

    void boilWater() {
        System.out.println("煮沸水");
    }

    void pourInCup() {
        System.out.println("倒入杯中");
    }

    // 抽象方法：交由子类实现
    abstract void brew();
    abstract void addCondiments();
}

class Tea extends CaffeineBeverage {
    void brew() {
        System.out.println("用热水浸泡茶叶");
    }

    void addCondiments() {
        System.out.println("加柠檬");
    }
}

class Coffee extends CaffeineBeverage {
    void brew() {
        System.out.println("用热水冲泡咖啡粉");
    }

    void addCondiments() {
        System.out.println("加糖和牛奶");
    }
}

public class Main {
    public static void main(String[] args) {
        CaffeineBeverage tea = new Tea();
        CaffeineBeverage coffee = new Coffee();

        System.out.println("制作茶：");
        tea.prepareRecipe();

        System.out.println("\n制作咖啡：");
        coffee.prepareRecipe();
    }
}
```



### C++ 实现

```cpp showLineNumbers
#include <iostream>
using namespace std;

class CaffeineBeverage {
public:
    void prepareRecipe() {
        boilWater();
        brew();
        pourInCup();
        addCondiments();
    }

    void boilWater() {
        cout << "煮沸水" << endl;
    }

    void pourInCup() {
        cout << "倒入杯中" << endl;
    }

    virtual void brew() = 0;
    virtual void addCondiments() = 0;

    virtual ~CaffeineBeverage() = default;
};

class Tea : public CaffeineBeverage {
public:
    void brew() override {
        cout << "用热水浸泡茶叶" << endl;
    }

    void addCondiments() override {
        cout << "加柠檬" << endl;
    }
};

class Coffee : public CaffeineBeverage {
public:
    void brew() override {
        cout << "用热水冲泡咖啡粉" << endl;
    }

    void addCondiments() override {
        cout << "加糖和牛奶" << endl;
    }
};

int main() {
    Tea tea;
    Coffee coffee;

    cout << "制作茶：" << endl;
    tea.prepareRecipe();

    cout << "\n制作咖啡：" << endl;
    coffee.prepareRecipe();

    return 0;
}
```



### Python 实现

```python showLineNumbers
from abc import ABC, abstractmethod

class CaffeineBeverage(ABC):
    def prepare_recipe(self):
        self.boil_water()
        self.brew()
        self.pour_in_cup()
        self.add_condiments()

    def boil_water(self):
        print("煮沸水")

    def pour_in_cup(self):
        print("倒入杯中")

    @abstractmethod
    def brew(self):
        pass

    @abstractmethod
    def add_condiments(self):
        pass

class Tea(CaffeineBeverage):
    def brew(self):
        print("用热水浸泡茶叶")

    def add_condiments(self):
        print("加柠檬")

class Coffee(CaffeineBeverage):
    def brew(self):
        print("用热水冲泡咖啡粉")

    def add_condiments(self):
        print("加糖和牛奶")

tea = Tea()
coffee = Coffee()

print("制作茶：")
tea.prepare_recipe()

print("\n制作咖啡：")
coffee.prepare_recipe()
```



### TypeScript 实现

```typescript showLineNumbers
abstract class CaffeineBeverage {
  // 模板方法
  prepareRecipe() {
    this.boilWater();
    this.brew();
    this.pourInCup();
    this.addCondiments();
  }

  boilWater() {
    console.log("煮沸水");
  }

  pourInCup() {
    console.log("倒入杯中");
  }

  abstract brew(): void;
  abstract addCondiments(): void;
}

class Tea extends CaffeineBeverage {
  brew() {
    console.log("用热水浸泡茶叶");
  }

  addCondiments() {
    console.log("加柠檬");
  }
}

class Coffee extends CaffeineBeverage {
  brew() {
    console.log("用热水冲泡咖啡粉");
  }

  addCondiments() {
    console.log("加糖和牛奶");
  }
}

const tea = new Tea();
const coffee = new Coffee();

console.log("制作茶：");
tea.prepareRecipe();

console.log("\n制作咖啡：");
coffee.prepareRecipe();
```



## 小结

| 特性     | 内容                                                         |
| -------- | ------------------------------------------------------------ |
| 模式类型 | 行为型                                                       |
| 适用场景 | 有一套流程固定，但其中某些步骤可以由子类自定义时             |
| 优点     | <ul><li>重用流程代码</li><li>提取公共逻辑</li><li>符合开闭原则</li></ul> |
| 缺点     | <ul><li>子类必须遵守流程结构</li><li>灵活性不如策略模式</li></ul> |

模板方法模式在框架设计中非常常见，比如：

- Java 中的 `Servlet.service()` 就是模板方法；
- Python 的 `unittest.TestCase.run()` 也是模板方法；
- 前端组件库中的生命周期函数也常用这种模式。
