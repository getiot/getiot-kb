---
sidebar_position: 18
slug: /mediator
sidebar_label: 中介者模式
---

# 设计模式 - 中介者模式

当多个对象之间存在复杂的引用关系时，代码会变得非常混乱且难以维护。中介者模式（Mediator Pattern）的目标是：**通过一个中介对象封装一系列对象之间的交互，从而让这些对象不再互相引用，降低耦合度。**

你可以把它想象成生活中的“调度中心”或“群聊管理者”：大家不再直接联系，而是统一交给中介处理。

:::tip 核心思想 🌟

将原本对象之间网状的调用关系变成**中心化结构**。

降低各个对象的耦合，增强可维护性和扩展性。

:::



## 模式结构（UML 类图）

```scss
         +------------------+
         |    Mediator      |
         +------------------+
         | +send()          |
         +------------------+
                  ▲
                  |
         +------------------+
         | ConcreteMediator |
         +------------------+
         | -colleague1      |
         | -colleague2      |
         +------------------+
         | +send()          |
         +------------------+

+------------------+       +------------------+
|   Colleague      |<----->| ConcreteColleague|
+------------------+       +------------------+
| -mediator        |       | +send()          |
+------------------+       | +receive()       |
                           +------------------+
```



## 示例场景

假设你正在开发一个聊天室系统。每个用户都可以发送消息给其他用户。如果每个用户都直接与其他所有用户通信，那关系会变得很复杂。

使用中介者模式，我们可以设计一个 `ChatRoom` 中介者，所有用户通过它来发送和接收消息，这样用户类之间就没有直接依赖了。



### Java 实现

```java showLineNumbers
// 抽象中介者
interface ChatRoom {
    void sendMessage(String message, User user);
}

// 具体中介者
class ChatRoomImpl implements ChatRoom {
    @Override
    public void sendMessage(String message, User user) {
        System.out.println(user.getName() + " says: " + message);
    }
}

// 同事类
class User {
    private String name;
    private ChatRoom chatRoom;

    public User(String name, ChatRoom chatRoom) {
        this.name = name;
        this.chatRoom = chatRoom;
    }

    public String getName() {
        return name;
    }

    public void send(String message) {
        chatRoom.sendMessage(message, this);
    }
}

// 使用
public class Main {
    public static void main(String[] args) {
        ChatRoom room = new ChatRoomImpl();

        User alice = new User("Alice", room);
        User bob = new User("Bob", room);

        alice.send("Hello Bob!");
        bob.send("Hi Alice!");
    }
}
```



### C++ 实现

```cpp showLineNumbers
#include <iostream>
#include <string>
using namespace std;

// 抽象中介者
class ChatRoom {
public:
    virtual void sendMessage(const string& message, const string& user) = 0;
};

// 具体中介者
class ChatRoomImpl : public ChatRoom {
public:
    void sendMessage(const string& message, const string& user) override {
        cout << user << " says: " << message << endl;
    }
};

// 同事类
class User {
    string name;
    ChatRoom* chatRoom;
public:
    User(string name, ChatRoom* chatRoom) : name(name), chatRoom(chatRoom) {}

    void send(const string& message) {
        chatRoom->sendMessage(message, name);
    }
};

int main() {
    ChatRoomImpl room;
    User alice("Alice", &room);
    User bob("Bob", &room);

    alice.send("Hello Bob!");
    bob.send("Hi Alice!");
    return 0;
}
```



### Python 实现

```python showLineNumbers
class ChatRoom:
    def send_message(self, message, user):
        print(f"{user.name} says: {message}")

class User:
    def __init__(self, name, chatroom):
        self.name = name
        self.chatroom = chatroom

    def send(self, message):
        self.chatroom.send_message(message, self)

# 使用
room = ChatRoom()
alice = User("Alice", room)
bob = User("Bob", room)

alice.send("Hello Bob!")
bob.send("Hi Alice!")
```



### TypeScript 实现

```typescript showLineNumbers
class ChatRoom {
  sendMessage(message: string, user: User) {
    console.log(`${user.name} says: ${message}`);
  }
}

class User {
  constructor(public name: string, private chatRoom: ChatRoom) {}

  send(message: string) {
    this.chatRoom.sendMessage(message, this);
  }
}

// 使用
const room = new ChatRoom();
const alice = new User("Alice", room);
const bob = new User("Bob", room);

alice.send("Hello Bob!");
bob.send("Hi Alice!");
```



## 小结

| 特性     | 内容                                                   |
| -------- | ------------------------------------------------------ |
| 模式类型 | 行为型                                                 |
| 适用场景 | 多对象之间需要进行复杂交互，但你又想减少对象之间的耦合 |
| 优点     | <ul><li>降低对象之间的耦合</li><li>集中控制</li></ul>  |
| 缺点     | <ul><li>中介者可能会变得非常复杂</li></ul>             |

中介者模式的核心价值在于**解耦**。它让各个“同事类”不再互相依赖，而是通过“中介”来协调工作，非常适合用于**GUI 界面控件交互**、**事件系统**、**聊天系统**等场景。
