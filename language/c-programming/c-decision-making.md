---
sidebar_position: 12
---

# C 语言 - 条件语句



C 程序默认是顺序执行的，如果想要改变程序的执行流程，则需要用到流程控制语句。在 C 语言中，有两种常用的流程控制，分别是分支控制和循环控制，利用它们可以让程序的执行千变万化。本文先来介绍分支控制。

分支控制使用的是条件语句（又称判断语句），顾名思义，它是根据程序员指定的一个或多个条件进行评估，如果条件为真则执行语句（必需的），条件为假则执行另一语句（可选的）。

下面是大多数编程语言中典型的判断结构的一般形式：

![C语言条件语句/判断语句](https://static.getiot.tech/c-decision-making.jpg#center)

提示：C 语言任何**非零**和**非空**的值假定为 **true**，把**零**或 **null** 假定为 **false**。



## if 语句

一个 `if` 语句包含一个或多个条件组成的布尔表达式（Boolean expression）。

**语法**

C 语言 `if` 语句的语法如下：

```c showLineNumbers
if (boolean_expression) {
   /* statement(s) will execute if the boolean expression is true */
}
```

如果布尔表达式的值为 **true**，那么 `if` 语句后面由大括号包裹的语句块将被执行。如果布尔表达式的值为 **false**，那么将执行整个 `if` 语句后的代码，也就是 `}` 后的第一行代码。

值得一提的是，如果 `if` 语句的语句块中只有一行代码，那么大括号 `{ }` 是可以省略的。但对于新手来说，不建议省略，因为很容易出错。

**流程图**

![C语言 if 语句](https://static.getiot.tech/c-if-statement.jpg#center)

**示例代码**

```c showLineNumbers
#include <stdio.h>
 
int main(void)
{
   /* local variable definition */
   int a = 10;
 
   /* check the boolean condition using if statement */
	
   if (a < 20) {
      /* if condition is true then print the following */
      printf("a is less than 20\n" );
   }
   
   printf("value of a is : %d\n", a);
 
   return 0;
}
```

编译、执行上述代码，输出结果如下：

```bash
a is less than 20;
value of a is : 10
```



## if...else 语句

一个 `if` 语句后面可以带上一个 `else` 语句，这样就能覆盖所有的条件，条件为 **true** 则执行 `if` 语句后面的语句块，条件为 **false** 则执行 `else` 语句后面的语句块。

**语法**

C 语言 `if...else` 语句的语法如下：

```c showLineNumbers
if (boolean_expression) {
   /* statement(s) will execute if the boolean expression is true */
} else {
   /* statement(s) will execute if the boolean expression is false */
}
```

如果布尔表达式的值为 **true**，那么 `if` 语句后面由大括号包裹的语句块将被执行。如果布尔表达式的值为 **false**，则执行 `else` 语句的语句块。

通用，如果 `else` 语句的语句块中只有一行代码，那么大括号 `{ }` 是可以省略的。但对于新手来说，不建议省略，因为很容易出错。

**流程图**

![C语言 if...else 语句](https://static.getiot.tech/c-if-else-statement.jpg#center)

**示例代码**

```c showLineNumbers
#include <stdio.h>
 
int main(void)
{
   /* local variable definition */
   int a = 100;
 
   /* check the boolean condition */
   if (a < 20) {
      /* if condition is true then print the following */
      printf("a is less than 20\n" );
   } else {
      /* if condition is false then print the following */
      printf("a is not less than 20\n" );
   }
   
   printf("value of a is : %d\n", a);
 
   return 0;
}
```

编译、执行上述代码，输出结果如下：

```bash
a is not less than 20;
value of a is : 100
```



## if...else if 语句

一个 `if` 语句后面还可以带多个 `else if` 语句，进行多种条件判断。这种结构是非常有用的，因为它比单一的 `if...else` 语句更丰富。如果末尾带上 `else` 语句，就形成了一个条件 100% 覆盖的 `if...else if...else` 语句。

使用 `if...else if...else` 语句时，有以下几点需要注意：

- 一个 `if` 后可跟零个或一个 `else`，`else` 必须在所有 `else if` 之后；
- 一个 `if` 后可跟零个或多个 `else if`，`else if` 必须在 `else` 之前；
- 一旦某个 `else if` 匹配成功，其他的 `else if` 或 `else` 将不会被测试。

**语法**

C 语言 `if...else if...else` 语句的语法如下：

```c showLineNumbers
if (boolean_expression 1) {
   /* Executes when the boolean expression 1 is true */
} else if (boolean_expression 2) {
   /* Executes when the boolean expression 2 is true */
} else if (boolean_expression 3) {
   /* Executes when the boolean expression 3 is true */
} else {
   /* executes when the none of the above condition is true */
}
```

**示例代码**

```c showLineNumbers
#include <stdio.h>

int main(void) 
{
   /* local variable definition */
   int a = 100;
 
   /* check the boolean condition */
   if (a == 10) {
      /* if condition is true then print the following */
      printf("Value of a is 10\n" );
   } else if (a == 20) {
      /* if else if condition is true */
      printf("Value of a is 20\n" );
   } else if (a == 30) {
      /* if else if condition is true  */
      printf("Value of a is 30\n" );
   } else {
      /* if none of the conditions is true */
      printf("None of the values is matching\n" );
   }
   
   printf("Exact value of a is: %d\n", a );
 
   return 0;
}
```

编译、执行上述代码，输出结果如下：

```bash
None of the values is matching
Exact value of a is: 100
```



## 嵌套 if 语句

在 C 语言中，嵌套 `if` 语句是合法的。也就是说，你可以在一个 `if` 或 `else if` 或 `else` 语句的语句块中再使用另一个 `if` 语句，而在该 `if` 语句中又可以继续使用另一个 `if` 语句。这种语法就称为“嵌套 if 语句”。

**语法**

C 语言嵌套 `if` 语句的语法如下：

```c showLineNumbers
if (boolean_expression 1) {

   /* Executes when the boolean expression 1 is true */
   if (boolean_expression 2) {
      /* Executes when the boolean expression 2 is true */
   }
   else if (boolean_expression 3) {
      /* Executes when the boolean expression 3 is true */
   } else {
      /* executes when the none of the above condition is true */
   }
}
```

**示例代码**

```c showLineNumbers
#include <stdio.h>
 
int main (void) {

   /* local variable definition */
   int a = 100;
   int b = 200;
 
   /* check the boolean condition */
   if (a == 100) {
   
      /* if condition is true then check the following */
      if (b == 200) {
         /* if condition is true then print the following */
         printf("Value of a is 100 and b is 200\n" );
      }
   }
   
   printf("Exact value of a is : %d\n", a );
   printf("Exact value of b is : %d\n", b );
 
   return 0;
}
```

编译、执行上述代码，输出结果如下：

```c showLineNumbers
Value of a is 100 and b is 200
Exact value of a is : 100
Exact value of b is : 200
```



## switch 语句

如果程序需要处理多级判断时，使用 `if...else if..else` 语句会显得非常冗长，因此 C 语言提供了 `switch` 语句。一个 `switch` 语句用于测试一个变量等于多个值时的情况，每个值称为一个 **case**。

**语法**

C 语言 `switch` 语句的语法如下：

```c showLineNumbers
switch (expression) {

   case constant-expression  :
      statement(s);
      break; /* optional */
	
   case constant-expression  :
      statement(s);
      break; /* optional */
  
   /* you can have any number of case statements */
   default : /* Optional */
   statement(s);
}
```

`switch` 语句必须遵循下面的规则：

- `switch` 语句中的 `expression` 是一个常量表达式，必须是一个整型或枚举类型；
- 在一个 `switch` 中可以有任意数量的 `case` 语句。每个 `case` 后跟一个要比较的值和一个冒号；
- `case` 的 *constant-expression* 必须与 `switch` 中的变量具有相同的数据类型，且**必须是一个常量或字面量**。
- 当被测试的变量等于 `case` 中的常量时，`case` 后跟的语句将被执行，直到遇到 `break` 语句为止；
- 当遇到 `break` 语句时，`switch` 终止，控制流将跳转到 `switch` 语句后的下一行；
- 不是每一个 `case` 都需要包含 `break`。如果 `case` 语句不包含 `break`，控制流将会继续后续的 `case`，直到遇到 `break` 为止；
- 一个 `switch` 语句可以有一个可选的 **default** case，出现在 `switch` 的结尾。`default` 可用于在上面所有 `case` 都不为真时执行一个任务；
- `default` 中的 `break` 语句不是必需的。

**流程图**

![C语言switch语句](https://static.getiot.tech/c-switch-statement.jpg#center)

**示例代码**

```c showLineNumbers
#include <stdio.h>
 
int main(void)
{
   /* local variable definition */
   char grade = 'B';

   switch (grade) {
      case 'A' :
         printf("Excellent!\n" );
         break;
      case 'B' :
      case 'C' :
         printf("Well done\n" );
         break;
      case 'D' :
         printf("You passed\n" );
         break;
      case 'F' :
         printf("Better try again\n" );
         break;
      default :
         printf("Invalid grade\n" );
   }
   
   printf("Your grade is  %c\n", grade );
 
   return 0;
}
```

编译、执行上述代码，输出结果如下：

```bash
Well done
Your grade is B
```



## 嵌套 switch 语句

`switch` 语句也是可以嵌套使用的，你可以在一个 `switch` 语句内使用另一个 `switch` 语句，即使内部和外部 `switch` 的 `case` 常量包含共同的值，也没有矛盾。

**语法**

C 语言嵌套 `switch` 语句的语法如下：

```c showLineNumbers
switch (ch1) {

   case 'A': 
      printf("This A is part of outer switch" );
		
      switch (ch2) {
         case 'A':
            printf("This A is part of inner switch" );
            break;
         case 'B': /* case code */
      }
	  
      break;
   case 'B': /* case code */
}
```

**示例代码**

```c showLineNumbers
#include <stdio.h>
 
int main(void)
{
   /* local variable definition */
   int a = 100;
   int b = 200;
 
   switch (a) {
   
      case 100: 
         printf("This is part of outer switch\n", a );
      
         switch (b) {
            case 200:
               printf("This is part of inner switch\n", a );
         }
   }
   
   printf("Exact value of a is : %d\n", a );
   printf("Exact value of b is : %d\n", b );
 
   return 0;
}
```

编译、执行上述代码，输出结果如下：

```bash
This is part of outer switch
This is part of inner switch
Exact value of a is : 100
Exact value of b is : 200
```



## 三目运算符 ? :

我们在 [C语言运算符](/c/c-operators/) 章节中有简单介绍过 **条件运算符 `? :`**，它可以用来替代 `if...else` 语句。它的一般形式如下：

```c showLineNumbers
Exp1 ? Exp2 : Exp3;
```

这里的 `Exp1`、`Exp2` 和 `Exp3` 都是表达式，由问号 `?` 和冒号 `:` 分隔。

`?` 表达式的值由 `Exp1` 决定：

- 如果 `Exp1` 为 **true**，则计算 `Exp2` 的值，`Exp2` 的结果即为整个表达式的值；
- 如果 `Exp1` 为 **false**，则计算 `Exp3` 的值，`Exp3` 的结果即为整个表达式的值。

