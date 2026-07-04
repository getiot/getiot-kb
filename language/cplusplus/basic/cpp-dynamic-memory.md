---
sidebar_position: 43
slug: /cpp-dynamic-memory
---

# C++ 动态内存



动态内存（Dynamic Memory）就是指在程序执行的过程中动态地分配或者回收存储空间（内存）的内存使用方式。动态内存在 C++ 程序中经常用到，使用 `new` 关键字可以动态分配内存，而 `delete` 关键字可以删除由 `new` 关键字分配的内存。



## 动态内存

想成为一名合格的 C++ 开发者，必须知道动态内存在 C++ 中是如何工作的。C++ 程序中的内存分为两个部分：

- **栈**：在函数内部声明的所有变量（局部变量）都将占用栈内存。
- **堆**：这是程序中未使用的内存，在程序运行时可用于动态分配内存。

很多时候，我们无法提前预知需要多少内存来存储某个定义变量中的特定信息，所需内存的大小需要在运行时才能确定。因此，C++ 为我们提供了 `new` 关键字用于动态内存分配。

使用 `new` 即可为给定类型的变量在运行时分配堆内的内存，然后返回所分配的空间地址；一旦不需要动态分配的内存，可以使用 `delete` 运算符来删除由 new 运算符分配的内存。



## new 和 delete 运算符

`new` 运算符可以为任意的数据类型动态分配内存。语法格式如下：

```cpp showLineNumbers
new data-type;
```

这里的 `data-type` 可以是包括数组在内的任意内置的数据类型，也可以是包括类或结构在内的用户自定义的任何数据类型。例如，可以定义一个指向 double 类型的指针，然后请求内存，该内存在执行时被分配。代码如下：

```cpp showLineNumbers
double *pvalue = NULL;  // 初始化为 null 的指针
pvalue = new double;    // 为变量请求内存
```

如果自由存储区已被用完，可能无法成功分配内存。所以建议检查 `new` 运算符是否返回 `NULL` 指针，并采取以下适当的操作。

```cpp showLineNumbers
double* pvalue = new double;

if (!(pvalue)) {
    cout << "Error: out of memory." << endl;
    exit(1);
}
```

**注意**：`malloc()` 函数在 C 语言用于动态内存分配，C++ 中仍然存在，但建议尽量不要使用 `malloc()` 函数。`new` 与 `malloc()` 函数相比，其主要优点是，`new` 不只是分配了内存，它还创建了对象。

如果某个已经动态分配内存的变量不再需要使用了，可以使用 `delete` 操作符释放它所占用的内存。如下所示：

```cpp showLineNumbers
delete pvalue;        // 释放 pvalue 所指向的内存
```



## 示例

下面示例演示如何使用 new 和 delete 来分配和释放动态内存。

```cpp showLineNumbers
#include <iostream>
using namespace std;

int main ()
{
    double* pvalue = NULL;    // 初始化为 null 的指针
    pvalue = new double;      // 为变量请求内存
    
    *pvalue = 3.1415926;       // 在分配的地址存储值
    cout << "Value of pvalue : " << *pvalue << endl;
    
    delete pvalue;             // 释放内存
    return 0;
}
```

执行 `g++ main.cpp && ./a.out` 编译运行以上示例，输出结果如下：

```cpp showLineNumbers
Value of pvalue : 3.14159
```



## 数组的内存动态分配

同样，我们可以使用 `new` 关键字给一个字符数组动态分配内存。比如，我们给一个长度为 20 的字符数组动态分配内存，语句如下：

```cpp showLineNumbers
char *pvalue = NULL;    // 初始化为 null 的指针
pvalue = new char[20];  // 为变量请求内存
```

如果要删除我们刚才创建的数组，语句如下：

```cpp showLineNumbers
delete []pvalue;        // 删除 pvalue 所指向的数组
```

### 一维数组

可以使用 `new` 或 `delete` 关键字给一维数组动态分配内存或删除它们，语句如下：

```cpp showLineNumbers
int *array = new int [m];  // 动态分配,数组长度为 m
delete [] array;           // 释放内存
```

### 二维数组

使用 `new` 或 `delete` 关键字给二维数组动态分配内存或删除它们，语句如下：

```cpp showLineNumbers
int **array

// 假定数组第一维长度为 m， 第二维长度为 n
// 动态分配空间

array = new int *[m];
for (int i=0; i<m; i++)
{
    array[i] = new int [n];
}

// 释放
for (int i=0; i<m; i++)
{
    delete [] arrar[i];
}
delete [] array;
```

**示例**：二维数组的动态内存分配

```cpp showLineNumbers
#include <iostream>
using namespace std;

int main()
{
    int **p;   
    int i, j;   // p[4][8]
    
    // 开始分配4行8列的二维数据
    p = new int *[4];
    for (i=0; i<4; i++) {
        p[i] = new int [8];
    }

    // 填充数据
    for (i=0; i<4; i++) {
        for (j=0; j<8; j++) {
            p[i][j] = j*i;
        }
    }
    
    // 打印数据
    for (i=0; i<4; i++) {
        for (j=0; j<8; j++)     
        {
            if (j==0) cout << endl;
            cout << p[i][j] << "\t";
        }
    }
    
    // 开始释放申请的堆
    for (i=0; i<4; i++) {
        delete [] p[i];
    }
    
    delete [] p;
    return 0;
}
```

### 三维数组

```cpp showLineNumbers
int ***array;
// 假定数组第一维为 m，第二维为 n，第三维为h
// 动态分配空间
array = new int **[m];
for (int i=0; i<m; i++)
{
    array[i] = new int *[n];
    for (int j=0; j<n; j++)
    {
        array[i][j] = new int [h];
    }
}
//释放
for (int i=0; i<m; i++)
{
    for (int j=0; j<n; j++)
    {
        delete array[i][j];
    }
    delete array[i];
}
delete [] array;
```

**示例**：给三维数组动态分配内存

```cpp showLineNumbers
#include <iostream>
using namespace std;

int main()
{   
    int i, j, k;   // p[2][3][4]

    int ***p;
    p = new int **[2]; 
    for (i=0; i<2; i++) {
        p[i] = new int *[3]; 
        for (j=0; j<3; j++)
            p[i][j] = new int[4];
    }

    //输出 p[i][j][k] 三维数据
    for (i=0; i<2; i++) {
        for (j=0; j<3; j++) {
            for (k=0; k<4; k++) {
                p[i][j][k] = i+j+k;
                cout << p[i][j][k] << " ";
            }
            cout << endl;
        }
        cout<<endl;
    }

    // 释放内存
    for (i=0; i<2; i++) {
        for (j=0; j<3; j++) {
            delete [] p[i][j];
        }
    }
    for (i=0; i<2; i++) {       
        delete [] p[i];   
    }
    delete [] p;
    return 0;
}
```



## 对象的动态内存分配

在 C++ 中，对象动态分配内存与给简单的数据类型没有什么不同。例如，下面示例中创建了一个包含 4 个 Box 对象的数组。

```cpp showLineNumbers
#include <iostream>
using namespace std;

class Box
{
public:
    Box() {
        cout << "调用构造函数 :)" << endl;
    }
    ~Box() {
        cout << "调用析构函数 _(:з」∠)_" <<endl;
    }
};

int main(void)
{
    Box* myBoxArray = new Box[4];
    
    delete [] myBoxArray; // 删除数组
    return 0;
}
```

编译运行以上示例，输出结果如下：

```bash
调用构造函数 :)
调用构造函数 :)
调用构造函数 :)
调用构造函数 :)
调用析构函数 _(:з」∠)_
调用析构函数 _(:з」∠)_
调用析构函数 _(:з」∠)_
调用析构函数 _(:з」∠)_
```

