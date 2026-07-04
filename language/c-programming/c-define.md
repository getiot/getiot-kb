---
sidebar_position: 31
---

# C 语言 - define 宏定义



### 宏定义的数据类型

浮点数

```c showLineNumbers
#include <stdio.h>
#define PI   3.14159f               

int main(void)
{
  float radius = 0.0f;
  float diameter = 0.0f;
  float circumference = 0.0f;
  float area = 0.0f;

  printf("Input the diameter of a table:");
  scanf("%f", &diameter);
  radius = diameter/2.0f;
  circumference = 2.0f*PI*radius;
  area = PI*radius*radius;
  printf("\nThe circumference is %.2f", circumference);
  printf("\nThe area is %.2f", area);
  return 0;
}
Input the diameter of a table:123
     
     The circumference is 386.42
     The area is 11882.28
```
