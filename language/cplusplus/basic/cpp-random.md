---
sidebar_position: 26
slug: /cpp-random
---

# C++ 随机数



在程序设计中，有许多情况需要生成随机数，C++ 标准库 `<cstdlib>` 中有两个和生成随机数有关的函数。

| 函数                            | 说明                     |
| ------------------------------- | ------------------------ |
| `int rand(void)`                | 返回一个伪随机数         |
| `void srand(unsigned int seed)` | 用于伪随机数生成算法播种 |

解释一下什么叫做播种，播种就是类似于我们摇骰子中不断的左右摇晃的次数，摇的次数不一样生成的随机数不一样的概念就更大。

C++ 中一般使用标准库 `<ctime>` 中的函数 `time()` 返回的时间戳当作随机数播种时的种子。

**示例：生成 100 以内的随机数**

```cpp showLineNumbers
#include <iostream>
#include <ctime>
#include <cstdlib>

int main ()
{
    int i, j;

    // 设置种子
    srand((unsigned)time(NULL));

    /* 生成 10 个随机数 */
    for (i=0; i<10; i++) {
        // 生成实际的随机数
        j = rand();
        std::cout << j << std::endl;
    }

    return 0;
}
```

编译和运行以上示例，输出结果如下：

```bash
64
76
63
35
47
63
67
76
73
32
```

多运行几次，就会发现每次生成的都不一样。