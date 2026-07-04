---
sidebar_position: 44
draft: true
---

# C 语言 - goto 语句



合格的程序员知道遵守“新手最佳实践”，优秀的程序员知道何时打破“最佳实践”。



A **goto** statement in C programming provides an unconditional jump from the 'goto' to a labeled statement in the same function.

**NOTE** − Use of **goto** statement is highly discouraged in any programming language because it makes difficult to trace the control flow of a program, making the program hard to understand and hard to modify. Any program that uses a goto can be rewritten to avoid them.

## 语法

The syntax for a **goto** statement in C is as follows −

```
goto label;
..
.
label: statement;
```

Here **label** can be any plain text except C keyword and it can be set anywhere in the C program above or below to **goto** statement.

## 流程图

![C goto statement](./images/c-goto-statement.jpg)

## 示例代码

```c showLineNumbers
#include <stdio.h>
 
int main () {

   /* local variable definition */
   int a = 10;

   /* do loop execution */
   LOOP:do {
   
      if( a == 15) {
         /* skip the iteration */
         a = a + 1;
         goto LOOP;
      }
		
      printf("value of a: %d\n", a);
      a++;

   }while( a < 20 );
 
   return 0;
}
```

When the above code is compiled and executed, it produces the following result −

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

