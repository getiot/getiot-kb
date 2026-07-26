---
sidebar_position: 8
---

# Shell 循环语句



Shell 同样支持循环语句，包括 for 循环和 while 循环两种形式。



## for 循环

其中 for 循环格式如下：

```bash showLineNumbers
for varible in list
do
    commands
done
```

在 list 参数中，需要提供迭代中一系列要使用的值，在每个迭代中，varible 会包含列表中的当前值，一次使用一个值，以此类推。

### 数值型循环

以从 1 到 10 循环打印数字为例，for 语句的具体写法如下：

```bash showLineNumbers
for i in {1..10}
do
    echo $i
done
```

结合 seq 命令使用（seq 命令用于输出序列化的一串数字）

```bash showLineNumbers
for i in $(seq 1 10)
do
    echo $i
done
```

也可以采用类似 C 语言的写法（用双小括号包裹）

```bash showLineNumbers
for ((i=1; i<=10; i++))
do
    echo $i
done
```



### 字符型循环

循环打印字符串中的单词

```bash showLineNumbers
fruit="apple banana orange"
for i in $fruit
do
    echo $i
done
```

结合 shell 命令获取字符串列表

```bash showLineNumbers
for i in `ls`
do
    echo $i
done
```



## while 循环

while 语句可以看成是 if-then 语句和 for 循环的混合。while 语句允许你定义一个要测试的命令，如果测试命令返回的退出状态码是 0，则循环执行一组命令。格式如下：

```bash showLineNumbers
while test command
do
    other commands
done
```

例如当 while 条件始终为真，即无限循环，在循环中不断播报时间：

```bash showLineNumbers
#!/bin/bash

while true
do
    date
    sleep 1
done
```

上述 while 语句等效于

```bash showLineNumbers
while :
do
    date
    sleep 1
done
```

通常，我们会为 while 语句增加判断条件

```bash showLineNumbers
#!/bin/bash

count=10

while [ $count -gt 0 ]
do
    date
    sleep 1
    ((count--))
done
```

在 while 循环期间，可以使用 break 语句跳出循环

```bash showLineNumbers
#!/bin/bash

count=10

while [ $count -gt 0 ]
do
    date
    sleep 1
    ((count--))
    
    if [ $count -lt 3 ]; then
        break
    fi
done
```

