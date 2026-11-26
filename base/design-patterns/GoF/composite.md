---
sidebar_position: 9
slug: /composite
sidebar_label: 组合模式
---

# 设计模式 - 组合模式

假设你正在写一个图形界面库，里面有很多控件，比如按钮、文本框、容器面板……有些控件是“叶子节点”（比如按钮），有些控件是“容器”，里面还可以装别的控件。这就像树状结构——容器中可以包含控件，也可以再包含容器，而你希望用统一的方式来操作它们。

:::tip 核心思想 🌟

组合模式（Composite Pattern）允许你将对象组合成树形结构来表示“部分-整体”的层次结构，使客户端可以用一致的方式对待单个对象和组合对象。

:::



## 模式结构（UML 类图）

```scss
        Component（抽象组件）
         ▲           ▲
     Leaf（叶子）  Composite（容器）
                          ▲
               （可包含多个子 Component）
```

类图说明：

- **Component**：抽象类或接口，定义统一的操作。
- **Leaf**：叶子节点，表示最基本的对象。
- **Composite**：组合节点，可以包含多个 Component。



## 示例场景

你要构建一个图形界面层级结构：

- 一个窗口（Window）可以包含面板（Panel）；
- 面板里可以有按钮（Button）和文本框（TextBox）；
- 所有组件都有一个统一的方法 `render()`。

我们就可以用组合模式来设计这套结构。



### Java 实现

```java showLineNumbers
import java.util.ArrayList;
import java.util.List;

// 抽象组件
interface UIComponent {
    void render();
}

// 叶子组件
class Button implements UIComponent {
    public void render() {
        System.out.println("渲染按钮");
    }
}

class TextBox implements UIComponent {
    public void render() {
        System.out.println("渲染文本框");
    }
}

// 组合组件
class Panel implements UIComponent {
    private List<UIComponent> children = new ArrayList<>();

    public void add(UIComponent component) {
        children.add(component);
    }

    public void render() {
        System.out.println("渲染面板");
        for (UIComponent child : children) {
            child.render();
        }
    }
}

// 使用
public class Main {
    public static void main(String[] args) {
        Panel panel = new Panel();
        panel.add(new Button());
        panel.add(new TextBox());

        Panel root = new Panel();
        root.add(panel);
        root.add(new Button());

        root.render();
    }
}
```



### C++ 实现

```cpp showLineNumbers
#include <iostream>
#include <vector>
#include <memory>
using namespace std;

// 抽象组件
class UIComponent {
public:
    virtual void render() = 0;
    virtual ~UIComponent() {}
};

// 叶子组件
class Button : public UIComponent {
public:
    void render() override {
        cout << "渲染按钮" << endl;
    }
};

class TextBox : public UIComponent {
public:
    void render() override {
        cout << "渲染文本框" << endl;
    }
};

// 组合组件
class Panel : public UIComponent {
private:
    vector<shared_ptr<UIComponent>> children;

public:
    void add(shared_ptr<UIComponent> component) {
        children.push_back(component);
    }

    void render() override {
        cout << "渲染面板" << endl;
        for (auto& child : children) {
            child->render();
        }
    }
};

// 使用
int main() {
    auto panel = make_shared<Panel>();
    panel->add(make_shared<Button>());
    panel->add(make_shared<TextBox>());

    auto root = make_shared<Panel>();
    root->add(panel);
    root->add(make_shared<Button>());

    root->render();
    return 0;
}
```



### Python 实现

```python showLineNumbers
from abc import ABC, abstractmethod

# 抽象组件
class UIComponent(ABC):
    @abstractmethod
    def render(self):
        pass

# 叶子组件
class Button(UIComponent):
    def render(self):
        print("渲染按钮")

class TextBox(UIComponent):
    def render(self):
        print("渲染文本框")

# 组合组件
class Panel(UIComponent):
    def __init__(self):
        self.children = []

    def add(self, component: UIComponent):
        self.children.append(component)

    def render(self):
        print("渲染面板")
        for child in self.children:
            child.render()

# 使用
panel = Panel()
panel.add(Button())
panel.add(TextBox())

root = Panel()
root.add(panel)
root.add(Button())

root.render()
```



### TypeScript 实现

```typescript showLineNumbers
// 抽象组件
interface UIComponent {
  render(): void;
}

// 叶子组件
class Button implements UIComponent {
  render(): void {
    console.log("渲染按钮");
  }
}

class TextBox implements UIComponent {
  render(): void {
    console.log("渲染文本框");
  }
}

// 组合组件
class Panel implements UIComponent {
  private children: UIComponent[] = [];

  add(component: UIComponent): void {
    this.children.push(component);
  }

  render(): void {
    console.log("渲染面板");
    for (const child of this.children) {
      child.render();
    }
  }
}

// 使用
const panel = new Panel();
panel.add(new Button());
panel.add(new TextBox());

const root = new Panel();
root.add(panel);
root.add(new Button());

root.render();
```



## 小结

| 特性     | 内容                                                         |
| -------- | ------------------------------------------------------------ |
| 模式类型 | 结构型                                                       |
| 适用场景 | 树状结构，如界面组件、文件系统、组织结构等                   |
| 优点     | <ul><li>统一处理单个对象和组合对象</li><li>简化客户端逻辑</li><li>结构灵活，可嵌套</li></ul> |
| 缺点     | <ul><li>增加系统设计复杂度</li><li>对子类控制粒度较弱</li></ul> |

组合模式适合处理**具有递归结构的对象模型**。如果你在建模时发现有“整体与部分”的关系，并且希望客户端统一操作这些元素，组合模式是你的不二选择。
