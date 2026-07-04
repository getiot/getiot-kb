---
sidebar_position: 20
---

# R 语言 - 数据框



数据框（Data Frames）是以表格格式显示的数据。

数据框可以在其中包含不同类型的数据。第一列可以是“字符”（`character`），第二列和第三列可以是“数字”（`numeric`）或“逻辑”（`logical`）。但是，每一列都应具有相同类型的数据。



## 创建数据框

使用 `data.frame()` 函数创建数据框：

```R showLineNumbers
# Create a data frame
Data_Frame <- data.frame (
  Training = c("Strength", "Stamina", "Other"),
  Pulse = c(100, 150, 120),
  Duration = c(60, 30, 45)
)

# Print the data frame
Data_Frame
```

结果为：

```R showLineNumbers
  Training Pulse Duration
1 Strength   100       60
2  Stamina   150       30
3    Other   120       45
```



## 汇总数据

使用 `summary()` 函数来汇总数据框中的数据：

```R showLineNumbers
Data_Frame <- data.frame (
  Training = c("Strength", "Stamina", "Other"),
  Pulse = c(100, 150, 120),
  Duration = c(60, 30, 45)
)

Data_Frame

summary(Data_Frame)
```

结果为：

```R showLineNumbers
   Training             Pulse          Duration   
 Length:3           Min.   :100.0   Min.   :30.0  
 Class :character   1st Qu.:110.0   1st Qu.:37.5  
 Mode  :character   Median :120.0   Median :45.0  
                    Mean   :123.3   Mean   :45.0  
                    3rd Qu.:135.0   3rd Qu.:52.5  
                    Max.   :150.0   Max.   :60.0
```

你将在 R 教程的统计部分了解有关 `summary()` 函数的更多信息。



## 访问数据

我们可以使用单括号 `[]`、双括号 `[[]]` 或 `$` 来访问数据框中的列：

```R showLineNumbers
Data_Frame <- data.frame (
  Training = c("Strength", "Stamina", "Other"),
  Pulse = c(100, 150, 120),
  Duration = c(60, 30, 45)
)

Data_Frame[1]

Data_Frame[["Training"]]

Data_Frame$Training
```



## 添加行

使用 `rbind()` 函数在数据框中添加新行：

```R showLineNumbers
Data_Frame <- data.frame (
  Training = c("Strength", "Stamina", "Other"),
  Pulse = c(100, 150, 120),
  Duration = c(60, 30, 45)
)

# Add a new row
New_row_DF <- rbind(Data_Frame, c("Strength", 110, 110))

# Print the new row
New_row_DF
```



## 添加列

使用 `cbind()` 函数在数据框中添加新列：

```R showLineNumbers
Data_Frame <- data.frame (
  Training = c("Strength", "Stamina", "Other"),
  Pulse = c(100, 150, 120),
  Duration = c(60, 30, 45)
)

# Add a new column
New_col_DF <- cbind(Data_Frame, Steps = c(1000, 6000, 2000))

# Print the new column
New_col_DF
```



## 删除行和列

使用 `c()` 函数删除数据框中的行和列：

```R showLineNumbers
Data_Frame <- data.frame (
  Training = c("Strength", "Stamina", "Other"),
  Pulse = c(100, 150, 120),
  Duration = c(60, 30, 45)
)

# Remove the first row and column
Data_Frame_New <- Data_Frame[-c(1), -c(1)]

# Print the new data frame
Data_Frame_New
```



## 行数和列数

使用 `dim()` 函数可获取数据框中的行数和列数：

```R showLineNumbers
Data_Frame <- data.frame (
  Training = c("Strength", "Stamina", "Other"),
  Pulse = c(100, 150, 120),
  Duration = c(60, 30, 45)
)

dim(Data_Frame)
```

你还可以使用 `ncol()` 函数查找列数，使用 `nrow()` 查找行数：

```R showLineNumbers
Data_Frame <- data.frame (
  Training = c("Strength", "Stamina", "Other"),
  Pulse = c(100, 150, 120),
  Duration = c(60, 30, 45)
)

ncol(Data_Frame)
nrow(Data_Frame)
```



## 数据框长度

使用 `length()` 函数查找数据框中的列数（类似于 `ncol()` 函数）：

```R showLineNumbers
Data_Frame <- data.frame (
  Training = c("Strength", "Stamina", "Other"),
  Pulse = c(100, 150, 120),
  Duration = c(60, 30, 45)
)

length(Data_Frame)
```



## 合并数据框

使用 `rbind()` 函数垂直组合 R 中的两个或多个数据框：

```R showLineNumbers
Data_Frame1 <- data.frame (
  Training = c("Strength", "Stamina", "Other"),
  Pulse = c(100, 150, 120),
  Duration = c(60, 30, 45)
)

Data_Frame2 <- data.frame (
  Training = c("Stamina", "Stamina", "Strength"),
  Pulse = c(140, 150, 160),
  Duration = c(30, 30, 20)
)

New_Data_Frame <- rbind(Data_Frame1, Data_Frame2)
New_Data_Frame
```

并使用 `cbind()` 函数水平组合 R 中的两个或多个数据框：

```R showLineNumbers
Data_Frame3 <- data.frame (
  Training = c("Strength", "Stamina", "Other"),
  Pulse = c(100, 150, 120),
  Duration = c(60, 30, 45)
)

Data_Frame4 <- data.frame (
  Steps = c(3000, 6000, 2000),
  Calories = c(300, 400, 300)
)

New_Data_Frame1 <- cbind(Data_Frame3, Data_Frame4)
New_Data_Frame1
```


