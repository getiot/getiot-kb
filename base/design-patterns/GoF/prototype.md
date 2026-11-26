---
sidebar_position: 6
slug: /prototype
sidebar_label: 原型模式
---

# 设计模式 - 原型模式

你有没有碰到过这样的需求：想要“复制”一个对象，而不是重新用构造函数创建一个全新的？

比如在游戏中生成怪物、在图形软件中复制图形对象、或者从模板快速创建表单。如果你用构造函数重新创建，可能需要手动设置一大堆属性，非常麻烦。更好的方式是——**克隆已有的对象**。

这就是**原型模式**（Prototype Pattern）要解决的问题。

:::tip 核心思想 🌟

原型模式就是通过复制（克隆）一个已存在的对象，来创建新的对象实例。

:::

这样做不仅节省了构造时间，还能保留对象的原始状态。



## 模式结构（UML 类图）

```markdown
          Prototype（原型接口）
                 ▲
                 |
         ConcretePrototype（具体原型）
```

**类图解释**：

- **Prototype**：定义克隆方法（如 `clone()`）。
- **ConcretePrototype**：实现 `clone()` 方法。
- 客户端（你）通过调用 `clone()` 方法来获得新的对象。



## 示例场景

我们以“创建怪物对象”为例，定义一个怪物类，它包含类型、血量、武器等属性。你可以复制现有的怪物作为模板，然后创建多个副本。



### Java 实现

```java showLineNumbers
// 原型接口
interface Monster extends Cloneable {
    Monster clone();
}

// 具体原型
class Orc implements Monster {
    String type;
    int hp;
    String weapon;

    public Orc(String type, int hp, String weapon) {
        this.type = type;
        this.hp = hp;
        this.weapon = weapon;
    }

    public Monster clone() {
        return new Orc(type, hp, weapon);
    }

    public String toString() {
        return "Orc [type=" + type + ", hp=" + hp + ", weapon=" + weapon + "]";
    }
}

// 使用
public class Main {
    public static void main(String[] args) {
        Orc orc1 = new Orc("Warrior", 100, "Axe");
        Orc orc2 = (Orc) orc1.clone();

        System.out.println(orc1);
        System.out.println(orc2);
    }
}
```



### C++ 实现

```cpp showLineNumbers
#include <iostream>
#include <string>
using namespace std;

// 原型接口
class Monster {
public:
    virtual Monster* clone() const = 0;
    virtual void show() const = 0;
    virtual ~Monster() {}
};

// 具体原型
class Orc : public Monster {
    string type;
    int hp;
    string weapon;

public:
    Orc(string t, int h, string w) : type(t), hp(h), weapon(w) {}

    Monster* clone() const override {
        return new Orc(type, hp, weapon);
    }

    void show() const override {
        cout << "Orc [type=" << type << ", hp=" << hp << ", weapon=" << weapon << "]" << endl;
    }
};

// 使用
int main() {
    Orc* orc1 = new Orc("Warrior", 100, "Axe");
    Monster* orc2 = orc1->clone();

    orc1->show();
    orc2->show();

    delete orc1;
    delete orc2;
    return 0;
}
```



### Python 实现

```python showLineNumbers
import copy

# 原型类
class Monster:
    def __init__(self, type, hp, weapon):
        self.type = type
        self.hp = hp
        self.weapon = weapon

    def clone(self):
        return copy.deepcopy(self)

    def __str__(self):
        return f"Monster [type={self.type}, hp={self.hp}, weapon={self.weapon}]"

# 使用
orc1 = Monster("Warrior", 100, "Axe")
orc2 = orc1.clone()

print(orc1)
print(orc2)
```



### TypeScript 实现

```typescript showLineNumbers
// 原型接口
interface Monster {
  clone(): Monster;
  toString(): string;
}

// 具体原型
class Orc implements Monster {
  constructor(public type: string, public hp: number, public weapon: string) {}

  clone(): Monster {
    return new Orc(this.type, this.hp, this.weapon);
  }

  toString(): string {
    return `Orc [type=${this.type}, hp=${this.hp}, weapon=${this.weapon}]`;
  }
}

// 使用
const orc1 = new Orc("Warrior", 100, "Axe");
const orc2 = orc1.clone();

console.log(orc1.toString());
console.log(orc2.toString());
```



## 小结

| 特性     | 内容                                                         |
| -------- | ------------------------------------------------------------ |
| 模式类型 | 创建型                                                       |
| 适用场景 | 创建对象成本高、对象结构复杂、需要大量复制                   |
| 优点     | <ul><li>无需重新创建，直接复制</li><li>保留原始状态</li></ul> |
| 缺点     | <ul><li>需要实现克隆逻辑</li><li>深拷贝、浅拷贝容易混淆</li></ul> |

原型模式适合用于**批量复制对象**的场景，也适合那些**构造代价昂贵或结构复杂**的对象。记得根据实际需求决定是**浅拷贝**还是**深拷贝**。
