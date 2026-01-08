---
sidebar_position: 1
sidebar_label: STL 格式
slug: /stl
---

# STL 格式（3D 打印模型）

**STL**（Stereolithography，光固化三维模型格式）是 3D Systems 公司 1987 年为 SLA 3D 打印机制定的一种模型格式，采用三角面片描述物体表面几何。文件以 ASCII 或二进制格式存储顶点坐标和法向量，不支持颜色、材质和层级结构，体积庞大但兼容性强，仍是 CAD 软件与 3D 打印机交互的通用格式。



## 格式简介

STL 是一种用于 3D 打印的模型文件格式，通过三角面片（三角形）来描述三维物体的表面。STL 格式简单、兼容性强，被所有 3D 打印机和 CAD 软件支持，是 3D 打印行业的标准格式。

STL 文件扩展名为 `.stl`，MIME 类型为 `model/stl` 或 `application/sla`。STL 格式支持 ASCII 和二进制两种编码方式。



## 技术特点

### 核心特性

- **三角面片**：使用三角形网格描述表面
- **简单格式**：结构简单，易于解析
- **广泛支持**：所有 3D 打印机都支持
- **两种编码**：支持 ASCII 和二进制格式

### 格式限制

- **无颜色信息**：不支持颜色和纹理
- **无材质信息**：不支持材质属性
- **无层级结构**：不支持模型层级
- **仅表面**：只描述表面，不包含内部结构

### ASCII vs 二进制

- **ASCII**：人类可读，文件较大
- **二进制**：文件较小，解析更快



## 文件结构

### ASCII STL 格式

```text showLineNumbers
solid object_name
  facet normal nx ny nz
    outer loop
      vertex x1 y1 z1
      vertex x2 y2 z2
      vertex x3 y3 z3
    endloop
  endfacet
  ...
endsolid object_name
```

### 二进制 STL 格式

```bash showLineNumbers
[文件头]                 # 80 字节头信息
[三角面片数量]           # 4 字节无符号整数
[三角面片 1]             # 50 字节
  - 法向量（12 字节）
  - 顶点1（12 字节）
  - 顶点2（12 字节）
  - 顶点3（12 字节）
  - 属性字节（2 字节）
[三角面片 2]
...
```



## 使用场景

### 适用场景

- **3D 打印**：3D 打印机模型文件
- **快速原型**：快速原型制作
- **CAD 导出**：CAD 软件导出格式
- **模型分享**：3D 模型文件分享

### 优缺点

**优点：**

- 格式简单，易于解析
- 广泛支持，兼容性强
- 适合 3D 打印
- 文件结构清晰

**缺点：**

- 不支持颜色和材质
- 文件体积可能较大
- 精度有限
- 不支持复杂属性



## 代码示例

### Python 读取 STL

```python showLineNumbers
from stl import mesh

# 读取 STL 文件
your_mesh = mesh.Mesh.from_file('model.stl')

# 获取信息
print(f"三角面片数: {len(your_mesh.vectors)}")
print(f"体积: {your_mesh.get_mass_properties()[0]}")

# 访问三角面片
for triangle in your_mesh.vectors:
    print(f"三角形顶点: {triangle}")
```

### Python 创建 STL

```python showLineNumbers
from stl import mesh
import numpy as np

# 创建简单的立方体
vertices = np.array([
    [0, 0, 0], [1, 0, 0], [1, 1, 0], [0, 1, 0],  # 底面
    [0, 0, 1], [1, 0, 1], [1, 1, 1], [0, 1, 1]   # 顶面
])

# 定义三角面片
faces = np.array([
    [0, 1, 2], [0, 2, 3],  # 底面
    [4, 7, 6], [4, 6, 5],  # 顶面
    # ... 其他面
])

# 创建网格
cube = mesh.Mesh(np.zeros(faces.shape[0], dtype=mesh.Mesh.dtype))
for i, f in enumerate(faces):
    for j in range(3):
        cube.vectors[i][j] = vertices[f[j]]

# 保存
cube.save('cube.stl')
```



## 相关工具

- **3D 建模软件**：
  - Blender：开源 3D 建模软件
  - AutoCAD：CAD 软件
  - SolidWorks：3D CAD 软件
- **STL 处理工具**：
  - MeshLab：网格处理工具
  - Netfabb：STL 修复工具
- **编程库**：
  - Python: `numpy-stl`、`pymeshlab`
  - JavaScript: `three.js`（支持 STL 加载）
  - C/C++: `Open3D`



## 相关链接

- [STL 格式说明](https://en.wikipedia.org/wiki/STL_(file_format))
- [numpy-stl 文档](https://github.com/WoLpH/numpy-stl)



## 参考

- [STL - Wikipedia](https://en.wikipedia.org/wiki/STL_(file_format))
- [STL 文件格式详解](https://en.wikipedia.org/wiki/STL_(file_format)#Binary_STL)

