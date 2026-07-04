---
sidebar_position: 6
---

# JavaScript 判断语句



判断语句也称为条件语句，用于判断不同的条件来执行不同的动作，从而改变程序的执行逻辑。

和 C/C++ 一样，JavaScript 也支持 if...else 和 switch 语句。



## if-else 语句

if-else 语句有几种不同的形式，可以只有一个 if 语句块，比如：

```javascript showLineNumbers
if ( condition ) { 
    /* 当条件为 true 时执行的代码 */ 
}
```

除了只在 if 语句块中执行代码，还可以指定一个 else 块，表示仅当条件为 false 时执行。

```javascript showLineNumbers
if ( condition ) {
    /* 当条件为 true 时执行的代码 */
}
else {
    /* 当条件不为 true 时执行的代码 */
}
```

也可以将多个 if-else 语句链接在一起，用于选择多个代码块之一来执行，比如：

```javascript showLineNumbers
if ( condition1 ) {
    /* 当条件 1 为 true 时执行的代码 */
}
else if ( condition2 ) {
    /* 当条件 2 为 true 时执行的代码 */
}
else {
    /* 当条件 1 和 条件 2 都不为 true 时执行的代码 */
}
```

另外，if-else 语句支持嵌套。



## switch 语句

switch 语句用于基于不同的条件来执行不同的动作，使用起来比 if-else 语句更简洁。

```javascript showLineNumbers
switch (表达式)
{
    case value1:
        // 执行代码块 1
        break;
    case value2:
        // 执行代码块 2
        break;
    default:
        // 与 case 1 和 case 2 不同时执行的代码
}
```

switch 语句会计算表达式，得到一个值，这个值可以是字符串、数值、布尔值，甚至是一个对象。然后再使用 case 语句指定的值与 switch 表达式的值逐一比较。如果值匹配，则执行 case 语句中的代码；如果没有匹配的值，则执行 default 语句中的代码。

另外，case 语句后面的 break 语句，表示执行到这里就会中断 switch 语句；如果没有 break 语句，那么程序会继续执行下一个 case 语句。

