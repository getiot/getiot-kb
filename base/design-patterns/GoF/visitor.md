---
sidebar_position: 24
slug: /visitor
sidebar_label: 访问者模式
---

# 设计模式 - 访问者模式

访问者模式（Visitor Pattern）允许你在不修改对象结构的情况下，增加新的操作。这就像是你通过一个“访问者”对象来访问一组元素，执行各种操作。

访问者模式的核心角色：

1. **元素（Element）**：所有需要被访问的类，通常有一个 `accept()` 方法，用来接受访问者的访问。
2. **具体元素（ConcreteElement）**：元素类的具体实现，它实现了 `accept()` 方法，通常会将访问者传递到具体的处理方法。
3. **访问者（Visitor）**：定义所有访问方法，每个访问方法对应一种元素类型。
4. **具体访问者（ConcreteVisitor）**：实现具体操作，如何访问元素并执行相应的动作。



:::tip 核心思想 🌟

将操作分离出来，封装在一个“访问者”对象中，使得操作可以在不修改元素类的情况下添加到对象结构上。

:::



## 模式结构（UML 类图）

```scss
              +----------------------------+
              |        Visitor             |
              +----------------------------+
              | + visitConcreteElementA()  |
              | + visitConcreteElementB()  |
              +----------------------------+
                            ▲
           +----------------+-----------------+
           |                                  |
+--------------------------+      +--------------------------+
|     ConcreteVisitorA     |      |     ConcreteVisitorB     |
+--------------------------+      +--------------------------+
| + visitConcreteElementA()|      | + visitConcreteElementB()|
+--------------------------+      +--------------------------+

+------------------+  
| Element          |  
+------------------+  
| + accept()       |  
+------------------+  
         ▲
         |
+----------------------+
| ConcreteElementA     |
+----------------------+
| + accept()           |
+----------------------+
```



## 示例场景

想象你有一个复杂的对象结构，比如各种不同类型的 `Animal`（动物）类，你可能希望执行不同的操作，如发出声音。

但你不想在每个类中重复写操作代码。这时候，你就可以使用访问者模式。你可以创建一个“访问者”对象，它知道如何操作这些类，而不需要修改每个类的定义。



### Java 实现

```java showLineNumbers
// 访问者接口
interface AnimalVisitor {
    void visit(Dog dog);
    void visit(Cat cat);
}

// 动物接口（元素）
interface Animal {
    void accept(AnimalVisitor visitor);
}

// 具体元素
class Dog implements Animal {
    public void accept(AnimalVisitor visitor) {
        visitor.visit(this);
    }

    public void bark() {
        System.out.println("Woof!");
    }
}

class Cat implements Animal {
    public void accept(AnimalVisitor visitor) {
        visitor.visit(this);
    }

    public void meow() {
        System.out.println("Meow!");
    }
}

// 具体访问者
class AnimalSoundVisitor implements AnimalVisitor {
    public void visit(Dog dog) {
        dog.bark();
    }

    public void visit(Cat cat) {
        cat.meow();
    }
}

// 使用
public class Main {
    public static void main(String[] args) {
        Animal dog = new Dog();
        Animal cat = new Cat();

        AnimalVisitor soundVisitor = new AnimalSoundVisitor();

        dog.accept(soundVisitor);  // 输出：Woof!
        cat.accept(soundVisitor);  // 输出：Meow!
    }
}
```



### C++ 实现

```cpp showLineNumbers
#include <iostream>
using namespace std;

// 访问者接口
class AnimalVisitor {
public:
    virtual void visit(class Dog&) = 0;
    virtual void visit(class Cat&) = 0;
    virtual ~AnimalVisitor() = default;
};

// 元素接口
class Animal {
public:
    virtual void accept(AnimalVisitor& visitor) = 0;
    virtual ~Animal() = default;
};

// 具体元素
class Dog : public Animal {
public:
    void accept(AnimalVisitor& visitor) override {
        visitor.visit(*this);
    }

    void bark() {
        cout << "Woof!" << endl;
    }
};

class Cat : public Animal {
public:
    void accept(AnimalVisitor& visitor) override {
        visitor.visit(*this);
    }

    void meow() {
        cout << "Meow!" << endl;
    }
};

// 具体访问者
class AnimalSoundVisitor : public AnimalVisitor {
public:
    void visit(Dog& dog) override {
        dog.bark();
    }

    void visit(Cat& cat) override {
        cat.meow();
    }
};

// 使用
int main() {
    Dog dog;
    Cat cat;
    AnimalSoundVisitor soundVisitor;

    dog.accept(soundVisitor); // 输出：Woof!
    cat.accept(soundVisitor); // 输出：Meow!

    return 0;
}
```



### Python 实现

```python showLineNumbers
from abc import ABC, abstractmethod

# 访问者接口
class AnimalVisitor(ABC):
    @abstractmethod
    def visit(self, animal):
        pass

# 元素接口
class Animal(ABC):
    @abstractmethod
    def accept(self, visitor):
        pass

# 具体元素
class Dog(Animal):
    def accept(self, visitor):
        visitor.visit(self)

    def bark(self):
        print("Woof!")

class Cat(Animal):
    def accept(self, visitor):
        visitor.visit(self)

    def meow(self):
        print("Meow!")

# 具体访问者
class AnimalSoundVisitor(AnimalVisitor):
    def visit(self, animal):
        if isinstance(animal, Dog):
            animal.bark()
        elif isinstance(animal, Cat):
            animal.meow()

# 使用
dog = Dog()
cat = Cat()

sound_visitor = AnimalSoundVisitor()
dog.accept(sound_visitor)  # 输出：Woof!
cat.accept(sound_visitor)  # 输出：Meow!
```



### TypeScript 实现

```typescript showLineNumbers
interface Animal {
  accept(visitor: AnimalVisitor): void;
}

interface AnimalVisitor {
  visit(dog: Dog): void;
  visit(cat: Cat): void;
}

class Dog implements Animal {
  accept(visitor: AnimalVisitor): void {
    visitor.visit(this);
  }

  bark() {
    console.log("Woof!");
  }
}

class Cat implements Animal {
  accept(visitor: AnimalVisitor): void {
    visitor.visit(this);
  }

  meow() {
    console.log("Meow!");
  }
}

class AnimalSoundVisitor implements AnimalVisitor {
  visit(dog: Dog): void {
    dog.bark();
  }

  visit(cat: Cat): void {
    cat.meow();
  }
}

// 使用
const dog = new Dog();
const cat = new Cat();

const soundVisitor = new AnimalSoundVisitor();
dog.accept(soundVisitor); // 输出：Woof!
cat.accept(soundVisitor); // 输出：Meow!
```



## 小结

| 特性     | 内容                                                         |
| -------- | ------------------------------------------------------------ |
| 模式类型 | 行为型                                                       |
| 适用场景 | <ul><li>复杂对象结构的操作（如编译器、解释器）</li><li>需要在不修改类的情况下增加新操作</li></ul> |
| 优点     | <ul><li>易于扩展新操作</li><li>遵循开放/封闭原则</li></ul>   |
| 缺点     | <ul><li>每增加一个元素类，都需要修改所有访问者</li></ul>     |

访问者模式是处理复杂对象结构时非常有用的模式，它使得你可以把操作逻辑和数据结构分离开，遵循了“开放/封闭原则”，非常适合需要**增加新操作而不修改已有元素类**的场景。
