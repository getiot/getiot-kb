---
sidebar_position: 6
draft: true
---

# Interview: Eigen Matrix Library



What follows is an interview with Benoît Jacob and Gael Guennebaud, two developers of the open source [Eigen](http://eigen.tuxfamily.org/) project, which provides incredibly fast C++ matrix and vector numeric code.

以下是对 Benoît Jacob 和 Gael Guennebaud 的采访，他们是开源 [Eigen](http://eigen.tuxfamily.org/) 项目的两位开发人员，该项目提供了令人难以置信的快速 C++ 矩阵和向量数字代码。

**OK, let’s start out with the basics. Could you introduce yourselves?**

**好吧，让我们从基础开始。 你能自我介绍一下吗？**

Benoit: I’m a Mathematics postdoc at the University of Toronto, coming from France. I’m working on [C*-algebras](https://en.wikipedia.org/wiki/C*-algebra), and teaching linear algebra. In addition to Eigen, I contribute to a few other free software projects, mostly within [KDE](http://kde.org/). In the past I also contributed to [Avogadro](http://avogadro.openmolecules.net/) and a little bit to [Open Babel](http://openbabel.org/).

Benoit：我是多伦多大学的数学博士后，来自法国。 我正在研究 [C*-algebras](https://en.wikipedia.org/wiki/C*-algebra)，并教授线性代数。 除了 Eigen 之外，我还为其他一些自由软件项目做出了贡献，主要是在 [KDE](http://kde.org/) 内。 过去我也为 [Avogadro](http://avogadro.openmolecules.net/) 和 [Open Babel](http://openbabel.org/) 做出了一些贡献。

Gael: I’m a French researcher in Computer Graphics currently working at INRIA Bordeaux. In particular, my research interests include real-time rendering and surface representations. My major contribution in the open-source world is by far what I did in Eigen, but I also contributed a bit to [vcglib](http://vcg.sourceforge.net/) and [MeshLab](http://meshlab.sourceforge.net/wiki).

Gael：我是一名法国计算机图形学研究员，目前在 INRIA Bordeaux 工作。 我的研究兴趣特别包括实时渲染和表面表示。 到目前为止，我在开源世界中的主要贡献是我在 Eigen 中所做的，但我也为 [vcglib](http://vcg.sourceforge.net/) 和 [MeshLab](http://meshlab.sourceforge.net/wiki)。

**What is [Eigen](http://eigen.tuxfamily.org/)?**

Benoit and Gael: [Eigen](http://eigen.tuxfamily.org/) is a free C++ template math library mainly focused on vectors, matrices, and linear algebra. It is a self-contained library covering a very broad range of use cases. For example, it covers both dense and sparse objects, and in the dense case, it covers both fixed-size and dynamic-size objects. Moreover it provides linear algebra algorithms, a geometry framework, etc. It has a [very nice API](http://eigen.tuxfamily.org/index.php?title=API_Showcase) for C++ programmers, and it embraces [very high performance](http://eigen.tuxfamily.org/index.php?title=Benchmark).

Benoit 和 Gael：[Eigen](http://eigen.tuxfamily.org/) 是一个免费的 C++ 模板数学库，主要关注向量、矩阵和线性代数。 它是一个独立的库，涵盖非常广泛的用例。 例如，它既覆盖密集对象又覆盖稀疏对象，在密集情况下，它同时覆盖固定大小和动态大小的对象。 此外，它还提供线性代数算法、几何框架等。它为 C++ 程序员提供了[非常好的 API](http://eigen.tuxfamily.org/index.php?title=API_Showcase)，并且它包含[非常高 性能](http://eigen.tuxfamily.org/index.php?title=Benchmark)。

**What drove you to create Eigen and Eigen 2?**

**是什么促使您创建 Eigen 和 Eigen 2？**

Benoit: Eigen 1 was a very small project, 2500 LOC and just a few months of development. Its creation in 2006 was driven by the then-simple needs of some [KDE](http://kde.org/) and [KOffice](http://koffice.org/) apps. However it quickly turned out that we had underestimated their needs, and Eigen 1 was insufficient. So in 2007, I started developing Eigen2. The aim was to create the linear algebra library that would satisfy all the needs of KDE and KOffice apps — a goal that, in retrospect, was very ambitious, and will only be reached with Eigen 2.1. After an initial experiment with [TVMET](http://tvmet.sourceforge.net/)‘s code, I decided to restart from scratch in August 2007 and quickly got a working implementation of expression templates. However, this early Eigen 2 was very small. Development speed really picked up when Gael joined in early 2008.

Benoit：Eigen 1 是一个非常小的项目，只有 2500 LOC，开发时间只有几个月。 它于 2006 年创建，是出于当时一些 [KDE](http://kde.org/) 和 [KOffice](http://koffice.org/) 应用程序的简单需求。 然而很快事实证明我们低估了他们的需求，Eigen 1 还不够。 所以在2007年，我开始开发Eigen2。 我们的目标是创建一个线性代数库来满足 KDE 和 KOffice 应用程序的所有需求——回想起来，这个目标非常雄心勃勃，只有 Eigen 2.1 才能实现。 在对 [TVMET](http://tvmet.sourceforge.net/) 的代码进行初步实验后，我决定在 2007 年 8 月从头开始，并很快获得了表达式模板的有效实现。 然而，这个早期的 Eigen 2 非常小。 2008 年初 Gael 加入后，开发速度确实加快了。

Gael: A bit more than a year ago, I became tired of going back and forth between my own fixed size vector/matrix classes and more generic linear algebra packages. So, I started looking at the other existing solutions without being excited by any of them. Since I have been using KDE for about 9 years, I was really curious to know what the KDE’s folks did in this area. At that time, it was exactly the start of Eigen2 which looked promising but the fact it was based on TVMET puzzled me. Eventually, Benoît had the great idea to restart the development of Eigen2 from scratch, and after one or two months he came up with a very lean design. Moreover his vision and feature plan for Eigen2 exactly matched my own, and being part of the KDE community was exciting too! At the beginning, I naively thought that after one or two months the job would be done! Instead, we started playing with exciting stuff like explicit vectorization, efficient matrix products, sparse matrix, etc.

Gael：一年多前，我厌倦了在自己的固定大小向量/矩阵类和更通用的线性代数包之间来回切换。因此，我开始研究其他现有的解决方案，但没有对其中任何一个感到兴奋。 由于我使用 KDE 已经大约 9 年了，我真的很想知道 KDE 的人们在这个领域做了什么。 那时，正是 Eigen2 的开始，看起来很有希望，但它基于 TVMET 的事实让我感到困惑。 最终，Benoît 产生了从头开始重新开发 Eigen2 的好主意，一两个月后，他想出了一个非常精益的设计。 此外，他对 Eigen2 的愿景和功能计划与我的完全一致，成为 KDE 社区的一员也令人兴奋！ 一开始我天真地以为一两个月后工作就完成了！ 相反，我们开始尝试令人兴奋的东西，例如显式向量化、高效矩阵乘积、稀疏矩阵等。

**Many people are familiar with other linear algebra and matrix libraries, including BLAS/LAPACK, Intel’s Math Kernel Library, and Apple’s vecLib framework. Can you explain how Eigen is different, besides being written in C++?**

**许多人都熟悉其他线性代数和矩阵库，包括 BLAS/LAPACK、Intel 的 Math Kernel Library 和 Apple 的 vecLib 框架。 除了用 C++ 编写之外，您能解释一下 Eigen 有何不同吗？**

Benoit and Gael:

Giving a fair answer to that question would require a thorough comparison to all existing libraries that is obviously out the scope of this interview. Search for “C++ matrix library” to get an idea. For us, most important criteria include:

- generality,
- performance,
- ease of use,
- license policy.

Even more important is a sort of meta criterion which would glue together all these criteria. Indeed, what’s the point in having a very efficient library but which which cannot handle your specific needs, and/or that you cannot freely use/extend because of the license ? The central difference between Eigen and other libraries reside in this unmatched combination of advantages.

要对这个问题给出一个公平的答案，需要对所有现有的库进行彻底的比较，这显然超出了本次采访的范围。 搜索“C++ 矩阵库”来了解一下。 对我们来说，最重要的标准包括：

- 一般性，
- 表现，
- 使用方便，
- 许可政策。

更重要的是一种将所有这些标准粘合在一起的元标准。 事实上，拥有一个非常高效的库但无法满足您的特定需求和/或由于许可证而无法自由使用/扩展有什么意义？ Eigen 与其他库之间的主要区别在于这种无与伦比的优势组合。

For instance, BLAS/LAPACK are certainly the most popular matrix/linear algebra packages. They can achieve very high performance, but only for relatively large and dense matrices, and through proprietary implementations such as Intel’s MKL or Apple’s vecLib. Goto BLAS too has a restrictive license. API-wise, BLAS/LAPACK are also very painful to use, though that limitation is somewhat overcome by the existence of many high-level wrappers (FLENS, matlab, etc.). In contrast, not only does Eigen provide a feature set to BLAS/LAPACK with better ease of use, but it also seamlessly supports small fixed size matrices, has experimental support for sparse matrices with optional back-ends, and includes other modules such as linear least squares and geometry.

例如，BLAS/LAPACK 无疑是最流行的矩阵/线性代数包。它们可以实现非常高的性能，但仅限于相对较大和密集的矩阵，并且需要通过专有实现（例如英特尔的 MKL 或苹果的 vecLib）。 Goto BLAS 也有限制性许可证。 就 API 而言，BLAS/LAPACK 使用起来也非常痛苦，尽管许多高级包装器（FLENS、matlab 等）的存在在一定程度上克服了这一限制。 相比之下，Eigen 不仅为 BLAS/LAPACK 提供了更好易用性的功能集，而且还无缝支持小型固定大小矩阵，对具有可选后端的稀疏矩阵进行了实验性支持，并包含其他模块，例如线性 最小二乘法和几何。

As we said, expression templates bring unmatched expressiveness and performance for basic operations. It is therefore interesting to have a brief look at the few other C++ template libraries which are also based on expression templates. The most popular ones include TVMET, Blitz++, and Boost::uBLAS. However, in contrast to Eigen, none of them provide explicit vectorization nor include linear algebra algorithms. They also perform poorly for both small and large matrix sizes, and suffer from some shortcomings in the way expression templates have been implemented making them hard to use in practice. For example, contrary to Eigen, they do not decide automatically when to use lazy evaluation. Eigen handles most cases automatically while ultimately letting the user override the default behavior. For example, in a chained matrix product A*B*C, Eigen understands that lazy evaluation would be a bad idea so decides to evaluate A*B into a temporary, while Boost::uBLAS requires the user to do that explicitly. Another advantage of Eigen over these other C++ libraries, is that Eigen has still reasonable compilation times: we are very careful about that.

正如我们所说，表达式模板为基本操作带来了无与伦比的表现力和性能。 因此，简要了解一下其他几个也基于表达式模板的 C++ 模板库是很有趣的。 最流行的包括 TVMET、Blitz++ 和 Boost::uBLAS。 然而，与 Eigen 相比，它们都不提供显式矢量化，也不包含线性代数算法。 它们对于小矩阵和大矩阵的表现也很差，并且在表达模板的实现方式上存在一些缺点，使得它们在实践中难以使用。 例如，与 Eigen 相反，它们不会自动决定何时使用惰性求值。 Eigen 自动处理大多数情况，同时最终让用户覆盖默认行为。 例如，在链式矩阵乘积 A*B*C 中，Eigen 知道惰性求值是一个坏主意，因此决定将 A*B 求值为临时值，而 Boost::uBLAS 要求用户明确执行此操作。 与其他 C++ 库相比，Eigen 的另一个优势是 Eigen 仍然具有合理的编译时间：我们对此非常小心。

**How does performance compare to other alternatives? Do you have some benchmarks?**

**与其他替代方案相比，性能如何？ 你有一些基准吗？**

Gael: Since good performance is one of our top priorities, we indeed regularly run several benchmarks. When speaking about performance it is important to distinguish between small fixed size and larger matrix which require very different kind of optimizations.

Gael：由于良好的性能是我们的首要任务之一，因此我们确实定期运行多个基准测试。 在谈论性能时，区分较小的固定尺寸和较大的矩阵非常重要，它们需要非常不同类型的优化。

About the first category, Eigen includes meta-unrollers and an advanced explicit vectorization mechanism allowing us to generate machine code as good as hand written assembly code. Therefore, in all our benchmarks, we found Eigen outperforms all other libraries, or at least we made sure that was the case by fixing Eigen when needed 😉

关于第一类，Eigen 包括元展开器和先进的显式矢量化机制，使我们能够生成与手写汇编代码一样好的机器代码。 因此，在我们所有的基准测试中，我们发现 Eigen 优于所有其他库，或者至少我们通过在需要时修复 Eigen 来确保情况如此

For relatively large matrices, we have [a comparison of several free and non-free libraries](http://eigen.tuxfamily.org/index.php?title=Benchmark). These results demonstrate that Eigen outperforms all other Free libraries, including [ATLAS](http://math-atlas.sourceforge.net/). Compared to non-Free alternatives like Intel’s MKL and Goto, Eigen is usually faster for both Level-1 (vector-vector) and Level-2 (matrix-vector) equivalent BLAS operations. This is mainly due to expression templates, and a highly optimized matrix-vector product algorithm. However, we acknowledge that matrix-matrix operations are not yet as optimized as their respective BLAS Level-3 routines of MKL and Goto.

对于相对较大的矩阵，我们有[几个免费和非免费库的比较](http://eigen.tuxfamily.org/index.php?title=Benchmark)。 这些结果表明 Eigen 优于所有其他免费库，包括 [ATLAS](http://math-atlas.sourceforge.net/)。 与 Intel 的 MKL 和 Goto 等非自由替代方案相比，Eigen 对于 1 级（向量-向量）和 2 级（矩阵-向量）等效 BLAS 运算通常更快。 这主要归功于表达式模板和高度优化的矩阵向量乘积算法。 然而，我们承认矩阵-矩阵运算尚未像 MKL 和 Goto 各自的 BLAS Level-3 例程那样优化。

Regarding higher-level linear algebra algorithms like LU or Cholesky factorizations, we currently do not provide any block implementations for them. Therefore the equivalent LAPACK routines of vendor tuned implementations scale better for very large matrices. Compared to them, we also lack a support for multi-core computing. But nothing is engraved in stone, and we are confident that all these performance limitations for very large matrices will be overcome in the future, in the short term by adding an optional LAPACK backend to Eigen, and in the longer term, who knows 😉

对于 LU 或 Cholesky 分解等高级线性代数算法，我们目前不提供任何块实现。 因此，供应商调整的实现的等效 LAPACK 例程对于非常大的矩阵可以更好地扩展。 与他们相比，我们还缺乏对多核计算的支持。 但没有什么是一成不变的，我们相信，在短期内，通过向 Eigen 添加可选的 LAPACK 后端，超大型矩阵的所有这些性能限制都将被克服，而从长远来看，谁知道呢？

**What projects are using Eigen right now?**

Benoit and Gael: Eigen is already used in a wide range of applications. Some of them include:

It is very interesting and motivating to see how many projects already switched, or are going to switched to Eigen, proving Eigen fills a real gap.

Benoit 和 Gael：Eigen 已经在广泛的应用中使用。 其中一些包括：

看到有多少项目已经切换或将要切换到 Eigen 是非常有趣和激励人心的，这证明 Eigen 填补了真正的空白。

**How would you write code with Eigen? Could you give me an example, say of multiplying the inverse of matrix A by matrix B?**

**您将如何使用 Eigen 编写代码？ 你能给我一个例子，比如将矩阵 A 的逆矩阵乘以矩阵 B 吗？**

Benoit: This operation amounts to solving the system AX=B which can be done for example using a LU decomposition. With Eigen you would do:

Benoit：此操作相当于求解系统 AX=B，这可以例如使用 LU 分解来完成。 使用 Eigen 你会这样做：

```cpp
A.lu().solve(B, &X);
```

Now, depending on your context, you may prefer using another kind of decomposition. Here, Eigen also allows you to use a QR, LLt, LDLt, or SVD decomposition, each time with the same obvious syntax, for example:

现在，根据你的上下文，你可能更喜欢使用另一种分解。 在这里，Eigen 还允许你使用 QR、LLt、LDLt 或 SVD 分解，每次都使用相同的明显语法，例如：

```cpp
A.svd().solve(B, &X);
```

If your matrices have small and fixed size, and especially if B is a vector, it can be faster to actually compute the inverse and the product:

如果您的矩阵较小且固定大小，特别是如果 B 是向量，则实际计算逆矩阵和乘积可能会更快：

```cpp
A.inverse() * B;
```

Here is a full example program that you can compile. It works with a 1000×1000 matrix A and a 1000×500 matrix B, with double precision. I get a relative error of the order of 1e-13 which is pretty good. Eigen’s LU does full pivoting which guarantees that it works in all cases, and an user just reported speed to be on par with LAPACK. However, for this kind of large sizes, depending on the CPU cache size, we acknowledge that it would start to be beneficial to have a more cache-friendly implementation, typically working block-wise.

这是一个可以编译的完整示例程序。它使用 1000×1000 矩阵 A 和 1000×500 矩阵 B，具有双精度。我得到了 1e-13 量级的相对误差，这相当不错。 Eigen 的 LU 进行了完全旋转，这保证了它在所有情况下都能工作，并且用户刚刚报告速度与 LAPACK 相当。 然而，对于这种大尺寸，根据 CPU 缓存大小，我们承认拥有更加缓存友好的实现（通常是按块工作）将开始变得有益。

```cpp
#include <Eigen/LU>// provides LU decomposition
#include <Eigen/Array>// provides random matrices

using namespace Eigen;
int main()
{
  MatrixXd A = MatrixXd::Random(1000, 1000);
  MatrixXd B = MatrixXd::Random(1000, 500);
  MatrixXd X;

  A.lu().solve(B, &X);

  std::cout << "relative error: " << (A*X - B).norm() / B.norm() << std::endl;
}
```

More examples are given in the [API showcase](http://eigen.tuxfamily.org/index.php?title=API_Showcase).

**Since Eigen is a template library, can you explain the license? Can you use it in proprietary projects?**

**由于Eigen是一个模板库，你能解释一下许可证吗？ 您可以在专有项目中使用它吗？**

Benoit: The license is dual LGPL3+/GPL2+. This means it’s LGPL3+, except that GPL2 projects can’t use LGPL3+ libraries so just for them we added the GPL2+ as an alternative. Yes, proprietary closed-source projects may use Eigen, without having to open any of their source code. The LGPL license allows it and we do have several closed-source users.

Benoit：许可证是双重 LGPL3+/GPL2+。 这意味着它是 LGPL3+，但 GPL2 项目不能使用 LGPL3+ 库，因此我们添加了 GPL2+ 作为替代方案。是的，专有的闭源项目可以使用 Eigen，而无需开放其任何源代码。 LGPL 许可证允许这样做，而且我们确实有几个闭源用户。

There used to be a problem with the older LGPL 2.1 and template libraries. Indeed, the phrasing of the LGPL 2.1 was not applicable to the case of C++ template libraries where the code is in header files and is included rather than linked to. Fortunately this issue was fixed in the LGPL3 which now explicitly adresses this issue in Section 3, in addition to having a much more generally applicable phrasing overall. See our [Licensing FAQ](http://eigen.tuxfamily.org/index.php?title=FAQ#Licensing).

旧的 LGPL 2.1 和模板库曾经存在问题。事实上，LGPL 2.1 的措辞不适用于 C++ 模板库的情况，其中代码位于头文件中，并且被包含而不是链接到。幸运的是，这个问题在 LGPL3 中得到了解决，除了总体上更普遍适用的措辞之外，LGPL3 现在在第 3 节中明确解决了这个问题。 请参阅我们的[许可常见问题解答](http://eigen.tuxfamily.org/index.php?title=FAQ#Licensing)。

**What are some goals of Eigen moving forward? What kind of help do you need? What are some new features we might see in Eigen 2.1?**

**Eigen 前进的目标是什么？ 您需要什么样的帮助？ 我们可能会在 Eigen 2.1 中看到哪些新功能？**

Benoit and Gael: Our goals for 2.1 are:

Our goals for 2.1 are:

- Finish stabilizing the API (the API guarantee is only partial in 2.0)
- Complete the Sparse module. One goal is to make it good enough for Step in KDE 4.3 and Krita.
- Make sure all dense decompositions are world-class (LU is already good though we have improvements in mind, SVD is being completely rewritten, etc…)
- Make fixed-size specializations of algorithms
- Optimize the case of complex numbers
- Vectorize more operations (e.g., exp() or sin() or log())
- Investigate optionally leveraging new GCC 4.4 hotness: per-function optimization flags

We need a lot of help with all that, more details can be found in our [To-do](http://eigen.tuxfamily.org/index.php?title=Todo). If new contributors join the team, in the longer term, we could see some new modules covering statistics, fast fourier transform, non linear optimizations, etc.

We also welcome testing, especially on exotic (read: non-GNU or non-x86/x86-64) platforms. All bug reports are much appreciated.

Benoit 和 Gael：我们 2.1 的目标是：

我们 2.1 的目标是：

- 完成 API 稳定（2.0 中 API 保证仅部分）
- 完成稀疏模块。目标之一是使其足够适合 KDE 4.3 和 Krita 中的 Step。
- 确保所有密集分解都是世界一流的（LU 已经很好了，尽管我们有改进的想法，SVD 正在被完全重写，等等……）
- 对算法进行固定大小的专业化
- 优化复数的情况
- 向量化更多操作（例如 exp() 或 sin() 或 log()）
- 研究选择性地利用新的 GCC 4.4 热度：每个函数优化标志

我们需要很多帮助来完成这一切，更多详细信息可以在我们的[待办事项](http://eigen.tuxfamily.org/index.php?title=Todo) 中找到。如果有新的贡献者加入团队，从长远来看，我们可以看到一些涵盖统计、快速傅立叶变换、非线性优化等的新模块。

我们也欢迎测试，特别是在异国情调（即：非 GNU 或非 x86/x86-64）平台上。 非常感谢所有错误报告。



