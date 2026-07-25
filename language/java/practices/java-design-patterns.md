---
sidebar_position: 4
slug: /java-design-patterns
sidebar_label: 常见设计模式
---

# 常见设计模式在 Java 中的应用

设计模式是解决常见问题的可复用方案。理解设计模式的应用是进行高质量开发的关键。本章将介绍常见设计模式在 Java 中的应用。

## 创建型模式：Singleton、Factory

### Singleton（单例模式）

**单例模式**确保一个类只有一个实例。

```java
// 饿汉式
public class Singleton {
    private static final Singleton instance = new Singleton();
    
    private Singleton() {
    }
    
    public static Singleton getInstance() {
        return instance;
    }
}

// 懒汉式（线程安全）
public class SingletonLazy {
    private static volatile SingletonLazy instance;
    
    private SingletonLazy() {
    }
    
    public static SingletonLazy getInstance() {
        if (instance == null) {
            synchronized (SingletonLazy.class) {
                if (instance == null) {
                    instance = new SingletonLazy();
                }
            }
        }
        return instance;
    }
}
```

### Factory（工厂模式）

**工厂模式**用于创建对象，隐藏创建逻辑。

```java
// 产品接口
public interface Shape {
    void draw();
}

// 具体产品
public class Circle implements Shape {
    @Override
    public void draw() {
        System.out.println("绘制圆形");
    }
}

public class Rectangle implements Shape {
    @Override
    public void draw() {
        System.out.println("绘制矩形");
    }
}

// 工厂类
public class ShapeFactory {
    public Shape createShape(String type) {
        if ("circle".equalsIgnoreCase(type)) {
            return new Circle();
        } else if ("rectangle".equalsIgnoreCase(type)) {
            return new Rectangle();
        }
        throw new IllegalArgumentException("未知类型：" + type);
    }
}

// 使用
ShapeFactory factory = new ShapeFactory();
Shape circle = factory.createShape("circle");
circle.draw();
```

## 结构型模式：Decorator、Adapter

### Decorator（装饰器模式）

**装饰器模式**动态地给对象添加功能。

```java
// 组件接口
public interface Coffee {
    double getCost();
    String getDescription();
}

// 具体组件
public class SimpleCoffee implements Coffee {
    @Override
    public double getCost() {
        return 5.0;
    }
    
    @Override
    public String getDescription() {
        return "简单咖啡";
    }
}

// 装饰器
public abstract class CoffeeDecorator implements Coffee {
    protected Coffee coffee;
    
    public CoffeeDecorator(Coffee coffee) {
        this.coffee = coffee;
    }
}

// 具体装饰器
public class MilkDecorator extends CoffeeDecorator {
    public MilkDecorator(Coffee coffee) {
        super(coffee);
    }
    
    @Override
    public double getCost() {
        return coffee.getCost() + 2.0;
    }
    
    @Override
    public String getDescription() {
        return coffee.getDescription() + ", 加牛奶";
    }
}

// 使用
Coffee coffee = new SimpleCoffee();
coffee = new MilkDecorator(coffee);
System.out.println(coffee.getDescription() + " - $" + coffee.getCost());
```

### Adapter（适配器模式）

**适配器模式**使不兼容的接口能够协同工作。

```java
// 目标接口
public interface MediaPlayer {
    void play(String audioType, String fileName);
}

// 适配者接口
public interface AdvancedMediaPlayer {
    void playVlc(String fileName);
    void playMp4(String fileName);
}

// 适配者实现
public class VlcPlayer implements AdvancedMediaPlayer {
    @Override
    public void playVlc(String fileName) {
        System.out.println("播放 VLC 文件：" + fileName);
    }
    
    @Override
    public void playMp4(String fileName) {
        // 不支持
    }
}

// 适配器
public class MediaAdapter implements MediaPlayer {
    private AdvancedMediaPlayer advancedPlayer;
    
    public MediaAdapter(String audioType) {
        if ("vlc".equalsIgnoreCase(audioType)) {
            advancedPlayer = new VlcPlayer();
        }
    }
    
    @Override
    public void play(String audioType, String fileName) {
        if ("vlc".equalsIgnoreCase(audioType)) {
            advancedPlayer.playVlc(fileName);
        }
    }
}

// 使用
MediaPlayer player = new MediaAdapter("vlc");
player.play("vlc", "movie.vlc");
```

## 行为型模式：Observer、Strategy

### Observer（观察者模式）

**观察者模式**定义对象间一对多的依赖关系。

```java
import java.util.*;

// 观察者接口
public interface Observer {
    void update(String message);
}

// 主题接口
public interface Subject {
    void attach(Observer observer);
    void detach(Observer observer);
    void notifyObservers();
}

// 具体主题
public class NewsAgency implements Subject {
    private List<Observer> observers = new ArrayList<>();
    private String news;
    
    @Override
    public void attach(Observer observer) {
        observers.add(observer);
    }
    
    @Override
    public void detach(Observer observer) {
        observers.remove(observer);
    }
    
    @Override
    public void notifyObservers() {
        for (Observer observer : observers) {
            observer.update(news);
        }
    }
    
    public void setNews(String news) {
        this.news = news;
        notifyObservers();
    }
}

// 具体观察者
public class NewsChannel implements Observer {
    private String name;
    
    public NewsChannel(String name) {
        this.name = name;
    }
    
    @Override
    public void update(String message) {
        System.out.println(name + " 收到新闻：" + message);
    }
}

// 使用
NewsAgency agency = new NewsAgency();
agency.attach(new NewsChannel("频道1"));
agency.attach(new NewsChannel("频道2"));
agency.setNews("重要新闻");
```

### Strategy（策略模式）

**策略模式**定义一系列算法，使它们可以互换。

```java
// 策略接口
public interface PaymentStrategy {
    void pay(double amount);
}

// 具体策略
public class CreditCardPayment implements PaymentStrategy {
    private String cardNumber;
    
    public CreditCardPayment(String cardNumber) {
        this.cardNumber = cardNumber;
    }
    
    @Override
    public void pay(double amount) {
        System.out.println("使用信用卡支付 $" + amount);
    }
}

public class PayPalPayment implements PaymentStrategy {
    private String email;
    
    public PayPalPayment(String email) {
        this.email = email;
    }
    
    @Override
    public void pay(double amount) {
        System.out.println("使用 PayPal 支付 $" + amount);
    }
}

// 上下文
public class ShoppingCart {
    private PaymentStrategy paymentStrategy;
    
    public void setPaymentStrategy(PaymentStrategy strategy) {
        this.paymentStrategy = strategy;
    }
    
    public void checkout(double amount) {
        paymentStrategy.pay(amount);
    }
}

// 使用
ShoppingCart cart = new ShoppingCart();
cart.setPaymentStrategy(new CreditCardPayment("1234-5678"));
cart.checkout(100.0);
```

## 示例代码演示

### 综合示例：订单处理系统

```java
// 使用多个设计模式
public class OrderProcessor {
    // 使用策略模式：不同的支付策略
    private PaymentStrategy paymentStrategy;
    
    // 使用观察者模式：订单状态变化通知
    private List<OrderObserver> observers = new ArrayList<>();
    
    public void processOrder(Order order) {
        // 验证订单（使用工厂模式创建验证器）
        OrderValidator validator = ValidatorFactory.createValidator(order.getType());
        if (!validator.validate(order)) {
            throw new IllegalArgumentException("订单验证失败");
        }
        
        // 处理支付
        paymentStrategy.pay(order.getAmount());
        
        // 通知观察者
        notifyObservers(order);
    }
    
    public void addObserver(OrderObserver observer) {
        observers.add(observer);
    }
    
    private void notifyObservers(Order order) {
        for (OrderObserver observer : observers) {
            observer.onOrderProcessed(order);
        }
    }
}
```

## 小结

常见设计模式要点：

- **创建型模式**：Singleton（单例）、Factory（工厂）
- **结构型模式**：Decorator（装饰器）、Adapter（适配器）
- **行为型模式**：Observer（观察者）、Strategy（策略）
- **应用场景**：根据需求选择合适的设计模式

**关键要点**：
- 单例模式确保唯一实例
- 工厂模式隐藏创建逻辑
- 装饰器模式动态添加功能
- 适配器模式兼容不同接口
- 观察者模式实现事件通知
- 策略模式实现算法互换

理解了设计模式，你就能设计更好的系统架构。在下一章，我们将学习 Java 性能优化。
