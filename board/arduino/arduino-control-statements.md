---
sidebar_position: 7
authors: [luhuadong]
---

# Arduino 控制语句



程序的执行有三种基本结构：顺序结构、选择结构、循环结构。三种结构可以相互嵌套，实现多种多样的控制流程。

顺序结构是最基本、最简单的程序组织结构。在顺序结构中，程序按语句的先后顺序依次执行。比如 Arduino 的程序框架就是顺序结构，先执行 setup() 函数，再执行 loop() 函数。

![](https://static.getiot.tech/arduino-sequence.png#center)

控制语句是源代码中控制程序执行流程的元素，是实现业务逻辑和控制功能必不可少的语句。下面我们着重来学习 Arduino 中的选择语句和循环语句。



## 选择语句

选择结构又称为判断结构或分支结构。在计算机编程中，经常需要根据当前数据做出判断，以决定下一步的操作。

选择结构在程序设计中非常实用。例如，Arduino 通过连接气体传感器，获取可燃气体浓度，并对浓度值做出判断，当可燃气体浓度过高，则向用户发出警报信号。

在 Arduino 编程中，选择语句有以下两种形式。



### if... else 语句

if... else 语句是最常用的选择结构实现方式，当给定的表达式为真时，就会运行其后的语句；而当给定的表达式为假时，则运行 else 后面的语句。根据 if 语句的分支情况，又可分为三种结构形式。

- **简单分支结构**

  ```cpp showLineNumbers
  if (表达式)
  {
      语句;
  }
  ```

- **双分支结构**

  ```cpp showLineNumbers
  if (表达式)
  {
      语句1;
  }
  else
  {
      语句2;;
  }
  ```

- **多分支结构**

  ```cpp showLineNumbers
  if (表达式)
  {
      语句1;
  }
  else if (表达式2)
  {
      语句2;
  }
  else if (表达式3)
  {
      语句3;
  }
  ...
  else
  {
      语句n;
  }
  ```

选择结构（if... else 语句）的设计重点在于，它要求开发者指定要由程序评估或测试的一个或多个条件，以及条件为真时要执行的语句（必需的）和条件为假时要执行的语句（可选的）。



### switch... case 语句

当处理比较复杂的问题，或者分支特别多的情况时，使用 if 语句会导致许多 else if 块，使程序显得冗长，且可读性差。此时选择 switch...  case 语句是一种更好的选择。

```cpp showLineNumbers
switch (表达式)
{
    case 常量表达式1:
         语句1;
         break;
    case 常量表达式2:
         语句2;
         break;
    case 常量表达式3:
         语句3;
         break;
    ...
    default :
         语句n;
         break;
}
```

需要注意，switch 后的表达式的结果必须是整型或字符型，如果必须使用其他类型，则应当使用 if... else 语句。

选择结构 switch 语句后的表达式会与 case 后的常量表达式进行逐一比较，如果匹配，则运行对应 case 中的语句，遇到 break 后退出 switch 结构。如果都不匹配，则运行 default 中的语句。



## 循环语句

在 Arduino 编程中，使用关键字 for 和 while 表示循环语句，while 语句根据先判断还是先执行又可分为两种情况。因此，共有三种循环结构形式。

### for 循环

for 循环非常灵活，循环次数确定或不确定的情况都适用。其一般形式为：

```cpp showLineNumbers
for (表达式1; 表达式2; 表达式3)
{
    语句;
}
```

for 语句后可接三个表达式：

- 表达式1 为 for 循环初始化语句；
- 表达式2 为判断语句；
- 表达式3 为每次循环执行后自动执行的语句（通常为增量语句）。

例如：

```cpp showLineNumbers
for (i=0; i<10; i++)
{
    Serial.print(i);
}
```

for 语句的三个表达式都是可选的，省略所有表达式条件，则表示死循环（无限循环）。

```cpp showLineNumbers
for (;;)
{
    语句;
}
```



### while 循环

while 语句是一种“当”型循环。即当满足 while 后的表达式条件时，才会执行循环体中的语句。其一般形式如下：

```cpp showLineNumbers
while (表达式)
{
    语句;
}
```

有时候，我们需要将程序放在死循环中，就可以利用 while 语句来实现。例如：

```cpp showLineNumbers
while (1)
{
    语句;
}
```

或者

```cpp showLineNumbers
while (true)
{
    语句;
}
```



### do... while 循环

do... while 语句是一种“直到”型循环。即它会一直循环执行，直到 while 给定的表达式条件不成立为止。

```cpp showLineNumbers
do
{
    语句;
}
while (表达式);
```

也就是说，无论如何都会先执行一次 do 语句中的循环体，再判断是否进入下一次循环。



## 循环控制语句

虽然可以在 for 语句和 while 语句的表达式中判断是否进入下一次循环，但有时候却需要提前结束循环，或者跳过本次循环。这时候就需要使用关键字 break 和 continue 来改变程序执行流程。

### break

break 语句可用于 switch 选择结构和所有循环结构，使用 break 可以终止（跳出）当前的控制块，继续执行该控制块后续的代码。在循环结构中，通常会搭配 if 语句判断，是否达到退出条件。例如：

```cpp showLineNumbers
while (1)
{
    语句;
    
    if (表达式) 
        break;
}
```

### continue

continue 语句只能用于循环结构中，与 break 不同，continue 只是跳过本次循环中剩余的语句，并且判断是否开始下一次循环。例如：

```cpp showLineNumbers
while (1)
{
    语句1;
    
    if (表达式)
        continue;
  
    语句2;
}
```

当触发 continue 条件时，会跳过语句2，跳回到 while 处决定是否进入下一次循环。

