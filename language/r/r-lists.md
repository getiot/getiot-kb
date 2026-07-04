---
sidebar_position: 17
---

# R 语言 - 列表



在 R 语言中，列表是有序且可变的数据集合，且可以在其中包含许多不同的数据类型。



## 创建列表

要创建列表，请使用 `list()` 函数：

```R showLineNumbers
# List of strings
thislist <- list("apple", "banana", "cherry")

# Print the list
thislist
```



## 访问列表

你可以通过引用括号内的索引号来访问列表项。第一项的索引为 1，第二项的索引为 2，依此类推。

```R showLineNumbers
thislist <- list("apple", "banana", "cherry")

thislist[1]
```



## 修改列表项

你可以通过索引号更改特定项目的值。

```R showLineNumbers
thislist <- list("apple", "banana", "cherry")
thislist[1] <- "blackcurrant"

# Print the updated list
thislist
```



## 列表长度

要找出一个列表有多少项，请使用 `length()` 函数。

```R showLineNumbers
thislist <- list("apple", "banana", "cherry")

length(thislist)
```



## 检查列表项是否存在

要查明列表中是否存在指定项目，可以使用 `%in%` 运算符。

例如：检查列表中是否存在 "apple"

```R showLineNumbers
thislist <- list("apple", "banana", "cherry")

"apple" %in% thislist
```



## 添加列表项

要将项目添加到列表的末尾，可以使用 `append()` 函数。

例如：将 "orange" 添加到列表中

```R showLineNumbers
thislist <- list("apple", "banana", "cherry")

append(thislist, "orange")
```

要将项目添加到指定索引的右侧，请在 `append()` 函数中添加“`after=*index number*`”。

例如：在“banana”之后的列表中添加“orange”（索引 2）

```R showLineNumbers
thislist <- list("apple", "banana", "cherry")

append(thislist, "orange", after = 2)
```



## 删除列表项

你还可以删除列表项。

例如：从列表中删除 "apple"

```R showLineNumbers
thislist <- list("apple", "banana", "cherry")

newlist <- thislist[-1]

# Print the new list
newlist
```



## 索引范围

你可以通过使用 `:` 运算符指定范围的开始位置和结束位置来指定索引范围。

例如：返回第二、三、四、五项

```R showLineNumbers
thislist <- list("apple", "banana", "cherry", "orange", "kiwi", "melon", "mango")

(thislist)[2:5]
```

**注意**：搜索将从索引 2（包括）开始，到索引 5（包括）结束。

请记住，第一项的索引为 1。



## 遍历列表

你可以使用 `for` 循环遍历列表项。

例如：逐一打印列表中的所有项目

```R showLineNumbers
thislist <- list("apple", "banana", "cherry")

for (x in thislist) {
  print(x)
}
```



## 合并列表

在 R 中有多种方法可以加入或连接两个或多个列表。

最常见的方法是使用 `c()` 函数，它将两个元素组合在一起：

```R showLineNumbers
list1 <- list("a", "b", "c")
list2 <- list(1,2,3)
list3 <- c(list1,list2)

list3
```


