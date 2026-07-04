---
sidebar_position: 13
---

# C 语言 - 循环语句

循环结构是程序设计中的另一种常用结构，比如在某些场景，你需要重复执行某一段代码很多次，这时候就需要用到循环语句了。本文将详细介绍 C 语言中循环语句的多种写法，掌握这些知识点，你将能够设计出拥有更为复杂执行路径的程序。

下面是大多数编程语言中循环语句的流程图：

![C语言循环语句](https://static.getiot.tech/c-loop-architecture.jpg#center)



## while 循环

只要给定的条件为 *true*，C 语言中的 `while` 循环语句会重复执行同一个语句块，直到条件变为 *false*。

**语法**

C 语言 `while` 循环语句的语法如下：

```c showLineNumbers
while (condition) {
    statement(s);
}
```

这里的 `condition` 可以是任意的表达式，当为任意非零值时都为 *true*。当条件为 *true* 时执行循环。 当条件为 *false* 时，退出循环，程序流将继续执行紧接着循环的下一条语句。

`statement(s)` 可以是一个单独的语句，也可以是几个语句组成的代码块。如果是单条语句，可以不使用大括号包裹。

**流程图**

![C语言 while 循环](https://static.getiot.tech/c-while-loop.jpg#center)

注意：`while` 循环有可能一次都不会执行。当条件为 *false* 时，会跳过循环主体，直接执行紧接着 `while` 循环的下一条语句。

**示例代码**

```c showLineNumbers
#include <stdio.h>
 
int main(void)
{
    /* local variable definition */
    int a = 10;
    
    /* while loop execution */
    while (a < 20) {
        printf("value of a: %d\n", a);
        a++;
    }
    
    return 0;
}
```

编译、执行上述代码，输出结果如下：

```bash
value of a: 10
value of a: 11
value of a: 12
value of a: 13
value of a: 14
value of a: 15
value of a: 16
value of a: 17
value of a: 18
value of a: 19
```



## do...while 循环

和 `while` 循环不同，`do...while` 循环是在循环的尾部检查它的条件。也就是说，`do...while` 循环会确保至少执行一次循环。

**语法**

C 语言 `do...while` 循环语句的语法如下：

```c showLineNumbers
do {
    statement(s);
} while (condition);
```

条件表达式 **condition** 出现在循环的尾部，所以循环中的 **statement(s)** 会在条件被测试之前至少执行一次。如果条件为真，控制流会跳转回上面的 do，然后重新执行循环中的 statement(s)。这个过程会不断重复，直到给定条件变为假为止。

**流程图**

![C语言 do...while 循环](https://static.getiot.tech/c-do-while-loop.jpg#center)

**示例代码**

```c showLineNumbers
#include <stdio.h>
 
int main(void)
{
    /* local variable definition */
    int a = 10;
    
    /* do loop execution */
    do {
        printf("value of a: %d\n", a);
        a = a + 1;
    } while (a < 20);
    
    return 0;
}
```

编译、执行上述代码，输出结果如下：

```bash
value of a: 10
value of a: 11
value of a: 12
value of a: 13
value of a: 14
value of a: 15
value of a: 16
value of a: 17
value of a: 18
value of a: 19
```



## for 循环

除了 `while` 语句，C 语言还提供另一个关键字 `for` 用于循环控制。`for` 循环通常用于编写一个执行指定次数的循环控制结构。

**语法**

C 语言 `for` 循环语句的语法如下：

```c showLineNumbers
for (init; condition; increment) {
    statement(s);
}
```

下面是 `for` 循环的控制流：

1. 首先执行 **init** 部分，并且只会执行一次。你可以在这里声明并初始化任何循环控制变量，也可以不在这里写任何语句，只要有一个分号出现即可。
2. 接下来，会判断 **condition** 表达式。如果为真，则执行循环主体。如果为假，则不执行循环主体，且控制流会跳转到紧接着 for 循环的下一条语句。
3. 在执行完 for 循环主体后，控制流会跳回上面的 **increment** 语句。通常会在这里更新循环控制变量，该语句可以留空，只要在条件后有一个分号出现即可。
4. 条件再次被判断。如果为真，则执行循环，这个过程会不断重复（循环主体，然后增加步值，再然后重新判断条件）。在条件变为假时，for 循环终止。

**流程图**

![C语言 for 循环](https://static.getiot.tech/c-for-loop.jpg#center)

**示例代码**

```c showLineNumbers
#include <stdio.h>
 
int main(void)
{
    int a;
    
    /* for loop execution */
    for (a = 10; a < 20; a = a + 1) {
        printf("value of a: %d\n", a);
    }
    
    return 0;
}
```

编译、执行上述代码，输出结果如下：

```bash
value of a: 10
value of a: 11
value of a: 12
value of a: 13
value of a: 14
value of a: 15
value of a: 16
value of a: 17
value of a: 18
value of a: 19
```



## 嵌套循环

C 语言允许在一个循环内使用另一个循环，无论是 `for` 循环还是 `while` 循环，都可以相互嵌套使用。

**语法**

C 语言嵌套 `for` 循环语句的语法如下：

```c showLineNumbers
for (init; condition; increment) {
    
    for (init; condition; increment) {
        statement(s);
    }
    statement(s);
}
```

C 语言嵌套 `while` 循环语句的语法如下：

```c showLineNumbers
while (condition) {

    while (condition) {
        statement(s);
    }
    statement(s);
}
```

C 语言嵌套 `do...while` 循环语句的语法如下：

```c showLineNumbers
do {
   statement(s);

   do {
      statement(s);
   } while (condition);

} while (condition);
```

注意：上面几种嵌套循环中，内层和外层都是同一种循环语句，但实际上你可以在任何类型的循环内嵌套其他任何类型的循环。比如，一个 for 循环可以嵌套在一个 while 循环内，反之亦然。

**示例代码**

下面示例代码通过两级循环实现九九乘法表的打印：

```c showLineNumbers
#include <stdio.h>

int main(void)
{
    int i, j;
    
    for (i = 1; i <= 9; i++) {
        for (j = 1; j <= i; j++) {
            printf("%d * %d = %d\t", i, j, i * j);
        }
        printf("\n");
    }
    
    return 0;
}
```

编译、执行上述代码，输出结果如下：

```bash
1 * 1 = 1
2 * 1 = 2       2 * 2 = 4
3 * 1 = 3       3 * 2 = 6       3 * 3 = 9
4 * 1 = 4       4 * 2 = 8       4 * 3 = 12      4 * 4 = 16
5 * 1 = 5       5 * 2 = 10      5 * 3 = 15      5 * 4 = 20      5 * 5 = 25
6 * 1 = 6       6 * 2 = 12      6 * 3 = 18      6 * 4 = 24      6 * 5 = 30      6 * 6 = 36
7 * 1 = 7       7 * 2 = 14      7 * 3 = 21      7 * 4 = 28      7 * 5 = 35      7 * 6 = 42      7 * 7 = 49
8 * 1 = 8       8 * 2 = 16      8 * 3 = 24      8 * 4 = 32      8 * 5 = 40      8 * 6 = 48      8 * 7 = 56      8 * 8 = 64
9 * 1 = 9       9 * 2 = 18      9 * 3 = 27      9 * 4 = 36      9 * 5 = 45      9 * 6 = 54      9 * 7 = 63      9 * 8 = 72      9 * 9 = 81
```



## 无限循环

如果循环条件永远不会变成 *false*，那么它就是一个无限循环，通常称为“死循环”。for 循环可以用来达到此目的，由于形成 for 循环的三个表达式都不是必需的，因此我们可以通过将条件表达式留空来创建无限循环。

```c showLineNumbers
#include <stdio.h>
 
int main(void)
{
    for (;;) {
        printf("This loop will run forever.\n");
    }
    
    return 0;
}
```

当 for 循环的条件表达式不存在时，判断结果就永远为真。因此，你可以添加一个初始化和增量表达式，只要两个分号中间的条件表达式为空，它依然是一个无限循环。

实际上，上述代码中的 `for(;;)` 也可以用 `while(1)` 替代。

提示：要想停止无限循环的程序，可以按 Ctrl + C 键。



## 循环控制语句

有时候，我们并不希望程序执行完整的循环，比如说当满足某个条件时，就跳出循环。这时候就需要用到循环控制语句，来改变代码的执行顺序。

C 语言提供了三种循环控制语句，包括 break、continue 和 goto 语句。goto 有点特殊，我们以后再介绍，这里先介绍前两种。

- break 语句：终止循环或 switch 语句，程序流将继续执行紧接着循环或 switch 的下一条语句。
- continue 语句：告诉一个循环体立刻停止本次循环迭代，重新开始下次循环迭代。
- goto 语句：将控制转移到被标记的语句，但是不建议在程序中使用 goto 语句。



### break 语句

C 语言中 `break` 语句有两种用法：

1. 当 `break` 语句出现在一个循环内时，循环会立即终止，且程序流将继续执行紧接着循环的下一条语句。
2. 它可用于终止 `switch` 语句中的一个 case。

如果你使用的是嵌套循环（即一个循环内嵌套另一个循环），`break` 语句会停止执行最内层的循环，然后开始执行该块之后的下一行代码。

![C语言 break 语句](https://static.getiot.tech/c-break-statement.jpg#center)

下面示例代码演示 break 语句的用法，当 a 大于 15 时跳出循环。

```c showLineNumbers
#include <stdio.h>
 
int main(void)
{
    /* local variable definition */
    int a = 10;
    
    /* while loop execution */
    while (a < 20) {
        printf("value of a: %d\n", a);
        a++;
        
        if( a > 15) {
            /* terminate the loop using break statement */
            break;
        }
    }
    
    return 0;
}
```

编译、执行上述代码，输出结果如下：

```bash
value of a: 10
value of a: 11
value of a: 12
value of a: 13
value of a: 14
value of a: 15
```



### continue 语句

C 语言中的 `continue` 语句有点像 `break` 语句，但它不是强制终止，而是跳过当前循环中的代码，执行下一次循环。对于 for 循环，`continue` 语句执行后自增语句仍然会执行；对于 while 和 do...while 循环，`continue` 语句会重新执行条件判断语句。

![C语言 continue 语句](https://static.getiot.tech/c-continue-statement.jpg#center)

下面示例代码演示 continue 语句的用法，当 a 等于 15 时跳过本次循环。

```c showLineNumbers
#include <stdio.h>
 
int main(void)
{
    /* local variable definition */
    int a = 10;

    /* do loop execution */
    do {
       if (a == 15) {
           /* skip the iteration */
           a = a + 1;
           continue;
       }
		
       printf("value of a: %d\n", a);
       a++;
   
    } while (a < 20);
 
    return 0;
}
```

编译、执行上述代码，输出结果如下：

```bash
value of a: 10
value of a: 11
value of a: 12
value of a: 13
value of a: 14
value of a: 16
value of a: 17
value of a: 18
value of a: 19
```

