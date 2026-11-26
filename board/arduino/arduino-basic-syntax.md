---
sidebar_position: 6
authors: [luhuadong]
---

# Arduino 基础语法



通常所说的 Arduino 语言，是指 Arduino 核心库文件提供的各种应用程序编程接口（Application Programming Interface，简称 API）的集合。这些 API 是对更底层的单片机支持库进行二次封装所形成的。例如，使用 AVR 单片机的 Arduino 核心库对 AVR-Libc（基于 GCC 的 AVR 支持库）的二次封装。

Arduino 语法是建立在 C/C++ 基础上，其实也就是基础的 C 语法，Arduino 语法只不过把相关的一些参数设置都函数化，不用我们去了解底层实现，让我们轻松上手。

前面我们学习了 Arduino 的[程序结构](/arduino/arduino-program-structure/)和[数据类型](/arduino/arduino-data-types/)，但是想要设计我们自己的 Arduino 程序，我们还需要学习更多内容，包括本节介绍的基础语法，以及后面介绍的控制流程和接口函数。



## 变量命名规则

与许多编程语言类似，Arduino 的变量命名也遵循一些规则，包括：

1. 只能包含英文字母、数字和下划线“_” 
2. 不能以数字作为开头
3. 不能与关键字重名
4. 变量名区分大小写
5. 相同作用域的不同变量不能使用同一个名字

另外，Arduino 的变量名建议采用驼峰式（首个单词字母小写，之后单词首个字母大写）命名法，并使用有含义的名字，见名知意。



## 变量和常量

由于 C/C++ 是静态语言，因此在 Arduino 程序中，也必须对所有数据指定其数据类型。Arduino 提供了各种[变量类型](/arduino/arduino-data-types/)用于有效地保存数据，其定义方法是：

```cpp showLineNumbers
类型 变量名;
```

例如：

```cpp showLineNumbers
int    i;   // 定义整型变量i
float  f;   // 定义浮点型变量f
char   c;   // 定义字符变量c
String str; // 定义字符串变量str
```

除了变量，程序中的数据还可以定义为常量。简单来说，在程序执行过程中，其值不可变的量称为常量，其值可变的量称为变量。

常量可以是数字、字符或字符串，通常使用 define 语句定义：

````cpp showLineNumbers
#define 常量名 常量值
````

定义常量时无需指定数据类型，行末也不需要分号 `;`。常量不占用内存，只是一个临时符号，代表一个值，预编译时会进行字符替换（将临时符号替换成对应的值），替换完之后，临时符号就不存在了。

例如：

```cpp showLineNumbers
#define PI 3.141592653589793
```

这样，我们在需要计算圆周率的地方，直接使用 PI 常量即可。

```cpp showLineNumbers
int r = 1;
double s = PI * r * r;    // 计算半径为r的圆面积
```

为方便编程，Arduino 为我们预定义了一些常量。比如：

- `HIGH` 和 `LOW` ：表示数字 IO 口的电平，`HIGH` 表示高电平（1），`LOW` 表示低电平（0）
- `INPUT` 和 `OUTPUT` ：表示数字 IO 口的方向，`INPUT` 表示输入（高阻态），`OUTPUT` 表示输出（AVR 能提供 5V 电压 40mA 电流）
- `true`  和  `false` ：`true` 表示真（1），`false` 表示假（0）



## 关键字

在计算机编程中，具有特殊意义的标识符被称为关键字。Arduino 支持的 C 语言的关键字，包括 32 个 ANSI C 关键字：

```c
auto     double   int       struct    break     else    long     switch
case     enum     register  typedef   char      extern  return   union
const    float    short     unsigned  continue  for     signed   void
default  goto     sizeof    volatile  do        if      while    static
```

具体可参考 [C关键字](/c/c-keywords/)



## 运算符

C/C++ 语言中有多种类型的运算符，常见的运算符如下表所示。

<table>
  <tr>
    <th>运算符类型</th>
    <th>运算符</th>
    <th>说明</th>
  </tr>
  <tr>
    <td rowspan='6'>算术运算符</td>
    <td>=</td>
    <td>赋值</td>
  </tr>
  <tr>
    <td>+</td>
    <td>加</td>
  </tr>
  <tr>
    <td>-</td>
    <td>减</td>
  </tr>
  <tr>
    <td>*</td>
    <td>乘</td>
  </tr>
  <tr>
    <td>/</td>
    <td>除</td>
  </tr>
  <tr>
    <td>%</td>
    <td>取模</td>
  </tr>
  <tr>
    <td rowspan='6'>比较运算符</td>
    <td>==</td>
    <td>等于</td>
  </tr>
  <tr>
    <td>!=</td>
    <td>不等于</td>
  </tr>
  <tr>
    <td>&lt;</td>
    <td>小于</td>
  </tr>
  <tr>
    <td>&gt;</td>
    <td>大于</td>
  </tr>
  <tr>
    <td>&lt;=</td>
    <td>小于或等于</td>
  </tr>
  <tr>
    <td>&gt;=</td>
    <td>大于或等于</td>
  </tr>
  <tr>
    <td rowspan='3'>逻辑运算符</td>
    <td>&&</td>
    <td>逻辑“与”运算</td>
  </tr>
  <tr>
    <td>||</td>
    <td>逻辑“或”运算</td>
  </tr>
  <tr>
    <td>!</td>
    <td>逻辑“非”运算</td>
  </tr>
  <tr>
    <td rowspan='4'>复合运算符</td>
    <td>++</td>
    <td>自加</td>
  </tr>
  <tr>
    <td>--</td>
    <td>自减</td>
  </tr>
  <tr>
    <td>+=</td>
    <td>复合加</td>
  </tr>
  <tr>
    <td>-=</td>
    <td>复合减</td>
  </tr>
</table>

运算符优先级遵循 C/C++ 规则。



## 注释

注释是对代码的解释和说明，其目的是让开发者能够更加轻松地了解代码。所有的编程语言都支持注释，适当的注释可以增强程序的可读性、可维护性，以便于更好地管理代码。也就是说，注释是写给人看的，因此注释不会被编译到程序中，也不会影响程序的运行。

与 C/C++ 一样，为 Arduino 程序添加注释有两种方法：

- **单行注释**，使用双斜线 `//` 

  ``````cpp showLineNumbers
  // This is a single-line comment
  ``````

  在 `//` 之后的内容都会被编译器认为是注释。

- **多行注释**，使用 `/*` 和 `*/` 包裹

  ```cpp showLineNumbers
  /*
    multi-line comments 1
    multi-line comments 2
    multi-line comments 3
  */
  ```

通常，多行注释用于文件头部和函数的描述信息，单行注释用于行内附加描述信息。使用哪种注释方法并没有限制，与开源项目或开发团队保持一致即可。



