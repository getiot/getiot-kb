---
sidebar_position: 10
slug: /cpp-stl-array
---

# C++ STL 数组（Array）

Array 容器是 C++ 11 标准中新增的序列容器。简单来说，它就是在 C++ 普通数组的基础上，添加了一些成员函数和全局函数。在使用上，Array 比普通数组更安全，同时效率并没有因此变差。

和其它容器不同，Array 容器的大小是固定的，无法动态的扩展或收缩。这也就意味着，在使用该容器的过程无法借由增加或移除元素而改变其大小，它只允许访问或者替换存储的元素。



## array 数组

Array 容器以类模板的形式定义在 `<array>` 头文件，并位于命名空间 std 中，如下所示：

```cpp showLineNumbers
namespace std{
    template <typename T, size_t N>
    class array;
}
```

因此，在使用该容器之前，代码中需引入 `<array>` 头文件，并默认使用 std 命令空间，如下所示：

```cpp showLineNumbers
#include <array>
using namespace std;
```

在 `array<T,N>` 类模板中，`T` 用于指明容器中的存储的具体数据类型，`N` 用于指明容器的大小。需要注意，这里的 `N` 必须是常量，不能用变量表示。



## array 初始化

创建一个大小为 10 的 array 浮点型数组，语法如下：

```cpp showLineNumbers
std::array<double, 10> values;
```

说明：

| 参数/变量 | 描述                   |
| --------- | ---------------------- |
| `double`  | 数组中每个元素的类型。 |
| `10`      | 数组的大小。           |
| `values`  | 数组的变量名。         |

这样就创建好了一个名为 `values` 的 array 容器，其包含 10 个浮点型元素。但是，由于未显式指定这 10 个元素的值，因此使用这种方式创建的容器中，各个元素的值是不确定的（array 容器不会做默认初始化操作）。

通过如下创建 array 容器的方式，可以将所有的元素初始化为 0 或者和默认元素类型等效的值：

```cpp showLineNumbers
std::array<double, 10> values {};
```

使用该语句，容器中所有的元素都会被初始化为 0.0。

如果想要在创建时给 array 数组赋初始值，可以使用下面语法：

```cpp showLineNumbers
std::array<double, 10> values {0.1, 1.4, 1.8, 2.4};
```

这里只初始化了前 4 个元素，剩余的元素都会被初始化为 0.0。

如果想要将全部元素赋一个指定的值，可以使用 `fill` 方法，例如全部初始化为 10.0：

```cpp
std::array<double, 10> values;
values.fill(10.0);
```



## array 成员函数

函数列表

| 成员函数              | 功能                                                         |
| --------------------- | ------------------------------------------------------------ |
| `begin()`             | 返回指向容器中第一个元素的随机访问迭代器。                   |
| `end()`               | 返回指向容器最后一个元素之后一个位置的随机访问迭代器，通常和 `begin()` 结合使用。 |
| `rbegin()`            | 返回指向最后一个元素的随机访问迭代器。                       |
| `rend()`              | 返回指向第一个元素之前一个位置的随机访问迭代器。             |
| `cbegin()`            | 和 `begin()` 功能相同，只不过在其基础上增加了 const 属性，不能用于修改元素。 |
| `cend()`              | 和 `end()` 功能相同，只不过在其基础上，增加了 const 属性，不能用于修改元素。 |
| `crbegin()`           | 和 `rbegin()` 功能相同，只不过在其基础上，增加了 const 属性，不能用于修改元素。 |
| `crend()`             | 和 `rend()` 功能相同，只不过在其基础上，增加了 const 属性，不能用于修改元素。 |
| `size()`              | 返回容器中当前元素的数量，其值始终等于初始化 array 类的第二个模板参数 N。 |
| `max_size()`          | 返回容器可容纳元素的最大数量，其值始终等于初始化 array 类的第二个模板参数 N。 |
| `empty()`             | 判断容器是否为空，和通过 `size()==0` 的判断条件功能相同，但其效率可能更快。 |
| `at(n)`               | 返回容器中 n 位置处元素的引用，该函数自动检查 n 是否在有效的范围内，如果不是则抛出 out_of_range 异常。 |
| `front()`             | 返回容器中第一个元素的直接引用，该函数不适用于空的 array 容器。 |
| `back()`              | 返回容器中最后一个元素的直接应用，该函数同样不适用于空的 array 容器。 |
| `data()`              | 返回一个指向容器首个元素的指针。利用该指针，可实现复制容器中所有元素等类似功能。 |
| `fill(val)`           | 将 val 这个值赋值给容器中的每个元素。                        |
| `array1.swap(array2)` | 交换 array1 和 array2 容器中的所有元素，但前提是它们具有相同的长度和类型。 |

除此之外，C++ 11 标准库也增加了 `begin()` 和 `end()` 这两个函数，和 array 容器包含的 `begin()` 和 `end()` 成员函数不同的是，标准库提供的这两个函数的操作对象，既可以是容器，还可以是普通数组。

- 当操作对象是容器时，它和容器包含的 `begin()` 和 `end()` 成员函数的功能完全相同；
- 当操作对象是普通数组，则 `begin()` 函数返回的是指向数组第一个元素的指针，同样 `end()` 返回指向数组中最后一个元素之后一个位置的指针（注意不是最后一个元素）。

另外，在 `<array>` 头文件中还重载了 `get()` 全局函数，该重载函数的功能是访问容器中指定的元素，并返回该元素的引用。正是由于 array 容器中包含了 `at()` 这样的成员函数，使得操作元素时比普通数组更安全。



## array 长度

可以使用 `size()` 函数获取 STL 中 array 容器的长度。例如：

```cpp showLineNumbers
arr.size();
```

`size()` 函数返回值为 `size_t` 类型，表示数组的长度。



## array 是否为空

有两个方法可以知道 array 容器是否为空：

1. 先使用 `size()` 函数获取其长度，再判断其值是否为 0；
2. 直接使用 `empty()` 函数。

```cpp showLineNumbers
arr.empty();
```

如果 arr 为空，返回 true，否则，返回 false。



## array 访问元素

当需要访问 STL 中的 array 的某个元素是，我们可以使用数组下标的方式、使用 at 的方式、使用 data 函数和 get 四种方式来访问 array 容器元素。

- 可以通过 `容器名 []` 的方式直接访问和使用容器中的元素，这和 C/C++ 标准数组访问元素的方式相同。但这种方式由于没有做任何边界检查，所以即便使用越界的索引值去访问或存储元素也不会被检测到。
- 为了能够有效地避免越界访问的情况，可以使用 array 容器提供的 `at()` 成员函数。当传给 `at()` 的索引是一个越界值时，程序会抛出 `std::out_of_range` 异常。
- array 容器还提供了 `get<n>` 模板函数，它是一个辅助函数，能够获取到容器的第 n 个元素。该模板函数中，参数的实参必须是一个在编译时可以确定的常量表达式，所以它不能是一个循环变量。也就是说，它只能访问模板参数指定的元素，编译器在编译时会对它进行检查。
- 通过调用 `data()` 函数可以得到指向容器首个元素的指针。通过该指针，可以获得容器中的各个元素。

**示例**：使用 at、get、data 三种方法访问 array

```cpp showLineNumbers
#include <iostream>
#include <array>

using namespace std;

int main(void)
{
    array<int, 4> arr;

    // 填充数组
    for (int i=0; i<arr.size(); i++) {
        arr.at(i) = i + 1;
    }

    // 使用 at 方法获取数组内容
    for (int i=0; i<arr.size(); i++) {
        cout << arr.at(i) << " ";
    }
    cout << endl;

    // 使用 get 方法获取数组内容
    cout << get<1>(arr) << endl;
    cout << get<2>(arr) << endl;

    // 使用 data 方法获取数组内容
    for (int i=arr.size()-1; i>=0; i--) {
        cout << *(arr.data()+i) << " ";
    }
    cout << endl;
    
    return 0;
}
```

执行 `g++ main.cpp` 编译示例程序，可以添加 `-std=c++11` 选项参数指定 C++ 版本，如下：

```bash
g++ main.cpp -std=c++11
```

执行 `./a.out` 运行程序，输出结果如下：

```bash
1 2 3 4 
2
3
4 3 2 1
```



## array 迭代器

array 容器是 C++ 11 标准中新增的序列容器，同时 STL 也为 array 容器配备了随机访问迭代器，可以用来随机访问 array 容器中的元素。

array 迭代器函数有 `begin()`、`end()`、`rbegin()`、`rend()`、`cbegin()`、`cend()`、`crbegin()` 和 `crend()`，相关说明参考 [array 成员函数](#array 成员函数)。除此之外，C++ 11 标准新增的 `begin()` 和 `end()` 函数，当操作对象为 array 容器时，也和迭代器有关，其功能分别和上面的 `begin()`、`end()` 成员函数相同。

根据它们的功能并结合实际场景的需要，这些成员函数通常是成对使用的，即 `begin()/end()`、`rbegin()/rend()`、`cbegin()/cend()`、`crbegin()/crend()` 各自成对搭配使用。

不仅如此，这 4 对中 `begin()/end()` 和 `cbegin()/cend()`、`rbegin()/rend()` 和 `crbegin()/crend()` 的功能大致是相同的，唯一的区别就在于其返回的迭代器能否用来修改元素值。

值得一提的是，以上函数在实际使用时，其返回值类型都可以使用 auto 关键字代替，编译器可以自行判断出该迭代器的类型。



### begin 和 end 迭代器

示例：使用 begin 和 end 迭代器访问元素

```cpp showLineNumbers
#include <iostream>
#include <array>

using namespace std;

int main(void)
{
    array<int, 5> arr;
    int v = 1;
    
    auto first = arr.begin();
    auto last = arr.end();
    
    while (first != last) {
        *first = v;
        ++first;
        v++;
    }
    
    first = arr.begin();
    
    while (first != last) {
        cout << *first << " ";
        ++first;
    }
    cout << "\n";
    return 0; 
}
```

执行 `g++ main.cpp -std=c++11 && ./a.out` 编译运行以上程序，输出结果如下：

```bash
1 2 3 4 5
```

可以看到，这里首先使用了迭代器对数组的元素进行了赋值，接着再次使用了迭代器访问了数组的所有元素。



### cbegin 和 cend 迭代器

示例：使用 cbegin 和 cend 迭代器访问元素

```cpp showLineNumbers
#include <iostream>
#include <array>

using namespace std;

int main(void)
{
    array<int, 5> arr{10, 20, 30, 40, 50};
    auto first = arr.cbegin();
    auto last = arr.cend();
    
    while (first != last) {
        cout << *first << " ";
        ++first;
    }
    cout << "\n";
    return 0; 
}
```

执行 `g++ main.cpp -std=c++11 && ./a.out` 编译运行以上程序，输出结果如下：

```bash
10 20 30 40 50
```

`cbegin()/cend()` 和 `begin()/end()` 函数的区别是，前者返回的是 const 类型的正向迭代器。这意味着，有 `cbegin()` 和 `cend()` 成员函数返回的迭代器，可以用来遍历容器内的元素，也可以访问元素，但是不能对所存储的元素进行修改。



## array 反向迭代器

STL 为 array 容器配备了随机访问的迭代器和反向迭代器，可以用来随机访问 array 容器中的元素。每对反向迭代器都可以分别得到指向最后一个元素和第一个元素前一个位置的随机访问迭代器。

在使用反向迭代器进行 `++` 或 `--` 运算时，`++` 指的是迭代器向左移动一位，`--` 指的是迭代器向右移动一位，即这两个运算符的功能也 “互换” 了。

### rbegin 和 rend 反向迭代器

示例：使用 rbegin 和 rend 反向迭代器访问元素

```cpp showLineNumbers
#include <iostream>
#include <array>

using namespace std;

int main(void)
{
    array<int, 5> arr;
    int v = 1;
    auto first = arr.rbegin();
    auto last = arr.rend();
    
    while (first != last) {
        *first = v;
        ++first;
        v++;
    }
    
    first = arr.rbegin();
    
    while (first != last) {
        cout << *first << " ";
        ++first;
    }
    cout << "\n";
    return 0; 
}
```

执行 `g++ main.cpp -std=c++11 && ./a.out` 编译运行以上程序，输出结果如下：

```bash
1 2 3 4 5
```

可以看到，这里首先使用了反向迭代器对数组的元素进行了赋值，接着再次使用了反向迭代器访问了数组的所有元素。



### crbegin 和 crend 反向迭代器

示例：使用 crbegin 和 crend 反向迭代器访问元素

```cpp showLineNumbers
#include <iostream>
#include <array>

using namespace std;

int main(void)
{
    array<int, 5> arr{10, 20, 30, 40, 50};
    auto first = arr.crbegin();
    auto last = arr.crend();
    
    while (first != last) {
        cout << *first << " ";
        ++first;
    }
    cout << "\n";
    return 0; 
}
```

执行 `g++ main.cpp -std=c++11 && ./a.out` 编译运行以上程序，输出结果如下：

```bash
50 40 30 20 10
```

使用 `crbegin()` 和 `crend()` 迭代器遍历 array 时，是从最后一个元素开始遍历到第一个元素的。