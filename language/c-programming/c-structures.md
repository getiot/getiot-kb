---
sidebar_position: 22
draft: true
---

# C 语言 - 结构体



Arrays allow to define type of variables that can hold several data items of the same kind. Similarly **structure** is another user defined data type available in C that allows to combine data items of different kinds.

Structures are used to represent a record. Suppose you want to keep track of your books in a library. You might want to track the following attributes about each book −

- Title
- Author
- Subject
- Book ID

## Defining a Structure

To define a structure, you must use the **struct** statement. The struct statement defines a new data type, with more than one member. The format of the struct statement is as follows −

```
struct [structure tag] {

   member definition;
   member definition;
   ...
   member definition;
} [one or more structure variables];  
```

The **structure tag** is optional and each member definition is a normal variable definition, such as int i; or float f; or any other valid variable definition. At the end of the structure's definition, before the final semicolon, you can specify one or more structure variables but it is optional. Here is the way you would declare the Book structure −

```
struct Books {
   char  title[50];
   char  author[50];
   char  subject[100];
   int   book_id;
} book;  
```

## Accessing Structure Members

To access any member of a structure, we use the **member access operator (.)**. The member access operator is coded as a period between the structure variable name and the structure member that we wish to access. You would use the keyword **struct** to define variables of structure type. The following example shows how to use a structure in a program −

[ Live Demo](http://tpcg.io/7DL5Jk)

```
#include <stdio.h>
#include <string.h>
 
struct Books {
   char  title[50];
   char  author[50];
   char  subject[100];
   int   book_id;
};
 
int main( ) {

   struct Books Book1;        /* Declare Book1 of type Book */
   struct Books Book2;        /* Declare Book2 of type Book */
 
   /* book 1 specification */
   strcpy( Book1.title, "C Programming");
   strcpy( Book1.author, "Nuha Ali"); 
   strcpy( Book1.subject, "C Programming Tutorial");
   Book1.book_id = 6495407;

   /* book 2 specification */
   strcpy( Book2.title, "Telecom Billing");
   strcpy( Book2.author, "Zara Ali");
   strcpy( Book2.subject, "Telecom Billing Tutorial");
   Book2.book_id = 6495700;
 
   /* print Book1 info */
   printf( "Book 1 title : %s\n", Book1.title);
   printf( "Book 1 author : %s\n", Book1.author);
   printf( "Book 1 subject : %s\n", Book1.subject);
   printf( "Book 1 book_id : %d\n", Book1.book_id);

   /* print Book2 info */
   printf( "Book 2 title : %s\n", Book2.title);
   printf( "Book 2 author : %s\n", Book2.author);
   printf( "Book 2 subject : %s\n", Book2.subject);
   printf( "Book 2 book_id : %d\n", Book2.book_id);

   return 0;
}
```

When the above code is compiled and executed, it produces the following result −

```
Book 1 title : C Programming
Book 1 author : Nuha Ali
Book 1 subject : C Programming Tutorial
Book 1 book_id : 6495407
Book 2 title : Telecom Billing
Book 2 author : Zara Ali
Book 2 subject : Telecom Billing Tutorial
Book 2 book_id : 6495700
```

## Structures as Function Arguments

You can pass a structure as a function argument in the same way as you pass any other variable or pointer.

[ Live Demo](http://tpcg.io/1Kk8Zs)

```
#include <stdio.h>
#include <string.h>
 
struct Books {
   char  title[50];
   char  author[50];
   char  subject[100];
   int   book_id;
};

/* function declaration */
void printBook( struct Books book );

int main( ) {

   struct Books Book1;        /* Declare Book1 of type Book */
   struct Books Book2;        /* Declare Book2 of type Book */
 
   /* book 1 specification */
   strcpy( Book1.title, "C Programming");
   strcpy( Book1.author, "Nuha Ali"); 
   strcpy( Book1.subject, "C Programming Tutorial");
   Book1.book_id = 6495407;

   /* book 2 specification */
   strcpy( Book2.title, "Telecom Billing");
   strcpy( Book2.author, "Zara Ali");
   strcpy( Book2.subject, "Telecom Billing Tutorial");
   Book2.book_id = 6495700;
 
   /* print Book1 info */
   printBook( Book1 );

   /* Print Book2 info */
   printBook( Book2 );

   return 0;
}

void printBook( struct Books book ) {

   printf( "Book title : %s\n", book.title);
   printf( "Book author : %s\n", book.author);
   printf( "Book subject : %s\n", book.subject);
   printf( "Book book_id : %d\n", book.book_id);
}
```

When the above code is compiled and executed, it produces the following result −

```
Book title : C Programming
Book author : Nuha Ali
Book subject : C Programming Tutorial
Book book_id : 6495407
Book title : Telecom Billing
Book author : Zara Ali
Book subject : Telecom Billing Tutorial
Book book_id : 6495700
```

## Pointers to Structures

You can define pointers to structures in the same way as you define pointer to any other variable −

```
struct Books *struct_pointer;
```

Now, you can store the address of a structure variable in the above defined pointer variable. To find the address of a structure variable, place the '&'; operator before the structure's name as follows −

```
struct_pointer = &Book1;
```

To access the members of a structure using a pointer to that structure, you must use the → operator as follows −

```
struct_pointer->title;
```

Let us re-write the above example using structure pointer.

[ Live Demo](http://tpcg.io/WOoGiV)

```
#include <stdio.h>
#include <string.h>
 
struct Books {
   char  title[50];
   char  author[50];
   char  subject[100];
   int   book_id;
};

/* function declaration */
void printBook( struct Books *book );
int main( ) {

   struct Books Book1;        /* Declare Book1 of type Book */
   struct Books Book2;        /* Declare Book2 of type Book */
 
   /* book 1 specification */
   strcpy( Book1.title, "C Programming");
   strcpy( Book1.author, "Nuha Ali"); 
   strcpy( Book1.subject, "C Programming Tutorial");
   Book1.book_id = 6495407;

   /* book 2 specification */
   strcpy( Book2.title, "Telecom Billing");
   strcpy( Book2.author, "Zara Ali");
   strcpy( Book2.subject, "Telecom Billing Tutorial");
   Book2.book_id = 6495700;
 
   /* print Book1 info by passing address of Book1 */
   printBook( &Book1 );

   /* print Book2 info by passing address of Book2 */
   printBook( &Book2 );

   return 0;
}

void printBook( struct Books *book ) {

   printf( "Book title : %s\n", book->title);
   printf( "Book author : %s\n", book->author);
   printf( "Book subject : %s\n", book->subject);
   printf( "Book book_id : %d\n", book->book_id);
}
```

When the above code is compiled and executed, it produces the following result −

```
Book title : C Programming
Book author : Nuha Ali
Book subject : C Programming Tutorial
Book book_id : 6495407
Book title : Telecom Billing
Book author : Zara Ali
Book subject : Telecom Billing Tutorial
Book book_id : 6495700
```

## Bit Fields

Bit Fields allow the packing of data in a structure. This is especially useful when memory or data storage is at a premium. Typical examples include −

- Packing several objects into a machine word. e.g. 1 bit flags can be compacted.
- Reading external file formats -- non-standard file formats could be read in, e.g., 9-bit integers.

C allows us to do this in a structure definition by putting :bit length after the variable. For example −

```
struct packed_struct {
   unsigned int f1:1;
   unsigned int f2:1;
   unsigned int f3:1;
   unsigned int f4:1;
   unsigned int type:4;
   unsigned int my_int:9;
} pack;
```

Here, the packed_struct contains 6 members: Four 1 bit flags f1..f3, a 4-bit type and a 9-bit my_int.

C automatically packs the above bit fields as compactly as possible, provided that the maximum length of the field is less than or equal to the integer word length of the computer. If this is not the case, then some compilers may allow memory overlap for the fields while others would store the next field in the next word.



## 结构体定义

定义结构体变量的一般形式如下：

**形式１：先定义结构体类型，再定义变量**

```c showLineNumbers
struct 结构体标识符
{
    成员变量列表;…
};
struct 结构体标识符 *指针变量名;
```

变量初始化：

```c showLineNumbers
struct 结构体标识符 变量名={初始化值1，初始化值2，…，初始化值n };
```



**形式２：在定义类型的同时定义变量**

```c showLineNumbers
struct 结构体标识符
{
    成员变量列表;…
} *指针变量名;
```



**形式３：直接定义变量，用无名结构体直接定义变量只能一次**

```c showLineNumbers
struct
{
    成员变量列表;…
} *指针变量名;
```

其中“指针变量名”为结构体指针变量的名称。形式1是先定义结构体，然后再定义此类型的结构体指针变量；形式２和形式3是在定义结构体的同时定义此类型的结构体指针变量。



### 简单结构体的赋值

先说结论：一般来说，C语言中的结构体变量可以用另一个变量对其进行赋值或初始化。简单结构体（不包含指针成员）直接赋值没有问题。
我们先下面一段代码：

```c showLineNumbers
#include <stdio.h>
#include <stdlib.h>

struct MyStruct
{
    int a;
    int b;
    char c[10];
};

int main()
{
    struct MyStruct t1 = {1, 2, "hello"};
    struct MyStruct t2 = {3, 4, "world"};
    t2 = t1; //将t1赋值给t2
    printf("MyStruct t1: %d, %d, %s\n", t1.a, t1.b, t1.c);
    printf("MyStruct t2: %d, %d, %s\n", t2.a, t2.b, t2.c);
    return 0;
}
```

以上代码的输出为：

```c showLineNumbers
MyStruct t1: 1, 2, hello
MyStruct t2: 1, 2, hello
```

以上用t1给t2进行初始化，结果也相同。可以看到简单的结构体（结构体的成员没有指针成员）变量之间直接赋值是没有问题的。

### 有指针成员的结构体赋值

而通常情况下，稍微复杂一点的结构体里面会有指针成员，那么以上的浅拷贝则会有问题了，我们假设MyStruct里面的成员c不是数组，而是字符指针，会有什么问题呢？ 看如下代码：

```c showLineNumbers
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
struct MyStruct
{
    int a;
    int b;
    char* c;
};
int main()
{
    struct MyStruct t1;
    t1.a = 1;
    t1.b = 2;
    // 为指针区域赋值
    char *p = (char*)malloc(10*sizeof(char));
    strcpy(p, "hello");
    t1.c = p;
    struct MyStruct t2;
    t2 = t1;
    printf("MyStruct t1: %d, %d, %s\n", t1.a, t1.b, t1.c);
    // 释放了t1的内存
    // free(p);
    printf("MyStruct t2: %d, %d, %s\n", t2.a, t2.b, t2.c);
    printf("t1 pointer addr: %p\n", t1.c);
    printf("t2 pointer addr: %p\n", t2.c);
    return 0;
}
```

上面的输出结果为：

```c showLineNumbers
MyStruct t1: 1, 2, hello
MyStruct t2: 1, 2, hello
t1 pointer addr: 0x6000284d0
t2 pointer addr: 0x6000284d0
```

可以看到，赋值会直接将t1的指针变量赋值给t2.c，如果我们在赋值之后将t1所用的资源释放掉，那么使用t2的话则可能导致内存泄漏了。如果上面的代码，我们没有注释掉 free(p);，那么输出t2时结果这不确定了：

```c showLineNumbers
MyStruct t1: 1, 2, hello
MyStruct t2: 1, 2, (/.?
t1 pointer addr: 0x6000284d0
t2 pointer addr: 0x6000284d0
```

所以，如果struct中有指针成员，那么结构体赋值不能简单的直接复制了，而需要为指针成员另外分配内存，并将数据拷贝过去，当然我们可以将这些处理封装在单独的函数中来完成。 示例代码如下：

```c showLineNumbers
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
struct MyStruct
{
    int a;
    int b;
    char* c;
};
int main()
{
    struct MyStruct t1;
    t1.a = 1;
    t1.b = 2;
    // 为指针区域赋值
    char *p = (char*)malloc(10*sizeof(char));
    strcpy(p, "hello");
    t1.c = p;
    struct MyStruct t2;
    // 各个成员分别赋值，可以进行封装
    t2.a = t1.a;
    t2.b = t1.b;
    char *p2 = (char*)malloc(10*sizeof(char));
    strcpy(p2, t1.c);
    t2.c = p2;
    printf("MyStruct t1: %d, %d, %s\n", t1.a, t1.b, t1.c);
    // 释放了t1的内存
    free(p);
    printf("MyStruct t2: %d, %d, %s\n", t2.a, t2.b, t2.c);
    // 释放了t2的内存
    free(p2);
    printf("t1 pointer addr: %p\n", t1.c);
    printf("t2 pointer addr: %p\n", t2.c);
    return 0;
}
```

以上代码输出结果为：

```c showLineNumbers
MyStruct t1: 1, 2, hello
MyStruct t2: 1, 2, hello
t1 pointer addr: 0x6000284d0
t2 pointer addr: 0x600062e10
```





## 参考

- [结构体中定义函数指针 - 聚散流沙的独白 - 博客园 (cnblogs.com)](https://www.cnblogs.com/lvjunjie/p/8961731.html)
