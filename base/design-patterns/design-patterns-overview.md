---
sidebar_position: 1
slug: /design-patterns-overview
---

# 什么是设计模式

在学习编程的过程中，你可能经常听到“设计模式”（Design Patterns）这个词。它听起来像是某种高深的编程技巧，实际上它就是一套帮助你写出更优雅、可维护、可扩展代码的“经验总结”。



## 就像建筑图纸那样的“模式”

试想你是一位建筑师，要设计一幢房子。你不会每次都从头开始想“门要怎么开，窗户怎么装”，你会参考已有的、成熟的建筑图纸。这些图纸总结了前人的经验，能够帮你少走弯路。

在软件开发中也一样。面对不同的开发问题，前人也总结出了一套通用的、可复用的代码结构方案，这就是“设计模式”（Design Patterns）。



## 设计模式的定义

设计模式是**对软件设计中常见问题的通用解决方案**。它不是具体的代码，而是某种可以被重复使用的“设计经验”，你可以根据具体情况，用你自己的语言或框架来实现它。

设计模式并不是新的发明，它们的基础源于无数经验丰富的软件工程师在实践中摸索出来的结构和思路。



## 设计模式的起源

1994 年，四位软件工程师 —— [Erich Gamma](https://en.wikipedia.org/wiki/Erich_Gamma)、[Richard Helm](https://en.wikipedia.org/wiki/Richard_Helm)、[Ralph Johnson](https://en.wikipedia.org/wiki/Ralph_Johnson_(computer_scientist)) 和 [John Vlissides](https://en.wikipedia.org/wiki/John_Vlissides) —— 合著了一本书《Design Patterns: Elements of Reusable Object-Oriented Software》（中文译为《设计模式：可复用面向对象软件的基础》）。由于作者是四位，所以人们习惯称他们为 **“四人帮（GoF, Gang of Four）”**。

![《设计模式》作者（GoF 四人帮）](https://static.getiot.tech/Design-Patterns_GoF.gif#center)

这本书首次系统性地总结了 23 种经典的面向对象设计模式，并按照目的进行了分类。这些模式就是今天我们口中常说的“GoF 设计模式”。



## 为什么要学习设计模式？

也许你会想，我现在能写代码就够了，为什么还要去学这些“模式”？这是一个好问题。下面是一些非常现实的理由：

1. **提高代码可读性和可维护性**
    设计模式能让你的代码更有结构，别人一看就能明白你的意图。
2. **解决重复出现的问题**
    不少编程问题在不同项目中都会遇到，比如对象的创建、多个对象之间的通信等等，设计模式提供了现成的解决方案。
3. **提升架构思维**
    学习设计模式的过程，其实是在培养你从更高层次思考程序结构的能力。
4. **更好地进行团队协作**
    设计模式是程序员之间的“共同语言”，只要说出“观察者模式”或“工厂模式”，大家都知道你想表达的意思。



## 设计模式解决了什么问题？

设计模式主要帮助你解决以下几个类型的问题：

- 如何合理创建对象？（避免过多使用 `new`）
- 如何解耦模块之间的关系？
- 如何应对需求的变化和扩展？
- 如何让系统更灵活、可复用？

这些问题在小项目中可能不明显，但一旦项目复杂起来，没有良好的架构设计，代码会变得越来越难维护。



## 设计模式的三大分类

GoF 将 23 种设计模式分为三类：

1. **创建型模式（Creational Patterns）**

   关注“对象的创建过程”，包括：[单例模式](/design-patterns/singleton/)、[工厂模式](/design-patterns/simple-factory/)、[建造者模式](/design-patterns/builder/)、[抽象工厂模式](/design-patterns/abstract-factory/)、[原型模式](/design-patterns/prototype/)。

2. **结构型模式（Structural Patterns）**

   关注“如何组织类与对象”，包括：[适配器模式](/design-patterns/adapter/)、[桥接模式](/design-patterns/bridge/)、[装饰器模式](/design-patterns/decorator/)、[组合模式](/design-patterns/composite/)、[外观模式](/design-patterns/facade/)、[享元模式](/design-patterns/flyweight/)、[代理模式](/design-patterns/proxy/)。

3. **行为型模式（Behavioral Patterns）**

   关注“对象之间如何交互和传递职责”，包括：[模版方法模式](/design-patterns/template-method/)、[命令模式](/design-patterns/command/)、[迭代器模式](/design-patterns/iterator/)、[观察者模式](/design-patterns/observer/)、[中介者模式](/design-patterns/mediator/)、[备忘录模式](/design-patterns/memento/)、[解释器模式](/design-patterns/interpreter/)、[状态模式](/design-patterns/state/)、[策略模式](/design-patterns/strategy/)、[职责链模式](/design-patterns/chain-of-responsibility/)、[访问者模式](/design-patterns/visitor/)。

我们会在后续章节中逐一讲解这些模式的具体内容和使用方式。



## 常见的设计模式有哪些？

以下是一些你可能最先接触到的设计模式：

- **单例模式**（Singleton）：确保一个类只有一个实例。
- **工厂模式**（Factory Method）：让子类决定创建哪个对象。
- **观察者模式**（Observer）：一种订阅-通知机制。
- **策略模式**（Strategy）：定义一系列算法，让它们可以互相替换。
- **装饰器模式**（Decorator）：在不改变原对象的情况下扩展其功能。

这些模式在很多知名框架和库中都有实际应用，比如 React 中的高阶组件（HOC）就使用了装饰器模式的思想。



## 小结

设计模式并不是一套“必须遵守的规范”，它更像是一套成熟的“思维工具”，帮助你在写代码时少踩坑、写得更好。

在本文中，你了解了：

- 设计模式的定义和起源
- 为什么要学习设计模式
- 设计模式解决了什么问题
- 设计模式的三大分类
- 常见的设计模式有哪些

接下来，我们将逐个深入讲解这些经典设计模式的原理、优缺点以及实战示例，帮助你真正掌握它们，并能灵活地运用在自己的项目中。
