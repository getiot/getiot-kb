---
sidebar_position: 21
---

# R 语言 - 因子



因子（Factor）是用于对数据进行分类并将按类别存储的数据对象，在统计建模的数据分析中很有用。因子可以存储字符串和整数，在具有有限数量的唯一值的列中很有用。

下面是因子的几个示例：

- 人口统计（Demography）：男性（Male）、女性（Female）
- 音乐（Music）：摇滚（Rock）、流行（Pop）、古典（Classic）、爵士（Jazz）
- 训练（Training）：力量（Strength）、耐力（Stamina）



## 创建因子

因子可通过`factor()`函数使用向量作为输入来创建。例如：

```R showLineNumbers
# Create a factor
music_genre <- factor(c("Jazz", "Rock", "Classic", "Classic", "Pop", "Jazz", "Rock", "Jazz"))

# Print the factor
music_genre
```

结果为

```R showLineNumbers
[1] Jazz    Rock    Classic Classic Pop     Jazz    Rock    Jazz
Levels: Classic Jazz Pop Rock
```

从上面的例子可以看出，该因素有四个级别（类别）：古典、爵士、流行和摇滚。

如果只想打印级别，请使用 `levels()` 函数：

```R showLineNumbers
music_genre <- factor(c("Jazz", "Rock", "Classic", "Classic", "Pop", "Jazz", "Rock", "Jazz"))

levels(music_genre)
```

结果为

```R showLineNumbers
[1] "Classic" "Jazz"    "Pop"     "Rock"  
```

你还可以通过在 `factor()` 函数中添加 `levels` 参数来设置级别：

```R showLineNumbers
music_genre <- factor(c("Jazz", "Rock", "Classic", "Classic", "Pop", "Jazz", "Rock", "Jazz"),
                      levels = c("Classic", "Jazz", "Pop", "Rock", "Other"))

levels(music_genre)
```

结果为

```R showLineNumbers
[1] "Classic" "Jazz"    "Pop"     "Rock"    "Other"
```



## 因子长度

使用 `length()` 函数找出因子中有多少项：

```R showLineNumbers
music_genre <- factor(c("Jazz", "Rock", "Classic", "Classic", "Pop", "Jazz", "Rock", "Jazz"))

length(music_genre)
```

结果为

```R showLineNumbers
[1] 8
```



## 访问因子

要访问因子中的项目，请使用 `[]` 括号引用索引号。

例如：访问第三项

```R showLineNumbers
music_genre <- factor(c("Jazz", "Rock", "Classic", "Classic", "Pop", "Jazz", "Rock", "Jazz"))

music_genre[3]
```

结果为

```R showLineNumbers
[1] Classic
Levels: Classic Jazz Pop Rock
```



## 更改因子

要更改特定项目的值，请参考索引号。

例如：更改第三项的值

```R showLineNumbers
music_genre <- factor(c("Jazz", "Rock", "Classic", "Classic", "Pop", "Jazz", "Rock", "Jazz"))

music_genre[3] <- "Pop"

music_genre[3]
```

结果为

```R showLineNumbers
[1] Pop
Levels: Classic Jazz Pop Rock
```

请注意，如果尚未在因子中指定，则无法更改特定项目的值。以下示例将产生错误：

```R showLineNumbers
music_genre <- factor(c("Jazz", "Rock", "Classic", "Classic", "Pop", "Jazz", "Rock", "Jazz"))

music_genre[3] <- "Opera"

music_genre[3]
```

结果为

```R showLineNumbers
Warning message:
In `[<-.factor`(`*tmp*`, 3, value = "Opera") :
  invalid factor level, NA generated
```

但是，如果你已经在 `levels` 参数中指定了它，它将起作用。

例如：改变第三项的值

```R showLineNumbers
music_genre <- factor(c("Jazz", "Rock", "Classic", "Classic", "Pop", "Jazz", "Rock", "Jazz"),
                      levels = c("Classic", "Jazz", "Pop", "Rock", "Opera"))

music_genre[3] <- "Opera"

music_genre[3]
```

结果为

```R showLineNumbers
[1] Opera
Levels: Classic Jazz Pop Rock Opera
```

