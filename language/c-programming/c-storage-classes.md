---
sidebar_position: 9
---

# C 语言 - 存储类

**存储类**（storage class）用于确定 C 程序中变量/函数的存储位置、生命周期和作用域。变量作用域分为全局（global）和局部（local）两种，对应的存储类为“静态”和“自动”。具有全局的生命周期贯穿整个程序的执行过程，而局部变量则只能在局部范围内使用。对于函数而言，所有函数都具有全局生存期。

C 语言中可用的存储类包括 auto、register、static、extern 四种，下面将逐一介绍。



## auto 存储类

*auto* 存储类是所有局部变量（local variables）默认的存储类。定义在函数中的变量默认为 *auto* 存储类，这意味着它们在函数开始时被创建，在函数结束时被销毁。

```c showLineNumbers
{
   int mount;
   auto int month;
}
```

上述示例定义了两个带有相同存储类的变量。需要注意的是，*auto* 只能用在函数内，即 *auto* 只能修饰局部变量。



## register 存储类

*register* 存储类用于定义存储在寄存器中而不是内存（RAM）中的局部变量。这意味着变量的最大尺寸等于寄存器的大小（通常是一个字），且不能对它应用一元的 `&` 运算符（因为它没有内存位置）。

由于 *register* 存储类定义存储在寄存器，所以 *register* 变量的访问速度更快，但是它不能直接取地址，因为它不是存储在 RAM 内存中的。如果一个变量需要频繁访问，那么使用 *register* 修饰该变量可以提高程序的运行速度。

```c showLineNumbers
{
   register int  miles;
}
```

计算机的寄存器是很珍贵的，因此 *register* 存储类只用于需要快速访问的变量，比如计数器。还应注意的是，定义 *register* 并不意味着变量将被存储在寄存器中，它仅仅意味着变量可能存储在寄存器中，这取决于硬件平台和编译器的实现和限制。



## static 存储类

*static* 存储类用于指示编译器在程序的生命周期内保持局部变量的存在，而不需要在每次它进入和离开作用域时进行创建和销毁。因此，使用 *static* 修饰局部变量可以在函数调用之间保持局部变量的值。简单来说，对于一个局部变量，使用 *static* 修饰之后，它的作用域（可见性）不会改变，但是生命周期会变成和全局变量一样，这样的变量也称为“静态变量”。

静态变量在程序中只被初始化一次，即使函数被调用多次，该变量的值也不会重置。下面示例演示了 *static* 修饰全局变量和局部变量的情况。

```c showLineNumbers
#include <stdio.h>
 
/* function declaration */
void func(void);
 
static int count = 5; /* global variable */

int main(void) 
{
    while (count--)
    {
        func();
    }

   return 0;
}

/* function definition */
void func(void)
{
    static int i = 5; /* local static variable */
    i++;
    
    printf("i is %d and count is %d\n", i, count);
}
```

上述示例中，count 作为全局变量可以在函数内使用，i 使用 *static* 修饰后，不会在每次调用时重置。

编译并执行该程序，输出结果如下：

```bash
i is 6 and count is 4
i is 7 and count is 3
i is 8 and count is 2
i is 9 and count is 1
i is 10 and count is 0
```

你现在可能还无法理解这个示例，因为这里使用了函数和全局变量，这两个概念目前为止还没进行讲解。不过，即使你现在不能完全理解也没有关系，后续的章节我们会详细讲解，到时候你可以回过头来再次理解。

实际上，*static* 修饰符用法还有很多，后面我们会单独介绍。例如修饰全局变量或函数时，会使变量的作用域限制在声明它的文件内。



## extern 存储类

*extern* 存储类用于定义在其他文件中声明的全局变量或函数。当使用 *extern* 关键字时，不会为变量分配任何存储空间，而只是指示编译器该变量在其他文件中定义。也就是说，这是一个声明，而不是定义。

*extern* 存储类用于提供一个全局变量的引用，全局变量对所有的程序文件都是可见的。当你使用 *extern* 时，对于无法初始化的变量，会把变量名指向一个之前定义过的存储位置。

当你有多个文件且定义了一个可以在其他文件中使用的全局变量或函数时，可以在其他文件中使用 *extern* 来得到已定义的变量或函数的引用。可以这么理解，*extern* 是用来在另一个文件中声明一个全局变量或函数。

请看下面代码：

**第一个文件 main.c**

```c showLineNumbers title="main.c"
#include <stdio.h>
 
int count;
extern void write_extern();
 
int main(void)
{
    count = 5;
    write_extern();
}
```

**第二个文件 support.c**

```c showLineNumbers title="support.c"
#include <stdio.h>

extern int count;

void write_extern(void)
{
    printf("count is %d\n", count);
}
```

在这个示例中，第二个文件中的 *extern* 关键字用于声明已经在第一个文件 main.c 中定义的变量 `count`；而第一个文件中的 *extern* 关键字用于声明在第二个文件 support.c 中实现的函数 `write_extern()`。现在，执行下面命令编译这两个文件。

```bash
$ gcc main.c support.c
```

编译完成后，将产生 a.out 可执行程序。程序运行结果如下：

```bash
$ ./a.out
count is 5
```

