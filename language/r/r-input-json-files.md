---
sidebar_position: 35
draft: true
---

# R 语言 - JSON 文件



JSON文件以可读取的格式将数据存储为文本。Json是一种JavaScript对象表示法。R可以使用*rjson*包读取JSON文件。

## 安装rjson软件包

在R控制台中，您可以发出以下命令来安装`rjson`包。

```r showLineNumbers
install.packages("rjson")
R
```

## 准备输入数据源

通过将以下数据复制到文本编辑器(如记事本)中创建一个JSON文件。 使用`.json`扩展名保存文件，并将文件类型选为所有文件(`*.*`)。创建一个文件：*input.json*，其内容如下所示 -

```json
{ 
   "ID":["1","2","3","4","5","6","7","8" ],
   "Name":["Rick","Dan","Michelle","Ryan","Gary","Nina","Simon","Guru" ],
   "Salary":["623.3","515.2","611","729","843.25","578","632.8","722.5" ],

   "StartDate":[ "1/1/2012","9/23/2013","11/15/2014","5/11/2014","3/27/2015","5/21/2013",
      "7/30/2013","6/17/2014"],
   "Dept":[ "IT","Operations","IT","HR","Finance","IT","Operations","Finance"]
}
JSON
```

## 读取JSON文件

R使用`JSON()`函数读取JSON文件的内容，它作为列表存储在R中。参考以下代码 - 

```r showLineNumbers
# Load the package required to read JSON files.
library("rjson")

# Give the input file name to the function.
result <- fromJSON(file = "input.json")

# Print the result.
print(result)
R
```

当我们执行上述代码时，会产生以下结果 -

```shell
$ID
[1] "1" "2" "3" "4" "5" "6" "7" "8"

$Name
[1] "Rick"     "Dan"      "Michelle" "Ryan"     "Gary"    
[6] "Nina"     "Simon"    "Guru"    

$Salary
[1] "623.3"  "515.2"  "611"    "729"    "843.25" "578"    "632.8" 
[8] "722.5" 

$StartDate
[1] "1/1/2012"   "9/23/2013"  "11/15/2014" "5/11/2014" 
[5] "3/27/2015"  "5/21/2013"  "7/30/2013"  "6/17/2014" 

$Dept
[1] "IT"         "Operations" "IT"         "HR"        
[5] "Finance"    "IT"         "Operations" "Finance"
Shell
```

## 将JSON转换为数据帧

我们可以将上述提取的数据通过使用`as.data.frame()`函数转换为R数据帧，以便进一步分析。

```r showLineNumbers
# Load the package required to read JSON files.
library("rjson")

# Give the input file name to the function.
result <- fromJSON(file = "input.json")

# Convert JSON file to a data frame.
json_data_frame <- as.data.frame(result)

print(json_data_frame)
R
```

当我们执行上述代码时，会产生以下结果 -

```shell
      id,   name,    salary,   start_date,     dept
1      1    Rick     623.30    2012-01-01      IT
2      2    Dan      515.20    2013-09-23      Operations
3      3    Michelle 611.00    2014-11-15      IT
4      4    Ryan     729.00    2014-05-11      HR
5     NA    Gary     843.25    2015-03-27      Finance
6      6    Nina     578.00    2013-05-21      IT
7      7    Simon    632.80    2013-07-30      Operations
8      8    Guru     722.50    2014-06-17      Finance
```



