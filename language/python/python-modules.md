---
sidebar_position: 26
---

# Python 常用模块




## os 模块

os 模块就是对操作系统进行操作，使用该模块必须先导入模块：

```python showLineNumbers
import os
```

练习：判断当前用户是否为 root

```python showLineNumbers
import os, sys

if os.geteuid() != 0:
    print("This program must be run as root. Aborting.")
    sys.exit(1)
```

## sys 模块

sys 模块功能多

## 数学模块

```python showLineNumbers
import math
```

## 时间模块

取得时间相关的信息的话，要用到 python time 模块，time 模块里面有很多非常好用的功能。

你可以试下下面的方式来取得当前时间的时间戳：

```python showLineNumbers
>> import time
>> time.time()
# 输出：1540281993.2281706
```

但是这样是一连串的数字不是我们想要的结果，我们可以利用 time 模块的格式化时间的方法来处理：

```python showLineNumbers
>> time.localtime(time.time())
# 输出：time.struct_time(tm_year=2018, tm_mon=10, tm_mday=23, tm_hour=16, tm_min=8, tm_sec=43, tm_wday=1, tm_yday=296, tm_isdst=0)
```

用 time.localtime() 方法，作用是格式化时间戳为本地的时间。

```python showLineNumbers
>> time.strftime('%Y-%m-%d',time.localtime(time.time()))
# 输出：'2018-10-23'
```

使用 time.strftime() 方法，把刚才的一大串信息格式化成我们想要的东西，现在的结果是：

输出日期和时间：

```python showLineNumbers
time.strftime('%Y-%m-%d %H:%M:%S',time.localtime(time.time()))
```

time.strftime 里面有很多参数，可以让你能够更随意的输出自己想要的东西，下面是 time.strftime 的参数：

```python showLineNumbers
strftime(format[, tuple]) -&gt; string
```

将指定的 struct_time（默认为当前时间），根据指定的格式化字符串输出。

python 中时间日期格式化符号：

```python showLineNumbers
%y  # 两位数的年份表示（00-99）
%Y  # 四位数的年份表示（000-9999）
%m  # 月份（01-12）
%d  # 月内中的一天（0-31）
%H  # 24小时制小时数（0-23）
%I  # 12小时制小时数（01-12） 
%M  # 分钟数（00=59）
%S  # 秒（00-59）
%a  # 本地简化星期名称
%A  # 本地完整星期名称
%b  # 本地简化的月份名称
%B  # 本地完整的月份名称
%c  # 本地相应的日期表示和时间表示
%j  # 年内的一天（001-366）
%p  # 本地A.M.或P.M.的等价符
%U  # 一年中的星期数（00-53）星期天为星期的开始
%w  # 星期（0-6），星期天为星期的开始
%W  # 一年中的星期数（00-53）星期一为星期的开始
%x  # 本地相应的日期表示
%X  # 本地相应的时间表示
%Z  # 当前时区的名称
%%  # %号本身 
```

## 随机数模块

`random()` 方法返回随机生成的一个实数，它在[0,1)范围内。以下是 random() 方法的语法:

```python showLineNumbers
import random
random.random()
```

注意：`random()` 是不能直接访问的，需要导入 random 模块，然后通过 random 静态对象调用该方法。

