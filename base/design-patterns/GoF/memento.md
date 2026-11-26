---
sidebar_position: 19
slug: /memento
sidebar_label: 备忘录模式
---

# 设计模式 - 备忘录模式

你有没有用过“撤销（Undo）”功能？比如在文本编辑器里回退到之前写的内容。这种行为其实就是**保存了一个历史快照**，当你想撤销时，就恢复到之前的状态。

备忘录模式（Memento Pattern）的核心角色：

1. **发起人（Originator）**：拥有需要保存状态的对象。
2. **备忘录（Memento）**：负责存储发起人内部状态的快照。
3. **负责人（Caretaker）**：负责保存和恢复备忘录，但不修改它的内容。

:::tip 核心思想 🌟

在不破坏封装的前提下，捕获一个对象的内部状态，并在以后需要时恢复这个状态。

:::



## 模式结构（UML 类图）

```scss
+------------------+
|   Originator     |
+------------------+
| - state          |
| + save()         |----+
| + restore(m)     |    |
+------------------+    |
                        |
                 +------v------+
                 |  Memento    |
                 +-------------+
                 | + getState()|
                 +-------------+
                        ▲
                        |
               +--------+--------+
               |   Caretaker     |
               +-----------------+
               | - mementos[]    |
               | + addMemento()  |
               | + getMemento()  |
               +-----------------+
```



## 示例场景

假设你正在做一个文本编辑器，当用户点击“保存”时，你要记住当前的内容；当用户点击“撤销”时，你就回退到保存时的状态。这时候就可以用备忘录模式。



### Java 实现

```java showLineNumbers
// 发起人
class Editor {
    private String text;

    public void type(String words) {
        this.text = words;
    }

    public Memento save() {
        return new Memento(text);
    }

    public void restore(Memento memento) {
        this.text = memento.getText();
    }

    public String getText() {
        return text;
    }

    // 备忘录
    static class Memento {
        private final String text;

        public Memento(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }
}

// 使用
public class Main {
    public static void main(String[] args) {
        Editor editor = new Editor();
        List<Editor.Memento> history = new ArrayList<>();

        editor.type("First version");
        history.add(editor.save());

        editor.type("Second version");
        history.add(editor.save());

        editor.restore(history.get(0));
        System.out.println(editor.getText()); // 输出：First version
    }
}
```



### C++ 实现

```cpp showLineNumbers
#include <iostream>
#include <vector>
using namespace std;

class Memento {
    string state;
public:
    Memento(string s) : state(s) {}
    string getState() const { return state; }
};

class Editor {
    string text;
public:
    void type(const string& s) { text = s; }
    Memento save() const { return Memento(text); }
    void restore(const Memento& m) { text = m.getState(); }
    string getText() const { return text; }
};

int main() {
    Editor editor;
    vector<Memento> history;

    editor.type("First version");
    history.push_back(editor.save());

    editor.type("Second version");
    history.push_back(editor.save());

    editor.restore(history[0]);
    cout << editor.getText() << endl; // 输出：First version
}
```



### Python 实现

```python showLineNumbers
class Memento:
    def __init__(self, text):
        self._text = text

    def get_text(self):
        return self._text

class Editor:
    def __init__(self):
        self._text = ""

    def type(self, words):
        self._text = words

    def save(self):
        return Memento(self._text)

    def restore(self, memento):
        self._text = memento.get_text()

    def get_text(self):
        return self._text

# 使用
editor = Editor()
history = []

editor.type("First version")
history.append(editor.save())

editor.type("Second version")
history.append(editor.save())

editor.restore(history[0])
print(editor.get_text())  # 输出：First version
```



### TypeScript 实现

```typescript showLineNumbers
class Memento {
  constructor(private text: string) {}

  getText(): string {
    return this.text;
  }
}

class Editor {
  private text: string = "";

  type(words: string) {
    this.text = words;
  }

  save(): Memento {
    return new Memento(this.text);
  }

  restore(memento: Memento) {
    this.text = memento.getText();
  }

  getText(): string {
    return this.text;
  }
}

// 使用
const editor = new Editor();
const history: Memento[] = [];

editor.type("First version");
history.push(editor.save());

editor.type("Second version");
history.push(editor.save());

editor.restore(history[0]);
console.log(editor.getText()); // 输出：First version
```



## 小结

| 特性     | 内容                                                         |
| -------- | ------------------------------------------------------------ |
| 模式类型 | 行为型                                                       |
| 适用场景 | 需要保存并在之后恢复对象的状态（如撤销、游戏存档等）         |
| 优点     | <ul><li>不破坏封装</li><li>易于实现撤销、回滚等功能</li></ul> |
| 缺点     | <ul><li>可能占用较多内存</li></ul>                           |

备忘录模式就像是为你的程序开了一个“时光机”。它适用于你需要保存历史状态的地方，比如：文本编辑器、绘图工具、表单填写等等。
