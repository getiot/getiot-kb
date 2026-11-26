---
sidebar_position: 15
slug: /interpreter
sidebar_label: 解释器模式
---

# 设计模式 - 解释器模式

解释器模式（Interpreter Pattern）就是将语言规则通过面向对象的方式建模，让每个语法元素变成一个可组合的对象，通过解释这些对象来实现语言的执行。如果你有一个自定义 DSL（领域特定语言）要解析，那解释器模式将会非常适合你！

解释器模式适用于这样一种情况：

> 你想为某种语言创建一个解释器。语言的语法可以用类表示，每个类代表语法中的一种规则，最终通过组合类来解释和执行语句。

实际上，如果你曾经写过一个“计算器”或者“公式解析器”，那你已经接触过解释器模式的思想了。

:::tip 核心思想 🌟

为某种语言或表达式定义一种解释器，用代码实现这种语言的语法规则，并通过对象结构来解释该语言中的句子。

- 每个语法规则用一个类来表示，实现一个统一的 `interpret()` 方法。
- 通过组合这些规则，构建出更复杂的表达式结构。
- 执行时，递归调用各个表达式的 `interpret()` 方法来计算结果。

:::



## 模式结构（UML 类图）

```scss
        +--------------------+
        | AbstractExpression |
        +--------------------+
        | + interpret()      |
        +--------------------+
             ▲          ▲
      +-----------+ +-------------+
      | Terminal  | | NonTerminal |
      |Expression | | Expression  |
      +-----------+ +-------------+

Client --→ 通过组合多个 Expression 构建语法树
```



## 示例：简单布尔表达式解释器

假设你想做一个简单的逻辑表达式解析器，比如：

```bash
true AND false
true OR false
```

你希望用代码来表示这些规则，并根据输入来“解释”出结果。这正是解释器模式要做的事情。



### Java 实现

```java showLineNumbers
interface Expression {
    boolean interpret();
}

class TrueExpression implements Expression {
    public boolean interpret() {
        return true;
    }
}

class FalseExpression implements Expression {
    public boolean interpret() {
        return false;
    }
}

class AndExpression implements Expression {
    private Expression left, right;

    public AndExpression(Expression l, Expression r) {
        this.left = l;
        this.right = r;
    }

    public boolean interpret() {
        return left.interpret() && right.interpret();
    }
}

class OrExpression implements Expression {
    private Expression left, right;

    public OrExpression(Expression l, Expression r) {
        this.left = l;
        this.right = r;
    }

    public boolean interpret() {
        return left.interpret() || right.interpret();
    }
}

public class Main {
    public static void main(String[] args) {
        Expression expr = new AndExpression(
            new TrueExpression(),
            new FalseExpression()
        );
        System.out.println(expr.interpret()); // false

        Expression expr2 = new OrExpression(
            new TrueExpression(),
            new FalseExpression()
        );
        System.out.println(expr2.interpret()); // true
    }
}
```



### C++ 实现

```cpp showLineNumbers
#include <iostream>
using namespace std;

class Expression {
public:
    virtual bool interpret() = 0;
    virtual ~Expression() = default;
};

class TrueExpression : public Expression {
public:
    bool interpret() override { return true; }
};

class FalseExpression : public Expression {
public:
    bool interpret() override { return false; }
};

class AndExpression : public Expression {
    Expression* left;
    Expression* right;
public:
    AndExpression(Expression* l, Expression* r) : left(l), right(r) {}
    bool interpret() override { return left->interpret() && right->interpret(); }
};

class OrExpression : public Expression {
    Expression* left;
    Expression* right;
public:
    OrExpression(Expression* l, Expression* r) : left(l), right(r) {}
    bool interpret() override { return left->interpret() || right->interpret(); }
};

int main() {
    Expression* expr = new AndExpression(new TrueExpression(), new FalseExpression());
    cout << expr->interpret() << endl; // 输出：0

    Expression* expr2 = new OrExpression(new TrueExpression(), new FalseExpression());
    cout << expr2->interpret() << endl; // 输出：1

    delete expr;
    delete expr2;
    return 0;
}
```



### Python 实现

```python showLineNumbers
class Expression:
    def interpret(self):
        pass

class TrueExpression(Expression):
    def interpret(self):
        return True

class FalseExpression(Expression):
    def interpret(self):
        return False

class AndExpression(Expression):
    def __init__(self, left, right):
        self.left = left
        self.right = right

    def interpret(self):
        return self.left.interpret() and self.right.interpret()

class OrExpression(Expression):
    def __init__(self, left, right):
        self.left = left
        self.right = right

    def interpret(self):
        return self.left.interpret() or self.right.interpret()

# 使用
expr = AndExpression(TrueExpression(), FalseExpression())
print(expr.interpret())  # 输出：False

expr2 = OrExpression(TrueExpression(), FalseExpression())
print(expr2.interpret())  # 输出：True
```



### TypeScript 实现

```typescript showLineNumbers
interface Expression {
  interpret(): boolean;
}

class TrueExpression implements Expression {
  interpret(): boolean {
    return true;
  }
}

class FalseExpression implements Expression {
  interpret(): boolean {
    return false;
  }
}

class AndExpression implements Expression {
  constructor(private left: Expression, private right: Expression) {}

  interpret(): boolean {
    return this.left.interpret() && this.right.interpret();
  }
}

class OrExpression implements Expression {
  constructor(private left: Expression, private right: Expression) {}

  interpret(): boolean {
    return this.left.interpret() || this.right.interpret();
  }
}

// 使用
const expr = new AndExpression(new TrueExpression(), new FalseExpression());
console.log(expr.interpret()); // false

const expr2 = new OrExpression(new TrueExpression(), new FalseExpression());
console.log(expr2.interpret()); // true
```



## 应用场景

- 正则表达式解释与匹配
- 数学表达式求值
- SQL 查询的解析器
- 自定义规则引擎（如折扣规则、权限规则）



## 小结

| 特性     | 内容                                                        |
| -------- | ----------------------------------------------------------- |
| 模式类型 | 行为型                                                      |
| 适用场景 | <ul><li>构建语言解析器</li><li>简单语法结构的解释</li></ul> |
| 优点     | <ul><li>易于扩展语法规则</li><li>每个类职责清晰</li></ul>   |
| 缺点     | <ul><li>类太多</li><li>复杂语法结构不适用</li></ul>         |

解释器模式适合用于那些**规则重复、表达式结构清晰**的场景，比如：公式计算器、命令解析器、机器人指令系统等等。
