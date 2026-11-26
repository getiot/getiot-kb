---
sidebar_position: 12
slug: /flyweight
sidebar_label: 享元模式
---

# 设计模式 - 享元模式

如果你在开发一个文字处理器，每次显示一个字母都要创建一个新对象，当文档中有成千上万个字母时，内存会爆炸。

**有没有一种办法可以让这些重复内容共用内存？**

享元模式（Flyweight Pattern）就是为了解决这个问题：**它通过共享技术来有效支持大量细粒度对象的复用，节省内存开销。**



:::tip 核心思想 🌟

享元模式把对象的状态分为两类：

- **内部状态（可共享）**：不会随环境改变，可被多个对象共享（如字符的形状）。
- **外部状态（不可共享）**：依赖环境，不可共享（如字符的位置、颜色）。

通过共享内部状态，我们就能极大地减少内存中的对象数量。

:::



## 模式结构（UML 类图）

```scss
Client ─────► FlyweightFactory ─────► Flyweight
                                │
                       Shared (ConcreteFlyweight)
```

- `Flyweight`：抽象享元类，定义共享接口。
- `ConcreteFlyweight`：具体享元，实现共享内容。
- `FlyweightFactory`：享元工厂，负责创建/复用对象。
- `Client`：客户端，只使用享元工厂获取实例。



## 示例场景

我们用“文字处理器”来举例：

- 所有字符（A、B、C……）都是共享的（**内部状态**）。
- 每个字符在屏幕上的位置是外部状态，单独管理。



### Java 实现

```java showLineNumbers
import java.util.*;

// 抽象享元
interface Glyph {
    void draw(String position);
}

// 具体享元
class CharacterGlyph implements Glyph {
    private char symbol;

    public CharacterGlyph(char symbol) {
        this.symbol = symbol;
    }

    public void draw(String position) {
        System.out.println("绘制字符 '" + symbol + "' 在位置 " + position);
    }
}

// 享元工厂
class GlyphFactory {
    private Map<Character, Glyph> glyphs = new HashMap<>();

    public Glyph getGlyph(char symbol) {
        if (!glyphs.containsKey(symbol)) {
            glyphs.put(symbol, new CharacterGlyph(symbol));
        }
        return glyphs.get(symbol);
    }
}

// 使用
public class Main {
    public static void main(String[] args) {
        GlyphFactory factory = new GlyphFactory();

        String doc = "AABBC";
        for (int i = 0; i < doc.length(); i++) {
            Glyph glyph = factory.getGlyph(doc.charAt(i));
            glyph.draw("位置[" + i + "]");
        }
    }
}
```



### C++ 实现

```cpp showLineNumbers
#include <iostream>
#include <unordered_map>
using namespace std;

// 抽象享元
class Glyph {
public:
    virtual void draw(const string& position) = 0;
    virtual ~Glyph() {}
};

// 具体享元
class CharacterGlyph : public Glyph {
    char symbol;
public:
    CharacterGlyph(char s) : symbol(s) {}
    void draw(const string& position) override {
        cout << "绘制字符 '" << symbol << "' 在位置 " << position << endl;
    }
};

// 享元工厂
class GlyphFactory {
    unordered_map<char, Glyph*> glyphs;
public:
    Glyph* getGlyph(char symbol) {
        if (glyphs.count(symbol) == 0) {
            glyphs[symbol] = new CharacterGlyph(symbol);
        }
        return glyphs[symbol];
    }

    ~GlyphFactory() {
        for (auto& p : glyphs) delete p.second;
    }
};

// 使用
int main() {
    GlyphFactory factory;
    string doc = "AABBC";

    for (size_t i = 0; i < doc.size(); ++i) {
        Glyph* glyph = factory.getGlyph(doc[i]);
        glyph->draw("位置[" + to_string(i) + "]");
    }
}
```



### Python 实现

```python showLineNumbers
# 抽象享元
class Glyph:
    def draw(self, position):
        raise NotImplementedError

# 具体享元
class CharacterGlyph(Glyph):
    def __init__(self, symbol):
        self.symbol = symbol

    def draw(self, position):
        print(f"绘制字符 '{self.symbol}' 在位置 {position}")

# 享元工厂
class GlyphFactory:
    def __init__(self):
        self._glyphs = {}

    def get_glyph(self, symbol):
        if symbol not in self._glyphs:
            self._glyphs[symbol] = CharacterGlyph(symbol)
        return self._glyphs[symbol]

# 使用
factory = GlyphFactory()
doc = "AABBC"

for i, ch in enumerate(doc):
    glyph = factory.get_glyph(ch)
    glyph.draw(f"位置[{i}]")
```



### TypeScript 实现

```typescript showLineNumbers
// 抽象享元
interface Glyph {
  draw(position: string): void;
}

// 具体享元
class CharacterGlyph implements Glyph {
  constructor(private symbol: string) {}

  draw(position: string): void {
    console.log(`绘制字符 '${this.symbol}' 在位置 ${position}`);
  }
}

// 享元工厂
class GlyphFactory {
  private glyphs: Map<string, Glyph> = new Map();

  getGlyph(symbol: string): Glyph {
    if (!this.glyphs.has(symbol)) {
      this.glyphs.set(symbol, new CharacterGlyph(symbol));
    }
    return this.glyphs.get(symbol)!;
  }
}

// 使用
const factory = new GlyphFactory();
const doc = "AABBC";

for (let i = 0; i < doc.length; i++) {
  const glyph = factory.getGlyph(doc[i]);
  glyph.draw(`位置[${i}]`);
}
```



## 小结

| 特性     | 内容                                                         |
| -------- | ------------------------------------------------------------ |
| 模式类型 | 结构型                                                       |
| 适用场景 | 系统中存在大量重复对象、内存压力大                           |
| 优点     | <ul><li>显著减少内存占用</li><li>提高性能</li></ul>          |
| 缺点     | <ul><li>区分内部/外部状态增加复杂性</li><li>共享对象需严格不可变</li></ul> |

享元模式就像“对象共享池”，非常适合在游戏开发、文字处理器、地图系统等需要大量重复对象的场景中使用。
