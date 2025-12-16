---
sidebar_position: 3
sidebar_label: Eigen
slug: /eigen
---

# Eigen 线性代数运算库

**Eigen** 是一个功能强大的 C++ 模板库，专注于线性代数运算，包括矩阵和向量操作、数值分析以及相关算法。它以其高性能和灵活性，广泛应用于计算机图形学、机器人学、机器学习等领域。

:::tip

“Eigen” 的标准英文发音为 **/ˈaɪɡən/**，听起来类似于 “**EYE-gun**”。关于 Eigen 的详细使用方法请阅读《[Eigen 使用教程](/eigen/)》。

:::

![Eigen 项目 Logo](https://static.getiot.tech/Eigen-logo.png#center)

## 主要特点

- **高性能**：利用表达式模板技术，在编译时生成高效的机器码，提供极快的运算速度。
- **简洁易用**：API 设计简洁明了，支持类似 MATLAB 的操作符重载，代码可读性高。
- **跨平台**：作为纯头文件库，无需编译，易于集成到各种平台和项目中。
- **模块丰富**：提供稠密矩阵、稀疏矩阵、几何变换、数值求解等多个模块，满足多样化需求。
- **开源许可**：遵循 MPL2.0 许可证，允许在商业项目中免费使用。



## 使用方法

#### 1. 安装

在 Linux 系统中，可以通过以下命令安装 Eigen：

```bash
sudo apt-get install libeigen3-dev
```

或者从官方网站下载源码，直接包含头文件使用。

#### 2. 引入头文件

根据需要引入相应的头文件：

```cpp showLineNumbers
#include <Eigen/Dense>   // 稠密矩阵和向量操作
#include <Eigen/Sparse>  // 稀疏矩阵操作
#include <Eigen/Geometry> // 几何变换
```

#### 3. 示例代码

以下是一个简单的示例，展示如何使用 Eigen 进行矩阵运算：

```cpp showLineNumbers
#include <iostream>
#include <Eigen/Dense>

int main() {
    Eigen::Matrix2d mat;
    mat << 1, 2,
           3, 4;
    Eigen::Vector2d vec(5, 6);
    Eigen::Vector2d result = mat * vec;
    std::cout << "Result:\n" << result << std::endl;
    return 0;
}
```



## 常用 API

- **矩阵和向量定义**：
  - `MatrixXd`：动态大小的双精度矩阵
  - `VectorXd`：动态大小的双精度向量
  - `Matrix3f`：3x3 的单精度矩阵
- **基本操作**：
  - `matrix.transpose()`：转置
  - `matrix.inverse()`：求逆
  - `matrix.determinant()`：行列式
- **线性方程求解**：
  - `matrix.colPivHouseholderQr().solve(b)`：求解线性方程组
- **特征值和特征向量**：
  - `EigenSolver<MatrixType>`：计算特征值和特征向量
- **稀疏矩阵操作**：
  - `SparseMatrix<double>`：定义稀疏矩阵
  - `SparseLU<SparseMatrix<double>>`：稀疏矩阵求解器



## 相关链接

- [Eigen 项目官网](https://eigen.tuxfamily.org)
- [Eigen 文档中心](https://libeigen.gitlab.io/docs/)
- [Eigen 代码仓库（GitLab）](https://gitlab.com/libeigen/eigen)
