---
sidebar_position: 58
slug: /cpp-scientific-computing-libraries
---

# C++ 科学计算库

虽然 `<math.h>` 作为 C 标准库的一部分提供了基本的数学函数，并且在 C++ 程序中也可以使用。然而，如果需要更高级的科学计算功能，则需要使用自定义库对其进行补充。在本文中，我们将介绍一些优秀的 C++ 科学计算库。由于 C++ 库的数量非常庞大，就科学计算库而言也种类繁多，从轻量级到重量级的都有，所以本文着重介绍都是比较著名的大型库。



## GSL

GSL 的全称是 GNU Scientific Library，是一个开源的科学计算函数库，同时是 C/C++ 中最成熟的科学计算库之一。GSL 库定义了常见的数学常数（如 π、e、欧拉常数等），支持向量、矩阵、复数，微积分，插值，统计，随机数生成等功能。如果你使用 Linux 系统，那么通过包管理器即可安装 GSL 库。

源码下载：[https://www.gnu.org/software/gsl/](https://www.gnu.org/software/gsl/)

下面是一个简单示例：

```cpp showLineNumbers
#include <stdio.h>
#include <gsl/gsl_vector.h>  /* For Vectors */
#include <gsl/gsl_rng.h>     /* For Random numbers */

int main(void)
{
    int i, n;
    /* Setup the Random number generator*/
    const gsl_rng_type * T;
    gsl_rng * r;
    gsl_rng_env_setup();
    T = gsl_rng_default;
    r = gsl_rng_alloc (T);

    printf("Number of elements in the vector:: ");
    scanf("%d",&n);
    
    /* Allocate the vector of the specified size*/
    gsl_vector * v = gsl_vector_alloc (n);
    
    /* Set the elements to a uniform random number in [0,1]*/
    for (i = 0; i < n; i++) {
        gsl_vector_set (v, i, gsl_rng_uniform (r));
    }
    
    /* Print the vector*/
    for (i = 0; i < n; i++) {
        printf ("v_%d = %g\n", i, gsl_vector_get (v, i));
    }
    
    gsl_vector_free (v);
    return 0;
}
```



## Blitz++

Blitz++ 是一个高效率的数值计算函数库，它的设计目的是希望建立一套既具像 C++ 一样方便，同时又比 Fortran 速度更快的数值计算环境。通常，用 C++ 所写出的数值程序，比 Fortran 慢20%左右，因此 Blitz++ 正是要改掉这个缺点。方法是利用 C++ 的模板（template）技术，程序执行甚至可以比 Fortran 更快。

Blitz++ 目前仍在发展中，对于常见的 SVD，FFTs，QMRES 等常见的线性代数方法并不提供，不过使用者可以很容易地利用 Blitz++ 所提供的函数来构建。

GitHub 地址：[https://github.com/blitzpp/blitz](https://github.com/blitzpp/blitz)



## MTL

MTL 的全称是 Matrix Template Library，它是一个高性能的泛型组件库，提供了各种格式矩阵的大量线性代数方面的功能。在某些应用使用高性能编译器的情况下，比如Intel的编译器，从产生的汇编代码可以看出其与手写几乎没有两样的效能。

GitHub 地址：[https://github.com/simunova/mtl4](https://github.com/simunova/mtl4)



## CGAL

CGAL 的全称是 Computational Geometry Algorithms Library，它的目的是把在计算几何方面的大部分重要的解决方案和方法以 C++ 库的形式提供给工业和学术界的用户。

项目网址：[https://www.cgal.org](https://www.cgal.org)



## Intel MKL

MKL 是 Math Kernel Library 的缩写，即英特尔数学核心函数库，如今更多被称为英特尔 oneAPI 数学核心函数库。

它支持基本线形代数运算（BLAS）向量与向量、向量与矩阵、矩阵与矩阵的运算，稀疏线形代数运算，快速傅立叶变换（单精度/双精度），LAPACK（求解线形方程组、最小方差、特征值、Sylvester 方程等），向量数学库（VML），向量统计学库（VSL），高级离散傅立叶变换等科学计算。



## IMSL

IMSL 的全称是 IMSL C Numerical Library，该库分为统计库和数学库两部分。IMSL 库已成为数值分析解决方案的工业标准，提供最完整与最值得信赖的函数库。IMSL 数值程序库提供目前世界上最广泛被使用的 IMSL 算法，有超过 370 验证过、最正确与 thread-safe 的数学与统计程序。 IMSL FORTRAN 程序库提供新一代以 FORTRAN 90 为程序库基础的程序，能展现出最佳化的演算法能力应用于多处理器与其它高效能运算系统。

项目网址：[https://www.imsl.com](https://www.imsl.com)



## LAPACK++

LAPACK 是 Linear Algebra PACKage 的缩写，是一以 Fortran 编程语言写的，用于数值计算的函数集。LAPACK 提供了丰富的工具函数，可用于诸如解多元线性方程、线性系统方程组的最小二乘解、计算特征向量、用于计算矩阵 QR 分解的 Householder 变换、以及奇异值分解等问题。

LAPACK++ 则是 LAPACK 的 C++ 版本。

下载地址：[https://math.nist.gov/lapack++/](https://math.nist.gov/lapack++/)


