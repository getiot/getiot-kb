---
sidebar_position: 6
authors: [luhuadong]
---

# 3D 打印 STL 文件格式



STL（STereo Lithography）文件格式已成为快速原型（Rapid Prototyping）制造行业的事实标准数据传输格式。最早由 3D System 公司创始人查尔斯·W·哈尔（Charles W.Hull）于 1988 年为满足其光固化立体成型（Stereo Lithography）工艺的需要而制定。



## STL 文件简介

STL 文件格式的最大特点是通过许多小三角形面片的组合来表达真实的模型结构。本质是将一个立体的模型文件按照一定规则划分成多个三角形面片，每个面片都包含该三角形面片个顶点的三维坐标及三角形面片的法向量信息，同时三角形的三个顶点排列顺序遵循右手定则。

![](https://static.getiot.tech/STL-format-Normal.png#center)

STL 文件格式并不是目前 3D 打印体系支持的唯一格式，但由于 STL 格式的三角形面片的格式易于被切片软件的分层处理，[ASCII](/computerbasics/ascii/) 码格式下的文件易于阅读和修改。所以，几乎所有的三维 CAD 设计软件和 3D 打印系统都支持 STL 格式，并已经被大家所默认为一种标准。此外，STL 切片输出模型的精度易于控制，切片算法相对简单，效率较高等也是其流行的重要原因。

![](https://static.getiot.tech/stl-example.jpg#center)

在存储格式上，STL 文件格式会给出每个三角形面片的三个顶点坐标和三角形法向量的分量来确定每个三角形面片的正方向。正是由于三角形面片组合，STL 模型文件出现错误后容易按照同一规则进行修改，模型的纠错也变得更加简单。

而在文件存储形式上，STL 文件可以按 [ASCII](/computerbasics/ascii/) 码格式存储，也可以按二进制格式存储。



## ASCII 码格式

ASCII 码格式的 STL 文件具有很强的可读性，但相比于二进制格式更占空间。ASCII 格式文件逐行给出三角形面片的集合信息，每个三角形面片的信息单元被命名为 facet，每个 facet 代表一个带矢量方向的三角形面片。格式如下：

```bash showLineNumbers
solid filename       # 文件路径及文件名
  facet normal x y x # 三角形面片法向量的 3 个分量值
    outer loop
      vertex x y z   # 三角形面片第一个顶点坐标
      vertex x y z   # 三角形面片第二个顶点坐标
      vertex x y z   # 三角形面片第三个顶点坐标
    endloop
  endfacet           # 完成一个三角形面片定义
  
  ...                # 其他三角形面片定义
  
endsolid             # 完成整个 STL 文件定义
```

每个三角形面片又由 7 行数据组成，其中 `facet normal` 后面紧跟三角形面片指向实体外部的法向量坐标，`outer loop` 后紧跟 3 行数据分别是三角形面片的 3 个顶点坐标。顶点沿指向实体外部的法向量方向逆时针排列（即遵循右手法则）。

下面是一个真实的 ASCII 码格式的 STL 文件：

```bash showLineNumbers
        solid cube_corner
          facet normal 0.0 -1.0 0.0
            outer loop
              vertex 0.0 0.0 0.0
              vertex 1.0 0.0 0.0
              vertex 0.0 0.0 1.0
            endloop
          endfacet
          facet normal 0.0 0.0 -1.0
            outer loop
              vertex 0.0 0.0 0.0
              vertex 0.0 1.0 0.0
              vertex 1.0 0.0 0.0
            endloop
          endfacet
          facet normal -1.0 0.0 0.0
            outer loop
              vertex 0.0 0.0 0.0
              vertex 0.0 0.0 1.0
              vertex 0.0 1.0 0.0
            endloop
          endfacet
          facet normal 0.577 0.577 0.577
            outer loop
              vertex 1.0 0.0 0.0
              vertex 0.0 1.0 0.0
              vertex 0.0 0.0 1.0
            endloop
          endfacet
        endsolid
```



## 二进制格式

二进制格式的 STL 文件可读性差（对人类来说），但相比于 ASCII 格式所需的存储空间更少，因此适合存储精度较高或者尺寸较大的 STL 模型文件。

二进制 STL 文件使用固定的字节数来给出三角形面片的几何信息。文件起始的 80 个字节是文件头，用于储存文件名。随后 4 个字节的整数用来描述模型的三角形面片个数，也就是说，一个 STL 文件可存储的三角形面片的个数理论上最多为 2 的 32 次方个。在这之后出现的是每个三角形面片的几何信息，每个三角形面片占用固定的 50 个字节，其中包括：

- 3 个 4 字节浮点数（三角形面片的法向量）
- 3 个 4 字节浮点数（第 1 个顶点的坐标）
- 3 个 4 字节浮点数（第 2 个顶点的坐标）
- 3 个 4 字节浮点数（第 3 个顶点的坐标）
- 2 个字节，用于描述三角形面片的属性信息

因此，一个完整的二进制格式 STL 文件，其大小为三角形面片数乘以 50 再加上 84 个字节。而在 ASCII 格式中，一个三角形面片至少需要 100 多个字节。

![](https://static.getiot.tech/ASCII-and-binary-STL-file.png#center)



