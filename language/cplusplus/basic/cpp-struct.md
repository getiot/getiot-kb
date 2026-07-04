---
sidebar_position: 27
slug: /cpp-struct
---

# C++ 结构体



在 C++ 中，结构体（struct）指的是一种数据结构，是 C++ 中聚合数据类型（aggregate data type）的一类。结构体可以被声明为变量、指针或数组等，用以实现较复杂的数据结构。



## 结构体的意义

我们知道，C++ 中的数组可以存储多个相同类型的数据，但它无法存储不同类型的数据，比如：

```cpp showLineNumbers
int a[4];

a[0] = 1;
a[1] = 2;
a[2] = 3.14;     // 错误，类型不同
a[3] = "Hello";  // 错误，类型不同
```

如果我们要定义一本书的标题、作者、分类、出版时间、书号（ISBN），一般会怎么做呢？

```cpp showLineNumbers
char* title;
char* author;
char* category;
int isbn;
```

如果有很多书，那么可能会这样做：

```cpp showLineNumbers
char* title_1;
char* author_1;
char* category_1;
int isbn_1;

char* title_2;
char* author_2;
char* category_2;
int isbn_2;
```

变量个数 = 书本的数量 x 4，想象下有 100 本，那将有 400 个变量。当然了，还有优化的余地，比如说用数组：

```cpp showLineNumbers
char* title[100];
char* author[100];
char* category[100];

int isbn[100];
```

是不是感觉很别扭？填充的时候万一开了个小差，数据就全乱了，难道就不能这样子：

```cpp showLineNumbers
Book = {
    char* title;
    char* author;
    char* category;
    int   isbn;
}
```

把它们放在一起，然后取个名字 `Book`，然后在创建一个数组：

```cpp showLineNumbers
Book book[100];
```

没错，结构体（`struct`）就因此而诞生了！

结构体是 C++ 中另一种用户自定义的可用的数据类型，允许存储不同类型的数据项。我们可以理解为，结构体就是一些元素的集合，而这些元素称为结构体的成员（member），这些成员的类型可以相同，也可以不同，成员一般用名字访问。



## 定义结构体

C++ 提供了关键字 `struct` 用于定义一个结构体。语法格式如下：

```cpp showLineNumbers
struct type_name {
    fieldType1 filed1;
    fieldType2 filed2;
    fieldType3 filed3;
    ...
} object_names;
```

这里使用 struct 定义了一个结构体 `type_name`，该结构体有三个字段（成员），名分别为 filed1、filed2 和 filed3，它们的类型分别为 fieldType1、fieldType2 和 fieldType3。

结构体的定义需要注意以下几点：

1. 以 `struct` 关键字开头
2. 然后是结构体的名字 `type_name`
3. 紧接着用大括号把一些变量定义扩起来
4. 大括号之后可以有选择性的定义一个该结构体的名字（`object_names`）
5. 最后的分号（`;`）是必须的

我们可以看到，因为分号的存在，所以这只是一个语句，我们姑且称之为 `struct` 语句吧。`struct` 语句定义了一个包含多个成员的新的复合数据类型。

下面我们就用 `struct` 语句来解决我们前面提出的定义一本书的问题：

```cpp showLineNumbers
struct Book {
    const char*  title;
    const char*  author;
    const char*  category;
    int          isbn;
};
```

现在，我们就可以使用 `Book` 类型来定义一个书的变量了！



## 定义结构体变量

定义一个结构体变量和定义一个基本类型的变量没什么太大区别，唯一不同是要加上 `struct` 关键字。

```cpp showLineNumbers
int age = 27;       // 定义一个基本类型 int 的变量 age
struct Book book1;  // 定义一个结构体 Book 的变量 book1
```

当然了，C++ 的设计者肯定也会想到了我们很懒，所以去掉 `struct` 关键字也是可以的！

```cpp showLineNumbers
Book book2;         // 定义一个结构体 Book 的变量 book2
```

另外，也可以在定义结构体 `Book` 的时候顺便定义变量，多个变量间用逗号（`,`）隔开。

```cpp showLineNumbers
struct Book {
    const char*  title;
    const char*  author;
    const char*  category;
    int          isbn;
} book1, book2;
```



## 访问结构成员

在 C++ 中，可以使用成员运算符（`.` 和 `->`）来访结构体变量的成员。它们区别是，点（`.`）用于对象和成员之间的连接，而箭头（`->`）用于对象指针和成员之间的连接。

例如，要访问变量 `book1` 对象的 `author` 变量，可以使用 `book1.author`，假如 `book2` 是指针，则使用 `book2->author`。通过下面示例可以加深理解。

```cpp showLineNumbers
#include <iostream>
using namespace std;

// 定义一个结构体 Book，顺带定义一个 book1 实例和一个 book2 指针
struct Book {
    const char*  title;
    const char*  author;
    const char*  category;
    int          isbn;
} book1, *book2;

int main(void)
{
    book2 = &book1;
    
    book1.title    = "C++ 基础教程";
    book1.author   = "人人都懂物联网";
    book1.category = "IT 技术";
    book1.isbn     = 12345678;
    
    cout << "《" << book1.title << "》" << "的编号是: " << book1.isbn;
    cout << " , 放在书架 " << book1.category;
    cout << " , 作者是："  << book1.author << endl;
    
    book2->title    = "C++ 高级教程";
    book2->author   = "GetIoT";
    book2->category = "物联网";
    book2->isbn     = 87654321;

    cout << "《" << book1.title << "》" << "的编号是: " << book1.isbn;
    cout << " , 放在书架 " << book1.category;
    cout << " , 作者是："  << book1.author << endl;

    return 0;
}
```

编译和运行以上示例，输出结果如下：

```bash
《C++ 基础教程》的编号是: 12345678 , 放在书架 IT 技术 , 作者是：人人都懂物联网
《C++ 高级教程》的编号是: 87654321 , 放在书架 物联网 , 作者是：GetIoT
```



## 结构体作为函数参数

既然自定义的结构体也是一种数据类型，那么它当然也可以作为函数的参数。

示例：

```cpp showLineNumbers
#include <iostream>
using namespace std;

// 定义一个结构体 Book，顺带定义一个 book1 实例和一个 book2 指针
struct Book {
    const char*  title;
    const char*  author;
    const char*  category;
    int          isbn;
} book1, *book2;

// 定义一个函数用于打印结构体 Book 的信息
void show_book(struct Book &book)
{
    cout << "《" << book.title << "》" << "的编号是: " << book.isbn;
    cout << " , 放在书架 " << book.category;
    cout << " , 作者是："  << book.author << endl;
}

int main(void)
{
    book2 = &book1;
    
    book1.title    = "C++ 基础教程";
    book1.author   = "人人都懂物联网";
    book1.category = "IT 技术";
    book1.isbn     = 12345678;
    
    show_book(book1);
    
    book2->title    = "C++ 高级教程";
    book2->author   = "GetIoT";
    book2->category = "物联网";
    book2->isbn     = 87654321;

    show_book(book1);

    return 0;
}
```

编译和运行以上示例，输出结果如下：

```cpp showLineNumbers
《C++ 基础教程》的编号是: 12345678 , 放在书架 IT 技术 , 作者是：人人都懂物联网
《C++ 高级教程》的编号是: 87654321 , 放在书架 物联网 , 作者是：GetIoT
```



## 指向结构体的指针

前面示例中的 `book2` 其实就是结构体指针，在 C++ 中，结构体指针的定义与使用和基本数据类型的指针类似。例如：

```cpp showLineNumbers
struct Book *ptr_book;
```

这样，我们就可以在 `ptr_book` 中存储结构体 Book 变量的地址了。而获取结构体变量的地址也是使用 `&` 取址符。

```cpp showLineNumbers
ptr_book = &book1;
```

当然，访问结构体指针中的成员变量时，就不能再用点符号（`.`）了，必须使用箭头（`->`）代替。

```cpp showLineNumbers
ptr_book->title;
```


