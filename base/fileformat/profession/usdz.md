---
sidebar_position: 4
sidebar_label: USDZ 格式
slug: /usdz
---

# USDZ 格式（AR 内容）

**USDZ**（Universal Scene Description Zip，通用场景描述压缩格式）是苹果与 Pixar 于 2018 年联合开发，基于 USD 格式的免解压 AR 文件封装。通过 ZIP 打包 3D 模型、动画和物理材质，支持 iOS 原生 AR Quick Look 直接预览，可嵌入 HDR 光照和空间音频，是移动端 AR 内容分发的核心格式。



## 格式简介

USDZ 是 Apple 和 Pixar 联合开发的 AR 文件格式，基于 USD（Universal Scene Description）格式。USDZ 文件实际上是一个 ZIP 压缩包，包含 3D 模型、纹理、动画等所有资源，可以在 iOS 设备上直接预览，无需解压。

USDZ 文件扩展名为 `.usdz`，MIME 类型为 `model/vnd.usdz+zip`。USDZ 格式专为 AR（增强现实）应用设计，是 iOS AR Quick Look 的标准格式。



## 技术特点

### 核心特性

- **免解压预览**：iOS 可以直接预览，无需解压
- **单文件格式**：所有资源打包在一个文件中
- **AR 优化**：专为 AR 场景优化
- **HDR 支持**：支持 HDR 光照
- **空间音频**：支持空间音频
- **物理材质**：支持基于物理的渲染

### 基于 USD

USDZ 基于 USD 格式：

- **USD**：Pixar 的场景描述格式
- **USDZ**：USD 的 ZIP 打包格式
- **兼容性**：USDZ 可以转换为 USD

### 支持的功能

- **3D 模型**：几何体、网格
- **材质**：PBR 材质、纹理
- **动画**：骨骼动画、变形动画
- **光照**：HDR 环境光照
- **音频**：空间音频



## 文件结构

USDZ 文件实际上是一个 ZIP 压缩包：

```bash showLineNumbers
model.usdz (ZIP 文件)
├── model.usd              # USD 场景描述文件
├── textures/              # 纹理文件
│   ├── diffuse.jpg
│   └── normal.png
├── geometry/              # 几何体文件
│   └── mesh.obj
└── [其他资源文件]
```

### 关键组件

- **USD 文件**：场景描述和结构
- **纹理文件**：材质贴图
- **几何体文件**：3D 模型数据
- **其他资源**：动画、音频等



## 使用场景

### 适用场景

- **AR 应用**：iOS AR Quick Look
- **电商展示**：产品 AR 预览
- **教育应用**：AR 教学内容
- **营销活动**：AR 营销内容
- **游戏开发**：AR 游戏资源

### 优缺点

**优点：**

- iOS 原生支持
- 免解压预览
- 单文件格式
- AR 优化
- 支持丰富功能

**缺点：**

- 主要在 Apple 生态使用
- 非 iOS 设备支持有限
- 需要专用工具创建
- 某些功能可能受限



## 代码示例

### 创建 USDZ

```bash showLineNumbers
# 使用 usdzconvert（Xcode 工具）
usdzconvert model.obj -o model.usdz

# 使用 Python usd-core
python -m usd.UsdUtils.CreateNewUsdzPackage model.usd model.usdz
```

### Python 使用 usd-core

```python showLineNumbers
from pxr import Usd, UsdUtils

# 创建 USD 场景
stage = Usd.Stage.CreateNew('model.usda')
# ... 添加模型、材质等

# 保存为 USDZ
UsdUtils.CreateNewUsdzPackage('model.usda', 'model.usdz')
```

### 在网页中使用

```html showLineNumbers
<!-- iOS Safari 支持 AR Quick Look -->
<a rel="ar" href="model.usdz">
    <img src="preview.jpg" alt="3D Model">
</a>
```



## 相关工具

- **创建工具**：
  - Xcode：包含 usdzconvert 工具
  - Reality Composer：Apple AR 创作工具
  - Blender：支持 USDZ 导出（需要插件）
- **查看器**：
  - AR Quick Look：iOS 原生查看器
  - Reality Composer：Apple AR 工具
- **编程库**：
  - Python: `usd-core`、`pxr`
  - Swift: `RealityKit`、`ARKit`



## 相关链接

- [USD 官方网站](https://openusd.org/)
- [USDZ 格式说明](https://developer.apple.com/augmented-reality/quick-look/)
- [AR Quick Look 文档](https://developer.apple.com/augmented-reality/quick-look/)



## 参考

- [USDZ - Wikipedia](https://en.wikipedia.org/wiki/USDZ)
- [USD 格式](https://openusd.org/)
- [AR Quick Look 指南](https://developer.apple.com/augmented-reality/quick-look/)

