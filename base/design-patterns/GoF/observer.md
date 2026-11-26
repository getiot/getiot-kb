---
sidebar_position: 20
slug: /observer
sidebar_label: 观察者模式
---

# 设计模式 - 观察者模式

想象你关注了某个微信公众号，每当有新文章发布时，你就会收到通知。公众号不需要知道你是谁，只需要发通知；你也不需要主动去问公众号有没有更新，只要静静等着它“推送”就行了。

观察者模式（Observer Pattern）包含两个主要角色：

- **Subject（主题/被观察者）**：负责维护一组观察者，当状态改变时通知它们。
- **Observer（观察者）**：订阅主题，当主题状态变化时接收通知并更新自己。

你可以动态添加/移除观察者，非常灵活。

:::tip 核心思想 🌟

当一个对象的状态发生变化时，依赖它的所有对象都会自动收到通知并做出响应。

:::



## 模式结构（UML 类图）

```scss
           +-------------+
           |  Subject    |
           +-------------+
           | +attach()   |
           | +detach()   |
           | +notify()   |
           +-------------+
                  ▲
                  │
         +------------------+
         | ConcreteSubject  |
         +------------------+
                  ▲
                  │
        +-------------------+
        |     Observer      |
        +-------------------+
                  ▲
                  │
         +------------------+
         | ConcreteObserver |
         +------------------+
```



## 示例场景

你可以把它想象成一个天气系统：

- **WeatherStation（天气站）** 是被观察者，它负责发布温度变化。
- **PhoneDisplay、LEDDisplay 等显示设备** 是观察者，它们订阅天气站的变化。



### Java 实现

```java showLineNumbers
import java.util.*;

interface Observer {
    void update(float temperature);
}

class WeatherStation {
    private List<Observer> observers = new ArrayList<>();
    private float temperature;

    public void addObserver(Observer o) {
        observers.add(o);
    }

    public void removeObserver(Observer o) {
        observers.remove(o);
    }

    public void setTemperature(float temp) {
        this.temperature = temp;
        notifyObservers();
    }

    private void notifyObservers() {
        for (Observer o : observers) {
            o.update(temperature);
        }
    }
}

class PhoneDisplay implements Observer {
    public void update(float temperature) {
        System.out.println("手机显示：当前温度为 " + temperature + "°C");
    }
}

class LEDDisplay implements Observer {
    public void update(float temperature) {
        System.out.println("LED 显示屏：当前温度为 " + temperature + "°C");
    }
}

public class Main {
    public static void main(String[] args) {
        WeatherStation station = new WeatherStation();
        Observer phone = new PhoneDisplay();
        Observer led = new LEDDisplay();

        station.addObserver(phone);
        station.addObserver(led);

        station.setTemperature(25.0f);
        station.setTemperature(28.5f);
    }
}
```



### C++ 实现

```cpp showLineNumbers
#include <iostream>
#include <vector>
using namespace std;

class Observer {
public:
    virtual void update(float temperature) = 0;
};

class WeatherStation {
    vector<Observer*> observers;
    float temperature;

public:
    void addObserver(Observer* obs) {
        observers.push_back(obs);
    }

    void removeObserver(Observer* obs) {
        observers.erase(remove(observers.begin(), observers.end(), obs), observers.end());
    }

    void setTemperature(float temp) {
        temperature = temp;
        notifyObservers();
    }

    void notifyObservers() {
        for (auto obs : observers) {
            obs->update(temperature);
        }
    }
};

class PhoneDisplay : public Observer {
public:
    void update(float temperature) override {
        cout << "手机显示：当前温度为 " << temperature << "°C" << endl;
    }
};

class LEDDisplay : public Observer {
public:
    void update(float temperature) override {
        cout << "LED 显示屏：当前温度为 " << temperature << "°C" << endl;
    }
};

int main() {
    WeatherStation station;
    PhoneDisplay phone;
    LEDDisplay led;

    station.addObserver(&phone);
    station.addObserver(&led);

    station.setTemperature(25.0f);
    station.setTemperature(30.0f);
}
```



### Python 实现

```python showLineNumbers
class Observer:
    def update(self, temperature):
        raise NotImplementedError

class WeatherStation:
    def __init__(self):
        self.observers = []
        self.temperature = 0.0

    def add_observer(self, observer):
        self.observers.append(observer)

    def remove_observer(self, observer):
        self.observers.remove(observer)

    def set_temperature(self, temp):
        self.temperature = temp
        self.notify_observers()

    def notify_observers(self):
        for observer in self.observers:
            observer.update(self.temperature)

class PhoneDisplay(Observer):
    def update(self, temperature):
        print(f"手机显示：当前温度为 {temperature}°C")

class LEDDisplay(Observer):
    def update(self, temperature):
        print(f"LED 显示屏：当前温度为 {temperature}°C")

# 使用
station = WeatherStation()
phone = PhoneDisplay()
led = LEDDisplay()

station.add_observer(phone)
station.add_observer(led)

station.set_temperature(22.5)
station.set_temperature(27.0)
```



### TypeScript 实现

```typescript showLineNumbers
interface Observer {
  update(temperature: number): void;
}

class WeatherStation {
  private observers: Observer[] = [];
  private temperature: number = 0;

  addObserver(observer: Observer): void {
    this.observers.push(observer);
  }

  removeObserver(observer: Observer): void {
    this.observers = this.observers.filter(o => o !== observer);
  }

  setTemperature(temp: number): void {
    this.temperature = temp;
    this.notifyObservers();
  }

  private notifyObservers(): void {
    this.observers.forEach(o => o.update(this.temperature));
  }
}

class PhoneDisplay implements Observer {
  update(temperature: number): void {
    console.log(`手机显示：当前温度为 ${temperature}°C`);
  }
}

class LEDDisplay implements Observer {
  update(temperature: number): void {
    console.log(`LED 显示屏：当前温度为 ${temperature}°C`);
  }
}

// 使用
const station = new WeatherStation();
const phone = new PhoneDisplay();
const led = new LEDDisplay();

station.addObserver(phone);
station.addObserver(led);

station.setTemperature(24);
station.setTemperature(29);
```



## 小结

| 特性     | 内容                                                         |
| -------- | ------------------------------------------------------------ |
| 模式类型 | 行为型                                                       |
| 适用场景 | 一个对象状态变化，需要通知多个观察者时                       |
| 优点     | <ul><li>低耦合</li><li>观察者数量可动态增减</li><li>灵活拓展</li></ul> |
| 缺点     | <ul><li>如果观察者很多，通知成本高</li><li>有时顺序难以控制</li></ul> |

观察者模式让你可以构建一个“发布-订阅”系统，核心优势是**解耦** —— 主题不需要知道具体有哪些观察者，观察者也不依赖主题的内部实现。
