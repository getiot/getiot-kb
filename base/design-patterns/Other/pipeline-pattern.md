---
sidebar_position: 1
slug: /pipeline-pattern
sidebar_label: 管道模式
---

# 设计模式 - 管道模式

**管道模式**（Pipeline Pattern）并不在 GoF 的 23 种经典设计模式中，但它已经被广泛应用于诸如中间件框架、数据处理、编译器设计等领域。

管道模式可认为是一种结构型设计模式，主要目的是将**处理任务拆分为一系列的独立步骤**，并通过“管道”方式顺序连接起来。你可以把它理解为一条流水线（pipeline），每个工位（处理步骤）只负责一小部分任务，数据从一头进来，经过每一个“处理器”，最终输出处理结果。

这种方式的优势在于 **解耦、可组合、易维护**，就像工厂的流水线，每个工人只做自己的一部分工作，合作完成整个产品的组装。

例如：

> 字符串数据 → 去除空格 → 转换成大写 → 添加前缀 → 输出

:::tip 核心思想 🌟

将一个复杂的处理过程分解为多个独立的、可重用的处理单元（处理器/步骤），并按顺序将它们组织成一条“流水线”，使数据逐步在每个处理单元中被处理，最终输出结果。

:::

管道模式通常包括以下角色：

- **Pipe**（管道）：组织并管理处理步骤
- **Handler/Stage**（处理阶段）：每一步负责处理输入数据
- **Input/Output**：输入和输出数据流

通常每个 Handler 接收一个输入，返回一个输出，供下一个处理器使用。



## 模式结构（UML 类图）

```scss
+--------------+      +--------------+      +--------------+
| Input Source | ---> | Handler One  | ---> | Handler Two  | ---> ... ---> Output
+--------------+      +--------------+      +--------------+
```

核心要素：

- `Pipeline`：管道整体，负责组织和串联多个处理器
- `Handler`：具体处理逻辑的单元，负责接收输入并输出处理结果



## 示例：字符串处理流水线

假设我们要处理一个字符串，处理流程如下：

1. 去除首尾空格
2. 转换为大写
3. 添加前缀 "Hello: "

### Java 实现

```java showLineNumbers
interface Handler {
    String process(String input);
}

class TrimHandler implements Handler {
    public String process(String input) {
        return input.trim();
    }
}

class UpperCaseHandler implements Handler {
    public String process(String input) {
        return input.toUpperCase();
    }
}

class PrefixHandler implements Handler {
    public String process(String input) {
        return "Hello: " + input;
    }
}

class Pipeline {
    private List<Handler> handlers = new ArrayList<>();

    public void addHandler(Handler h) {
        handlers.add(h);
    }

    public String execute(String input) {
        String result = input;
        for (Handler h : handlers) {
            result = h.process(result);
        }
        return result;
    }
}

// 使用
public class Main {
    public static void main(String[] args) {
        Pipeline pipeline = new Pipeline();
        pipeline.addHandler(new TrimHandler());
        pipeline.addHandler(new UpperCaseHandler());
        pipeline.addHandler(new PrefixHandler());

        String result = pipeline.execute("  world  ");
        System.out.println(result); // 输出: Hello: WORLD
    }
}
```



### C++ 实现

```cpp showLineNumbers
#include <iostream>
#include <vector>
#include <functional>
#include <algorithm>
#include <cctype>
using namespace std;

class Pipeline {
    vector<function<string(string)>> handlers;

public:
    void addHandler(function<string(string)> handler) {
        handlers.push_back(handler);
    }

    string execute(const string& input) {
        string result = input;
        for (auto& h : handlers) {
            result = h(result);
        }
        return result;
    }
};

// 使用
int main() {
    Pipeline pipeline;

    pipeline.addHandler([](string s) {
        // Trim
        size_t start = s.find_first_not_of(" \t");
        size_t end = s.find_last_not_of(" \t");
        return s.substr(start, end - start + 1);
    });

    pipeline.addHandler([](string s) {
        transform(s.begin(), s.end(), s.begin(), ::toupper);
        return s;
    });

    pipeline.addHandler([](string s) {
        return "Hello: " + s;
    });

    cout << pipeline.execute("  world  ") << endl; // Hello: WORLD
}
```



### Python 实现

```python showLineNumbers
class Pipeline:
    def __init__(self):
        self.handlers = []

    def add_handler(self, func):
        self.handlers.append(func)

    def execute(self, input_str):
        result = input_str
        for handler in self.handlers:
            result = handler(result)
        return result

# 使用
pipeline = Pipeline()
pipeline.add_handler(lambda s: s.strip())
pipeline.add_handler(lambda s: s.upper())
pipeline.add_handler(lambda s: "Hello: " + s)

print(pipeline.execute("  world  "))  # Hello: WORLD
```



### TypeScript 实现

```typescript showLineNumbers
type Handler = (input: string) => string;

class Pipeline {
  private handlers: Handler[] = [];

  addHandler(handler: Handler): void {
    this.handlers.push(handler);
  }

  execute(input: string): string {
    return this.handlers.reduce((acc, handler) => handler(acc), input);
  }
}

// 使用
const pipeline = new Pipeline();
pipeline.addHandler(str => str.trim());
pipeline.addHandler(str => str.toUpperCase());
pipeline.addHandler(str => "Hello: " + str);

console.log(pipeline.execute("  world  ")); // Hello: WORLD
```



## 应用场景

你可以在以下场景中使用管道模式：

- 中间件链路（如 Web 请求处理）
- 编译器的词法、语法、语义分析阶段
- 文本处理或数据转换流程
- 构建工具（如 Gulp、Webpack 的 loader）
- 图像处理、音频处理



## 小结

| 特性     | 内容                                                         |
| -------- | ------------------------------------------------------------ |
| 模式类型 | 行为型 / 结构型（视语义而定）                                |
| 适合场景 | 数据/请求处理流程分段执行                                    |
| 优点     | <ul><li>解耦各处理步骤</li><li>易于拓展与组合</li><li>流程结构清晰</li></ul> |
| 缺点     | <ul><li>增加调试难度</li><li>中间状态传递可能增加开销</li></ul> |

如果你正在构建具有多个可组合步骤的处理流程，比如文本过滤器、数据转换器、日志处理器，管道模式会是一个非常强大且优雅的解决方案。

