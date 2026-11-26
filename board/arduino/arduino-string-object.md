---
sidebar_position: 15
authors: [luhuadong]
---

# Arduino String 对象



在 Arduino 中，创建字符串除了使用字符数组，还可以使用 String 类。String 对象使用起来比字符数组灵活得多。

构造 String 类的实例的方法很多，它支持从不同的数据类型构造字符串（即将它们格式化为字符序列），包括：

- 双引号中的常量字符串（即字符数组）
- 单个常量字符，在单引号中
- String 对象的另一个实例
- 一个常量整数或长整数
- 使用指定基数的常量整数或长整数
- 一个整数或长整数变量
- 整数或长整数变量，使用指定的基数
- 浮点数或双精度数，使用指定的小数位

下面列举几个例子：

从一个数字构造一个字符串，将产生一个包含该数字的 ASCII 表示的字符串（默认是十进制）

```cpp showLineNumbers
String thisString = String(13);
```

这将得到字符串 "13"，可以添加第二个参数指定转换基数，例如十六进制：

```cpp showLineNumbers
String thisString = String(13, HEX);
```

这将得到字符串 "d"，转换为二进制：

```cpp showLineNumbers
String thisString = String(13, BIN);
```

这将得到字符串 "1101"。



## 构造语法

```cpp showLineNumbers
String(val)
String(val, base)
String(val, decimalPlaces)
```

**参数说明**

| 参数            | 说明                                                         |
| --------------- | ------------------------------------------------------------ |
| `val`           | 要格式化为字符串的变量。允许的数据类型：string、char、byte、int、long、unsigned int、unsigned long、float、double。 |
| `base`          | 格式化整数值的基数（可选）                                   |
| `decimalPlaces` | 仅当 value 为 float 或 double 时有效，表示所需的小数位。     |

**返回值**

返回 String 类的一个实例。



## 构造示例

以下所有都是字符串的有效声明。

```cpp showLineNumbers
String stringOne = "Hello String";                    // using a constant String
String stringOne = String('a');                       // converting a constant char into a String
String stringTwo = String("This is a string");        // converting a constant string into a String object
String stringOne = String(stringTwo + " with more");  // concatenating two strings
String stringOne = String(13);                        // using a constant integer
String stringOne = String(analogRead(0), DEC);        // using an int and a base
String stringOne = String(45, HEX);                   // using an int and a base (hexadecimal)
String stringOne = String(255, BIN);                  // using an int and a base (binary)
String stringOne = String(millis(), DEC);             // using a long and a base
String stringOne = String(5.698, 3);                  // using a float and the decimal places
```



## 成员方法

| 函数                                                         | 功能                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [charAt()](https://www.arduino.cc/reference/en/language/variables/data-types/string/functions/charat) | 访问 String 中的特定字符                                     |
| [compareTo()](https://www.arduino.cc/reference/en/language/variables/data-types/string/functions/compareto) | 比较两个 String 的大小，使用字符的 ASCII 值逐个比较          |
| [concat()](https://www.arduino.cc/reference/en/language/variables/data-types/string/functions/concat) | 以追加的方式连接两个字符串                                   |
| [c_str()](https://www.arduino.cc/reference/en/language/variables/data-types/string/functions/c_str) | 将 String 的内容转换为 C 风格的以 '\0' 结束的字符串。注意：这样可以直接访问内部 String 缓冲区，使用时要小心。 |
| [endsWith()](https://www.arduino.cc/reference/en/language/variables/data-types/string/functions/endswith) | 测试一个 String 是否以另一个 String 的字符结束。             |
| [equals()](https://www.arduino.cc/reference/en/language/variables/data-types/string/functions/equals) | 比较两个字符串是否相等（区分大小写）。                       |
| [equalsIgnoreCase()](https://www.arduino.cc/reference/en/language/variables/data-types/string/functions/equalsignorecase) | 比较两个字符串是否相等（不区分大小写）。                     |
| [getBytes()](https://www.arduino.cc/reference/en/language/variables/data-types/string/functions/getbytes) | 将 String 的字符复制到提供的缓冲区。                         |
| [indexOf()](https://www.arduino.cc/reference/en/language/variables/data-types/string/functions/indexof) | 在另一个字符串中定位一个字符或字符串。默认情况下，从 String 的开头开始搜索，但也可以从给定的索引开始搜索。 |
| [lastIndexOf()](https://www.arduino.cc/reference/en/language/variables/data-types/string/functions/lastindexof) | 在另一个字符串中定位一个字符或字符串。默认情况下，从 String 的末尾开始搜索，但也可以从给定索引向后搜索。 |
| [length()](https://www.arduino.cc/reference/en/language/variables/data-types/string/functions/length) | 返回字符串的长度，以字符为单位。注意：这并不包括一个尾随的空字符。 |
| [remove()](https://www.arduino.cc/reference/en/language/variables/data-types/string/functions/remove) | 原地修改一个 String，从提供的索引删除字符到 String 的末尾，或者从提供的索引删除字符到 index + count。 |
| [replace()](https://www.arduino.cc/reference/en/language/variables/data-types/string/functions/replace) | 将给定字符的所有实例替换为另一个字符。使用 replace 将 String 的子字符串替换为不同的子字符串。 |
| [reserve()](https://www.arduino.cc/reference/en/language/variables/data-types/string/functions/reserve) | 在内存中分配一个缓冲区来操作字符串。                         |
| [setCharAt()](https://www.arduino.cc/reference/en/language/variables/data-types/string/functions/setcharat) | 设置字符串的一个字符。对字符串现有长度以外的索引没有影响。   |
| [startsWith()](https://www.arduino.cc/reference/en/language/variables/data-types/string/functions/startswith) | 测试一个 String 是否以另一个 String 的字符开始。             |
| [substring()](https://www.arduino.cc/reference/en/language/variables/data-types/string/functions/substring) | 获取 String 对象的子字符串。起始索引是包容性的（对应的字符包含在子字符串中），但是可选的结束索引是排他的（对应的字符不包含在子字符串中）。如果省略结束索引，子字符串将继续到字符串的末尾。 |
| [toCharArray()](https://www.arduino.cc/reference/en/language/variables/data-types/string/functions/tochararray) | 将 String 的字符复制到提供的缓冲区。                         |
| [toDouble()](https://www.arduino.cc/reference/en/language/variables/data-types/string/functions/todouble) | 将有效字符串转换为双精度浮点数。输入字符串应该以数字开头，如果字符串包含非数字字符，函数将停止执行转换。注意：浮点数只有 6-7 位小数的精度，较长的字符串可能会被截断。 |
| [toInt()](https://www.arduino.cc/reference/en/language/variables/data-types/string/functions/toint) | 将有效的字符串转换为整数。输入字符串应该以整数开头，如果字符串包含非整型数字，函数将停止执行转换。 |
| [toFloat()](https://www.arduino.cc/reference/en/language/variables/data-types/string/functions/tofloat) | 将有效字符串转换为浮点数。输入字符串应该以数字开头，如果字符串包含非数字字符，函数将停止执行转换。注意：浮点数只有 6-7 位小数的精度，较长的字符串可能会被截断。 |
| [toLowerCase()](https://www.arduino.cc/reference/en/language/variables/data-types/string/functions/tolowercase) | 获取 String 的小写版本。从1.0开始，toLowerCase() 会在适当的地方修改 String，而不是返回一个新的。 |
| [toUpperCase()](https://www.arduino.cc/reference/en/language/variables/data-types/string/functions/touppercase) | 获取 String 的大写版本。从1.0开始，toUpperCase() 会在适当的地方修改String，而不是返回一个新的。 |
| [trim()](https://www.arduino.cc/reference/en/language/variables/data-types/string/functions/trim) | 获取一个去掉所有开头和结尾空白的 String 版本。从1.0开始，trim() 将修改字符串的位置，而不是返回一个新的字符串。 |



## 操作符

| Operator | 功能                                                         |
| -------- | ------------------------------------------------------------ |
| `[]`     | 访问 String 中的单个字符。类似于数组操作。                   |
| `+`      | 组合或连接两个字符串为一个新的字符串。第二个 String 被附加到第一个 String，结果被放在一个新的 String 中。工作原理与 string.concat() 相同。 |
| `+=`     | 将字符串与其他数据连接起来。                                 |
| `==`     | 比较两个字符串是否相等（区分大小写）。在功能上与 string.equals() 相同 |
| `>`      | 测试左侧的 String 是否大于右侧的 String。该操作符按字母顺序计算 string 的值，计算两者不同的第一个字符。例如 "b" > "a" 和 "2" > "1"，但 "999" > "1000" 因为 9 在 1 后面。 |
| `>=`     | 测试左边的 String 是否大于或等于右边的 String。该操作符按字母顺序计算 string 的值，即两者不同的第一个字符。 |
| `<`      | 测试左侧的 String 是否小于右侧的 String。该操作符按字母顺序计算 string 的值，即两者不同的第一个字符。 |
| `<=`     | 测试左边的 String 是否小于或等于右边的 String。该操作符按字母顺序计算 string 的值，即两者不同的第一个字符。 |
| `!=`     | 比较两个字符串的差异。比较是区分大小写的，这意味着字符串 "hello" 不等于字符串 "hello"。在功能上与 string.equals() 相同。 |



## 示例

- [Character Analysis](https://www.arduino.cc/en/Tutorial/BuiltInExamples/CharacterAnalysis)：使用运算符来识别我们正在处理的字符类型。
- [String Addition Operator](https://www.arduino.cc/en/Tutorial/BuiltInExamples/StringAdditionOperator)：以多种方式将字符串添加在一起。
- [String Append Operator](https://www.arduino.cc/en/Tutorial/BuiltInExamples/StringAppendOperator)：使用 += 运算符和 concat() 方法将内容附加到字符串。
- [String Case Changes](https://www.arduino.cc/en/Tutorial/BuiltInExamples/StringCaseChanges)：更改字符串的大小写。
- [String Characters](https://www.arduino.cc/en/Tutorial/BuiltInExamples/StringCharacters)：获取/设置字符串中特定字符的值。
- [String Comparison Operators](https://www.arduino.cc/en/Tutorial/BuiltInExamples/StringComparisonOperators)：按字母顺序比较字符串。
- [String Constructors](https://www.arduino.cc/en/Tutorial/BuiltInExamples/StringConstructors)：初始化字符串对象。
- [String Index Of](https://www.arduino.cc/en/Tutorial/BuiltInExamples/StringIndexOf)：在字符串中查找字符的第一个/最后一个实例。
- [String Length & String Length Trim](https://www.arduino.cc/en/Tutorial/BuiltInExamples/StringLengthTrim)：获取并修剪字符串的长度。
- [String Replace](https://www.arduino.cc/en/Tutorial/BuiltInExamples/StringReplace)：替换字符串中的单个字符。
- [String Start With Ends With](https://www.arduino.cc/en/Tutorial/BuiltInExamples/StringStartsWithEndsWith)：检查给定字符串以哪些字符/子字符串开头或结尾。
- [String Substring](https://www.arduino.cc/en/Tutorial/BuiltInExamples/StringSubstring)：在给定字符串中查找“短语”。
- [String To Int](https://www.arduino.cc/en/Tutorial/BuiltInExamples/StringToInt)：允许你将字符串转换为整数。

