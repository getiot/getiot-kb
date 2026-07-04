---
sidebar_position: 15
slug: /cpp-loops
---

# C++ 循环语句



循环语句和前面的条件判断语句，为编程语言提供了更为复杂执行路径的多种控制结构。使用循环语句，可以在程序中多次执行一个语句或语句组，是某一代码块重复运行。

在 C++ 中，同样提供了丰富循环类型，最常见的是 for 和 while 循环语句。

| 循环类型        | 描述                                                      |
| --------------- | --------------------------------------------------------- |
| for 循环        | 多次执行一个语句序列，简化管理循环变量的代码。            |
| while 循环      | 当给定条件为真时，重复语句或语句组。                      |
| do...while 循环 | 除了它是在循环主体结尾测试条件外，其他与 while 语句类似。 |
| 嵌套循环        | 可以在 while、for 或 do..while 循环内使用一个或多个循环。 |



## for 循环

语法：

```cpp showLineNumbers
for (express1; express2; express3)
{
	// statements
}
```

该 for 循环以 express1 做为初始条件，不断执行 statements 里面的代码逻辑，并且每次执行一次循环都会执行 express3，for 循环执行的结束条件是 express2 不再成立。

示例：循环打印三次

```cpp showLineNumbers
int i = 0;
for (i = 0; i < 3; i++)
{
    cout << "i = " << i << endl;
}
```

在该示例中，我们定义了一个 for 循环结构，计数器变量 i 从 0 开始，结束条件是 i < 3，每次执行一次循环都打印出 i 的值，并且将 i 的值加 1。

for 循环语句中的三个表达式都不是必须的。如果没有开始条件和结束条件，就会实现 for 死循环。如下：

```cpp showLineNumbers
for (;;)
{
    // loop forever
}
```

只要不终止程序，程序将会一直执行下去。



## while 循环

C++ 的 while 循环跟 if 条件判断类似，都是在特定条件满足的情况下，执行相对应的代码。不过，while 循环是只要条件满足，会一直执行缩进里面的代码块，这点又类似于 for 循环。

C++ 的 while 循环跟 if 和 for 语句类似，都是使用 `{}` 做为分割符，要执行的代码块都是使用相同的缩进形式。语法如下：

```cpp showLineNumbers
while (condition)
{
	// do something
}
```

当 condition 条件为真时，一直执行缩进里面的代码块，直到 condition 条件为假，循环结束。

示例：

```cpp showLineNumbers
int num = 0;
while (num < 3)
{
    cout << "Num = " << num << endl;
    num = num + 1;
}
```

该示例定义了一个整型类型的变量 num，并且赋值为 0，接着使用 while 循环来判断变量 num 是否小于 3，如果小于，则一直执行 cout 的代码块，并且每次执行后都将 num 变量加 1。



## do...while 循环

do...while 循环跟 while 循环 类似，区别是，不管 do...while 的条件是否为真，do...while 至少会执行一次。

语法：

```cpp showLineNumbers
do{
    //do something 
} while (condition);   
```

当 condition 条件为真时，一直执行 `{}` 里面的代码块，直到 condition 条件为假，循环结束。即使 condition 条件为假，那么 do...while 循环也会执行一次。

示例：

```cpp showLineNumbers
do {
    cout << "Just run once" << endl;
} while(0);
```

我们定义的 do...while 的循环条件为 0，即一直为假，但 do...while 循环还是执行了一次。这是因为不管条件是否为真，do...while 循环至少会执行一次。



## 嵌套循环

C++ 的 while 循环也可以实现嵌套的效果，即 while 循环里面嵌套一个或多个 while 循环。这种写法就类似于 C 语言的 for 循环的嵌套。

语法：

```cpp showLineNumbers
while cond1
{
	// do something
    while cond2
    {
    	// do something
        while cond3
        {
        	// do something
        }
    }
}
```

这里定义了三个 while 循环的嵌套。只要 cond1 为真，就一直执行 cond1 的代码块；只要 cond2 为 真，就一直执行 cond2 的代码块；只要 cond3 为真，就一直执行 cond3 的代码块。

当然，你可以嵌套任意多个的 while 循环，但为了提高代码可读性，建议不要超过 3 层。