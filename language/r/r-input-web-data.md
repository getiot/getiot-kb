---
sidebar_position: 37
draft: true
---

# R 语言 - 获取 Web 数据



许多网站为用户提供一些公开的数据。 例如，世界卫生组织(WHO)以CSV，txt和XML文件的形式提供关于健康和医疗信息的报告。 使用R程序，我们可以从这些网站以编程方式提取特定的数据。 用于从网络中废弃数据的R中的一些包是 - *RCurl*，*XML*和*stringr*，用于连接URL，识别文件所需的链接并将其下载到本地环境。

## 安装R包

需要以下包才能处理URL和链接到文件。 如果它们在R环境中不可用，则可以使用以下命令安装它们。

```r showLineNumbers
install.packages("RCurl")
install.packages("XML")
install.packages("stringr")
install.packages("plyr")
R
```

## 准备输入数据

我们将访问URL[天气数据](http://www.geos.ed.ac.uk/~weather/jcmb_ws/)，并使用R来下载`2015`年天气的CSV文件。

## 例子

我们将使用函数`getHTMLLinks()`来收集文件的URL。然后将使用函数`download.file()`将文件保存到本地系统。由于我们将为多个文件一次又一次地应用相同的代码，所以将创建一个被多次调用的函数。文件名作为参数以R列表对象的形式传递给此函数。

```r showLineNumbers
# Read the URL.
url <- "http://www.geos.ed.ac.uk/~weather/jcmb_ws/"

# Gather the html links present in the webpage.
links <- getHTMLLinks(url)

# Identify only the links which point to the JCMB 2015 files. 
filenames <- links[str_detect(links, "JCMB_2015")]

# Store the file names as a list.
filenames_list <- as.list(filenames)

# Create a function to download the files by passing the URL and filename list.
downloadcsv <- function (mainurl,filename) {
   filedetails <- str_c(mainurl,filename)
   download.file(filedetails,filename)
}

# Now apply the l_ply function and save the files into the current R working directory.
l_ply(filenames,downloadcsv,mainurl = "http://www.geos.ed.ac.uk/~weather/jcmb_ws/")
R
```

## 验证文件下载

运行上述代码后，可以在当前R工作目录中找到以下文件。

```shell
"JCMB_2015.csv" "JCMB_2015_Apr.csv" "JCMB_2015_Feb.csv" "JCMB_2015_Jan.csv"
   "JCMB_2015_Mar.csv"
```

