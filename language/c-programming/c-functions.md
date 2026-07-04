---
sidebar_position: 14
---

# C 语言 - 函数



函数是 C 程序中的基本模块单元，通常设计为执行一项特定任务，由一系列语句组成。本节我们将一起学习在 C 语言中如何定义函数、声明函数和调用函数，函数是模块化程序设计的重要基础，因此本节知识非常重要。



## 函数是什么

函数（Function）是计算机编程中一个通用的概念，一个函数就是一组一起执行一个任务的语句。在不同的编程语言或应用领域中，函数可能有一些不同的叫法，比如方法、子例程或子程序等等。

在前面的章节中，其实我们已经接触过函数，因为每个 C 程序都至少有一个函数，即主函数 `main()`。当然，除了主函数，我们也可以把代码划分到不同的函数中，也就是自定义函数。至于如何划分代码到不同的函数中，则完全是由程序员（你）来决定的，但在逻辑上，通常会根据每个函数执行一个特定的任务来进行的。

在 C 语言中，函数包含声明和语句，函数声明是为了告诉编译器函数的名称、返回类型和参数。函数定义则提供了函数的实际主体，也就是该任务需要执行的一组语句。每个函数都有一个名称，函数名通常会反映该任务是做什么的。比如，C 标准库提供的函数 `strcat()` 用来连接两个字符串，函数 `memcpy()` 用来复制内存到另一个位置。

C 标准库提供了大量的程序可以调用的内置函数，你可以在《[Linux 常用 C 函数参考手册](https://getiot.tech/manual/linux-c-functions/index.html)》中找到它们。



## 如何定义函数

在 C 语言中，定义一个函数的基本语法形式如下：

```c showLineNumbers
return_type function_name( parameter list ) {
    body of the function
}
```

C 函数由一个函数头和一个函数主体组成，其中函数头又包含函数名称、参数列表、返回类型 3 部分。具体说明如下：

- **返回类型（Return Type）**：一个函数可以返回一个值，而 `return_type` 就是函数返回的值的数据类型，表示当函数执行完毕将返回一个该类型的数据。并不是所有函数都需要返回值，这时候返回类型是 `void`，表示无返回值。
- **函数名称（Function Name）**：这是函数的实际名称，函数名可以反映函数的功能，函数名和参数列表一起构成了函数签名。
- **参数（Parameters）**：参数列表包括函数参数的类型、顺序、数量。当调用函数时，需要按要求传递参数。但不是所有函数都需要参数，也就是说，参数是可选的。
- **函数主体（Function Body）**：函数主体包含一组定义函数执行任务的语句。

下面通过一个实例演示如何定义函数，这里我们会定义一个 `max()` 函数，它的功能是接收两个整型参数 `num1` 和 `num2`，然后返回它们中的最大值。

```c showLineNumbers
/* function returning the max between two numbers */
int max(int num1, int num2)
{
    /* local variable declaration */
    int result;
    
    if (num1 > num2)
        result = num1;
    else
        result = num2;
    
    return result; 
}
```

如果使用三目运算符，`max()` 函数的定义可以简化为：

```c showLineNumbers
int max(int num1, int num2)
{
    return (num1 > num2 ? num1 : num2); 
}
```



## 函数的声明

在 C 语言中，函数必须具有定义且应具有声明（这个概念和变量的定义和声明类似）。函数声明必须在调用函数前出现，否则 C 编译器无法找到该函数。实际上，定义可用作声明，也就是说，如果函数定义出现在调用之前，那么可以省略函数声明。更多的情况下，我们会将函数的声明放在头文件，这样需要调用该函数的文件只要引用对应的头文件即可。

函数声明包含有关参数的类型和数目以及返回类型等信息，也被称为**函数原型**。C 编译器使用原型来比较随后通过函数的参数对函数进行的调用中的自变量类型，并在需要时，将自变量类型转换为参数类型。

下面是函数声明的语法，它和函数定义的函数头很像，只是后面不需要跟函数主体，而是用分号结束。

```c showLineNumbers
return_type function_name( parameter list );
```

还记得前面那个 `max()` 函数吗？我们可以这样声明它：

```c showLineNumbers
int max(int num1, int num2);
```

对于函数声明而言，参数列表中的参数类型是必须的，但参数名称不是必须的，因此 `max()` 的声明可以简化为：

```c showLineNumbers
int max(int, int);
```



## 函数的调用

当我们有了函数的定义和声明之后，接下来就要被程序调用该函数，完成真正的任务。

当调用一个函数时，程序控制权会转移给被调用的函数。被调用的函数执行已定义的任务，当函数的返回语句被执行时，或到达函数的结束括号时，会把程序控制权交还给主程序。这就完成了一次函数调用。

调用函数时，传递所需参数，如果函数返回一个值，则可以存储返回值。例如：

```c showLineNumbers
#include <stdio.h>

/* function declaration */
int max(int num1, int num2);

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

/* function returning the max between two numbers */
int max(int num1, int num2)
{
    return (num1 > num2 ? num1 : num2); 
}
```

如果将 `max()` 函数的定义放在 `main()` 之前，可以省略显式声明。如下：

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

这就是为什么在很多 C 程序中 `main()` 函数出现在源文件的末尾的原因。

编译、执行上述代码，输出结果如下：

```bash
Max value is : 200
```



## 函数的参数

参数在函数名之后的圆括号内指定。你可以添加任意多的参数，只需用逗号分隔它们。例如：

```c showLineNumbers
int max(int num1, int num2);
```

再增加一个参数：

```c showLineNumbers
int max(int num1, int num2, int num3);
```

形式参数类似于函数内的其他局部变量，在进入函数时被创建，退出函数时被销毁。

在 C 语言中，调用函数时有两种向函数传递参数的方式：

- **值传递**：该方法把参数的实际值复制给函数的形式参数。在这种情况下，修改函数内的形式参数不会影响实际参数。
- **地址传递**：通过指针传递方式，形参为指向实参地址的指针，当对形参的指向操作时，就相当于对实参本身进行的操作。

默认情况下，C 使用**值传递**来传递参数。一般来说，这意味着函数内的代码不能改变用于调用函数的实际参数。

关于函数参数传递的更多用法和细节，我们会在下一节介绍。
