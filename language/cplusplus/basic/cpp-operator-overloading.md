---
sidebar_position: 34
slug: /cpp-operator-overloading
---

# C++ 运算符重载

在 C++ 中，重载是指一个与之前已经在该作用域内声明过的函数或方法具有相同名称的声明，但是它们的参数列表和定义不相同。C++ 允许在同一作用域中的某个运算符指定多个定义，称为**运算符重载**。



## 运算符重载

C++ 使用关键字 `operator` 重载运算符，并允许重定义或重载大部分 C++ 内置的运算符。**重载的运算符是带有特殊名称的函数**，函数名是由关键字 `operator` 和其后要重载的运算符符号构成的。

与其它函数一样，重载运算符有一个返回类型和一个参数列表。例如：

```cpp showLineNumbers
Cube operator+(const Cube&);
```

重载加法（`+`）运算符用于把两个 `Cube` 对象相加，返回最终的 `Cube` 对象。

大多数的重载运算符可被定义为普通的非成员函数，或者被定义为类成员函数。如果我们将上面的函数定义为类的非成员函数，那么需要为每次操作传递两个参数。

```cpp showLineNumbers
Cube operator+(const Cube&, const Cube&);
```

下面通过一个示例加深对运算符重载的理解，在这个示例中，对象作为参数进行传递，对象的属性使用 `this` 运算符进行访问。

```cpp showLineNumbers
#include <iostream>
using namespace std;

class Cube
{
public:
    double getVolume(void)
    {
        return length * width * height;
    }

    void setLength( double l )
    {
        length = l;
    }

    void setWidth( double w )
    {
        width = w;
    }

    void setHeight( double h )
    {
        height = h;
    }

    // 重载 + 运算符，用于把两个 Cube 对象相加
    Cube operator+(const Cube& b)
    {
        Cube c;

        c.length = this->length + b.length;
        c.width  = this->width  + b.width;
        c.height = this->height + b.height;

        return c;
    }

private:
    double length;    // 长度
    double width;     // 宽度
    double height;    // 高度
};

int main( )
{
    Cube c1;                // 声明 c1，类型为 Cube
    Cube c2;                // 声明 c2，类型为 Cube
    Cube c3;                // 声明 c3，类型为 Cube
    double volume = 0.0;    // 把体积存储在该变量中

    // 设置 c1 属性
    c1.setLength(10.0); 
    c1.setWidth(10.0); 
    c1.setHeight(10.0);

    // 设置 c2 属性
    c2.setLength(20.0); 
    c2.setWidth(20.0); 
    c2.setHeight(20.0);

    // 获取 c1 的体积
    volume = c1.getVolume();
    cout << "Volume of c1 : " << volume << endl;

    // 获取 c2 的体积
    volume = c2.getVolume();
    cout << "Volume of c2 : " << volume << endl;

    // 把两个对象相加，得到 c3
    c3 = c1 + c2;

    // 获取 c3 的体积
    volume = c3.getVolume();
    cout << "Volume of c3 : " << volume << endl;

    return 0;
}
```

使用 `g++ main.cpp && ./a.out` 命令编译运行以上示例，输出结果如下：

```bash
Volume of c1 : 1000
Volume of c2 : 8000
Volume of c3 : 27000
```



## 运算符符号

### 可重载运算符

下表列出的是 C++ 中允许重载的运算符。

```cpp showLineNumbers
 +      -      *      /        %        ^
 &      |      ~      !        ,        =
 <      >      <=     >=       ++       --
 <<     >>     ==     !=       &&       ||
 +=     -=     /=     %=       ^=       &=
 |=     *=     <<=    >>=      []       ()
 ->     ->*    new    new []   delete   delete []
```


### 不可重载运算符

C++ 中不可重载的运算符有四个：`::`、`.*`、`.`、`?:`。



## 运算符重载示例

下面是一些 C++ 运算符重载示例，包括算术运算符、赋值运算符、逻辑运算符、成员运算符、关系运算符等等，这些都是使用频率较高的几个运算符重载案例。

所有示例代码均存放于 [GitHub: getiot/cpp-courses/operator_overloading](https://github.com/getiot/cpp-courses/tree/main/operator_overloading) 。



### 示例 1：一元运算符重载

一元运算符即只对一个操作数进行操作的运算符，例如：`!obj`、`-obj`、`++obj` 、`obj++` 或 `obj--` 等等。

下面示例将对负号（`-`）进行重载：

```cpp showLineNumbers
#include <iostream>
using namespace std;

class Distance
{
private:
    int feet;    // 0 到无穷
    int inches;  // 0 到 12
public:
    // 构造函数
    Distance() {
        feet = 0;
        inches = 0;
    }
    Distance(int f, int i) {
        feet = f;
        inches = i;
    }
    
    // 显示距离
    void displayDistance() {
        cout << "F: " << feet << ", I: " << inches << endl;
    }
    
    // 重载负运算符 ( - )
    Distance operator- () {
        feet = -feet;
        inches = -inches;
        return Distance(feet, inches);
    }
};

int main(void)
{
    Distance d1(1, 10), d2(-5, 110);
    
    -d1;                     // 取相反数
    d1.displayDistance();    // 距离 D1
    
    -d2;                     // 取相反数
    d2.displayDistance();    // 距离 D2
    
    return 0;
}
```

编译并运行以上示例，输出结果如下：

```bash
F: -1, I: -10
F: 5, I: -110
```



### 示例 2：二元运算符重载

二元运算符即需要两个参数的运算符，例如：加运算符（`+`）、减运算符（`-`）、乘运算符（`*`）、除运算符（`/`）。

下面示例将重载加运算符（`+`）：

```cpp showLineNumbers
#include <iostream>
using namespace std;

class Box
{
    double length;  // 长度
    double width;   // 宽度
    double height;  // 高度

public:
    Box () {
        length = 0.0;
        width  = 0.0;
        height = 0.0;
    }

    Box (double a, double b ,double c)
    {
        length = a;
        width  = b;
        height = c;        
    }

    double getVolume(void)
    {
        return length * width * height;
    }

    // 重载 + 运算符，用于把两个 Box 对象相加
    Box operator+(const Box& b)
    {
        Box box;
        box.length = this->length + b.length;
        box.width  = this->width + b.width;
        box.height = this->height + b.height;
        return box;
    }
};

int main(void)
{
    Box b1(5.0, 4.0, 3.0);
    Box b2(6.0, 5.0, 4.0);
    Box b3;

    cout << "Volume of b1 : " << b1.getVolume() << endl;
    cout << "Volume of b2 : " << b2.getVolume() << endl;

    // 把两个对象相加，得到 Box3
    b3 = b1 + b2;

    // Box3 的体积
    cout << "Volume of b3 : " << b3.getVolume() << endl;

    return 0;
}
```

使用 `g++ main.cpp && ./a.out` 命令编译运行以上示例，输出结果如下：

```bash
Volume of b1 : 60
Volume of b2 : 120
Volume of b3 : 693
```



### 示例 3：关系运算符重载

C++ 允许重载任何一个关系运算符（例如 `<`、`>`、`<=`、`>=`、`==` 等），重载后的关系运算符可用于比较类的对象。许多 C++ 内置的数据类型也都支持各种关系运算符。

下面示例将重载小于符（`<`）：

```cpp showLineNumbers
#include <iostream>
using namespace std;

class Rect
{
private:
    double width;
    double height;

public:
    Rect(double a, double b)
    {
        width  = a;
        height = b;
    }

    double area() {
        return width * height;
    }

    // 重载小于运算符 ( < ), 按照面积比大小
    bool operator<(Rect& that)
    {
        return this->area() < that.area();
    }
};

int main()
{
    Rect r1(3.0, 5.0), r2(3.5, 4.5);

    cout << "Area of r1 = " << r1.area() << endl;
    cout << "Area of r2 = " << r2.area() << endl;

    if ( r1 < r2 )
        cout << "r1 is less than r2" << endl;
    else
        cout << "r1 is large than r2" << endl;

   return 0;
}
```

编译运行以上代码，输出结果如下：

```bash
Area of r1 = 15
Area of r2 = 15.75
r1 is less than r2
```



### 示例 4：输入/输出运算符重载

C++ 使用**流提取运算符**（`>>`）和**流插入运算符**（`<<`）来输入和输出内置的数据类型，同时也允许重载 `>>` 和 `<<` 来操作对象等用户自定义的数据类型。

可以把运算符重载函数声明为类的友元函数，这样就可以不用创建对象而直接调用函数。

```cpp showLineNumbers
#include <iostream>
using namespace std;

class Rect
{
public:
    double width;
    double height;

    Rect() {
        width = 0;
        height = 0;
    }

    Rect(double a, double b )
    {
        width  = a;
        height = b;
    }

    double area() {
        return width * height;
    }

    friend std::ostream &operator<<(std::ostream &output, Rect &r)
    { 
        output << "width: " << r.width << ", ";
        output << "height: " << r.height << ", ";
        output << "area: " << r.area();

        return output;
    }

    friend std::istream &operator>>(std::istream &input, Rect &r)
    {
        input >> r.width >> r.height;
        return input;            
    }
};

int main()
{
    Rect r1(3.0, 4.0), r2(6.0, 8.0), r3;
    
    cout << "Enter the value of object: \n";
    cin >> r3;
    cout << "r1: " << r1 << endl;
    cout << "r2: " << r2 << endl;
    cout << "r3: " << r3 << endl;
    
    return 0;
}
```

编译和运行以上示例，输出结果如下：

```bash
Enter the value of object: 
2 3
r1: width: 3, height: 4, area: 12
r2: width: 6, height: 8, area: 48
r3: width: 2, height: 3, area: 6
```



### 示例 5：++ 和 -- 运算符重载

递增运算符（`++`）和递减运算符（`--`）是 C++ 语言中两个重要的一元运算符，包括前缀和后缀两种用法。

下面示例将演示如何重载前缀自增（`++obj`）和后缀自减运算符（`obj--`）：

```cpp showLineNumbers
#include <iostream>
using namespace std;

class Time
{
private:
    int minute;             
    int second;

public:
    Time () {
        minute = 0;
        second = 0;
    }

    Time (int m, int s) {
        minute = m;
        second = s;
    }

    void display() {
        cout << minute << " : " << second << endl;
    }

    // 重载前缀递增运算符 ( ++ )
    Time operator++() {
        second++;

        if (second >= 60) {
            minute++;
            second = 0;
        }

        return Time(minute, second);
      }
    
    // 重载后缀递增运算符（ ++ ）
    Time operator++(int)
    {
        Time t(minute, second);  // 保存原始值
        second++;                // 对象加 1

        if (second >= 60) {
            minute++;
            second = 0;
        }

        return t;  // 返回旧的原始值
    }
};

int main()
{
    Time t1(12, 58), t2(0,45);
    
    t1.display();
    (++t1).display();
    (++t1).display();
    
    t2.display();
    (t2++).display();
    (t2++).display();
    
    return 0;
}
```

编译运行以上示例，输出结果如下：

```bash
12 : 58
12 : 59
13 : 0
0 : 45
0 : 45
0 : 46
```



### 示例 6：赋值运算符重载

C++ 允许重载赋值运算符（`=`），用于创建一个对象，比如拷贝构造函数。

下面示例重载 `Rect` 中的赋值运算符，并在每次拷贝的时候就把长度和宽度数值各加 1。

```cpp showLineNumbers
#include <iostream>
using namespace std;

class Rect
{
private:
    double width;
    double height;

public:
    Rect() {
        width = 0;
        height = 0;
    }

    Rect(double a, double b) {
        width = a;
        height = b;
    }

    void display() {
        cout << " width: " << width;
        cout << " height: " << height;
    }

    void operator= (const Rect &r)
    {
        width = r.width + 1;
        height = r.height + 1;
    }
};

int main()
{
    Rect r1(3.0, 4.0), r2;
    
    r2 = r1;

    cout << "r1: ";
    r1.display();
    cout << endl;

    cout << "r2: ";
    r2.display();
    cout << endl;

    return 0;
}
```

编译和运行以上示例，输出结果如下：

```bash
r1:  width: 3 height: 4
r2:  width: 4 height: 5
```



### 示例 7：函数调用运算符重载

C++ 允许重载函数调用运算符（即 `()` 符号）。重载 `()` 的目的不是为了创造一种新的调用函数的方式，而是创建一个可以传递任意个参数的运算符函数。其实就是创建一个可调用的对象。

下面示例将演示重载函数调用运算符的妙用：

```cpp showLineNumbers
#include <iostream>
using namespace std;

class Rect
{
private:
    int width;
    int height;

public:
    Rect() {
        width  = 0;
        height = 0;
    }

    Rect(int a ,int b) {
        width  = a;
        height = b;
    }

    void operator()() {
        cout << "Area of myself is:" << width * height << endl;
    }
};

int main()
{
    Rect r1(3, 4), r2(6, 8);

    cout << "r1: "; 
    r1();

    cout << "r2: ";
    r2();
    
    return 0;
}
```

编译和运行以上示例，输出结果如下：

```bash
r1: Area of myself is:12
r2: Area of myself is:48
```



### 示例 8：下标运算符重载

下标操作符（`[]`）通常用于访问数组元素。C++ 允许重载下标运算符用于增强操作 C++ 数组的功能，重载下标运算符最重要的作用就是设置一个哨兵，防止数组访问越界。

下面示例演示重载下标运算符：

```cpp showLineNumbers
#include <iostream>
using namespace std;

const int SIZE = 10;

class Fibo
{
private:
    // 偷懒，防止把 SIZE 设置的过小
    int arr[SIZE+3];

public:
    Fibo() {
        arr[0] = 0;
        arr[1] = 1;

        for(int i=2; i<SIZE; i++) {
            arr[i] = arr[i-2] + arr[i-1];
        }
    }

    int& operator[](unsigned int i) {
        if (i >= SIZE) {
            std::cout << "(索引超过最大值) ";
            return arr[0]; // 返回第一个元素
        }
        return arr[i];
    }
};

int main()
{
    Fibo fb;
    
    for (int i=0; i<SIZE+1; i++) {
        cout << fb[i] << " ";
    }
    cout << endl;
    
    return 0;
}
```

编译和运行以上示例，输出结果如下：

```bash
0 1 1 2 3 5 8 13 21 34 (索引超过最大值) 0
```



### 示例 9：类成员访问运算符重载

C++ 允许重载类成员访问运算符（`->`），用于为一个类赋予 "指针" 行为。重载 `->` 运算符时需要注意以下几点：

- 运算符 `->` 必须是一个成员函数；
- 如果使用了 `->` 运算符，返回类型必须是指针或者是类的对象；
- 运算符 `->` 通常与指针引用运算符 `*` 结合使用，用于实现智能指针的功能；
- 这些指针是行为与正常指针相似的对象，唯一不同的是，通过指针访问对象时，它们会执行其它的任务（比如，当指针销毁时，或者当指针指向另一个对象时，会自动删除对象）。

间接引用运算符 `->` 可被定义为一个一元后缀运算符，比如：

```cpp showLineNumbers
class Ptr{
   //...
   X * operator->();
};
```

类 `Ptr` 的对象可用于访问类 `X` 的成员，使用方式与指针的用法十分相似，如下：

```cpp showLineNumbers
void f(Ptr p )
{
    p->m = 10 ; // (p.operator->())->m = 10
}
```

语句 `p->m` 被解释为 `(p.operator->())->m`。通过下面示例加深理解：

```cpp showLineNumbers
#include <iostream>
#include <vector>

using namespace std;

// 假设一个实际的类
class Obj
{
    static int i, j;

public:
    void f() const { cout << i++ << endl; }
    void g() const { cout << j++ << endl; }
};

// 静态成员定义
int Obj::i = 10;
int Obj::j = 12;

// 为上面的类实现一个容器
class ObjContainer
{
    std::vector<Obj*> a;

public:
    void add(Obj* obj) {
        a.push_back(obj);  // 调用向量的标准方法
    }

    friend class SmartPointer;
};

// 实现智能指针，用于访问类 Obj 的成员
class SmartPointer {
    ObjContainer oc;
    int index;

public:
    SmartPointer(ObjContainer& objc)
    {
        oc = objc;
        index = 0;
    }
    // 前缀版本
    // 返回值表示列表结束
    bool operator++() 
    {
        if(index >= oc.a.size())
            return false;
        
        if(oc.a[++index] == 0)
            return false;
        
        return true;
    }
    // 后缀版本
    bool operator++(int)
    {
        return operator++();
    }

    // 重载运算符 ->
    Obj* operator->() const 
    {
        if(!oc.a[index]) {
            std::cout << "Zero value";
            return (Obj*)0;
        }

        return oc.a[index];
    }
};

int main() 
{
    const int sz = 6;

    Obj o[sz];
    ObjContainer oc;

    for(int i=0; i<sz; i++) {
        oc.add(&o[i]);
    }

    SmartPointer sp(oc); 

    do {
        sp->f(); 
        sp->g();
    } while(sp++);

    return 0;
}
```

编译和运行以上示例，输出结果如下：

```bash
10
12
11
13
12
14
13
15
14
16
15
17
```



### 示例 10：逻辑非运算符重载

逻辑非（`!`）运算符是一元运算符，它总是出现在所操作对象的左边，如 `!obj`。逻辑非运算符运算符返回的类型为 `bool` 类型，当对象为真值时，返回假；当对象为假值时，返回真。

下面示例演示如何重载 `!` 运算符：

```cpp showLineNumbers
#include <iostream>
using namespace std;

class Rect
{
private:
    int width;
    int height;

public:
    Rect() {
        width = 0;
        height = 0;
    }

    Rect( int a, int b ) {
        width = a;
        height = b;
    }

    int area () {
        return width * height;
    }

    // 当 width 或者 height 有一个小于 0 则返回 true
    bool operator!() {
        if ( width <= 0 || height <= 0 ) {
            return true;
        }
        return false;
    }
};

int main()
{
    Rect r1(3, 4), r2(-3, 4);

    if (!r1) cout << "r1 is not a rectangle" << endl;
    else cout << "r1 is a rectangle" << endl;

    if (!r2) cout << "r2 is not a rectangle" << endl;
    else cout << "r2 is a rectangle" << endl;
    
    return 0;
}
```

使用 `g++ main.cpp && ./a.out` 命令编译和运行以上示例，输出结果如下：

```bash
r1 is a rectangle
r2 is not a rectangle
```