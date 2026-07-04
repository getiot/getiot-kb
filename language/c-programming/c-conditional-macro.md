---
sidebar_position: 32
---

# C 语言 - 条件宏



```c showLineNumbers
#if defined(A) && defined(B)
```



```c showLineNumbers
#ifdef A && B
```



示例

```c showLineNumbers
#if defined (MAX) && ! defined (MIN)  
```



```c showLineNumbers
#ifdef max 
#ifndef min
```



示例

```c showLineNumbers
#define A
#define B
#if(defined A && defined B)
printf("define test");
#endif
```



```c showLineNumbers
#ifdef A
#ifdef B
printf("define test");
#endif
#endif
```

