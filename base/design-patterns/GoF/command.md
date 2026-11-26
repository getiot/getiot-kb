---
sidebar_position: 16
slug: /command
sidebar_label: 命令模式
---

# 设计模式 - 命令模式

想象你在做一个智能家居系统，用户可以用手机控制灯泡、电风扇、电视等设备的开关操作。你也许会写这样的代码：

```java showLineNumbers
if (userClick.equals("light_on")) {
    light.turnOn();
} else if (userClick.equals("fan_off")) {
    fan.turnOff();
}
```

久而久之，你的控制逻辑越来越复杂、越来越难维护。

这时候，**命令模式**（Command Pattern）登场了！

:::tip 核心思想 🌟

把请求（例如“打开灯”）封装成一个命令对象，将请求的发出者（手机 App）和执行者（灯）解耦。

你只需要调用命令，而不需要关心命令是如何实现的、谁来执行的。

:::



## 模式结构（UML 类图）

```scss
        +------------------+        +------------------+
        |   Client         |        |  Command         |
        +------------------+        +------------------+
                |                          ▲
                |                          |
                v                          |
        +------------------+        +---------------------+
        |   Invoker        |------->| ConcreteCommand     |
        +------------------+        +---------------------+
                |                          |
                v                          |
        +------------------+               |
        | Receiver (设备)   |<--------------+
        +------------------+
```



## 示例场景：遥控器控制设备

你要构建一个遥控器，可以控制灯泡的开和关。使用命令模式，你可以：

- 把“开灯”命令封装成一个类
- 把“关灯”命令封装成另一个类
- 遥控器只需要执行命令，不关心命令怎么实现



### Java 实现

```java showLineNumbers
// 命令接口
interface Command {
    void execute();
}

// 接收者
class Light {
    void on() {
        System.out.println("灯打开了");
    }
    void off() {
        System.out.println("灯关闭了");
    }
}

// 具体命令
class LightOnCommand implements Command {
    private Light light;
    LightOnCommand(Light light) {
        this.light = light;
    }
    public void execute() {
        light.on();
    }
}

class LightOffCommand implements Command {
    private Light light;
    LightOffCommand(Light light) {
        this.light = light;
    }
    public void execute() {
        light.off();
    }
}

// 调用者
class RemoteControl {
    private Command command;
    void setCommand(Command command) {
        this.command = command;
    }
    void pressButton() {
        command.execute();
    }
}

// 使用示例
public class Main {
    public static void main(String[] args) {
        Light light = new Light();
        Command onCommand = new LightOnCommand(light);
        Command offCommand = new LightOffCommand(light);

        RemoteControl remote = new RemoteControl();
        remote.setCommand(onCommand);
        remote.pressButton();  // 打开灯

        remote.setCommand(offCommand);
        remote.pressButton();  // 关闭灯
    }
}
```



### C++ 实现

```cpp showLineNumbers
#include <iostream>
using namespace std;

class Light {
public:
    void on() {
        cout << "灯打开了" << endl;
    }
    void off() {
        cout << "灯关闭了" << endl;
    }
};

class Command {
public:
    virtual void execute() = 0;
};

class LightOnCommand : public Command {
private:
    Light* light;
public:
    LightOnCommand(Light* light) : light(light) {}
    void execute() override {
        light->on();
    }
};

class LightOffCommand : public Command {
private:
    Light* light;
public:
    LightOffCommand(Light* light) : light(light) {}
    void execute() override {
        light->off();
    }
};

class RemoteControl {
private:
    Command* command;
public:
    void setCommand(Command* command) {
        this->command = command;
    }
    void pressButton() {
        command->execute();
    }
};

int main() {
    Light light;
    LightOnCommand onCmd(&light);
    LightOffCommand offCmd(&light);

    RemoteControl remote;
    remote.setCommand(&onCmd);
    remote.pressButton();

    remote.setCommand(&offCmd);
    remote.pressButton();

    return 0;
}
```



### Python 实现

```python showLineNumbers
from abc import ABC, abstractmethod

# 接收者
class Light:
    def on(self):
        print("灯打开了")

    def off(self):
        print("灯关闭了")

# 命令接口
class Command(ABC):
    @abstractmethod
    def execute(self):
        pass

# 具体命令
class LightOnCommand(Command):
    def __init__(self, light: Light):
        self.light = light

    def execute(self):
        self.light.on()

class LightOffCommand(Command):
    def __init__(self, light: Light):
        self.light = light

    def execute(self):
        self.light.off()

# 调用者
class RemoteControl:
    def set_command(self, command: Command):
        self.command = command

    def press_button(self):
        self.command.execute()

# 使用
light = Light()
on_command = LightOnCommand(light)
off_command = LightOffCommand(light)

remote = RemoteControl()
remote.set_command(on_command)
remote.press_button()

remote.set_command(off_command)
remote.press_button()
```



### TypeScript 实现

```typescript showLineNumbers
interface Command {
  execute(): void;
}

class Light {
  on() {
    console.log("灯打开了");
  }

  off() {
    console.log("灯关闭了");
  }
}

class LightOnCommand implements Command {
  constructor(private light: Light) {}

  execute() {
    this.light.on();
  }
}

class LightOffCommand implements Command {
  constructor(private light: Light) {}

  execute() {
    this.light.off();
  }
}

class RemoteControl {
  private command: Command;

  setCommand(command: Command) {
    this.command = command;
  }

  pressButton() {
    this.command.execute();
  }
}

// 使用示例
const light = new Light();
const onCommand = new LightOnCommand(light);
const offCommand = new LightOffCommand(light);

const remote = new RemoteControl();
remote.setCommand(onCommand);
remote.pressButton();

remote.setCommand(offCommand);
remote.pressButton();
```



## 小结

| 特性     | 内容                                                         |
| -------- | ------------------------------------------------------------ |
| 模式类型 | 行为型                                                       |
| 适用场景 | <ul><li>将请求封装为对象</li><li>支持撤销、排队、日志记录等功能</li></ul> |
| 优点     | <ul><li>解耦调用者和执行者</li><li>命令可组合、可复用</li><li>容易扩展新命令</li></ul> |
| 缺点     | <ul><li>会增加类的数量</li></ul>                             |

命令模式的妙处在于它的灵活性：你可以对命令进行排队、组合、撤销…… 这是简单调用方法做不到的！

