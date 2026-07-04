---
sidebar_position: 25
slug: /cpp-datetime
---

# C++ 时间日期



C++ 通过头文件 `<ctime>` 提供了操作日期和时间的数据结构和函数。



## 头文件

使用 C++ 提供的日期/时间函数需要加载头文件 `<ctime>`。

```cpp showLineNumbers
#include <ctime>
```



## 数据结构

`<ctime>` 提供了四个类型的数据结构：`clock_t`、`time_t`、`size_t` 和 `tm`。

其中，类型 `clock_t` 、`size_t` 和 `time_t` 能够把系统时间和日期表示为某种整数，结构类型 `tm` 把日期和时间以结构体的形式保存。

`tm` 的定义如下：

```cpp showLineNumbers
struct tm {
  int tm_sec;   // 秒，正常范围从 0 到 59，但允许至 61
  int tm_min;   // 分，范围从 0 到 59
  int tm_hour;  // 小时，范围从 0 到 23
  int tm_mday;  // 一月中的第几天，范围从 1 到 31
  int tm_mon;   // 月，范围从 0 到 11
  int tm_year;  // 自 1900 年起的年数
  int tm_wday;  // 一周中的第几天，范围从 0 到 6，从星期日算起
  int tm_yday;  // 一年中的第几天，范围从 0 到 365，从 1月1日算起
  int tm_isdst; // 夏令时
}
```



## 相关函数

下表列出了头文件 `<ctime>` 提供的函数。

| 函数                                             | 描述                                                         |
| ------------------------------------------------ | ------------------------------------------------------------ |
| `time_t time(time_t *time)`                      | 返回自 1970 年 1 月 1 日以来经过的秒数。                     |
| `char *ctime(const time_t* time)`                | 返回一个表示当地时间的字符串指针，格式为 `day month year hours:minutes:seconds year\n\0`。 |
| `struct tm *localtime(const time_t* time)`       | 返回一个指向表示本地时间的 tm 结构的指针。                   |
| `clock_t clock(void)`                            | 返回程序执行起（一般为程序的开头），处理器时钟所使用的时间。如果时间不可用，则返回 -1。 |
| `char * asctime ( const struct tm * time )`      | 返回一个指向字符串的指针，字符串包含了 time 所指向结构中存储的信息，格式为：`day month date hours:minutes:seconds year\n\0`。 |
| `struct tm *gmtime(const time_t* time)`          | 返回一个指向 time 的指针，time 为 tm 结构，用协调世界时（UTC）也被称为格林尼治标准时间（GMT）表示。 |
| `time_t mktime(struct tm *time)`                 | 返回日历时间，相当于 time 所指向结构中存储的时间。           |
| `double difftime ( time_t time2, time_t time1 )` | 返回 time1 和 time2 之间相差的秒数。                         |
| `size_t strftime()`                              | 用于格式化日期和时间为指定的格式。                           |



## 当前日期和时间

以下示例通过 `time()` 函数获取自 '1970-01-01 00:00:00 以来经过的秒数，然后使用 `ctime()` 和 `gmtime()` 来格式化时间。

```cpp showLineNumbers
#include <iostream>
#include <ctime>

int main(void)
{
   // 获取基于当前系统的当前日期/时间
   time_t now = time(0);

   // 把 now 转换为字符串形式
   char* dt = ctime(&now);

   std::cout << "本地日期和时间：" << dt << std::endl;

   // 把 now 转换为 tm 结构
   tm *gmtm = gmtime(&now);
   dt = asctime(gmtm);

   std::cout << "UTC 日期和时间："<< dt << std::endl;

   return 0;
}
```

使用 `g++ main.cpp && ./a.out` 命令编译和运行上面代码，输出结果如下：

```bash
本地日期和时间：Sun Nov 28 01:59:34 2021

UTC 日期和时间：Sat Nov 27 17:59:34 2021

```



## 使用 tm 格式化时间

`tm` 以结构体的形式保存日期和时间，大多数与时间相关的函数都使用了 tm 结构。

下面的代码演示了 `tm` 结构体和各种与日期和时间相关的函数。

```cpp showLineNumbers
#include <iostream>
#include <ctime>

int main(void)
{
   // 获取基于当前系统的当前日期 / 时间
   time_t now = time(0);

   std::cout << "Number of sec since January 1,1970:";
   std::cout << now;
   std::cout << std::endl;

   tm *ltm = localtime(&now);

   // 输出 tm 结构的各个组成部分

   std::cout << "Year: "<< 1900 + ltm->tm_year << std::endl;
   std::cout << "Month: "<< 1 + ltm->tm_mon<< std::endl;
   std::cout << "Day: "<<  ltm->tm_mday << std::endl;
   std::cout << "Time: "<< 1 + ltm->tm_hour << ":";
   std::cout << 1 + ltm->tm_min << ":";
   std::cout << 1 + ltm->tm_sec << std::endl;

   return 0;
}
```

使用 `g++ main.cpp && ./a.out` 命令编译和运行上面代码，输出结果如下：

```bash
Number of sec since January 1,1970:1638036145
Year: 2021
Month: 11
Day: 28
Time: 3:3:26
```