---
sidebar_position: 50
draft: true
---

# C 语言弱符号和弱引用



本文主要为大家详细介绍了C 语言弱符号与弱引用的用法。

## 弱符号

弱符号是指在定义或者声明一个对象（变量、结构体成员、函数）时，在对象的前面添加 `__attribute__((weak))` 标志所得到的对象符号。如下所示函数即为一个弱对象符号 `void test_weak_attr(void)`，或者称该函数是弱函数属性的、虚函数。

```c showLineNumbers
__attribute__((weak)) void test_weak_attr(void)
// 或者使用如下样式的定义，两者等效
void __attribute__((weak)) test_weak_attr(void)
{
    printf("Weak Func!\r\n");
}
```

### 弱符号的作用与示例

弱符号是相对于强符号而言的，在定义或者声明变量、函数时，未添加 `__attribute__((weak))` 标识的就默认为强符号。如下，最普通的函数定义，就是定义了一个强符号 void test_strong_ref(void)：

```c showLineNumbers
void test_weak_attr(void)
{
    printf("this is a strong func\r\n");
}
```

驱动程序往往需要考虑兼容性，因为要兼任很多厂商的不同型号的设备。若驱动程序中使用强符号定义一些与适配的设备的特性相关的功能，则下次适配其他设备时，该强符号函数可能需要被修改，以兼容新的设备。当适配的设备很多时，频繁地更改驱动代码将破坏驱动的可维护性。

弱符号的出现可以很好地解决该问题。弱符号的对象具有可以被重定义的功能（即可以被重载）。下面通过测试说明弱符号这种可被重载的特性。

在 test_weak_attr.c 程序中定义如下弱函数：

```c showLineNumbers
// test_weak_attr.c
#include <stdio.h>
 
__attribute__((weak)) void test_weak_attr(void)
{
    printf("this is a weak func\r\n");
}
```

在 main.c 中定义如下程序：

```c showLineNumbers
// main.c
void test_weak_attr(void)
{
    printf("this is a strong func\r\n");
}
 
void app_main(void)
{
    printf("init done\r\n");
     
    test_weak_attr();
}
```

编译运行该 main.c 程序，得到的结果是什么样子的呢？

```bash
this is a strong func
```

将 main.c 中的 void test_weak_attr(void) 函数注释掉，再重新编译运行程序得到的结果是：

```bash
this is a weak func
```

**小结**：在使用弱符号函数时，我们可以重新定义一个同名的强符号函数来替代它；若没有重新定义一个强函数来替换它，就使用弱函数的实现。弱函数就好像是一个可以被替换的“默认函数”。

值得一提的是，旧版本的编译器还可以使用如下方式的定义（仅声明无效）将一个对象定义为一个弱对象：

```c showLineNumbers
__weak void f(void)
{
//code
}
```

在 linux 的一些代码中，`__weak` 其实就是通过 `__attribute__((weak))`的重命名，两者等效。

## 弱引用

弱引用是在声明一个对象时，通过`__attribute__ ((weakref())` 定义一个符号的引用关系。如下所示即定义 test_weakref() 函数弱引用 test_weak_ref() 函数。

```c showLineNumbers
static void test_weakref(void) __attribute__ ((weakref("test_weak_ref")));
```

弱引用是相对于强引用而言的。未通过 `__attribute__ ((weakref())` 的符号和实现代码之间的关系是强引用。如下即为一个强引用函数。它直接给出了 函数 `test_strong_ref(void) `的实现。

```c showLineNumbers
static void test_strong_ref(void)
{
    printf("this is a strong ref\r\n");
}
```

在编译程序的时候，我们可以直接使用 `test_strong_ref(void) `而不必担心编译不通过。如果，我没有时间去实现 test_strong_ref(void) ，还想在程序里先使用该函数那该如何呢？（是的，就是想白嫖，不想实现，还想先在程序里使用这个函数）。

这个时候弱引用就派上用场了。可以先将该函数定义为弱引用插入到代码中，待后期有时间再慢慢优化代码实现这个函数完整的功能。下面结合测试进行说明。

#### 测试代码1：

```c showLineNumbers
static void test_weakref(void) __attribute__ ((weakref("test_weak_ref")));
void app_main(void)
{
    printf("init done\r\n");
    if (test_weakref) {
        test_weakref();
    } else {
        printf("There is no weakref\r\n");
    }
}
```

**测试结果：**

> There is no weakref

#### 测试代码2：

```c showLineNumbers
void test_weak_ref(void)
{ 
    printf("this is a weak ref\n");
}
static void test_weakref(void) __attribute__ ((weakref("test_weak_ref")));
void app_main(void)
{
    printf("init done\r\n");
    if (test_weakref) {
        test_weakref();
    } else {
        printf("There is no weakref\r\n");
    }
}
```

**测试结果：**

> this is a weak ref

**小结**： 强引用，在未定义该强引用的实现时，编译会报错误：未定义的引用。弱引用允许定义一个未实现（未实例化）的对象，这在编译的时候会将该对象处理成 `NULL`，编译器并不会报错。通过使用弱引用可以实现后期优化代码的功能。而避免改动使用该函数的地方。使用弱函数可以实现类似“钩子（hook）"函数的功能。

实际上，包括C、python、go 编程语言在内的很多语言 都有类似用法，本篇文章叙述的方法同样适用于这些语言的相关开发。

**注意**：弱引用仅在静态编译中有效，动态链接中可能无效。



## 小结

弱符号、弱引用都是增强程序的可维护性的方法。弱符号通过可以被重定义的特性，实现可以被替换实现。弱引用通过可以暂时使用一个未定义的函数的功能，实现允许后期再实现该函数具体功能，而不必担心编译不通过。

本篇文章就到这里了，希望能够给你带来帮助，也希望您能够多多关注脚本之家的更多内容!  



## 参考

- [C 语言的弱符号与弱引用你了解吗](https://www.jb51.net/article/242439.htm)
- [Mongoose mbuf 模块](https://mongoose.ws/)

