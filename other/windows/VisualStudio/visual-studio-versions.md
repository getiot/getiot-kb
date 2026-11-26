---
sidebar_position: 2
slug: /visual-studio-versions
sidebar_label: Visual Studio 版本说明
---

# Visual Studio 版本说明（C++）

新手在刚使用 Visual Studio 开发 C++ 应用程序时往往会对其版本产生困惑，包括 Visual Studio 版本、MSVC 版本、工具集版本等等。因此本文尝试给大家解释一下 Visual Studio 不同版本号的对应关系。

以 Visual Studio 2022 为例，版本信息包括：

- Visual Studio 发布年份（营销版本号），例如 Visual Studio 2022
- Visual Studio 的实际版本号，例如 Visual Studio 17.0
- Visual C++（MSVC）版本，例如 MSVC 14.30
- 工具集（Toolset）版本，例如 toolset 143
- 编译器版本，例如 `cl.exe` 19.30



## Visual Studio 版本

我相信大多数人首先看到的是 Visual Studio 的发布年份，因为 Microsoft 官方就是这么宣传的。例如你可以在官网下载页面看到 Visual Studio 2022、Visual Studio 2019 等等。

但其实 Visual Studio 的版本也有一个更加普遍的 `major.minor` 版本控制方案，主版本号会在每个发布年份递增。例如 VS 2010 是版本 10，VS 2017 是版本 15，VS 2019 是版本 16，VS 2022 是版本 17。所以，如果客户跟你说：“我用的是 15 版本”，那就意味着它是 Visual Studio 2017。

请注意，Visual Studio 版本的年份和主要版本之间没有任何关联，只是 Visual Studio 2010 恰好也是版本 10。

当然，除了主版本号，Visual Studio 还有次版本号。下表列出了目前主要版本的对应关系。

|      发布年份      | 实际版本号 |
| :----------------: | :--------: |
| Visual Studio 2017 |    15.0    |
|                    |    15.3    |
| Visual Studio 2019 |    16.0    |
|                    |    16.1    |
| Visual Studio 2022 |    17.0    |
|                    |    17.1    |



## Visual C++ 版本

Microsoft Visual C++，又名 MSVC，虽然它作为 Visual Studio 的一部分跟随 Visual Studio 一同发布，但它也有自己的版本控制方案。值得一提的是，MSVC 的主版本号表示 ABI 兼容性，这意味着使用同一主版本号 MSVC 编译的东西可以与使用相同主版本号的任意其他 MSVC 编译的东西链接（有一些[限制](https://learn.microsoft.com/en-us/cpp/porting/binary-compat-2015-2017)）。

幸运的是，MSVC 的主要版本号比 Visual Studio 版本本身更少被调整。到 Visual Studio 2022 为止，微软官方都将 MSVC 的主要版本保持在了 14，而次要版本的第一个数字似乎在每个主要版本的 Visual Studio 中都有所改变。

下表列出了 Visual Studio 和 MSVC 版本的对应关系。

|      发布年份      | 实际版本号 | MSVC 版本 |
| :----------------: | :--------: | :-------: |
| Visual Studio 2017 |    15.0    |   14.1    |
|                    |    15.3    |   14.11   |
| Visual Studio 2019 |    16.0    |   14.20   |
|                    |    16.1    |   14.21   |
| Visual Studio 2022 |    17.0    |   14.30   |
|                    |    17.1    |   14.31   |

:::tip

链接器（`link.exe`）也使用 Visual C++ 版本号作为它的版本号。例如 Visual C++ 14.32，你可能会看到 `link.exe` 版本号为 `14.32.31332.0`。

:::



## C++ 工具集版本

与 MSVC 版本号密切相关的是 C++ 工具集（toolset）版本号。从微软官方的文章来看，工具集版本似乎是由 MSVC 主要版本和 MSVC 次要版本的第一位数字组成。

我整理到下面表格，方便你能看出来它们之间的关系。

|      发布年份      | 实际版本号 | MSVC 版本 | 工具集版本 |
| :----------------: | :--------: | :-------: | :--------: |
| Visual Studio 2017 |    15.0    |   14.1    |    141     |
|                    |    15.3    |   14.11   |    141     |
| Visual Studio 2019 |    16.0    |   14.20   |    142     |
|                    |    16.1    |   14.21   |    142     |
| Visual Studio 2022 |    17.0    |   14.30   |    143     |
|                    |    17.1    |   14.31   |    143     |



## 编译器版本

最后是编译器的版本，在这里特指 `cl.exe` 的版本，例如 `19.16.27048`。并且这个 `major.minor` 版本号与 `_MSC_VER` 宏定义相关联，这意味着你可以在源代码中检查它。例如，`cl.exe` 版本 19.21 对应的 `_MSC_VER` 宏为 1921。

你可以通过下面代码获取当前所使用的 Visual Studio 编译器的版本：

```cpp showLineNumbers
#include <iostream>

int main()
{
    std::cout << "Version: " << _MSC_VER << std::endl;
    return 0;
}
```

下表列出了 Visual Studio、MSVC、工具集以及编译器版本的对应关系。

|      发布年份      | 实际版本号 | MSVC 版本 | 工具集版本 | 编译器版本 |
| :----------------: | :--------: | :-------: | :--------: | :--------: |
| Visual Studio 2017 |    15.0    |   14.1    |    141     |   19.10    |
|                    |    15.3    |   14.11   |    141     |   19.11    |
| Visual Studio 2019 |    16.0    |   14.20   |    142     |   19.20    |
|                    |    16.1    |   14.21   |    142     |   19.21    |
| Visual Studio 2022 |    17.0    |   14.30   |    143     |   19.30    |
|                    |    17.1    |   14.31   |    143     |   19.31    |

基于此关系，你可以在源代码中通过 `_MSC_VER` 宏来区分不同版本，例如只有在足够新的 Visual Studio 编译环境下才编译某些东西，例如 `#if _MSC_VER >= 1930`。

参考下面示例代码：

```cpp showLineNumbers
#include <iostream>

int main()
{
#if _MSC_VER >= 1930
    std::cout << "Visual Studio 2022" << std::endl;
#elif _MSC_VER >= 1920
    std::cout << "Visual Studio 2019" << std::endl;
#elif _MSC_VER >= 1910
    std::cout << "Visual Studio 2017" << std::endl;
#elif _MSC_VER >= 1900
    std::cout << "Visual Studio 2015" << std::endl;
#elif _MSC_VER >= 1800
    std::cout << "Visual Studio 2013" << std::endl;
#elif _MSC_VER >= 1700
    std::cout << "Visual Studio 2012" << std::endl;
#elif _MSC_VER >= 1600
    std::cout << "Visual Studio 2010" << std::endl;
#else
    std::cout << "Unknown Version" << std::endl;
#endif
    return 0;
}
```



## 小结

本文介绍了 Windows 集成开发环境 Visual Studio 令人混淆的版本号关系，横向对比了 MSVC、工具集以及编译器的版本号，并通过示例演示了如何在源代码中判断当前版本。希望对你有所帮助！

