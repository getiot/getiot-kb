---
sidebar_position: 7
---

# Shell 判断语句



## if-then 语句

使用 if-then 语句，语法如下：

```bash showLineNumbers
if [ confition ]; then
    statements
fi
```

或者

```bash showLineNumbers
if [ confition ]; then
    statements
else
    other statements
fi
```

或者

```bash showLineNumbers
if [ confition 1 ]; then
   statements 1
elif [ confition 2 ]; then
   statements 2
elif [ confition 3 ]; then
   statements 3
else
   other statements
fi
```

说明：当条件 confition 为 true 时，则执行 if 语句，否则执行 else 语句。如果有多个分支，则使用 elif 判断条件。

示例：

```bash showLineNumbers
#!/bin/bash

read -p "Please enter a number: " num

if [ $num -ge 90 ]; then
    echo "Score: A"
elif [ $num -ge 60 ]; then
    echo "Score: B"
else
    echo "Score: C"
fi
```



### 条件判断

在 shell 编程中，我们常常需要判断各种条件，以便执行不同路径。常见的条件判断有以下 3 类：

**1）数值比较**

|   比较    |          描述          |
| :-------: | :--------------------: |
| n1 -eq n2 |    检查n1是否等于n2    |
| n1 -ge n2 | 检查n1是否大于或等于n2 |
| n1 -gt n2 |    检查n1是否大于n2    |
| n1 -le n2 | 检查n1是否小于或等于n2 |
| n1 -lt n2 |    检查n1是否小于n2    |
| n1 -ne n2 |   检查n1是否不等于n2   |

**2）字符串比较**

|     比较     |          描述          |
| :----------: | :--------------------: |
| str1 = str2  | 检查str1与str2是否相同 |
| str1 != str2 | 检查str1与str2是否不同 |
| str1 < str2  |  检查str1是否小于str2  |
| str1 > str2  |  检查str1是否大于str2  |
|    -n str    | 检查str的长度是否为非0 |
|    -z str    |  检查str的长度是否为0  |

**3）文件比较**

|  比较   |               描述               |
| :-----: | :------------------------------: |
| -d file |   检查file是否存在且是一个目录   |
| -e file |         检查file是否存在         |
| -f file | 检查file是否存在且是一个普通文件 |
| -r file |      检查file是否存在且可读      |
| -s file |      检查file是否存在且非空      |
| -w file |      检查file是否存在且可写      |
| -x file |     检查file是否存在且可执行     |



### 判断多个条件

如果需要同时判断多个条件，可以使用布尔运算符（逻辑运算符）连接多个条件，格式如下：

- 如果 a > b 且 a < c

  ```bash
  if (( a > b )) && (( a < c ))
  if [[ $a > $b ]] && [[ $a < $c ]]
  if [ $a -gt $b -a $a -lt $c ]
  ```

- 如果 a > b 或 a < c

  ```bash
  if (( a > b )) || (( a < c ))
  if [[ $a > $b ]] || [[ $a < $c ]]
  if [ $a -gt $b -o $a -lt $c ]
  ```


注意：在比较时，数字和字符串使用不同的比较符号 。



## case 语句

虽然 if-then 语句可以胜任条件判断/分支执行的工作，但是如果分支过多，则会导致代码臃肿。因此，可以使用 case 语句来替代，避免过长的 if-then 语句。shell 中的 case 语句类似于 C 语言的 switch 语句，一般形式如下：

```bash showLineNumbers
case varible in
    pattern1 | pattern2) command1;;
    pattern3) command2;;
    *) command3;;
esac
```

case 语句由 case 和 esac 关键字包裹，通过判断 varible 的值，与 pattern 匹配。pattern 可以是一个数字、一个字符串，甚至是一个正则表达式。匹配成功则执行相应的命令语句，直到遇到双分号（`;;`）才停止，如果没有匹配到任何一个 pattern，则执行 `*)` 后面的语句，相当于 else 部分。

示例：

```bash showLineNumbers
#!/bin/bash

user=`whoami`

case $user in
    root) echo "You are super user";;
    rudy) echo "You are my boyfriend";;
    tina) echo "You are my girlfriend";;
    *) echo "Other user";;
esac
```





