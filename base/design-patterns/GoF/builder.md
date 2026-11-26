---
sidebar_position: 5
slug: /builder
sidebar_label: 生成器模式
---

# 设计模式 - 生成器模式（建造者模式）

你有没有遇到过这样的情况：需要创建一个结构复杂、配置灵活的对象，比如一份简历、一辆汽车或一个网页？这些对象有很多组件，每个组件都有自己的配置方式。

如果用构造函数去创建这样的对象，很快就会变得臃肿难维护。这个时候，你可以使用 **建造者模式**（Builder Pattern）。

:::tip 核心思想 🌟

建造者模式将一个复杂对象的构建过程与它的表示分离，使得同样的构建过程可以创建不同的表示。

:::

换句话说：你可以一步步地建造一个对象（比如一辆车），而且你还可以换一个“建造者”去造不同的车。



## 模式结构（UML 类图）

```scss
           Director（指挥者）
                  |
            +------------------+
            |                  |
     Builder（抽象建造者）    ConcreteBuilder（具体建造者）
            |                            |
         Product（最终产品）
```

类图解释：

- **Product**：你要构建的复杂对象，比如一辆汽车。
- **Builder**：规定产品的建造流程（比如建造车轮、引擎、车身）。
- **ConcreteBuilder**：实现这些建造步骤，并保存建好的产品。
- **Director**：指导建造顺序，比如先装底盘再装引擎。



## 示例场景

我们来建造一辆汽车，包含：引擎（engine）、轮子（wheels）和车身（body）。你可以创建不同类型的汽车：跑车、SUV 等。

### Java 实现

```java showLineNumbers
// 产品类
class Car {
    String engine;
    String wheels;
    String body;

    public String toString() {
        return "Car [Engine: " + engine + ", Wheels: " + wheels + ", Body: " + body + "]";
    }
}

// 抽象建造者
interface CarBuilder {
    void buildEngine();
    void buildWheels();
    void buildBody();
    Car getResult();
}

// 具体建造者
class SportsCarBuilder implements CarBuilder {
    Car car = new Car();

    public void buildEngine() {
        car.engine = "V8 Engine";
    }

    public void buildWheels() {
        car.wheels = "Sport Wheels";
    }

    public void buildBody() {
        car.body = "Sleek Body";
    }

    public Car getResult() {
        return car;
    }
}

// 指挥者
class Director {
    public void construct(CarBuilder builder) {
        builder.buildEngine();
        builder.buildWheels();
        builder.buildBody();
    }
}

// 使用
public class Main {
    public static void main(String[] args) {
        CarBuilder builder = new SportsCarBuilder();
        Director director = new Director();
        director.construct(builder);
        Car car = builder.getResult();
        System.out.println(car);
    }
}
```



### C++ 实现

```cpp showLineNumbers
#include <iostream>
#include <string>
using namespace std;

class Car {
public:
    string engine;
    string wheels;
    string body;

    void show() {
        cout << "Car [Engine: " << engine << ", Wheels: " << wheels << ", Body: " << body << "]" << endl;
    }
};

// 抽象建造者
class CarBuilder {
public:
    virtual void buildEngine() = 0;
    virtual void buildWheels() = 0;
    virtual void buildBody() = 0;
    virtual Car* getResult() = 0;
    virtual ~CarBuilder() {}
};

// 具体建造者
class SportsCarBuilder : public CarBuilder {
    Car* car = new Car();

public:
    void buildEngine() override {
        car->engine = "V8 Engine";
    }

    void buildWheels() override {
        car->wheels = "Sport Wheels";
    }

    void buildBody() override {
        car->body = "Sleek Body";
    }

    Car* getResult() override {
        return car;
    }
};

// 指挥者
class Director {
public:
    void construct(CarBuilder* builder) {
        builder->buildEngine();
        builder->buildWheels();
        builder->buildBody();
    }
};

// 使用
int main() {
    SportsCarBuilder builder;
    Director director;
    director.construct(&builder);
    Car* car = builder.getResult();
    car->show();
    delete car;
    return 0;
}
```



### Python 实现

```python showLineNumbers
# 产品类
class Car:
    def __init__(self):
        self.engine = ""
        self.wheels = ""
        self.body = ""

    def __str__(self):
        return f"Car [Engine: {self.engine}, Wheels: {self.wheels}, Body: {self.body}]"

# 抽象建造者
class CarBuilder:
    def build_engine(self): pass
    def build_wheels(self): pass
    def build_body(self): pass
    def get_result(self): pass

# 具体建造者
class SportsCarBuilder(CarBuilder):
    def __init__(self):
        self.car = Car()

    def build_engine(self):
        self.car.engine = "V8 Engine"

    def build_wheels(self):
        self.car.wheels = "Sport Wheels"

    def build_body(self):
        self.car.body = "Sleek Body"

    def get_result(self):
        return self.car

# 指挥者
class Director:
    def construct(self, builder):
        builder.build_engine()
        builder.build_wheels()
        builder.build_body()

# 使用
builder = SportsCarBuilder()
director = Director()
director.construct(builder)
car = builder.get_result()
print(car)
```



### TypeScript 实现

```typescript showLineNumbers
// 产品类
class Car {
  engine = "";
  wheels = "";
  body = "";

  toString(): string {
    return `Car [Engine: ${this.engine}, Wheels: ${this.wheels}, Body: ${this.body}]`;
  }
}

// 抽象建造者
interface CarBuilder {
  buildEngine(): void;
  buildWheels(): void;
  buildBody(): void;
  getResult(): Car;
}

// 具体建造者
class SportsCarBuilder implements CarBuilder {
  private car = new Car();

  buildEngine(): void {
    this.car.engine = "V8 Engine";
  }

  buildWheels(): void {
    this.car.wheels = "Sport Wheels";
  }

  buildBody(): void {
    this.car.body = "Sleek Body";
  }

  getResult(): Car {
    return this.car;
  }
}

// 指挥者
class Director {
  construct(builder: CarBuilder): void {
    builder.buildEngine();
    builder.buildWheels();
    builder.buildBody();
  }
}

// 使用
const builder = new SportsCarBuilder();
const director = new Director();
director.construct(builder);
const car = builder.getResult();
console.log(car.toString());
```



## 小结

|   特性   | 内容                                                |
| :------: | --------------------------------------------------- |
| 模式类型 | 创建型                                              |
| 适用场景 | 对象构建步骤复杂，或者构建顺序有要求                |
|   优点   | - 将构建过程与表示分离<br/>- 可复用构建逻辑         |
|   缺点   | - 增加代码复杂度<br/>- 每种产品需要一个具体建造者类 |

当你需要**灵活地一步步构建复杂对象**，并且希望封装构建细节时，建造者模式是一个非常适合的选择。
