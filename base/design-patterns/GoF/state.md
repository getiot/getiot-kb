---
sidebar_position: 21
slug: /state
sidebar_label: 状态模式
---

# 设计模式 - 状态模式

假设你正在设计一个电梯控制系统。电梯在不同的状态下（如停止、运行、开门、关门）其行为也不相同，比如运行状态不能开门，开门状态不能运行等。**你是否希望在这些状态下封装不同的行为，而不是写一堆 if-else？**

这就是**状态模式**（State Pattern）能帮你解决的问题！

:::tip 核心思想 🌟

将对象的状态封装成独立的类，当对象内部状态改变时，行为也随之改变。

:::

你不再使用繁杂的条件语句判断状态，而是通过切换状态对象本身，自动改变行为。



## 模式结构（UML 类图）

```scss
       +-------------+
       |   Context   |
       +-------------+
       | state       |
       | setState()  |
       | request()   |
       +-------------+
              │
              ▼
       +-------------+         +----------------+
       |  State      |<--------| ConcreteStateA |
       +-------------+         +----------------+
       | handle()    |         | handle()       |
       +-------------+         +----------------+
                               
                                +----------------+
                                | ConcreteStateB |
                                +----------------+
                                | handle()       |
                                +----------------+
```



## 示例场景：电灯开关

我们以一个简单的电灯为例：

- 电灯有两个状态：开（On）和关（Off）
- 每次按下开关，状态在“开”与“关”之间切换



### Java 实现

```java showLineNumbers
interface State {
    void toggle(LightContext context);
}

class OnState implements State {
    public void toggle(LightContext context) {
        System.out.println("电灯关闭！");
        context.setState(new OffState());
    }
}

class OffState implements State {
    public void toggle(LightContext context) {
        System.out.println("电灯打开！");
        context.setState(new OnState());
    }
}

class LightContext {
    private State state;

    public LightContext() {
        this.state = new OffState(); // 初始为关闭
    }

    public void setState(State state) {
        this.state = state;
    }

    public void pressSwitch() {
        state.toggle(this);
    }
}

public class Main {
    public static void main(String[] args) {
        LightContext light = new LightContext();
        light.pressSwitch(); // 打开
        light.pressSwitch(); // 关闭
    }
}
```



### C++ 实现

```cpp showLineNumbers
#include <iostream>
using namespace std;

class LightContext;

class State {
public:
    virtual void toggle(LightContext* context) = 0;
};

class OnState;
class OffState;

class LightContext {
    State* state;

public:
    LightContext(State* initState) : state(initState) {}

    void setState(State* newState) {
        state = newState;
    }

    void pressSwitch() {
        state->toggle(this);
    }
};

class OnState : public State {
public:
    void toggle(LightContext* context) override;
};

class OffState : public State {
public:
    void toggle(LightContext* context) override;
};

void OnState::toggle(LightContext* context) {
    cout << "电灯关闭！" << endl;
    context->setState(new OffState());
}

void OffState::toggle(LightContext* context) {
    cout << "电灯打开！" << endl;
    context->setState(new OnState());
}

int main() {
    LightContext light(new OffState());
    light.pressSwitch(); // 打开
    light.pressSwitch(); // 关闭
}
```



### Python 实现

```python showLineNumbers
class State:
    def toggle(self, context):
        pass

class OnState(State):
    def toggle(self, context):
        print("电灯关闭！")
        context.set_state(OffState())

class OffState(State):
    def toggle(self, context):
        print("电灯打开！")
        context.set_state(OnState())

class LightContext:
    def __init__(self):
        self.state = OffState()

    def set_state(self, state):
        self.state = state

    def press_switch(self):
        self.state.toggle(self)

# 使用
light = LightContext()
light.press_switch()  # 打开
light.press_switch()  # 关闭
```



### TypeScript 实现

```typescript showLineNumbers
interface State {
  toggle(context: LightContext): void;
}

class OnState implements State {
  toggle(context: LightContext): void {
    console.log("电灯关闭！");
    context.setState(new OffState());
  }
}

class OffState implements State {
  toggle(context: LightContext): void {
    console.log("电灯打开！");
    context.setState(new OnState());
  }
}

class LightContext {
  private state: State;

  constructor() {
    this.state = new OffState();
  }

  setState(state: State): void {
    this.state = state;
  }

  pressSwitch(): void {
    this.state.toggle(this);
  }
}

// 使用
const light = new LightContext();
light.pressSwitch(); // 打开
light.pressSwitch(); // 关闭
```



## 小结

| 特性     | 内容                                                         |
| -------- | ------------------------------------------------------------ |
| 模式类型 | 行为型                                                       |
| 适用场景 | 对象在运行时需要根据“状态”改变行为，如游戏角色、工作流、UI 控件等 |
| 优点     | <ul><li>将状态相关的行为封装到独立的类中</li><li>避免大量的 if/else 分支</li><li>更易于拓展新状态</li></ul> |
| 缺点     | <ul><li>状态类会增多</li><li>切换状态需要额外维护状态引用</li></ul> |

状态模式可以帮你优雅地管理状态转换逻辑，特别适合那种状态行为变化频繁的系统。如果你发现某段代码里有很多 `if (state == A)` 的判断，也许就是引入这个模式的好时机！
