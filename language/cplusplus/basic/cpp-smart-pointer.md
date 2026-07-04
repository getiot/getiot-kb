---
sidebar_position: 46
slug: /cpp-smart-pointer
---

# C++ 智能指针

由于 C++ 没有提供自动内存回收机制，因此每个 `new` 出来的对象在不需要时都要手动 `delete` 掉，否则就会造成内存泄漏（memory leak）。但由于种种原因，例如程序流程太复杂，或者程序员忘记 `delete`，从而导致内存泄漏，影响程序运行甚至异常退出。因此，在现代 C++ 编程中，标准库定义了智能指针（Smart Pointer），这些智能指针用于帮助确保程序不会出现内存泄漏，并具有异常安全。



## 什么是智能指针

简单来说，C++ 中的智能指针就是一种用于自动化管理动态分配内存的机制。它是 C++ 提供的一种高级工具，可以自动地管理指向堆内存的指针，并在不需要时将其释放。这些指针使用一个计数器来跟踪有多少个指针引用了同一个对象。当计数器归零时，智能指针会自动释放对象。

:::tip

使用智能指针，程序员在使用 `new` 分配内存后不再需要跟踪指向该内存的指针，也不需要手动 `delete` 释放该内存。有效地避免了因程序流程太复杂，或者忘记 `delete` 导致内存泄漏或野指针等问题。

:::

对于编译器来说，智能指针实际上是一个栈对象，并非指针类型，在栈对象生命期即将结束时，智能指针通过析构函数释放由它管理的堆内存。所有智能指针都重载了 `operator->` 操作符，直接返回对象的引用，用以操作对象。访问智能指针原来的方法则使用 `.` 操作符。

访问智能指针包含的裸指针则可以用 `get()` 函数。由于智能指针是一个对象，所以 `if (my_smart_object)` 永远为真，要判断智能指针的裸指针是否为空，应该使用如下方式判断。

```cpp showLineNumbers
if (my_smart_object.get())
```

智能指针包含了 `reset()` 方法，如果不传递参数（或者传递 `NULL`），则智能指针会释放当前管理的内存。如果传递一个对象，则智能指针会释放当前对象，来管理新传入的对象。

智能指针在 `std` 命名空间中定义 ，下面我们将逐一介绍四种智能指针。



## 智能指针的种类

在 C++ 中，主要有三种智能指针：

- **`unique_ptr`**：唯一所有权指针，一个对象只能由一个 `unique_ptr` 指向，当 `unique_ptr` 被销毁时，它所管理的对象也被销毁。
- **`shared_ptr`**：共享所有权指针，允许多个 `shared_ptr` 指向同一对象。它使用一个引用计数器来跟踪有多少个 `shared_ptr` 指向同一个对象，并在所有指向该对象的 `shared_ptr` 都被销毁时释放该对象。
- **`weak_ptr`**：弱引用指针，允许共享一个对象的所有权，但不会增加引用计数。`weak_ptr` 主要用于避免 `shared_ptr` 的循环引用问题。

使用智能指针可以避免手动管理动态内存的复杂性，并减少内存泄漏和悬挂指针等错误的风险。但需要注意的是，智能指针并不能完全消除所有的内存管理问题，还需要根据具体情况综合使用。



### unique_ptr

`unique_ptr` 定义在头文件 `<memory>` 中，它持有对对象的独有权 —— 两个 `unique_ptr` 不能指向同一个对象，即 `unique_ptr` 不共享它所管理的对象。

`unique_ptr` 无法复制到其他 `unique_ptr`，无法通过值传递到函数，也无法用于需要副本的任何标准模板库 （STL）算法。你只能移动 `unique_ptr`，即对资源管理权限可以实现转移。这意味着，内存资源所有权可以转移到另一个 `unique_ptr`，并且原始 `unique_ptr` 不再拥有此资源。

实际使用中，建议将对象限制为由一个所有者所有，因为多个所有权会使程序逻辑变得复杂。因此，当需要智能指针用于存 C++ 对象时，可使用 `unique_ptr`，构造 `unique_ptr` 时，可使用 `make_unique` Helper 函数。

下图演示了两个 unique_ptr 实例之间的所有权转换。

![C++ unique_ptr 指针转移所有权](https://static.getiot.tech/cpp-pointer-unique_ptr.png#center)

`unique_ptr` 与原始指针一样有效，并可用于 STL 容器。将 `unique_ptr` 实例添加到 STL 容器运行效率很高，因为通过 `unique_ptr` 的移动构造函数，不再需要进行复制操作。

`unique_ptr` 指针与其所指对象的关系：在智能指针生命周期内，可以改变智能指针所指对象，如创建智能指针时通过构造函数指定、通过 `reset` 方法重新指定、通过 `release` 方法释放所有权、通过移动语义转移所有权，`unique_ptr` 还可能没有对象，这种情况被称为 `empty`。

```cpp showLineNumbers
//智能指针的创建  
unique_ptr<int> u_i; 	//创建空智能指针
u_i.reset(new int(3)); 	//绑定动态对象  
unique_ptr<int> u_i2(new int(4));//创建时指定动态对象
unique_ptr<T,D> u(d);	//创建空 unique_ptr，执行类型为 T 的对象，用类型为 D 的对象 d 来替代默认的删除器 delete

//所有权的变化  
int *p_i = u_i2.release();	//释放所有权  
unique_ptr<string> u_s(new string("abc"));  
unique_ptr<string> u_s2 = std::move(u_s); //所有权转移(通过移动语义)，u_s所有权转移后，变成“空指针” 
u_s2.reset(u_s.release());	//所有权转移
u_s2=nullptr;//显式销毁所指对象，同时智能指针变为空指针。与u_s2.reset()等价
```

下面是一个使用 `unique_ptr` 的简单示例程序，展示了如何创建 `unique_ptr` 对象、将其作为函数参数传递以及如何使用 `unique_ptr` 管理动态内存：

```cpp showLineNumbers
#include <iostream>
#include <memory> // 包含 unique_ptr

void print(std::unique_ptr<int>& ptr) { // 接受 unique_ptr 的引用
    std::cout << "value: " << *ptr << std::endl;
}

int main()
{
    std::unique_ptr<int> ptr(new int(42)); // 创建 unique_ptr 对象

    print(ptr); // 将 unique_ptr 作为函数参数传递

    *ptr = 43; // 可以像常规指针一样使用箭头或星号操作符

    std::cout << "new value: " << *ptr << std::endl;

    return 0; // 在 main 函数结束时，unique_ptr 对象自动释放内存
}
```

在这个示例程序中，我们首先创建了一个指向 int 类型的 `unique_ptr` 对象，并通过 new 运算符在堆上分配了一个整型对象。然后，我们将 `unique_ptr` 对象作为函数参数传递给 print 函数，并输出指向的整数值。接着，我们通过星号操作符修改了指向的整数值，并输出新值。

在程序结束时，`unique_ptr` 对象自动释放了它所管理的内存，因此我们无需手动调用 `delete` 操作符来释放分配的内存。



### shared_ptr

`shared_ptr`是一个标准的共享所有权的智能指针，允许多个指针指向同一个对象，定义在 `<memory>` 文件中，命名空间为 `std`。`shared_ptr` 最初实现于 Boost 库中，后由 `C++11` 引入到 `C++ STL`。

`shared_ptr` 利用引用计数的方式实现了对所管理的对象的所有权的分享，即允许多个 `shared_ptr` 共同管理同一个对象。像 `shared_ptr` 这种智能指针，在《Effective C++》中被称为“引用计数型智能指针”（reference-counting smart pointer，RCSP）。

`shared_ptr` 是为了解决 `auto_ptr` 在对象所有权上的局限性（`auto_ptr` 是独占的），在使用引用计数的机制上提供了可以共享所有权的智能指针，当然这需要额外的开销 —— `shared_ptr` 对象除了包括一个所拥有对象的指针外，还必须包括一个引用计数代理对象的指针。而时间上的开销主要在初始化和拷贝操作上， `*` 和 `->` 操作符重载的开销跟 `auto_ptr` 是一样。

开销并不是我们不使用 `shared_ptr` 的理由，永远不要进行不成熟的优化，直到性能分析器告诉你这一点。

```cpp showLineNumbers
#include <iostream>
#include <memory>
using namespace std;
class A
{
public:
    int i;
    A(int n):i(n) { };
    ~A() { cout << i << " " << "destructed" << endl; }
};
int main()
{
    shared_ptr<A> sp1(new A(2));  // A(2)由sp1托管
    shared_ptr<A> sp2(sp1);       // A(2)同时交由sp2托管
    shared_ptr<A> sp3;
    sp3 = sp2;                    // A(2)同时交由sp3托管
    cout << sp1->i << "," << sp2->i << "," << sp3->i << endl;
    A * p = sp3.get();            // get返回托管的指针，p 指向 A(2)
    cout << p->i << endl;         // 输出 2
    sp1.reset(new A(3));          // reset导致托管新的指针, 此时sp1托管A(3)
    sp2.reset(new A(4));          // sp2托管A(4)
    cout << sp1->i << endl;       // 输出 3
    sp3.reset(new A(5));          // sp3托管A(5),A(2)无人托管，被delete
    cout << "end" << endl;
    return 0;
}
```

下面是一个使用 `shared_ptr` 的简单示例程序，展示了如何创建 `shared_ptr` 对象、使用引用计数以及如何在不同的作用域中共享动态内存：

```cpp showLineNumbers
#include <iostream>
#include <memory> // 包含 shared_ptr

void func(std::shared_ptr<int> ptr) // 接受 shared_ptr 的拷贝
{
    std::cout << "func: " << *ptr << std::endl;
}

int main()
{
    std::shared_ptr<int> ptr1(new int(42)); // 创建 shared_ptr 对象

    std::cout << "ptr1 count: " << ptr1.use_count() << std::endl; // 输出引用计数

    {
        std::shared_ptr<int> ptr2 = ptr1; // 复制 shared_ptr，共享同一块内存
        std::cout << "ptr1 count: " << ptr1.use_count() << std::endl; // 输出引用计数
        std::cout << "ptr2 count: " << ptr2.use_count() << std::endl; // 输出引用计数
    } // 离开作用域时，ptr2 被销毁，但内存不被释放

    std::cout << "ptr1 count: " << ptr1.use_count() << std::endl; // 输出引用计数

    func(ptr1); // 将 shared_ptr 作为函数参数传递，函数内部共享同一块内存

    std::cout << "ptr1 count: " << ptr1.use_count() << std::endl; // 输出引用计数

    return 0; // 在 main 函数结束时，shared_ptr 对象自动释放内存
}
```

在这个示例程序中，我们首先创建了一个指向 `int` 类型的 `shared_ptr` 对象，并通过 `new` 运算符在堆上分配了一个整型对象。然后，我们输出 `shared_ptr` 对象的引用计数，发现此时计数为 `1`。

接着，我们创建了一个新的作用域，并将 `shared_ptr` 对象复制给另一个 `shared_ptr` 对象，共享同一块内存。我们输出两个 `shared_ptr` 对象的引用计数，发现此时计数为 `2`。当离开这个作用域时，其中一个 `shared_ptr` 对象被销毁，但内存不被释放。

然后，我们将 `shared_ptr` 对象作为函数参数传递给 `func` 函数，并输出 `shared_ptr` 对象的引用计数，发现此时计数为 `2`，这是因为 `func` 函数内部也共享同一块内存。

在程序结束时，`shared_ptr` 对象自动释放了它所管理的内存，因此我们无需手动调用 `delete` 操作符来释放分配的内存。



### weak_ptr

`weak_ptr` 被设计为与 `shared_ptr` 共同工作，可以从一个 `shared_ptr` 或者另一个 `weak_ptr` 对象构造而来。

`weak_ptr` 是为了配合 `shared_ptr` 而引入的一种智能指针，它更像是 `shared_ptr` 的一个助手而不是智能指针，因为它不具有普通指针的行为，没有重载 `operator*` 和 `operator->` ，因此取名为 **weak**，表明其是功能较弱的智能指针。

它的最大作用在于协助 `shared_ptr` 工作，可获得资源的观测权，像旁观者那样观测资源的使用情况。观察者意味着 `weak_ptr` 只对 `shared_ptr` 进行引用，而不改变其引用计数，当被观察的 `shared_ptr` 失效后，相应的 `weak_ptr` 也相应失效。

使用 `weak_ptr` 的成员函数 `use_count()` 可以观测资源的引用计数，另一个成员函数 `expired()` 的功能等价于 `use_count()==0`，但更快，表示被观测的资源（也就是 `shared_ptr` 管理的资源）已经不复存在。

`weak_ptr` 可以使用一个非常重要的成员函数 `lock()` 从被观测的 `shared_ptr` 获得一个可用的 `shared_ptr` 管理的对象，从而操作资源。但当 `expired()==true` 的时候，`lock()` 函数将返回一个存储空指针的 `shared_ptr`。

`weak_ptr` 的基本用法总结如下：

```cpp showLineNumbers
weak_ptr<T> w;	 	 // 创建空 weak_ptr，可以指向类型为 T 的对象。
weak_ptr<T> w(sp);	 // 与 shared_ptr 指向相同的对象，shared_ptr 引用计数不变。T必须能转换为 sp 指向的类型。
w=p;				 // p 可以是 shared_ptr 或 weak_ptr，赋值后 w 与 p 共享对象。
w.reset();			 // 将 w 置空。
w.use_count();		 // 返回与 w 共享对象的 shared_ptr 的数量。
w.expired();		 // 若 w.use_count() 为 0，返回 true，否则返回 false。
w.lock();			 // 如果 expired() 为 true，返回一个空 shared_ptr，否则返回非空 shared_ptr。
```

下面是一个简单的使用示例：

```cpp showLineNumbers
#include < assert.h>

#include <iostream>
#include <memory>
#include <string>
using namespace std;

int main()
{
	shared_ptr<int> sp(new int(10));
	assert(sp.use_count() == 1);
	weak_ptr<int> wp(sp); 	             // 从shared_ptr创建weak_ptr
	assert(wp.use_count() == 1);
    
	if (!wp.expired())		             // 判断weak_ptr观察的对象是否失效
	{
		shared_ptr<int> sp2 = wp.lock(); // 获得一个shared_ptr
		*sp2 = 100;
		assert(wp.use_count() == 2);
	}
	assert(wp.use_count() == 1);
	cout << "int:" << *sp << endl;
    return 0;
}
```



## 如何选择智能指针

### 两个原则

记住下面两个原则：

- 如果程序要使用多个指向同一个对象的指针，应选择 `shared_ptr`。
- 如果程序不需要多个指向同一个对象的指针，则可使用 `unique_ptr`。

如果函数使用 `new` 分配内存，并返还指向该内存的指针，将其返回类型声明为 `unique_ptr` 是不错的选择。这样，所有权转让给接受返回值的 `unique_ptr`，而该智能指针将负责调用 `delete`。可将 `unique_ptr` 存储到 STL 容器中，只要不调用将一个 `unique_ptr` 复制或赋值给另一个的算法（如 `sort()`）。

例如，可在程序中使用类似于下面的代码段。

```cpp showLineNumbers
unique_ptr<int> make_int(int n)
{
    return unique_ptr<int>(new int(n));
}

void show(unique_ptr<int>& p1)
{
    cout << *p1 << ' ';
}

int main()
{
    ...
    vector<unique_ptr<int> > vp(size);
    for(int i = 0; i < vp.size(); i++)
		vp[i] = make_int(rand() % 1000);       // copy temporary unique_ptr
    vp.push_back(make_int(rand() % 1000));     // ok because arg is temporary
    for_each(vp.begin(), vp.end(), show);      // use for_each()
    ...
}
```

其中 `push_back` 调用没有问题，因为它返回一个临时 `unique_ptr`，该 `unique_ptr` 被赋给 vp 中的一个 `unique_ptr`。

另外，如果按值而不是按引用给 `show()` 传递对象，`for_each()` 将非法，因为这将导致使用一个来自 `vp` 的非临时 `unique_ptr` 初始化 `pi`，而这是不允许的。前面说过，编译器将发现错误使用 `unique_ptr` 的企图。

在 `unique_ptr` 为右值时，可将其赋给 `shared_ptr`，这与将一个 `unique_ptr` 赋给另一个 `unique_ptr` 需要满足的条件相同，即 `unique_ptr` 必须是一个临时对象。与前面一样，在下面的代码中，`make_int()` 的返回类型为 `unique_ptr<int>`

```cpp showLineNumbers
unique_ptr<int> pup(make_int(rand() % 1000));   	// ok
shared_ptr<int> spp(pup);                    	    // not allowed, pup as lvalue
shared_ptr<int> spr(make_int(rand() % 1000));    	// ok
```

模板 `shared_ptr` 包含一个显式构造函数，可用于将右值 `unique_ptr` 转换为 `shared_ptr`。`shared_ptr` 将接管原来归 `unique_ptr` 所有的对象。

### 不建议使用 auto_ptr

`auto_ptr` 是 C++11 之前提供的一种智能指针，也用于自动管理动态分配的内存。与 `unique_ptr` 不同，`auto_ptr` 可以进行所有权的转移，即将指向对象的所有权从一个 `auto_ptr` 转移给另一个 `auto_ptr`。

然而，由于 `auto_ptr` 存在一些严重的问题，因此已经被 C++11 引入的 `unique_ptr` 所取代。`auto_ptr` 的主要问题是它的所有权转移机制是基于赋值操作的，这意味着使用 `auto_ptr` 时必须非常小心，以避免无意中将所有权转移到错误的指针上。此外，`auto_ptr` 也不能被用于数组的动态内存管理。

因此，尽管 `auto_ptr` 可以在某些情况下用于动态内存管理，但由于存在严重的问题，建议使用 `unique_ptr` 代替 auto_ptr。

### Boost 智能指针

除了上面提到的四种智能指针，C++ Boost 库还提出了 `boost::scoped_ptr`、`boost::scoped_array`、`boost::intrusive_ptr` 等智能指针，虽然尚未得到 C++ 标准采纳，但是你也可以在开发实践中使用它们。这里暂不做过多介绍。

