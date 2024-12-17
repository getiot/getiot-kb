---
sidebar_position: 22
slug: /kaldi
---

# Kaldi

![](https://static.getiot.tech/kaldi_text_and_logo.png#center-200)

Kaldi 是一个开源的语音识别系统，使用 Apache v2.0 开源协议，由 Daniel Povey 主导开发，在很多语音识别测试和应用中广泛使用。但它依赖大量脚本语言，且核心算法是用 C++ 编写的，对声学模型的更新和代码调试带来一定难度。它的主要目标用户是语音识别的研究者（而不是普通的用户）。

Kaldi 的目标和 HTK 类似，它需要提供现代和灵活的代码，使用 C++ 实现，容易修改和扩展。它包括如下重要特性：

- **代码级别集成 WFST**

  Kaldi 是把 OpenFST 作为一个库编译进来。(而不是脚本的方式集成)。

- **广泛的线性代数支持**

  Kaldi 包括封装了标准 BLAS 和 LAPACK 库的[矩阵库](http://kaldi-asr.org/doc/matrix.html)。

- **可扩展的设计**

  比如，Kaldi 中的 decoder 是基于模板，模板的对象根据（frame, fst-input-symbol）来计算 score。这就意味着 decoder 可以很容易的用神经网络梯度 GMM 模型。

- **开源协议**

  基于 Apache 2.0 开源协议，最自由的开源协议。

- **完整的 recipe**

  对于很多常见语音数据集（主要是 LDC 的数据，当然也有一些其它开源数据集）都提供完整的 recipe，从而可以完整的复现整个过程。

包含完整的 reciple 是 Kaldi 的重要特性。这样其他人就可以轻松的复现整个实验过程。

GitHub 地址：[https://github.com/kaldi-asr/kaldi](https://github.com/kaldi-asr/kaldi)



## 参考

- [关于Kaldi](http://fancyerii.github.io/kaldidoc/about/)
- [专注E2E语音识别，腾讯AILab开源语音处理工具包PIKA](https://www.163.com/dy/article/FVJJGK2M0511AQHO.html)

