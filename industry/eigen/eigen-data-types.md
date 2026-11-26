---
sidebar_position: 4
---

# Eigen 数据类型



## Matrix 矩阵

在 Eigen，所有的矩阵和向量都是 **Eigen::Matrix** 模板类的对象，Eigen::Vector 只是一种特殊的矩阵（一行或者一列）。

Matrix 有6个模板参数，主要使用前三个参数，剩下的有默认值。

```cpp
Matrix<typename _Scalar, int _Rows, int _Cols, 
       int _Options, int _MaxRows, int _MaxCols>
```

`_Scalar` 表示元素的类型，`_Rows` 表示矩阵的行，`_Cols` 表示矩阵的列。

库中提供了一些类型便于使用，形式如下：

```cpp
MatrixNt = Matrix<type, N, N>
```

其中，N 可以是 2,3,4 或 X（Dynamic），t 可以是 i (int)、f (float)、d (double)、cf (complex)、cd (complex) 等。

比如：

- `Matrix2d` 表示 `Matrix<double, 2, 2>`
- `Matrix3i` 表示 `Matrix<int, 3, 3>`
- `Matrix4f` 表示 `Matrix<float, 4, 4>`

特殊地，还有 `MatrxXi` 表示 `Matrix<int, Dynamic, Dynamic>`。



## Vector 向量

列向量

```cpp
typedef Matrix<float, 3, 1> Vector3f;
```

行向量

```cpp
typedef Matrix<int, 1, 2> RowVector2i;
```

同样，Vector 也有多种简便类型：

- `VectorNt = Matrix<type, N, 1>`， 比如 `Vector2f = Matrix<float, 2, 1>`
- `RowVectorNt = Matrix<type, 1, N>`，比如 `RowVector3d = Matrix<double, 1, 3>`



## Dynamic

Eigen 不只限于已知大小（编译阶段）的矩阵，有些矩阵的尺寸是运行时确定的，于是引入了一个特殊的标识符 `Dynamic`。

例如：

```cpp
typedef Matrix<double, Dynamic, Dynamic> MatrixXd;
typedef Matrix<int, Dynamic, 1> VectorXi;
Matrix<float, 3, Dynamic>
```



## Array 数组

Matrix 与 Array 对象可以相互转换，内部数据类型一致，在运算上进行分离。

Matrix 的运算遵守矩阵运算规则，Array 则提供更加灵活的运算，比如对应系数相乘，向量加数量等，为 Matrix 提供了所谓 coefficient-wise 的运算补充。



```cpp
#include <Eigen/Dense>
#include <iostream>
 
using namespace Eigen;
using namespace std;
 
int main()
{
  MatrixXf m(2,2);
  MatrixXf n(2,2);
  MatrixXf result(2,2);
 
  m << 1,2,
       3,4;
  n << 5,6,
       7,8;
 
  result = m * n;
  cout << "-- Matrix m*n: --" << endl << result << endl << endl;
  result = m.array() * n.array();
  cout << "-- Array m*n: --" << endl << result << endl << endl;
  result = m.cwiseProduct(n);
  cout << "-- With cwiseProduct: --" << endl << result << endl << endl;
  result = m.array() + 4;
  cout << "-- Array m + 4: --" << endl << result << endl << endl;
}
```





Eigen::Array

Eigen::ArrayXd

Eigen::Stride



## Affine 仿射变换矩阵

Eigen::Affine3d

Eigen::Map

Eigen::Hyperplane



Eigen::Dynamic

Eigen::Ref

Eigen::DontAlign

Eigen::RowMajor

Eigen::Unaligned





