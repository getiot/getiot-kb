---
sidebar_position: 3
slug: /factory-method
sidebar_label: 工厂方法模式
---

# 设计模式 - 工厂方法模式

在简单工厂模式中，**所有对象的创建都由一个工厂类负责**。这虽然方便，但当你新增产品类型时，往往不得不修改工厂类的代码，违反了“**开放-封闭原则**”。为了解决这个问题，工厂方法模式（Factory Method Pattern）应运而生。

- 定义一个“工厂接口”，用于创建产品。
- 每种产品都有自己的“工厂类”负责生产。
- 客户端不直接创建产品，只通过工厂来获取。

你不再需要修改工厂逻辑，而是通过扩展（新增一个工厂类）来支持新的产品。

:::tip 核心思想 🌟

**将“产品的创建”延迟到具体的工厂子类中进行。**

:::



## Java 实现

```java showLineNumbers
// 产品接口
interface Shape {
    void draw();
}

// 具体产品
class Circle implements Shape {
    public void draw() {
        System.out.println("Drawing Circle");
    }
}

class Square implements Shape {
    public void draw() {
        System.out.println("Drawing Square");
    }
}

// 工厂接口
interface ShapeFactory {
    Shape createShape();
}

// 具体工厂
class CircleFactory implements ShapeFactory {
    public Shape createShape() {
        return new Circle();
    }
}

class SquareFactory implements ShapeFactory {
    public Shape createShape() {
        return new Square();
    }
}

// 使用
public class Main {
    public static void main(String[] args) {
        ShapeFactory factory = new CircleFactory();
        Shape shape = factory.createShape();
        shape.draw(); // 输出：Drawing Circle
    }
}
```



## C++ 实现

```cpp showLineNumbers
#include <iostream>
using namespace std;

// 产品接口
class Shape {
public:
    virtual void draw() = 0;
    virtual ~Shape() {}
};

// 具体产品
class Circle : public Shape {
public:
    void draw() override {
        cout << "Drawing Circle" << endl;
    }
};

class Square : public Shape {
public:
    void draw() override {
        cout << "Drawing Square" << endl;
    }
};

// 工厂接口
class ShapeFactory {
public:
    virtual Shape* createShape() = 0;
    virtual ~ShapeFactory() {}
};

// 具体工厂
class CircleFactory : public ShapeFactory {
public:
    Shape* createShape() override {
        return new Circle();
    }
};

class SquareFactory : public ShapeFactory {
public:
    Shape* createShape() override {
        return new Square();
    }
};

// 使用
int main() {
    ShapeFactory* factory = new SquareFactory();
    Shape* shape = factory->createShape();
    shape->draw(); // 输出：Drawing Square

    delete shape;
    delete factory;
    return 0;
}
```



## Python 实现

```python showLineNumbers
# 产品接口
class Shape:
    def draw(self):
        raise NotImplementedError

# 具体产品
class Circle(Shape):
    def draw(self):
        print("Drawing Circle")

class Square(Shape):
    def draw(self):
        print("Drawing Square")

# 工厂接口
class ShapeFactory:
    def create_shape(self):
        raise NotImplementedError

# 具体工厂
class CircleFactory(ShapeFactory):
    def create_shape(self):
        return Circle()

class SquareFactory(ShapeFactory):
    def create_shape(self):
        return Square()

# 使用
factory = CircleFactory()
shape = factory.create_shape()
shape.draw()  # 输出：Drawing Circle
```



## TypeScript 实现

```typescript showLineNumbers
// 产品接口
interface Shape {
  draw(): void;
}

// 具体产品类
class Circle implements Shape {
  draw(): void {
    console.log("Drawing Circle");
  }
}

class Square implements Shape {
  draw(): void {
    console.log("Drawing Square");
  }
}

// 工厂接口
interface ShapeFactory {
  createShape(): Shape;
}

// 具体工厂
class CircleFactory implements ShapeFactory {
  createShape(): Shape {
    return new Circle();
  }
}

class SquareFactory implements ShapeFactory {
  createShape(): Shape {
    return new Square();
  }
}

// 使用
const factory: ShapeFactory = new SquareFactory();
const shape = factory.createShape();
shape.draw(); // 输出：Drawing Square
```



## C 语言实现（模拟工厂方法）

```c showLineNumbers
// factory_method.c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// 抽象产品
typedef struct Shape {
    void (*draw)(struct Shape*);
} Shape;

// Circle 实现
void draw_circle(Shape* s) {
    printf("Drawing Circle\n");
}
Shape* create_circle() {
    Shape* shape = (Shape*)malloc(sizeof(Shape));
    shape->draw = draw_circle;
    return shape;
}

// Square 实现
void draw_square(Shape* s) {
    printf("Drawing Square\n");
}
Shape* create_square() {
    Shape* shape = (Shape*)malloc(sizeof(Shape));
    shape->draw = draw_square;
    return shape;
}

// 工厂“接口”：通过函数指针模拟
typedef struct ShapeFactory {
    Shape* (*create_shape)();
} ShapeFactory;

// 具体工厂
ShapeFactory* new_circle_factory() {
    ShapeFactory* factory = (ShapeFactory*)malloc(sizeof(ShapeFactory));
    factory->create_shape = create_circle;
    return factory;
}

ShapeFactory* new_square_factory() {
    ShapeFactory* factory = (ShapeFactory*)malloc(sizeof(ShapeFactory));
    factory->create_shape = create_square;
    return factory;
}

// 使用
int main() {
    ShapeFactory* factory = new_circle_factory();
    Shape* shape = factory->create_shape();
    shape->draw(shape); // 输出：Drawing Circle

    free(shape);
    free(factory);
    return 0;
}
```



## 结构图（UML）

```scss
    Shape（产品接口）
        ▲
  ┌─────┴─────┐
Circle      Square

    ShapeFactory（工厂接口）
        ▲
  ┌─────┴─────┐
CircleFactory  SquareFactory
```

结构说明：

- `Shape` 是产品接口
- 每种产品有自己的具体实现类
- 每个工厂类负责生产一种产品
- 新增产品时只需添加一个产品类 + 工厂类，原代码无需改动



## 小结

| 模式     | 特点                                                         |
| -------- | ------------------------------------------------------------ |
| 简单工厂 | 所有产品由一个工厂方法创建，逻辑集中，扩展困难               |
| 工厂方法 | 每种产品都有一个对应工厂，新增产品只需新增类，**符合开放-封闭原则** |

工厂方法模式适用于：

- 系统中存在多个相似产品类；
- 你希望将创建逻辑封装在独立的工厂类中；
- 希望避免修改已有工厂逻辑，支持“添加不修改”的扩展方式。
