---
sidebar_position: 18
slug: /cpp-lambda
---

# C++ Lambda 表达式



C++11 标准引入了对匿名函数的支持，称为 Lambda 函数，也叫 Lambda 表达式。利用 Lambda 表达式，就可以很方便地定义和创建匿名函数。

虽然“Lambda 表达式”或“匿名函数”对 C++ 来说是“新玩意儿”，但其实很多高级语言在很早以前就已经提供了 Lambda 表达式的功能，比如 Python、C# 等等。

在 C++ 中，Lambda 表达式把函数看作对象，我们可以像使用对象一样使用 Lambda 表达式，也可以将它们赋给变量和作为参数传递，还可以像函数一样对其求值。



## 声明 Lambda 表达式

Lambda 表达式的声明与函数声明非常类似，语法格式如下：

```cpp showLineNumbers
[capture list] (params list) mutable exception-> return type { function body }
```

各项具体含义如下：

- `capture list`：捕获外部变量列表（可选的）
- `params list`：参数列表（可选的，类似于函数中的形式参数）
- `mutable` 指示符：用于说明是否可以修改捕获的变量
- `exception`：异常设定
- `return type`：返回值类型
- `function body`：函数体

通过省略其中某些成分，常见的 Lambda 表达式声明有以下几种：

| 序号 | 格式                                                         |
| ---- | ------------------------------------------------------------ |
| ①    | `[capture list] (params list) -> return type { function body }` |
| ②    | `[capture list] (params list) { function body }`             |
| ③    | `[capture list] { function body }`                           |


其中，格式 ① 声明了 const 类型的表达式，这种类型的表达式不能修改捕获列表中的值。

格式 ② 省略了返回值类型，但编译器可以根据以下规则推断出 Lambda 表达式的返回类型：

- 如果 function body 中存在 return 语句，则该 Lambda 表达式的返回类型由 return 语句的返回类型确定；
- 如果 function body 中没有 return 语句，则返回值为 void 类型。

格式 ③ 中省略了参数列表，类似普通函数中的无参函数。

示例：下面的代码声明了一个比较 `int` 类型变量 `x`,`y` 大小的 Lambda 表达式。

```cpp showLineNumbers
[](int x, int y) -> bool { return x < y ; }
```

示例：一个简单的 Lambda 表达式。

```cpp showLineNumbers
[]{ ++global_x; }
```

示例：一个更复杂的 Lambda 表达式。

```cpp showLineNumbers
[](int x, int y) -> int { int z = x + y; return z + x; }
```

函数体中，一个临时的参数 `z` 被创建用来存储中间结果。如同一般的函数，`z` 的值不会保留到下一次该匿名函数再次被调用时。



## Lambda 使用示例

下面示例展示了 Lambda 表达式的用法。

```cpp showLineNumbers
#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

bool cmp(int a, int b)
{
    return  a < b;
}

int main(void)
{
    vector<int> myvec{ 3, 2, 5, 7, 3, 2 };
    vector<int> lbvec(myvec);

    /* 旧式做法 */
    sort(myvec.begin(), myvec.end(), cmp);
    cout << "predicate function:" << endl;
    for (int it : myvec)
        cout << it << ' ';
    cout << endl;

    /* Lambda表达式 */
    sort(lbvec.begin(), lbvec.end(), [](int a, int b) -> bool { return a < b; });
    cout << "lambda expression:" << endl;
    for (int it : lbvec)
        cout << it << ' ';
    cout << endl;
    
    return 0;
}
```

在 C++11 之前，我们使用 STL 的 sort 函数，需要提供一个谓词函数。而使用 C++11 的 Lambda 表达式，只需要传入一个匿名函数即可，方便简洁，而且代码的可读性也比旧式的做法好多了。



## 捕获外部变量

Lambda 表达式可以使用其可见范围内的外部变量，但必须明确声明（明确声明哪些外部变量可以被该 Lambda 表达式使用）。Lambda 表达式通过在最前面的方括号 `[capture list]` 来明确指明其内部可以访问的外部变量，这一过程也称过 Lambda 表达式“捕获”了外部变量。

示例：

```cpp showLineNumbers
int main(void)
{
    int a = 100, b = 200;
    auto f = [a, b] { int c = a + b; cout << c << endl; };
    f(); // 输出 300

    // 或通过“函数体”后面的‘()’传入参数，输出 123
    auto x = [](int a) -> int { cout << a << endl; return a; }(123);
    
    return 0;
}
```

上述示例先声明了两个整型变量 a 和 b，然后再创建 Lambda 表达式，该表达式“捕获”了 a 和 b 变量，这样在 Lambda 表达式函数体中就可以获得该变量的值。

类似参数传递方式（值传递、引入传递、指针传递），在Lambda表达式中，外部变量的捕获方式也有值捕获、引用捕获、隐式捕获。



### 值捕获

值捕获和参数传递中的值传递类似，被捕获的变量的值在 Lambda 表达式创建时通过值拷贝的方式传入，因此随后对该变量的修改不会影响影响 Lambda 表达式中的值。

示例：

```cpp showLineNumbers
int main()
{
    int a = 123;
    auto f = [a] { cout << a << endl; }; 
    a = 321;
    f(); // 输出：123
}
```

说明：如果以传值方式捕获外部变量，则在 Lambda 表达式函数体中不能修改该外部变量的值。

### 引用捕获

使用引用捕获一个外部变量，只需要在捕获列表变量前面加上一个引用说明符 &。

示例：

```cpp showLineNumbers
int main()
{
    int a = 123;
    auto f = [&a] { cout << a << endl; }; 
    a = 321;
    f(); // 输出：321
}
```

说明：引用捕获的变量使用的实际上就是该引用所绑定的对象。

### 隐式捕获

上面的值捕获和引用捕获都需要我们在捕获列表（capture list）中显式列出 Lambda 表达式中使用的外部变量。除此之外，我们还可以让编译器根据函数体中的代码来推断需要捕获哪些变量，这种方式称之为隐式捕获。

隐式捕获有两种方式，分别是 `[=]` 和 `[&]`。其中，`[=]` 表示以值捕获的方式捕获外部变量，`[&]` 表示以引用捕获的方式捕获外部变量。

隐式值捕获示例：

```cpp showLineNumbers
int main()
{
    int a = 123;
    auto f = [=] { cout << a << endl; };    // 值捕获
    f(); // 输出：123
}
```

隐式引用捕获示例：

```cpp showLineNumbers
int main()
{
    int a = 123;
    auto f = [&] { cout << a << endl; };    // 引用捕获
    a = 321;
    f(); // 输出：321
}
```



### 混合方式

除此之外，Lambda 表达式还支持混合的方式捕获外部变量，这种方式主要是将上面几种捕获方式的组合使用。

总结来说，C++11 中的 Lambda 表达式捕获外部变量主要有以下形式：

| 捕获形式        | 说明                                                         |
| --------------- | ------------------------------------------------------------ |
| `[]`            | 不捕获任何外部变量。                                         |
| `[变量名, ...]` | 默认以值得形式捕获指定的多个外部变量（用逗号分隔），<br/>如果引用捕获，需要显示声明（使用 & 说明符）。 |
| `[this]`        | 以值的形式捕获this指针。                                     |
| `[=]`           | 以值的形式捕获所有外部变量。                                 |
| `[&]`           | 以引用形式捕获所有外部变量。                                 |
| `[=, &x]`       | 变量 x 以引用形式捕获，其余变量以传值形式捕获。              |
| `[&, x]`        | 变量 x 以值的形式捕获，其余变量以引用形式捕获。              |



## 修改捕获变量

在 Lambda 表达式中，如果以传值方式捕获外部变量，则函数体中不能修改该外部变量，否则会引发编译错误。如果想要修改捕获变量，则需要使用 mutable 关键字，该关键字用以说明表达式体内的代码可以修改值捕获的变量。

示例：

```cpp showLineNumbers
int main()
{
    int a = 123;
    auto f = [a]()mutable { cout << ++a; }; // 不会报错
    cout << a << endl; // 输出：123
    f(); // 输出：124
}
```



## Lambda 表达式的参数

本文开头提到，Lambda 表达式的参数类似于普通函数的形式参数。不过，在 Lambda 表达式中传递参数还有一些限制。主要有以下几点：

- 参数列表中不能有默认参数；
- 不支持可变参数；
- 所有参数必须有参数名。


