---
sidebar_position: 14
slug: /cpp-decision
---

# C++ 判断语句



主流的程序设计语言一般有三大流程控制语句：分别是顺序控制、分支控制和循环控制。利用分支控制和循环控制，可以让程序的执行千变万化，本文先来介绍分支控制。

C++ 编程语言提供了以下类型的判断语句（主要是 if 和 switch 语句），通过判断语句的条件（真或假），决定程序执行的路径或返回值。

![](https://static.getiot.tech/cpp-decision-statement.png#center)



## if 语句

在 C++ 中，关键字 if 是用于测试某个条件的语句是否满足一定的条件，如果满足特定的条件，则会执行 if 后代码块，否则就忽略该代码块继续执行后续的代码。

语法：

```cpp showLineNumbers
if (condition)
{
	//do something
}
```

其中，condition 是条件判断语句，必须返回真或者假。



## if-else 语句

在 C++ 中，关键字 else 是用于在 if 条件不满足的情况下，执行的代码逻辑。

语法：

```cpp showLineNumbers
if (condition)
{
	// do something
}
else
{
	// do something1
}
```

else 语句可以直接配套 if 语句使用，如果 if 条件判断不成立，则执行 else 里面的代码逻辑。

需要注意：else 后面是没有加判断条件的，且不能加判断条件，否则会编译错误。



## if-else if 语句

在 C++ 中，else if 关键字用于在 if 语句条件不满足的情况下，继续执行 else if 里面的逻辑判断，如果满足条件则执行 else if 缩进里面的逻辑。

语法：

```cpp showLineNumbers
if (condition)
{
	// do something
}
else if (condition1)
{
	// do something1
}
else if (condition2)
{
	// do something2
}
else
{
	// do something3
}
```

else if 语句只能写在 if 语句的同级代码的后面，且 else if 语句可以写任意多个。



## 嵌套 if 语句

在 C++ 中，if 语句、else if 语句和 else 语句可以进行任意的嵌套。

语法：

```cpp showLineNumbers
if (condition)
{
	if (condition1)
	{
		// do something1
	}
	else if (condition2)
	{
		// do something2
	}
}
else
{
	if (condition3)
	{
		// do something3
	}
	else if (condition4)
	{
		// do something4
	}
	else
	{
		// do something5
	}
}
```

可以在一个 if 或 else if 语句内使用另一个 if 或 else if 语句。但不建议嵌套超过 3 层。



## switch 语句

switch 语句的作用类似于 if 语句，用于基于不同条件执行不同动作，每一个 case 分支都是唯一的，从上至下逐一测试，直到匹配为止。在需要测试一个变量等于多个值时的情况非常适合。

语法：

```cpp showLineNumbers
switch (expression) {
    case val1:
        //do something
    	break;
    case val2:
         //do something
    	break;
    default:
         //do something
    	break;
}
```

说明：如果 expression 的值满足条件 val1，那么就会执行 val1 下面的代码块，如果 expression 的值满足 val2，那么就会执行 val2 下面的代码块，如果所有条件都不满足，那么就执行 default 语句下面的代码块。

注意：

- C++ 的 switch 语句如果匹配成功后，不需要继续匹配其他项，那么需要在每个项后面加 break 语句。
- 如果希望在任何一个都没有匹配成功后，使用默认的 case，那么可以使用 default 语句。
- 可以在一个 switch 语句内使用另一个 switch 语句。



## ? : 三目运算符

其实我们已经在 [C++运算符](/cplusplus/cpp-operators/) 中介绍过，在一些简单的控制条件中，三目运算符 `? :` 可以用来替代 `if...else` 语句。其语法结构如下：

```cpp showLineNumbers
Exp1 ? Exp2 : Exp3;
```

Exp1、Exp2 和 Exp3 是表达式。

- ? 表达式的值是由 Exp1 决定的；
- 如果 Exp1 为真，则计算 Exp2 的值，结果即为整个 ? 表达式的值；
- 如果 Exp1 为假，则计算 Exp3 的值，结果即为整个 ? 表达式的值。

