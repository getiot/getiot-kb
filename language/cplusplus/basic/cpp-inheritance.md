---
sidebar_position: 31
slug: /cpp-inheritance
---

# C++ 继承



继承是 C++ 面向对象编程中一个非常重要的概念，继承允许我们依据一个类来定义另一个类。也就是说，当创建一个类时，不需要重新编写新的数据成员和成员函数，只需指定新建的类继承了一个已有的类的成员即可。这使得创建和维护一个应用程序变得更容易，也达到了重用代码功能和提高执行效率的效果。

继承是面向对象的三大特征之一（另外两个是封装和多态），继承代表了 "is a" 关系。例如，哺乳动物是动物，狗是哺乳动物，因此，狗是动物，等等。



## 继承的优缺点

**优点**：

- 提高代码的重用性，减少创建类的工作量，每个子类都拥有父类的方法和属性。
- 子类可以形似父类，但又异于父类，“龙生龙，凤生凤，老鼠生来会打洞” 是说子拥有父母的 “种”，“世界上没有两片完全相同的叶子” 是指明子与父母的不同。
- 提高代码的可扩展性，实现父类的方法就可以 “为所欲为”了，很多开源框架的扩展接口都是通过继承父类来完成的。
- 提高产品或项目的开放性。

**缺点**：

- 继承是侵入性的。只要继承，就必须拥有父类的所有属性和方法。
- 降低代码的灵活性。子类必须拥有父类的属性和方法，让子类自由的世界中多了些约束。
- 增强了耦合性。当父类的常量、变量和方法被修改时，需要考虑子类的修改，而且在缺乏规范的环境下，这种修改可能带来非常糟糕的结果 —— 大段的代码需要重构。



## 继承的使用场景

在 C++ 中，类的继承主要有两个使用场景：

1. 当你创建的新类与现有的类相似，只是多出若干成员变量或成员函数时，可以使用继承，这样不但会减少代码量，而且新类会拥有基类的所有功能。
2. 当你需要创建多个类，它们拥有很多相似的成员变量或成员函数时，也可以使用继承。可以将这些类的共同成员提取出来，定义为基类，然后从基类继承，既可以节省代码，也方便后续修改成员。



## 基类 & 派生类

当创建一个类时，你不需要重新编写新的数据成员和成员函数，只需指定新建的类继承了一个已有的类的成员即可，这个已有的类称为 **基类**，新建的类称为 **派生类**。

定义一个派生类时，可以使用一个类派生列表来指定基类。类派生列表以一个或多个基类命名，形式如下：

```cpp showLineNumbers
class derived-class: access-specifier base-class
```

这里创建了一个新类 `derived-class`，其继承自 `base-class`，是之前定义过的某个类的名称。访问修饰符 `access-specifie` 是 `public`、`protected` 或 `private` 三者之一。如果未使用访问修饰符 `access-specifier`，则默认为 `private`。

示例：派生类 Rectangle 继承基类 Shape

```cpp showLineNumbers
#include <iostream>

// 基类
class Shape 
{
public:
    void setWidth(int w)
    {
        width = w;
    }
    void setHeight(int h)
    {
        height = h;
    }
protected:
    int width;
    int height;
};

// 派生类
class Rectangle: public Shape
{
public:
    int getArea()
    {
        return (width * height);
    }
};

int main(void)
{
    Rectangle r;
    
    r.setWidth(5);   // 使用基类的方法设置宽度
    r.setHeight(7);  // 使用基类的方法设置高度
    
    // 输出对象的面积
    std::cout << "Total area: " << r.getArea() << std::endl;
    
    return 0;
}
```

编译和运行以上示例，输出结果如下：

```bash
Total area: 35
```



## 访问控制和继承

派生类可以访问基类中所有的非私有成员，基类成员如果不想被派生类的成员函数访问，则应在基类中声明为 `private`。

下表列出了根据访问权限总结出不同的访问类型：

| 访问     | public | protected | private |
| -------- | ------ | --------- | ------- |
| 同一个类 | yes    | yes       | yes     |
| 派生类   | yes    | yes       | no      |
| 外部的类 | yes    | no        | no      |

一个派生类继承了所有的基类方法，但下列情况除外。

1. 基类的构造函数、析构函数和拷贝构造函数；
2. 基类的重载运算符；
3. 基类的友元函数。



## 继承类型

继承类型是通过访问修饰符 `access-specifier` 来指定的。当一个类派生自基类，该基类可以被继承为 `public`、 `protected` 或 `private` 几种类型。

在实际应用中，很少使用 `protected` 或 `private` 继承，通常使用 `public` 继承。

当使用不同类型的继承时，遵循以下几个规则：

- **公有继承（public）**

  当一个类派生自公有基类时，基类的公有成员也是派生类的公有成员，基类的保护成员也是派生类的保护成员，基类的私有成员不能直接被派生类访问，但是可以通过调用基类的公有和保护成员来访问。

- **保护继承（protected）**

  当一个类派生自保护基类时，基类的公有和保护成员将成为派生类的保护成员。

- **私有继承（private）**

  当一个类派生自私有基类时，基类的公有和保护成员将成为派生类的私有成员。



## 多继承

多继承即一个子类可以有多个父类，C++ 类可以从多个类继承成员，语法如下：

```cpp showLineNumbers
class <派生类名>:<访问修饰符> <基类名1>, <访问修饰符> <基类名2>, ...
{
    <派生类类体>
};
```

访问修饰符可以是 `public` 、`protected` 或 `private` 三者之一，各个基类之间用逗号分隔。

示例：类的多继承

```cpp showLineNumbers
#include <iostream>

// 基类 Shape
class Shape 
{
    public:
        Shape() {
            width = 0;
            height = 0;
        }

        Shape(int a, int b) {
            width = a;
            height = b;
        }

    protected:
        int width;
        int height;
};

// 基类 PaintCost
class PaintCost 
{
    public:
        int cost(int area) { return area * 70; }
};

// 派生类
class Rectangle: public Shape, public PaintCost
{
    public:
        Rectangle(int a,int b):Shape(a,b){}

        int area() { return width * height; }
};

int main(void)
{
    Rectangle rect(5,7);

    int area = rect.area();

    // 输出对象的面积
    std::cout << "Total area: " << area << "\n";

    // 输出总花费
    std::cout << "Total paint cost: $" << rect.cost(area) << "\n";
    
    return 0;
}
```

编译和运行以上示例，输出结果如下：

```bash
Total area: 35
Total paint cost: $2450
```

