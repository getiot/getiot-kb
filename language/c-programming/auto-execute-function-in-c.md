---
sidebar_position: 46
draft: true
---

# 自动执行 C 函数

With GCC family of C compilers, we can mark some functions to execute before and after main(). So some startup code can be executed before main() starts, and some cleanup code can be executed after main() ends. For example, in the following program, myStartupFun() is called before main() and myCleanupFun() is called after main().

使用 GCC 系列的 C 编译器，我们可以在 main() 之前和之后标记一些要执行的函数。 所以有些启动代码可以在main()开始之前执行，有些清理代码可以在main()结束之后执行。 例如，在下面的程序中，在 main() 之前调用 myStartupFun()，在 main() 之后调用 myCleanupFun()。

```c showLineNumbers
#include<stdio.h>
  
/* Apply the constructor attribute to myStartupFun() so that it
    is executed before main() */
void myStartupFun (void) __attribute__ ((constructor));
  
  
/* Apply the destructor attribute to myCleanupFun() so that it
   is executed after main() */
void myCleanupFun (void) __attribute__ ((destructor));
  
  
/* implementation of myStartupFun */
void myStartupFun (void)
{
    printf ("startup code before main()\n");
}
  
/* implementation of myCleanupFun */
void myCleanupFun (void)
{
    printf ("cleanup code after main()\n");
}
  
int main (void)
{
    printf ("hello\n");
    return 0;
}
```

执行结果

```shell
startup code before main()
hello
cleanup code after main()
```

Like the above feature, GCC has added many other interesting features to standard C language. See [this](http://drdobbs.com/cpp/184401956) for more details.

**Related Article :**
[Executing main() in C – behind the scene](https://www.geeksforgeeks.org/executing-main-in-c-behind-the-scene/)

Please write comments if you find anything incorrect, or you want to share more information about the topic discussed above.

Want to learn from the best curated videos and practice problems, check out the **[C Foundation Course](https://practice.geeksforgeeks.org/courses/C-Foundation?utm_source=GeeksforGeeks&utm_medium=Text&utm_campaign=GFG_Article_Bottom_Text_C)** for Basic to Advanced C.





## 参考

- [Functions that are executed before and after main() in C](https://www.geeksforgeeks.org/functions-that-are-executed-before-and-after-main-in-c/)