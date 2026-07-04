---
sidebar_position: 15
---

# C 语言 - 参数传递



本节介绍 C 语言中形参和实参的概念，以及参数传递的两种方式，即 **值传递** 和 **地址传递**。下面将通过几个示例介绍这些概念。



## 形参和实参

在 C 语言中，如果函数要使用参数，则必须声明接受参数值的变量。我们以前面介绍的 `max()` 函数来说明：

```c showLineNumbers
#include <stdio.h>

/* function returning the max between two numbers */
int max(int num1, int num2)
{
    return (num1 > num2 ? num1 : num2); 
}

int main(void)
{
    /* local variable definition */
    int a = 100;
    int b = 200;
    int ret;
 
    /* calling a function to get max value */
    ret = max(a, b);
    printf( "Max value is : %d\n", ret );
    
    return 0;
}
```

在这里，`max()` 函数参数列表中的 `num1` 和 `num2`，这些变量称为函数的**形式参数**（Formal parameters），简称**形参**。而在函数调用时传入的变量值则称为**实际参数**（Actual parameters），简称**实参**，比如这里的 `a` 和 `b`。



## 值传递

**值传递**是 C 语言中函数参数传递的默认方式，即把参数的实际值复制给函数的形式参数。在这种情况下，修改函数内的形式参数不会影响实际参数。

下面我们尝试实现一个 `swap()` 函数，它的作用是接收两个整型参数，并交换它们的位置。

```c showLineNumbers
/* function definition to swap the values */
void swap(int x, int y)
{
    int temp;
    
    temp = x; /* save the value of x */
    x = y;    /* put y into x */
    y = temp; /* put temp into y */
  
    return;
}
```

接下来，编写主函数，通过传递实际参数来调用函数 `swap()`：

```c showLineNumbers
#include <stdio.h>
 
/* function declaration */
void swap(int x, int y);

int main(void)
{
    /* local variable definition */
    int a = 100;
    int b = 200;
    
    printf("Before swap, value of a : %d\n", a);
    printf("Before swap, value of b : %d\n", b);
    
    /* calling a function to swap the values */
    swap(a, b);
    
    printf("After swap, value of a : %d\n", a);
    printf("After swap, value of b : %d\n", b);
    
    return 0;
}

void swap(int x, int y)
{
    int temp;
    
    temp = x; /* save the value of x */
    x = y;    /* put y into x */
    y = temp; /* put temp into y */
    
    return;
}
```

编译、执行上述代码，输出结果如下：

```bash
Before swap, value of a : 100
Before swap, value of b : 200
After swap, value of a : 100
After swap, value of b : 200
```

看起来变量 `a` 和 `b` 的值并没有发生变化，显然 `swap()` 函数没有起到我们想要的效果。原因是虽然在 `swap()` 函数内改变了 `a` 和 `b` 的值，但因为采用的是值传递方式，形式参数 `x` 和 `y` 相当于函数内部创建的局部变量，当 `swap()` 函数结束时，局部变量也会被销毁，因此主函数中 `a` 和 `b` 的值不会受到影响。



## 地址传递

**地址传递**有时候也被称为“引用传递”或“指针传递”，因为在 C 语言中是通过指针来实现的。通过指针传递方式，形参为指向实参地址的指针，当对形参的指向操作时，就相当于对实参本身进行的操作。

传递指针可以让多个函数访问指针所引用的对象，而不用把对象（变量）声明为全局可访问。指针在 C 语言中有非常多的用法，在 [C 语言 - 指针](/c/c-pointers/) 章节中会详细介绍。

提示：在 C++ 中，指针和引用是两个不同的概念，不过在 C 语言中并没有本质区别，实际上就是一个地址。

下面我们通过地址传递的方式改写 `swap()` 函数，让它真正实现实参的交换。

```c showLineNumbers
/* function definition to swap the values */
void swap(int *x, int *y)
{
    int temp;
    
    temp = *x;    /* save the value at address x */
    *x = *y;      /* put y into x */
    *y = temp;    /* put temp into y */
    
    return;
}
```

形参前面加上 `*` 表示这是一个指针变量。而在函数体中，指针变量前面加上 `*` 表示获取指针变量对应的值，这个操作也称为“解引用”。

接下来，编写主函数，通过地址传递参数来调用函数 `swap()`，方法是在变量前面加上取址符 `&`：

```c showLineNumbers
#include <stdio.h>

int main(void)
{
    /* local variable definition */
    int a = 100;
    int b = 200;
    
    printf("Before swap, value of a : %d\n", a );
    printf("Before swap, value of b : %d\n", b );
    
    /* calling a function to swap the values */
    swap(&a, &b);
    
    printf("After swap, value of a : %d\n", a );
    printf("After swap, value of b : %d\n", b );
    
    return 0;
}

void swap(int *x, int *y)
{
    int temp;
    
    temp = *x; /* save the value of x */
    *x = *y;    /* put y into x */
    *y = temp; /* put temp into y */
    
    return;
}
```

编译、执行上述代码，输出结果如下：

```bash
Before swap, value of a : 100
Before swap, value of b : 200
After swap, value of a : 200
After swap, value of b : 100
```

可以看到，这次主函数中的变量 `a` 和 `b` 的值被交换了。



## 小结

在 C 语言中，有两种函数参数传递方式，一种是值传递，另一种是地址传递。与值传递的函数调用不同，使用地址传递方式可以在函数内改变函数外的变量（实际参数）。虽然在本节的 `swap()` 示例中，值传递的方式并没有达到预期结果，但并不是说值传递就不好。实际上，这种种参数传递方式都有非常广泛的应用，只有将两者结合起来，才能设计出好的函数接口。

一般来说，我们会将函数参数分为输入参数和输出参数，输入参数理论上是只读的，因此使用值传递方式就很合适。而输出参数除了可以通过函数返回值进行返回，还可以通过地址传递的方式传给函数内部，处理完之后直接将结果赋值给该参数。另外，对于较大的参数，比如数组、结构体，为了减少内存拷贝，往往也会采用地址传递的方式。

关于如何在函数中传递数组、字符串、结构体、指针等知识，我们会在对应的数据类型章节中进行介绍。
