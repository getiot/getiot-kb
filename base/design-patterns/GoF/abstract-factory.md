---
sidebar_position: 4
slug: /abstract-factory
sidebar_label: 抽象工厂模式
---

# 设计模式 - 抽象工厂模式

如果你正在开发一个系统，它有**多个系列的产品**（比如不同品牌的按钮和输入框），而且你希望系统能轻松地切换不同产品系列时不影响现有代码，那么你可以考虑使用 **抽象工厂模式**（Abstract Factory Pattern）。

:::tip 核心思想 🌟

抽象工厂模式提供一个创建一系列相关对象的接口，而不需要指定它们的具体类。

:::

你可以把它看作“工厂的工厂”：

> 一个抽象工厂，负责创建一组产品（例如按钮、输入框），每个具体工厂生产一整套产品。

**举个例子**

假设你正在开发一个跨平台界面库，需要支持 macOS 风格 和 Windows 风格的控件。

- 抽象产品族：Button、TextField
- 产品家族 A（macOS）：MacButton、MacTextField
- 产品家族 B（Windows）：WinButton、WinTextField
- 抽象工厂：GUIFactory
- 具体工厂：MacFactory、WinFactory

你可以通过切换工厂，批量生成不同风格的控件。



## 模式结构（UML 类图）

```scss
           GUIFactory（抽象工厂）
             /         \
  MacFactory            WinFactory
     |                       |
MacButton + MacTextField  WinButton + WinTextField
     ^           ^           ^             ^
   Button     TextField   Button       TextField
```



## Java 实现

```java showLineNumbers
// 抽象产品
interface Button {
    void click();
}

interface TextField {
    void input(String text);
}

// macOS 产品族
class MacButton implements Button {
    public void click() {
        System.out.println("Clicked macOS button");
    }
}

class MacTextField implements TextField {
    public void input(String text) {
        System.out.println("Input on macOS text field: " + text);
    }
}

// Windows 产品族
class WinButton implements Button {
    public void click() {
        System.out.println("Clicked Windows button");
    }
}

class WinTextField implements TextField {
    public void input(String text) {
        System.out.println("Input on Windows text field: " + text);
    }
}

// 抽象工厂
interface GUIFactory {
    Button createButton();
    TextField createTextField();
}

// 具体工厂
class MacFactory implements GUIFactory {
    public Button createButton() {
        return new MacButton();
    }
    public TextField createTextField() {
        return new MacTextField();
    }
}

class WinFactory implements GUIFactory {
    public Button createButton() {
        return new WinButton();
    }
    public TextField createTextField() {
        return new WinTextField();
    }
}

// 使用
public class Main {
    public static void main(String[] args) {
        GUIFactory factory = new MacFactory();
        Button button = factory.createButton();
        TextField textField = factory.createTextField();

        button.click();               // 输出：Clicked macOS button
        textField.input("Hello!");    // 输出：Input on macOS text field: Hello!
    }
}
```



## C++ 实现

```cpp showLineNumbers
#include <iostream>
using namespace std;

// 抽象产品
class Button {
public:
    virtual void click() = 0;
    virtual ~Button() {}
};

class TextField {
public:
    virtual void input(const string& text) = 0;
    virtual ~TextField() {}
};

// macOS 产品
class MacButton : public Button {
public:
    void click() override {
        cout << "Clicked macOS button" << endl;
    }
};

class MacTextField : public TextField {
public:
    void input(const string& text) override {
        cout << "Input on macOS text field: " << text << endl;
    }
};

// Windows 产品
class WinButton : public Button {
public:
    void click() override {
        cout << "Clicked Windows button" << endl;
    }
};

class WinTextField : public TextField {
public:
    void input(const string& text) override {
        cout << "Input on Windows text field: " << text << endl;
    }
};

// 抽象工厂
class GUIFactory {
public:
    virtual Button* createButton() = 0;
    virtual TextField* createTextField() = 0;
    virtual ~GUIFactory() {}
};

// 具体工厂
class MacFactory : public GUIFactory {
public:
    Button* createButton() override {
        return new MacButton();
    }
    TextField* createTextField() override {
        return new MacTextField();
    }
};

class WinFactory : public GUIFactory {
public:
    Button* createButton() override {
        return new WinButton();
    }
    TextField* createTextField() override {
        return new WinTextField();
    }
};

// 使用
int main() {
    GUIFactory* factory = new WinFactory();
    Button* button = factory->createButton();
    TextField* textField = factory->createTextField();

    button->click();
    textField->input("Hello");

    delete button;
    delete textField;
    delete factory;

    return 0;
}
```



## Python 实现

```python showLineNumbers
# 抽象产品
class Button:
    def click(self):
        raise NotImplementedError

class TextField:
    def input(self, text):
        raise NotImplementedError

# macOS 产品
class MacButton(Button):
    def click(self):
        print("Clicked macOS button")

class MacTextField(TextField):
    def input(self, text):
        print(f"Input on macOS text field: {text}")

# Windows 产品
class WinButton(Button):
    def click(self):
        print("Clicked Windows button")

class WinTextField(TextField):
    def input(self, text):
        print(f"Input on Windows text field: {text}")

# 抽象工厂
class GUIFactory:
    def create_button(self):
        raise NotImplementedError
    def create_text_field(self):
        raise NotImplementedError

# 具体工厂
class MacFactory(GUIFactory):
    def create_button(self):
        return MacButton()
    def create_text_field(self):
        return MacTextField()

class WinFactory(GUIFactory):
    def create_button(self):
        return WinButton()
    def create_text_field(self):
        return WinTextField()

# 使用
factory = MacFactory()
button = factory.create_button()
text_field = factory.create_text_field()

button.click()
text_field.input("Hello!")
```



## TypeScript 实现

```typescript showLineNumbers
// 抽象产品
interface Button {
  click(): void;
}

interface TextField {
  input(text: string): void;
}

// macOS 产品
class MacButton implements Button {
  click(): void {
    console.log("Clicked macOS button");
  }
}

class MacTextField implements TextField {
  input(text: string): void {
    console.log(`Input on macOS text field: ${text}`);
  }
}

// Windows 产品
class WinButton implements Button {
  click(): void {
    console.log("Clicked Windows button");
  }
}

class WinTextField implements TextField {
  input(text: string): void {
    console.log(`Input on Windows text field: ${text}`);
  }
}

// 抽象工厂
interface GUIFactory {
  createButton(): Button;
  createTextField(): TextField;
}

// 具体工厂
class MacFactory implements GUIFactory {
  createButton(): Button {
    return new MacButton();
  }
  createTextField(): TextField {
    return new MacTextField();
  }
}

class WinFactory implements GUIFactory {
  createButton(): Button {
    return new WinButton();
  }
  createTextField(): TextField {
    return new WinTextField();
  }
}

// 使用
const factory: GUIFactory = new WinFactory();
const button = factory.createButton();
const textField = factory.createTextField();

button.click();                    // 输出：Clicked Windows button
textField.input("Hi there!");      // 输出：Input on Windows text field: Hi there!
```



## 小结

| 特性     | 内容                                                         |
| -------- | ------------------------------------------------------------ |
| 模式类型 | 创建型                                                       |
| 适用场景 | 需要创建多个“相关”对象时（如 UI 组件家族）                   |
| 优点     | - 符合开放-封闭原则<br/>- 更好地管理产品族                   |
| 缺点     | 不适合经常扩展产品“种类”（比如加一个新控件） 因为需要改所有工厂 |

抽象工厂模式非常适合**产品组之间的一致性管理**，你可以轻松切换“风格主题”或“品牌实现”。
