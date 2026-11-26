---
sidebar_position: 2
slug: /simple-factory
sidebar_label: 简单工厂模式
---

# 设计模式 - 简单工厂模式

当你需要**创建对象**，但又不想在代码中到处使用 `new` 或 `malloc` 的时候，工厂模式（Factory Pattern）就派上用场了。

:::tip 核心思想 🌟

把创建对象的过程封装在“工厂”中，客户端只关心“我要什么对象”，而不是“怎么造这个对象”。

:::

常见的工厂模式分为三种：

1. **简单工厂**（Simple Factory）：一个工厂根据参数返回不同的类实例。
2. **工厂方法**（Factory Method）：每个产品有一个对应的工厂类。
3. **抽象工厂**（Abstract Factory）：创建一系列相关对象的家族。

本节我们先讲最基础、最通俗易懂的 **简单工厂模式**。



## Java 实现

```java showLineNumbers
// 产品接口
interface Shape {
    void draw();
}

// 具体产品类
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

// 工厂类
class ShapeFactory {
    public static Shape createShape(String type) {
        if (type.equals("circle")) {
            return new Circle();
        } else if (type.equals("square")) {
            return new Square();
        }
        return null;
    }
}

// 使用
public class Main {
    public static void main(String[] args) {
        Shape shape = ShapeFactory.createShape("circle");
        shape.draw(); // 输出：Drawing Circle
    }
}
```



## C++ 实现

```cpp showLineNumbers
#include <iostream>
#include <string>
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

// 工厂类
class ShapeFactory {
public:
    static Shape* createShape(const string& type) {
        if (type == "circle") return new Circle();
        if (type == "square") return new Square();
        return nullptr;
    }
};

// 使用
int main() {
    Shape* shape = ShapeFactory::createShape("square");
    if (shape) shape->draw(); // 输出：Drawing Square
    delete shape;
    return 0;
}
```



## Python 实现

```python showLineNumbers
# 产品类
class Shape:
    def draw(self):
        raise NotImplementedError

class Circle(Shape):
    def draw(self):
        print("Drawing Circle")

class Square(Shape):
    def draw(self):
        print("Drawing Square")

# 工厂函数
def create_shape(type):
    if type == "circle":
        return Circle()
    elif type == "square":
        return Square()
    else:
        return None

# 使用
shape = create_shape("circle")
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

// 工厂类
class ShapeFactory {
  static createShape(type: string): Shape | null {
    if (type === "circle") return new Circle();
    if (type === "square") return new Square();
    return null;
  }
}

// 使用
const shape = ShapeFactory.createShape("square");
shape?.draw(); // 输出：Drawing Square
```



## C 语言实现

```c showLineNumbers
// factory.c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef enum { CIRCLE, SQUARE, UNKNOWN } ShapeType;

typedef struct Shape {
    void (*draw)(struct Shape*);
} Shape;

// 具体产品：Circle
void draw_circle(Shape* s) {
    printf("Drawing Circle\n");
}

// 具体产品：Square
void draw_square(Shape* s) {
    printf("Drawing Square\n");
}

// 工厂函数
Shape* create_shape(const char* type) {
    Shape* shape = (Shape*)malloc(sizeof(Shape));
    if (strcmp(type, "circle") == 0) {
        shape->draw = draw_circle;
    } else if (strcmp(type, "square") == 0) {
        shape->draw = draw_square;
    } else {
        free(shape);
        return NULL;
    }
    return shape;
}

// 使用
int main() {
    Shape* shape = create_shape("circle");
    if (shape) {
        shape->draw(shape); // 输出：Drawing Circle
        free(shape);
    }
    return 0;
}
```



## 结构图（UML）

```scss
    Shape (接口)
        ▲
  ┌─────┴─────┐
Circle      Square
    ▲
ShapeFactory
    + createShape(type)
```

结构解释：

- `Shape` 是抽象产品
- `Circle` / `Square` 是具体产品
- `ShapeFactory` 根据传入的类型返回对应产品实例



## 小结

|      语言      | 特点说明                                                     |
| :------------: | ------------------------------------------------------------ |
|    **Java**    | 使用接口 + 静态工厂方法是最常见做法                          |
|    **C++**     | 抽象类模拟接口，返回多态对象指针，注意释放内存               |
|   **Python**   | 简单灵活，用函数或类都可实现                                 |
| **TypeScript** | 使用类型接口和类结合，实现清晰                               |
|     **C**      | 模拟对象和函数指针模拟“方法”，创建过程靠 `strcmp()` 判断类型 |

**工厂模式的好处**是：**将对象创建与使用分离，解耦代码逻辑。**

但它也有缺点，比如当你新增一个新的产品类型时，需要**修改工厂函数逻辑**，这违背了“开放-封闭原则”。为了解决这个问题，可以引入 **工厂方法模式** —— 我们将在后续章节中讲解。
