---
sidebar_position: 49
authors: [luhuadong]
---

# Linux 内核链表



## 概述

Linux 内核提供了一个经典通用的双向循环链表 list 的实现，任何模块都可以借助该接口实现自己的内部循环链表。因为是通用的，可以直接移植到用户态中使用，下面介绍相关的接口与一个简单操作例子，包括链表的插入、查询、修改和删除操作。想深入了解的话直接阅读内核list源代码，代码不是很多，只有 list.h 和 types.h。内核源码可以直接下载也可以使用下文给出的链接。

内核定义了链表的结构体，任何链表的实现只要在相关结构体中包含下面这个结构体就可以使用。

```c showLineNumbers
struct list_head {
	struct list_head *next, *prev;
}; 
```



### 链表组织

内核链表一般就是在一个结构体有一个结构体成员变量，该结构体成员变量只有 next 和 prev两个指针，分别指向下一个结点和上一个结构，就像一条绳子串起所有的结构体，这样做的好处，就是可以用内核链表来串起各个不同类型的结构体。

![](https://static.getiot.tech/linux-kernel-double-linked-list.png#center)



## 链表 APIs

### 创建链表

链表头的初始化有两种， 初始化完成就相当于创建了一个链表，接下来就可以进行对链表的增删查改操作。

```c showLineNumbers
LIST_HEAD(name)  //name就是链表头的名字，该宏会自动定义一个名字为name 的 list_head 结构体。
```

第二种如下，先声明一个list_head变量，然后使用该宏初始化

```c showLineNumbers
struct list_head head;    //声明链表头
INIT_LIST_HEAD(&head);    //链表头初始化
```

### 插入链表

```c showLineNumbers
list_add(struct list_head *new, struct list_head *head)        //加入链表头部
list_add_tail(struct list_head *new, struct list_head *head)   //加入到链表尾部
```

### 遍历链表

```c showLineNumbers
list_for_each(pos, head)      //向前遍历链表，可以结合list_entry()接口对数据操作
list_for_each_prev(pos, head) //向后遍历
list_for_each_entry(pos, head, member)  //向前遍历
list_for_each_entry_reverse(pos, head, member) //向后遍历
list_for_each_safe(pos, n, head)    //如果在遍历过程中涉及结点删除操作，则需要使用这个接口
```

list_for_each_entry() 的三个参数分别是：pos（指向member的指针）、head（数据类型结构体头结点）、member（数据类型结构体的一个成员变量）。这个宏可以通过通过一个指针指向一个结构体中一个成员，来返回这个结构体的起始地址。实现这个功能最重要的一个宏是 list_entry()，它的实现如下：

```c showLineNumbers
#define list_entry(ptr, type, member) \
((type *)((char *)(ptr)-(unsigned long)(&((type *)0)->member)))
```





### 删除结点

```c showLineNumbers
list_del(struct list_head *entry)
```

### 其他

在内核list源码中还定义了很多其它的链表操作，这里不再一一列举：

```c showLineNumbers
list_empty(const struct list_head *head)     //判断链表是否为空
```













