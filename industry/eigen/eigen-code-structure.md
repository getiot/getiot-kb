---
sidebar_position: 3
---

# Eigen 代码结构



## 目录结构

Eigen 的目录结构分为两大部分 **src** 和 **头文件**，如下所示。头文件按照具体功能划分，使用时只需将其包含在内即可，例如想使用特征值计算，那么就直接 `#include<Eigen/Eigenvalues>` 即可；而 **src** 目录则是对应的实现。

```bash
Eigen$ tree -L 1
├── src
├── Cholesky
├── CholmodSupport
├── Core
├── Dense
├── Eigen
├── Eigenvalues
├── Geometry
├── Householder
├── IterativeLinearSolvers
├── Jacobi
├── KLUSupport
├── LU
├── MetisSupport
├── OrderingMethods
├── PardisoSupport
├── PaStiXSupport
├── QR
├── QtAlignedMalloc
├── Sparse
├── SparseCholesky
├── SparseCore
├── SparseLU
├── SparseQR
├── SPQRSupport
├── StdDeque
├── StdList
├── StdVector
├── SuperLUSupport
├── SVD
└── UmfPackSupport
```

**src** 虽然是对应的实现，但是却没有一个 cpp/cc 文件，而是与上一级头文件一一对应的子目录，各子目录是对应的实现（都是 .h 文件）。

```bash
$ ls Eigen/src/
Cholesky                Jacobi           PaStiXSupport   SPQRSupport
CholmodSupport          KLUSupport       plugins         StlSupport
Core                    LU               QR              SuperLUSupport
Eigenvalues             MetisSupport     SparseCholesky  SVD
Geometry                misc             SparseCore      UmfPackSupport
Householder             OrderingMethods  SparseLU
IterativeLinearSolvers  PardisoSupport   SparseQR
```



## 模块和头文件

下表列出常用的一些模块和它所对应的头文件，以及该模块包含的功能。

| 模块        | 头文件                | 内容                                                         |
| ----------- | --------------------- | ------------------------------------------------------------ |
| Core        | `<Eigen/Core>`        | 矩阵和数组（向量）类（Matrix、Array），基于线性代数还有数组操作 |
| Geometry    | `<Eigen/Geometry>`    | 变换、平移、缩放、2D 旋转和 3D 旋转（包括四元数和角轴）      |
| LU          | `<Eigen/LU>`          | 使用求解器进行求逆，行列式，LU 分解操作                      |
| Cholesky    | `<Eigen/Cholesky>`    | 使用求解器进行 LLT、LT、Cholesky 分解                        |
| Householder | `<Eigen/Householder>` | Householder 变换；被用作几个线性代数模块                     |
| SVD         | `<Eigen/SVD>`         | SVD 分解与最小二乘求解器                                     |
| QR          | `<Eigen/QR>`          | QR 分解                                                      |
| Eigenvalues | `<EIgen/Eigenvalues>` | 特征值，特征向量分解                                         |
| Sparse      | `<Eigen/Sparse>`      | 稀疏矩阵存储以及相关的基本线性代数                           |
| Dense       | `<Eigen/Dense>`       | 包括 Core、Geometry、LU、Cholesky、SVD、QR、Eigenvalues 的头文件 |
| Eigen       | `<Eigen/Eigen>`       | 包括 Dense 和 Sparse 的头文件                                |





---



那么这么多头文件怎么组织好包含关系呢？Eigen 给出的答案是，在对外头文件中按照依赖关系排列头文件顺序。

 以**Core**模块为例，该模块定义了Eigen核心数据结构和基本功能。Eigen/src/Matrix.h定义了矩阵，其定义如下：

```cpp
template<typename Scalar_, int Rows_, int Cols_, int Options_, int MaxRows_, int MaxCols_>
class Matrix
: public PlainObjectBase<Matrix<Scalar_, Rows_, Cols_, Options_, MaxRows_, MaxCols_> >
```

但是我们发现，Matrix.h 并没有直接 `#include <PlainObjectBase.h>`。打开 Eigen/Core，我们就可以发现如下结构

```cpp showLineNumbers
#include "src/Core/DenseCoeffsBase.h"
#include "src/Core/DenseBase.h"
#include "src/Core/MatrixBase.h"
#include "src/Core/EigenBase.h"

#include "src/Core/Product.h"
#include "src/Core/CoreEvaluators.h"
#include "src/Core/AssignEvaluator.h"

#ifndef EIGEN_PARSED_BY_DOXYGEN // work around Doxygen bug triggered by Assign.h r814874
                                // at least confirmed with Doxygen 1.5.5 and 1.5.6
  #include "src/Core/Assign.h"
#endif

#include "src/Core/ArrayBase.h"
#include "src/Core/util/BlasUtil.h"
#include "src/Core/DenseStorage.h"
#include "src/Core/NestByValue.h"

// #include "src/Core/ForceAlignedAccess.h"

#include "src/Core/ReturnByValue.h"
#include "src/Core/NoAlias.h"
#include "src/Core/PlainObjectBase.h"
#include "src/Core/Matrix.h"
#include "src/Core/Array.h"
```

当用户将 Eigen/Core 包含在自己的文件中，编译时头文件的代码一经展开，PlainObjectBase 便是已经声明并定义好的了，所以客户端代码并不会发生链接问题。需要注意的是，如果客户只 include 其中一个文件比如 Matrix.h，此时就会发生链接问题，因为找不到 PlainObjectBase。这样做的好处是减少了各文件之间的编译依赖关系。



