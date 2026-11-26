---
sidebar_position: 20
slug: /how-to-generate-uml-from-cpp-source-code
---

# 从 C++ 源代码生成 UML 类图



本文介绍一种 C++ 源代码生成 UML 类图的方法 —— 用 [Doxygen](/foss/doxygen/) 工具根据源代码生成文档，并以 Ubuntu 系统为例进行演示。



## 安装

在 Ubuntu 系统中，执行下面命令安装 doxygen 和 graphviz 软件包。

```bash
sudo apt install graphviz    # 用于生成代码关系图 
sudo apt install doxygen
```



## 示例

进入工程目录，执行下面命令生成配置文件

```bash
doxygen -g Doxygen.config
```

修改配置文件 Doxygen.config

```ini showLineNumbers
EXTRACT_ALL            = YES
HAVE_DOT               = YES
UML_LOOK               = YES
RECURSIVE              = YES 
```

根据代码生成文档

```bash
doxygen Doxygen.config
```

在工程目录下可以看到生成的 html 和 latex 目录，使用网络浏览器（例如 Chrome）打开 html 目录中的 index.html 文件，可以看到如下类似文档页面。

![](https://static.getiot.tech/doxygen-run.png#center)

找到代码中的某一个类，可以看到其 UML类图，如下所示。

![](https://static.getiot.tech/doxygen-uml.png#center)

