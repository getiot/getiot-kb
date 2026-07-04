# C 语言实现万年历



## 项目介绍

万年历（Perpetual Calendar）是可以使用很多年的日历，通常设计成可以计算未来某一日期在星期中的日子。

本项目使用纯 C 语言，实现一个可以生成任意年份的万年历程序。该程序接收一个年份作为输入，然后打印出该年份各个月的日历。就如同我们平常看到的日历一样，每个月当中每天对应的星期均可查看。要求格式整齐，星期对照直观，并支持中英文输出。



## 代码思路

首先构思整个需求的思路，即接收一个年份，然后打印该年各个月的日历，其难点在于如何知道每个月的第一天是星期几，后面的天数即可依次循环打印即可。

本项目需要知道的其余几个小技术点和易出错点：

1. 判断闰年，这里判断不对易出错，方法是能被 4 整除并且能被 100 整除，或者是直接能被 400 整除。
2. 能判断出某月某天是这一年的第几天，方法是把这个月前面的天数加上这个月的天数。
3. 如何知道每个月多少天，这个除了二月其余月是固定的，可以提前写好（二月可以定 28 天也可以 29 天），特殊判定这年是否是闰年，来决定是否单独加一天或减一天。
4. 格式问题，熟练使用宏定义、switch 语句判断即可，做好实际数字与英文的对应打印。



## 代码实现

完整工程代码可以在 [GitHub](https://github.com/getiot/linux-c/tree/main/projects/perpetual_calendar) 仓库获取。

```c showLineNumbers title="calendar.c"
#include <stdio.h>

#define Mon            1
#define Tues           2
#define Wed            3
#define Thur           4
#define Fri            5
#define Sat            6
#define Sun            0

#define January_days   31
#define February_days  28
#define March_days     31
#define April_days     30
#define May_days       31
#define June_days      30
#define July_days      31
#define August_days    31
#define September_days 30
#define October_days   31
#define November_days  30
#define December_days  31

#define first1month    (January_days)
#define first2month    (first1month + February_days)
#define first3month    (first2month + March_days)
#define first4month    (first3month + April_days)
#define first5month    (first4month + May_days)
#define first6month    (first5month + June_days)
#define first7month    (first6month + July_days)
#define first8month    (first7month + August_days)
#define first9month    (first8month + September_days)
#define first10month   (first9month + October_days)
#define first11month   (first10month + November_days)

char *month_names_en[] = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
char *month_names_zh[] = {"一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"};

int known_weekday = Tues;
int known_year = 1901;
int konwn_month = 1;
int known_day = 1;

int day_count(int month)
{
    switch(month)
    {
    case 1: return 0; break;
    case 2: return first1month; break;
    case 3: return first2month; break;
    case 4: return first3month; break;
    case 5: return first4month; break;
    case 6: return first5month; break;
    case 7: return first6month; break;
    case 8: return first7month; break;
    case 9: return first8month; break;
    case 10: return first9month; break;
    case 11: return first10month; break;
    case 12: return first11month; break;
    }
}

char *get_month_name(int month)
{
    if (month < 1 || month > 12) {
        return "";
    }

#ifdef PRINT_IN_CHINESE
    return month_names_zh[month-1];
#else
    return month_names_en[month-1];
#endif
}

/* 按格式打印某年某月名称 */
void print_month_header(int month, int year)
{
#ifdef PRINT_IN_CHINESE
    printf("%15d年 %s \n", year, get_month_name(month));
#else
    printf("%17s %d \n", get_month_name(month), year);
#endif
}

/* 按格式打印星期名称 */
void print_week_header()
{
#ifdef PRINT_IN_CHINESE
    printf(" %-6s%-6s%-6s%-6s%-6s%-6s%-6s\n","日", "一", "二", "三", "四", "五", "六");
#else
    printf("%-5s%-5s%-5s%-5s%-5s%-5s%-5s\n","Sun.", "Mon.", "Tue.", "Wed.", "Thu.", "Fri.", "Sat.");
#endif
}
  
/* 计算该年该月份与已知日子之间的距离天数 */
int date_distance_count(int month, int year)
{
    int leap_year_count = 0;
    int i;
    int distance;
     
    if (year > known_year)
    {
        for (i=known_year; i<year; i++)
        {
            if(((i%4 == 0) && (i%100 != 0) ) || (i%400 == 0))
            {
                leap_year_count++;
            }
        }
         
        if (month > 2)
        {
            if(((year%4 == 0) && (year%100 != 0) ) || (year%400 == 0))
            {
                leap_year_count++;
            }
        }
    }
    else {
        if (year == known_year)
        {
            if (month > 2)
            {
                leap_year_count = 1;
            }
        }
    }
     
    distance = (year - known_year) * 365 + leap_year_count + day_count(month);
    return distance;
}

/* 确定该月份第一天是星期几 */
int makesure_firstday_weekday(int month, int year)
{
    int date_distance = 0;
    int weekday;
     
    date_distance = date_distance_count(month, year);
    weekday = (known_weekday + date_distance) % 7;
     
    return weekday;
}

/* 依次打印出该月份的日子 */
void print_in_turn(int month, int firstday, int year)
{
    int i = 1;
    int weekday;
     
    switch(firstday)
    {
    case Sun:
        break;
    case Mon:
        printf("%-5s", "");
        break;
    case Tues:
        printf("%-10s", "");
        break;
    case Wed:
        printf("%-15s", "");
        break;
    case Thur:
        printf("%-20s", "");
        break;
    case Fri:
        printf("%-25s", "");
        break;
    case Sat:
        printf("%-30s", "");
        break;
    }
     
    switch(month)
    {
    case 1:
    case 3:
    case 5:
    case 7:
    case 8:
    case 10:
    case 12:
        {
            for(i=0; i<31; i++)
            {
                weekday = (firstday + i) % 7;
                printf("%3d  ", i+1);
                 
                if(weekday == Sat)
                {
                    printf("\n");
                }
            }
            break;
        }
    case 2:
        {
            if(((year%4 == 0) && (year%100 != 0) ) || (year%400 == 0)) /*闰年*/
            {
                for(i=0; i<29; i++)
                {
                    weekday = (firstday + i) % 7;
                    printf("%3d  ", i+1);
                     
                    if(weekday == Sat)
                    {
                        printf("\n");
                    }
                }
                break;
            }
            else /*平年*/
            {
                for(i=0; i<28; i++)
                {
                    weekday = (firstday + i) % 7;
                    printf("%3d  ", i+1);
                     
                    if(weekday == Sat)
                    {
                        printf("\n");
                    }
                }
                break;
            }
             
        }
    case 4:
    case 6:
    case 9:
    case 11:
        {
            for(i=0; i<30; i++)
            {
                weekday = (firstday + i) % 7; /*计算该天是星期几*/
                printf("%3d  ", i+1);
                 
                if(weekday == Sat)
                {
                    printf("\n"); /*如果是星期六，则换行*/
                }
            }
            break;
        }
    }
}
  
void print_date(int month, int year)
{
    int firstday;
     
    firstday = makesure_firstday_weekday(month, year);
    print_in_turn(month, firstday, year);
    printf("\n");
}
  
void print_month(int month, int year)
{
    print_month_header(month, year);
    print_week_header();
    print_date(month, year);
    printf("\n\n");
}
  
void print_calendar(int year)
{
    int i;
    for(i=1; i<=12; i++)
    {
        print_month(i, year);
    }
}
  
int main()
{
    int year;
    printf("请输入年份：year = ");
    scanf("%d", &year);
    printf("\n");
     
    while(year < 1902) {
        printf("请输入大于1901的年份\n");
        printf("请输入年份：year = ");
        scanf("%d", &year);
        printf("\n");
    }
     
    print_calendar(year);
    return 0;
}
```



## 编译运行

打开终端，切换到 calendar.c 文件所在目录，执行下面命令编译程序：

```bash
gcc calendar.c -o calendar
```

如果你从 [GitHub](https://github.com/getiot/linux-c/tree/main/projects/perpetual_calendar) 下载了完整工程，那么可以直接执行 `make` 编译：

```bash
$ make
```

默认为英文输出，如果需要中文输出，可以在编译时添加 `PRINT_IN_CHINESE` 宏定义：

```bash
$ make CFLAGS=-DPRINT_IN_CHINESE
```

或者直接修改 Makefile 文件，添加 `CFLAGS += -D PRINT_IN_CHINESE` 宏定义。

编译完成后，执行程序 `./calendar`，输入要生成的年份（例如 2024），日历输出如下：

```bash
$ ./calendar 
请输入年份：year = 2024

          January 2024 
Sun. Mon. Tue. Wed. Thu. Fri. Sat. 
       1    2    3    4    5    6  
  7    8    9   10   11   12   13  
 14   15   16   17   18   19   20  
 21   22   23   24   25   26   27  
 28   29   30   31  


         February 2024 
Sun. Mon. Tue. Wed. Thu. Fri. Sat. 
                      1    2    3  
  4    5    6    7    8    9   10  
 11   12   13   14   15   16   17  
 18   19   20   21   22   23   24  
 25   26   27   28   29  


            March 2024 
Sun. Mon. Tue. Wed. Thu. Fri. Sat. 
                           1    2  
  3    4    5    6    7    8    9  
 10   11   12   13   14   15   16  
 17   18   19   20   21   22   23  
 24   25   26   27   28   29   30  
 31  


            April 2024 
Sun. Mon. Tue. Wed. Thu. Fri. Sat. 
       1    2    3    4    5    6  
  7    8    9   10   11   12   13  
 14   15   16   17   18   19   20  
 21   22   23   24   25   26   27  
 28   29   30  


              May 2024 
Sun. Mon. Tue. Wed. Thu. Fri. Sat. 
                 1    2    3    4  
  5    6    7    8    9   10   11  
 12   13   14   15   16   17   18  
 19   20   21   22   23   24   25  
 26   27   28   29   30   31  


             June 2024 
Sun. Mon. Tue. Wed. Thu. Fri. Sat. 
                                1  
  2    3    4    5    6    7    8  
  9   10   11   12   13   14   15  
 16   17   18   19   20   21   22  
 23   24   25   26   27   28   29  
 30  


             July 2024 
Sun. Mon. Tue. Wed. Thu. Fri. Sat. 
       1    2    3    4    5    6  
  7    8    9   10   11   12   13  
 14   15   16   17   18   19   20  
 21   22   23   24   25   26   27  
 28   29   30   31  


           August 2024 
Sun. Mon. Tue. Wed. Thu. Fri. Sat. 
                      1    2    3  
  4    5    6    7    8    9   10  
 11   12   13   14   15   16   17  
 18   19   20   21   22   23   24  
 25   26   27   28   29   30   31  



        September 2024 
Sun. Mon. Tue. Wed. Thu. Fri. Sat. 
  1    2    3    4    5    6    7  
  8    9   10   11   12   13   14  
 15   16   17   18   19   20   21  
 22   23   24   25   26   27   28  
 29   30  


          October 2024 
Sun. Mon. Tue. Wed. Thu. Fri. Sat. 
            1    2    3    4    5  
  6    7    8    9   10   11   12  
 13   14   15   16   17   18   19  
 20   21   22   23   24   25   26  
 27   28   29   30   31  


         November 2024 
Sun. Mon. Tue. Wed. Thu. Fri. Sat. 
                           1    2  
  3    4    5    6    7    8    9  
 10   11   12   13   14   15   16  
 17   18   19   20   21   22   23  
 24   25   26   27   28   29   30  



         December 2024 
Sun. Mon. Tue. Wed. Thu. Fri. Sat. 
  1    2    3    4    5    6    7  
  8    9   10   11   12   13   14  
 15   16   17   18   19   20   21  
 22   23   24   25   26   27   28  
 29   30   31  

```

