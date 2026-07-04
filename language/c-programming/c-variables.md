---
sidebar_position: 7
---

# C 语言 - 变量



在 C 程序中，变量（variable）只不过是我们的程序可以操作的存储区域的名称。C 程序中的每个变量都有一个特定的数据类型，它决定了变量内存的大小和布局、该内存中可以存储的值的范围，以及可以应用于变量的操作集。



## 变量命名规则

C 语言的变量名遵循标识符命名规则，可以是字母、数字和下划线（`_`）的组合。但必须满足以下规则：

- 变量名的开头必须是字母或下划线，不能是数字。
- 变量名中的字母是区分大小写的。比如 a 和 A 是不同的变量名，num 和 Num 也是不同的变量名。
- 变量名绝对不可以是C语言关键字，想知道 C 语言都有哪些关键字，可以点击[这里](/c/c-keywords/)查看。

虽然允许以下划线开头，但并不建议使用，因为以下划线开头的变量名通常是系统专用的。



## 变量的定义

在 C 语言中，变量要“先定义，再使用”。变量定义的作用是告诉编译器在何处以及为变量创建多少存储空间。

定义变量时，需要指定一种数据类型和包含该类型的一个或多个变量的列表，如下所示：

```c showLineNumbers
type variable_list;
```

这里，*type* 必须是有效的 C 数据类型，包括 char、int、float、double 或任何用户定义的对象；*variable_list* 可以由一个或多个以逗号分隔的标识符名称组成。

下面是声明变量的一些示例：

```c showLineNumbers
int    i, j, k;
char   c, ch;
float  f, salary;
double d;
```

在上述示例，`int i, j, k;` 行声明并定义了变量 `i`、`j` 和 `k`，它指示编译器创建名为 `i`、`j` 和 `k` 的 `int` 类型变量。

变量可以在其声明中初始化（分配初始值）。初始化器由一个等号后跟一个常量表达式组成，如下所示：

```c showLineNumbers
type variable_name = value;
```

下面是变量定义和初始化的一些示例：

```c showLineNumbers
extern int d = 3, f = 5;    // declaration of d and f. 
int d = 3, f = 5;           // definition and initializing d and f. 
byte z = 22;                // definition and initializes z. 
char x = 'x';               // the variable x has the value 'x'.
```

对于没有初始化的变量，如果是具有静态存储持续时间的变量隐式初始化为 NULL（所有字节的值为 0），除此之外其他变量的初始值均未定义（undefined）。与变量的存储类型和作用域有关，这部分内容在后续章节会进一步讲解。



## 变量的声明

变量声明向编译器保证存在具有给定类型和名称的变量，以便编译器可以继续进行进一步编译，而不需要有关该变量的完整详细信息。变量定义仅在编译时才有意义，编译器在链接程序时需要实际的变量定义。

当使用多个文件并且在链接程序时可用的文件之一中定义变量时，变量声明非常有用。我们可以使用关键字 `extern` 在任何地方声明变量。需要注意，尽管可以在 C 程序中多次声明一个变量，但它只能在文件、函数或代码块中定义一次。

尝试以下示例，其中变量已在顶部声明，但它们已在主函数内定义和初始化 -

```c showLineNumbers
#include <stdio.h>

// variable declaration:
extern int a, b;
extern int c;
extern float f;

int main(void)
{
   /* variable definition: */
   int a, b;
   int c;
   float f;
 
   /* actual initialization */
   a = 10;
   b = 20;
  
   c = a + b;
   printf("value of c : %d \n", c);

   f = 70.0/3.0;
   printf("value of f : %f \n", f);
 
   return 0;
}
```

当上面的代码被编译并执行时，输出结果如下：

```c showLineNumbers
value of c : 30
value of f : 23.333334
```

相同的概念适用于函数声明，在声明时只需要提供函数原型（名称、返回值、参数列表），而函数的定义（具体实现）可以在其他任何地方给出。例如：

```c showLineNumbers
// function declaration
int func();

int main() {

   // function call
   int i = func();
}

// function definition
int func() {
   return 0;
}
```



## 定义和声明

在 C 语言中，变量的定义（Definition）和声明（Declaration）有以下区别：

- **定义** —— 所谓的定义就是编译器创建一个对象，为这个对象分配一块内存并给它取上一个名字，这个名字就是我们所说的变量名/对象名。这个名字一旦和这块内存匹配起来，它们就同生共死，终生不离不弃，并且这块内存的位置也不能被改变。一个变量或对象在一定区域内（涉及作用域和生命周期）只能被定义一次，如果定义多次，编译器会提示你重复定义同一个变量或对象。
- **声明** —— 告诉编译器，这个名字已经匹配到一块内存上了，所以你不能再用它作为将要定义的变量名/对象名。和变量的定义不同，变量的声明是可以出现多次的，并且在多个源文件中使用该变量之前都应该先声明。



## 左值和右值

C 语言中有两种表达式，即左值（lvalue）表达式和右值（rvalue）表达式，它们的区别如下：

- **左值**：引用内存位置的表达式称为“左值”表达式。左值可以显示为赋值的左侧或右侧。
- **右值**：右值是指存储在内存中某个地址的数据值。右值是一个不能赋值的表达式，这意味着右值可以出现在赋值号的右侧，但不能出现在左侧。

变量是左值，因此它们可能出现在赋值语句的左侧。数字常量是右值，因此它们可能不会被赋值，也不能出现在左侧。

```c showLineNumbers
int g = 20; // valid statement

10 = 20; // invalid statement; would generate compile-time error
```

