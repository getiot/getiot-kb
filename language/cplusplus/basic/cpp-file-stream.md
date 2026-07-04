---
sidebar_position: 41
slug: /cpp-file-stream
---

# C++ 文件和流

在前面的 C++ 示例中，我们都使用到了 **`iostream`** 标准库，它提供了 `cin` 和 `cout` 方法分别用于从标准输入读取流和向标准输出写入流。

之前已经介绍了 C++ 的[标准输入输出](/cplusplus/cpp-input-output/)，所以本文将主要介绍文件输入输出，即如何从文件读取流，以及向文件写入流。



## 头文件

关于文件和流的操作，需要用到 C++ 中另一个标准库 **`fstream`**，它定义了 3 个新的数据类型。

| 数据类型   | 描述                                                         |
| ---------- | ------------------------------------------------------------ |
| `ofstream` | 输出文件流，用于创建文件并向文件写入信息。                   |
| `ifstream` | 输入文件流，用于从文件读取信息。                             |
| `fstream`  | 文件流，同时具有 ofstream 和 ifstream 两种功能，这意味着它可以创建文件，向文件写入信息，从文件读取信息。 |

要在 C++ 中进行文件处理，必须先包含 `<iostream>` 和 `<fstream>` 头文件。

```cpp showLineNumbers
#include <iostream>
#include <fstream>
```



## 打开文件

在从文件读取信息或者向文件写入信息之前，必须先打开文件。**ofstream** 和 **fstream** 对象都可以用来打开文件进行写操作。如果只需要打开文件进行读操作，则使用 **ifstream** 对象。

`open()` 函数是 fstream、ifstream 和 ofstream 对象的一个成员函数，用来打开文件。函数原型如下：

```cpp showLineNumbers
void open(const char *filename, ios::openmode mode);
```

参数说明：

- `filename`：指定要打开的文件的名称和位置。
- `mode`：指定文件打开的模式。

其中，文件打开模式有以下几种：

| 模式标志     | 描述                                                         |
| ------------ | ------------------------------------------------------------ |
| `ios::app`   | 追加模式，所有写入都追加到文件末尾。                         |
| `ios::ate`   | 文件打开后定位到文件末尾。                                   |
| `ios::in`    | 打开文件用于读取。                                           |
| `ios::out`   | 打开文件用于写入。                                           |
| `ios::trunc` | 如果该文件已经存在，其内容将在打开文件之前被截断，即把文件长度设为 0。 |

我们可以将上两种或两种以上的模式结合使用。

例如，如果想要以写入模式打开文件，并希望截断文件，以防文件已存在，则使用下面的语句：

```cpp showLineNumbers
ofstream outfile;
outfile.open("demo.txt", ios::out | ios::trunc);
```

类似地，如果想要打开一个文件用于读写，可以使用下面的语句

```cpp showLineNumbers
fstream  afile;
afile.open("demo.txt", ios::out | ios::in);
```



## 关闭文件

虽然应用程序终止时系统会关闭所有流，释放所有分配的内存，并关闭所有打开的文件。但程序员应该养成一个好习惯，在程序终止前关闭所有打开的文件。

在 C++ 中，可以使用 `close()` 函数关闭文件，它也是 fstream、ifstream 和 ofstream 对象的一个成员。函数原型如下：

```cpp showLineNumbers
void close();
```



## 写入文件

在 C++ 中，可以使用流插入运算符（`<<`）向文件写入信息，就像使用该运算符输出信息到标准输出上一样。唯一不同的是，写入文件使用的是 `ofstream` 或 `fstream` 对象，而不是 `cout` 对象。



## 读取文件

同样，在 C++ 中，可以使用流提取运算符（`>>`）从文件读取信息，就像使用该运算符从标准输入（键盘）读取信息一样。唯一不同的是，读取文件使用的是 `ifstream` 或 `fstream` 对象，而不是 `cin` 对象。



## 示例

下面示例演示如何向文件读写数据。首先以读写模式打开一个文件 demo.txt，写入用户输入的信息，然后再从文件读取信息，并将其输出到屏幕上。

```cpp showLineNumbers
#include <fstream>
#include <iostream>

using namespace std;

int main ()
{
    char data[1024];
    
    // 以写模式打开文件
    ofstream outfile;
    outfile.open("demo.txt");
    
    cout << "Writing to the file >>" << endl;
    cout << "Enter your name: "; 
    cin.getline(data, 1024);
    
    // 向文件写入用户输入的数据
    outfile << "Name:" << data << endl;
    
    cout << "Enter your age: ";
    cin >> data;
    cin.ignore();
    
    // 再次向文件写入用户输入的数据
    outfile << "Age:" << data << endl;
    
    // 关闭打开的文件
    outfile.close();
    
    // 以读模式打开文件
    ifstream infile;
    infile.open("demo.txt");
    
    cout << "Reading from the file >>" << endl;
    infile >> data;
    
    // 在屏幕上写入数据
    cout << data << endl;
    
    // 再次从文件读取数据，并显示它
    infile >> data;
    cout << data << endl;
    
    // 关闭打开的文件
    infile.close();
    return 0;
}
```

编译运行以上示例，输出结果如下：

```bash
Writing to the file >>
Enter your name: GetIoT.tech
Enter your age: 3
Reading from the file >>
Name:GetIoT.tech
Age:3
```

该示例使用了 `cin` 对象的附加函数，如 `getline()` 函数从外部读取一行，`ignore()` 函数会忽略掉之前读语句留下的多余字符。



## 文件位置指针

**istream** 类和 **ostream** 类都提供了用于重新定位文件位置指针的成员函数。

这些函数有：

- **istream** 的 `seekg()`，意思是 seek get
- **ostream** 的 `seekp()`，意思是 seek put

`seekg` 和 `seekp` 的第一个参数通常是长整型（long int），指定了从文件的起始位置到指针所在位置的字节数，第二个参数可以用于指定查找方向。

查找方向可以以下几种：

- `ios::beg`：默认的，从流的开头开始定位。
- `ios::cur`：从流的当前位置开始定位。
- `ios::end`：从流的末尾开始定位。

下面是使用 `seekg()` 函数定位文件位置指针的一些示例。

（1）定位到 fileObject 的第 n 个字节（假设是 `ios::beg`）

```cpp showLineNumbers
fileObject.seekg( n );
```

（2）把文件的读指针从 fileObject 当前位置向后移 n 个字节

```cpp showLineNumbers
fileObject.seekg( n, ios::cur );
```

（3）把文件的读指针从 fileObject 末尾往回移 n 个字节

```cpp showLineNumbers
fileObject.seekg( n, ios::end );
```

（4）定位到 fileObject 的末尾

```cpp showLineNumbers
fileObject.seekg( 0, ios::end );
```