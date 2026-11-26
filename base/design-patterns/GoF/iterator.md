---
sidebar_position: 17
slug: /iterator
sidebar_label: 迭代器模式
---

# 迭代器模式

迭代器模式（Iterator Pattern）是一个非常基础但非常常用的设计模式，理解它能帮助你更深入地掌握集合、容器等数据结构的遍历原理。简单来讲，迭代器模式就是你可以用一个统一的方式来遍历各种集合，而不需要知道它们是数组、链表还是其他什么数据结构。

:::tip 核心思想 🌟

提供一种方法顺序访问一个聚合对象中的各个元素，而不暴露该对象的内部表示。

:::

迭代器模式的核心角色：

- **Iterator**（迭代器接口）：定义遍历元素的方法，比如 `hasNext()` 和 `next()`。
- **ConcreteIterator**（具体迭代器）：实现迭代器接口，维护遍历状态。
- **Aggregate**（聚合接口）：定义创建迭代器的方法。
- **ConcreteAggregate**（具体聚合）：实现聚合接口，创建相应的迭代器。



## 模式结构（UML 类图）

```scss
   +--------------------+
   |   Iterator         |<--------------------------+
   +--------------------+                           |
   | + hasNext(): bool  |                           |
   | + next(): Object   |                           |
   +--------------------+                           |
           ▲                                        |
           |                                        |
   +-----------------------+            +------------------------+
   |   ConcreteIterator    |            |   Aggregate            |
   +-----------------------+            +------------------------+
   | - currentPosition     |            | + createIterator()     |
   | - collection          |            +------------------------+
   | + hasNext()           |                        ▲
   | + next()              |                        |
   +-----------------------+            +--------------------------+
                                        |   ConcreteAggregate      |
                                        +--------------------------+
                                        | - items: List<Object>    |
                                        | + createIterator()       |
                                        +--------------------------+
```



## 示例场景

比如你有一个图书馆系统，里面有各种书籍集合。不同的集合（比如按分类、按作者等）内部实现可能完全不同，但你希望能以统一方式遍历它们。这时候，迭代器就能帮你做到。



### Java 实现

```java showLineNumbers
import java.util.List;
import java.util.ArrayList;

// 迭代器接口
interface Iterator<T> {
    boolean hasNext();
    T next();
}

// 聚合接口
interface Aggregate<T> {
    Iterator<T> createIterator();
}

// 具体聚合类
class BookCollection implements Aggregate<String> {
    private List<String> books = new ArrayList<>();

    public void addBook(String book) {
        books.add(book);
    }

    public Iterator<String> createIterator() {
        return new BookIterator();
    }

    // 内部类作为具体迭代器
    private class BookIterator implements Iterator<String> {
        private int index = 0;

        public boolean hasNext() {
            return index < books.size();
        }

        public String next() {
            return books.get(index++);
        }
    }
}

// 使用
public class Main {
    public static void main(String[] args) {
        BookCollection collection = new BookCollection();
        collection.addBook("Design Patterns");
        collection.addBook("Clean Code");

        Iterator<String> iterator = collection.createIterator();
        while (iterator.hasNext()) {
            System.out.println(iterator.next());
        }
    }
}
```



### C++ 实现

```cpp showLineNumbers
#include <iostream>
#include <vector>
#include <string>

using namespace std;

// 迭代器接口
class Iterator {
public:
    virtual bool hasNext() = 0;
    virtual string next() = 0;
    virtual ~Iterator() = default;
};

// 聚合类
class BookCollection {
private:
    vector<string> books;
public:
    void addBook(const string& book) {
        books.push_back(book);
    }

    vector<string>& getBooks() {
        return books;
    }

    class BookIterator : public Iterator {
    private:
        BookCollection& collection;
        size_t index = 0;
    public:
        BookIterator(BookCollection& c) : collection(c) {}

        bool hasNext() override {
            return index < collection.getBooks().size();
        }

        string next() override {
            return collection.getBooks()[index++];
        }
    };

    Iterator* createIterator() {
        return new BookIterator(*this);
    }
};

// 使用
int main() {
    BookCollection collection;
    collection.addBook("Effective C++");
    collection.addBook("Design Patterns");

    Iterator* it = collection.createIterator();
    while (it->hasNext()) {
        cout << it->next() << endl;
    }
    delete it;
    return 0;
}
```



### Python 实现（使用内置迭代器）

```python showLineNumbers
class BookCollection:
    def __init__(self):
        self.books = []

    def add_book(self, book):
        self.books.append(book)

    def __iter__(self):
        return BookIterator(self.books)

class BookIterator:
    def __init__(self, books):
        self._books = books
        self._index = 0

    def __next__(self):
        if self._index < len(self._books):
            result = self._books[self._index]
            self._index += 1
            return result
        else:
            raise StopIteration

    def __iter__(self):
        return self

# 使用
collection = BookCollection()
collection.add_book("Python Tricks")
collection.add_book("Fluent Python")

for book in collection:
    print(book)
```



### TypeScript 实现（使用 ES6 迭代器协议）

```typescript showLineNumbers
class BookCollection implements Iterable<string> {
  private books: string[] = [];

  addBook(book: string) {
    this.books.push(book);
  }

  [Symbol.iterator](): Iterator<string> {
    let index = 0;
    const books = this.books;

    return {
      next(): IteratorResult<string> {
        if (index < books.length) {
          return { value: books[index++], done: false };
        } else {
          return { value: undefined, done: true };
        }
      }
    };
  }
}

// 使用
const collection = new BookCollection();
collection.addBook("TypeScript Handbook");
collection.addBook("Clean Architecture");

for (const book of collection) {
  console.log(book);
}
```



## 小结

| 特性     | 内容                                                         |
| -------- | ------------------------------------------------------------ |
| 模式类型 | 行为型                                                       |
| 适用场景 | <ul><li>需要访问集合中元素而不暴露集合结构</li><li>支持多种遍历方式</li></ul> |
| 优点     | <ul><li>统一访问方式</li><li>可以为不同容器提供不同迭代逻辑</li></ul> |
| 缺点     | <ul><li>增加系统类的数量</li><li>对简单集合来说略显复杂</li></ul> |

通过迭代器模式，你可以优雅地遍历任何集合，无需关心它的内部结构。这正体现了面向对象设计中的**封装性与职责分离原则**。
