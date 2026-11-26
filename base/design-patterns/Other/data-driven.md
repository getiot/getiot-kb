---
sidebar_position: 5
slug: /data-driven
sidebar_label: 数据驱动模式
---

# 数据驱动模式

**数据驱动模式**（Data-Driven Design Pattern）是一种非常实用、易于扩展的设计思想，在现代软件开发中应用非常广泛，尤其适用于游戏开发、业务规则系统、UI 构建、工作流引擎等场景。



## 什么是数据驱动模式？

**数据驱动模式**是一种将程序的**行为或配置**从代码中剥离出来，**用数据来控制程序逻辑**的设计方式。也就是说，程序本身的逻辑结构相对固定，而执行细节通过外部数据进行“注入”或“控制”。

通俗地说，就是：“**程序少写点，数据多干活**”。

:::tip 核心思想 🌟

把逻辑从硬编码中抽离出来，改为通过数据（配置、规则、模型等）来驱动行为。

:::

数据驱动模型具有以下特点：

- 把 **控制流程、业务逻辑、状态机、行为规则等** 设计为可配置的数据。
- 程序框架本身只负责 **读取数据并执行相应操作**。
- 更易于扩展、修改和调试。



## 示例：菜单命令系统

下面我们来设计一个数据驱动的“菜单命令系统”。这个系统模拟了当你运行一个应用时，点击菜单项触发相应功能的行为。我们将把菜单项和对应的处理逻辑都放到数据里，而不是硬编码写在程序中。

我们希望支持这样的功能：

- 菜单项通过数据描述；
- 每个菜单项绑定一个命令名称；
- 用户输入命令时自动执行绑定函数；
- 新增菜单项时不需要改程序，只需添加数据。

### 菜单数据（JSON 格式）

```json showLineNumbers
[
  { "label": "Say Hello", "command": "hello" },
  { "label": "Show Version", "command": "version" },
  { "label": "Exit", "command": "exit" }
]
```

### Python 实现

```python showLineNumbers
import json

# 菜单配置
menu_config = '''
[
  { "label": "Say Hello", "command": "hello" },
  { "label": "Show Version", "command": "version" },
  { "label": "Exit", "command": "exit" }
]
'''

# 命令映射表
def say_hello():
    print("Hello, World!")

def show_version():
    print("App version: 1.0.0")

def exit_app():
    print("Exiting...")
    exit(0)

command_table = {
    "hello": say_hello,
    "version": show_version,
    "exit": exit_app
}

# 主逻辑
menu = json.loads(menu_config)

while True:
    print("\n=== Menu ===")
    for i, item in enumerate(menu, 1):
        print(f"{i}. {item['label']}")

    choice = input("Select an option (number): ").strip()
    if not choice.isdigit():
        continue

    idx = int(choice) - 1
    if 0 <= idx < len(menu):
        cmd = menu[idx]["command"]
        handler = command_table.get(cmd)
        if handler:
            handler()
        else:
            print(f"Unknown command: {cmd}")
```



### C 语言实现（简化版）

注意：由于 C 没有内置 JSON 支持，我们使用结构体数组表示数据，函数指针模拟“绑定命令”。

```c showLineNumbers
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// 命令函数定义
void say_hello() {
    printf("Hello, World!\n");
}

void show_version() {
    printf("App version: 1.0.0\n");
}

void exit_app() {
    printf("Exiting...\n");
    exit(0);
}

// 菜单结构
typedef struct {
    const char *label;
    const char *command;
    void (*handler)();
} MenuItem;

// 菜单数据
MenuItem menu[] = {
    { "Say Hello",    "hello",   say_hello },
    { "Show Version", "version", show_version },
    { "Exit",         "exit",    exit_app }
};

int main() {
    int choice;
    int menu_size = sizeof(menu) / sizeof(MenuItem);

    while (1) {
        printf("\n=== Menu ===\n");
        for (int i = 0; i < menu_size; ++i) {
            printf("%d. %s\n", i + 1, menu[i].label);
        }

        printf("Select an option (number): ");
        if (scanf("%d", &choice) != 1) {
            while (getchar() != '\n'); // 清除缓冲区
            continue;
        }

        if (choice >= 1 && choice <= menu_size) {
            menu[choice - 1].handler();
        } else {
            printf("Invalid choice.\n");
        }
    }

    return 0;
}
```



## 数据驱动的优点

|    优点    | 说明                                        |
| :--------: | ------------------------------------------- |
|  灵活性高  | 只需改数据即可改变程序行为                  |
|  易于扩展  | 新增规则/场景时无需修改已有代码             |
|  易于测试  | 可以用不同数据配置进行组合测试              |
|  解耦逻辑  | 框架逻辑与具体业务完全分离                  |
| 可视化友好 | 数据可存储为 JSON/YAML 并用于构建 UI 编辑器 |



## 常见应用场景

- 游戏逻辑（技能、任务、AI）
- 表单 / 报表 / 仪表板系统
- 配置式业务流程引擎
- 构建 UI 编辑器（如可视化 Web IDE）
- 插件系统（通过注册数据启用不同模块）
- 国际化文本管理
- 低代码 / 无代码平台核心逻辑



## 小结

数据驱动模式是将业务行为、逻辑流程或结构配置抽象为可编辑的数据，从而使系统更易于维护、配置和扩展。你可以借助 JSON、YAML、数据库或其他数据结构定义规则，程序只是负责“读取并执行”，极大地提升了系统的灵活性。

它不属于 GoF 的 23 种设计模式，但在现代软件工程中是一种非常强大的架构风格，尤其适用于变化频繁、可配置性强的系统。
