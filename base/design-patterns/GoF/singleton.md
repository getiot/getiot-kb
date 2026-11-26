---
sidebar_position: 1
slug: /singleton
sidebar_label: 单例模式
---

# 设计模式 - 单例模式

在很多场景中，你可能希望某个类只有一个实例，而且这个实例可以被整个程序共享使用。比如：配置管理器、日志记录器、数据库连接池、操作系统驱动或线程池等系统资源。**单例模式**（Singleton Pattern）就是为了解决这个问题。

:::tip 核心思想 🌟

确保一个类在整个系统中只有一个实例，并提供一个全局访问点来获取它。

:::



## Java 实现

```java showLineNumbers
// 懒汉式（线程不安全）
public class Singleton {
    private static Singleton instance; // 静态成员变量保存唯一实例

    private Singleton() {} // 构造函数私有化

    public static Singleton getInstance() {
        if (instance == null) {
            instance = new Singleton(); // 第一次调用时才创建实例
        }
        return instance;
    }
}
```

如果你担心多线程环境下创建多个实例，可以使用**双重检查锁定**的线程安全写法：

```java showLineNumbers
// 线程安全的双重检查锁定
public class Singleton {
    private static volatile Singleton instance;

    private Singleton() {}

    public static Singleton getInstance() {
        if (instance == null) {
            synchronized (Singleton.class) {
                if (instance == null) {
                    instance = new Singleton();
                }
            }
        }
        return instance;
    }
}
```



## C++ 实现

```cpp showLineNumbers
// 懒汉式单例（C++11 后线程安全）
#include <iostream>

class Singleton {
private:
    Singleton() {}
    ~Singleton() {}
    Singleton(const Singleton&) = delete;            // 禁用拷贝
    Singleton& operator=(const Singleton&) = delete; // 禁用赋值

public:
    static Singleton& getInstance() {
        static Singleton instance; // 局部静态变量，第一次调用时创建，C++11 后线程安全
        return instance;
    }

    void doSomething() {
        std::cout << "Doing something...\n";
    }
};
```



## C 语言实现

虽然 C 语言本身不支持面向对象的语法（如类、构造函数、私有成员等），但你仍然可以通过结构体 + 静态变量的方式模拟单例模式的行为。

```c showLineNumbers
#include <stdio.h>
#include <stdlib.h>

// 定义一个结构体，代表“类”
typedef struct Singleton {
    int data;
    // 可以在这里添加更多字段
} Singleton;

// 获取唯一实例的函数
Singleton* get_instance() {
    static Singleton* instance = NULL; // 静态变量，只初始化一次
    if (instance == NULL) {
        instance = (Singleton*)malloc(sizeof(Singleton));
        if (instance != NULL) {
            instance->data = 0; // 初始化
        }
    }
    return instance;
}

// 示例方法
void do_something(Singleton* instance) {
    if (instance != NULL) {
        instance->data++;
        printf("Singleton data: %d\n", instance->data);
    }
}

int main() {
    Singleton* s1 = get_instance();
    Singleton* s2 = get_instance();

    do_something(s1);
    do_something(s2);

    // 检查是否为同一实例
    if (s1 == s2) {
        printf("s1 和 s2 是同一个实例。\n");
    } else {
        printf("s1 和 s2 不是同一个实例。\n");
    }

    // 注意：此示例没有释放内存，为了模拟“全局常驻”
    return 0;
}
```



## Python 实现

Python 有很多方式实现单例，这里是最直观的一种：使用 `__new__` 方法：

```python showLineNumbers
class Singleton:
    _instance = None

    def __new__(cls):
        if cls._instance is None:
            cls._instance = super().__new__(cls)
        return cls._instance

# 使用
obj1 = Singleton()
obj2 = Singleton()
print(obj1 is obj2)  # 输出 True，表示两个对象是同一个实例
```

还可以用装饰器、元类甚至直接使用模块（因为模块在 Python 中天然是单例的）。



## TypeScript 实现

```typescript showLineNumbers
class Singleton {
  private static instance: Singleton;

  // 构造函数私有，禁止外部 new
  private constructor() {}

  public static getInstance(): Singleton {
    if (!Singleton.instance) {
      Singleton.instance = new Singleton();
    }
    return Singleton.instance;
  }

  public sayHello(): void {
    console.log("Hello from Singleton!");
  }
}

// 使用
const s1 = Singleton.getInstance();
const s2 = Singleton.getInstance();
console.log(s1 === s2); // 输出 true
```

TypeScript 中如果使用模块作用域，也能自然形成单例（即模块导出的是同一个对象）。



## 结构图（UML）

```scss
┌───────────────┐
│   Singleton   │
│---------------│
│- instance     │ static
│+ getInstance()│
└───────┬───────┘
        │
        ▼
     单一实例
```

你可以把上面的结构理解为：

- `Singleton` 类只有一个实例（通过私有构造函数控制）
- `getInstance()` 是获取实例的唯一入口



## 小结

|      语言      | 特点说明                                                     |
| :------------: | ------------------------------------------------------------ |
|    **Java**    | 支持多种写法；需注意线程安全；双重检查锁是经典方案。         |
|    **C++**     | 使用局部静态变量 + 禁用拷贝构造函数是最常见方式。            |
|     **C**      | 使用 `static` 指针模拟唯一实例，用 `malloc` 创建结构体，函数模拟方法。 |
|   **Python**   | `__new__` 是通用方式；也可用模块、元类或装饰器等高级技巧。   |
| **TypeScript** | 用类的静态属性模拟；也可直接用模块导出一个对象形成天然单例。 |

单例模式适用于需要“全局唯一”的对象，但也要注意：滥用单例可能会让代码耦合度过高，测试困难。在使用时，建议结合具体场景理性选择。
