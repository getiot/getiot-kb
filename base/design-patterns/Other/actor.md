---
sidebar_position: 4
slug: /actor
sidebar_label: Actor 模式
---

# Actor 模式：消息驱动的并发模型

Actor 模式是一种**消息驱动的并发模型**。它把系统中的每个并发实体都抽象为一个 **Actor**（演员），每个 Actor 是一个独立的计算单元，具有自己的状态和行为。

当你使用 Actor 模式编程时，你不需要直接管理线程或锁，而是将任务封装成消息，通过消息传递来进行协作。



## 💡 Actor 模式是什么？

你可以把 **Actor** 理解成一个“拥有邮箱的智能小人”，它们之间通过“写信”（消息）来交流：

- 每个 Actor：
  - 拥有自己的私有状态
  - 只能异步接收消息
  - 接收到消息后，可以：
    - 修改自己的状态
    - 发送消息给其他 Actor
    - 创建新的 Actor

由于没有使用共享内存！每个 Actor 拥有自己的封闭状态，因此**天然避免了数据竞争**。

你可以把 Actor 看作是“最小的服务单元”，它们内部的运行机制有点像微服务之间的交互，只是粒度更小、更轻量。



## 🧱 模式结构

```scss
+-----------+     +-----------+     +-----------+
|  Actor A  |<--->|  Actor B  |<--->|  Actor C  |
+-----------+     +-----------+     +-----------+
     ▲                                    │
     └─────────────消息通信────────────────┘

```

你可以把每个 Actor 看成一个迷你进程或协程，它们通过消息驱动来解耦复杂的并发逻辑。



## 🛠️ 使用场景

- 构建**高并发系统**（如：聊天服务器、在线游戏）
- 实现**分布式计算模型**
- 替代传统的线程锁模型，简化并发控制
- 常用于 Erlang、Akka（Scala/Java）、Orleans（.NET）等框架中



## 🟢 示例（以 Python 伪代码说明）

```python showLineNumbers
import queue
import threading

class Actor:
    def __init__(self):
        self.mailbox = queue.Queue()
        threading.Thread(target=self._run).start()

    def send(self, msg):
        self.mailbox.put(msg)

    def _run(self):
        while True:
            msg = self.mailbox.get()
            self.receive(msg)

    def receive(self, msg):
        print(f"处理消息: {msg}")

# 使用示例
actor = Actor()
actor.send("Hello")
actor.send("World")
```

这里的 `Actor` 类模拟了一个简单的消息循环模型。



## 🧩 优点

- ✅ 并发安全：无共享状态，不需要加锁
- ✅ 易于构建分布式系统
- ✅ 更自然的面向消息编程方式



## ⚠️ 注意事项

- Actor 系统的调试比同步系统更复杂
- 需要设计好消息格式和通信协议
- 高性能 Actor 系统通常依赖于高效调度器或框架支持



## 🧾 小结

Actor 模式是一种以“消息驱动”的方式组织并发逻辑的设计模式。它让你可以像组织演员一样组织系统中的计算单元，每个 Actor 互不干扰，独立处理任务。这种模式非常适合构建可伸缩、健壮的并发系统。
