---
sidebar_position: 10
sidebar_label: PSD 格式
slug: /psd
---

# PSD 格式（Photoshop）

**PSD**（Photoshop Document）是 Adobe 公司 1990 年随 Photoshop 1.0 发布的存储格式，以分层结构存储图像编辑数据。支持图层、蒙版、路径和智能对象等非破坏性编辑元素，文件体积庞大且需专用软件解析，是平面设计行业的事实标准工作格式。



## 格式简介

PSD 是 Adobe Photoshop 的原生文件格式，用于存储图像编辑项目的所有信息。PSD 格式支持图层、蒙版、路径、通道、滤镜效果等所有 Photoshop 功能，是专业图像编辑的标准格式。

PSD 文件扩展名为 `.psd`，MIME 类型为 `image/vnd.adobe.photoshop`。PSD 格式是专有格式，但许多图像编辑软件都支持读取和部分编辑。



## 技术特点

### 核心特性

- **图层支持**：支持多个图层和图层组
- **非破坏性编辑**：保留所有编辑历史
- **蒙版支持**：支持图层蒙版和矢量蒙版
- **路径支持**：支持矢量路径和形状
- **通道支持**：支持 Alpha 通道和专色通道
- **智能对象**：支持智能对象和智能滤镜

### 支持的图像模式

- **RGB**：红绿蓝颜色模式
- **CMYK**：印刷颜色模式
- **灰度**：灰度图像
- **索引色**：索引颜色模式
- **Lab**：Lab 颜色空间
- **位图**：黑白位图



## 使用场景

### 适用场景

- **平面设计**：广告设计、海报设计
- **图像编辑**：照片后期处理
- **UI 设计**：界面设计、图标设计
- **印刷设计**：书籍、杂志排版
- **数字艺术**：数字绘画、插画

### 优缺点

**优点：**

- 功能完整，支持所有 Photoshop 特性
- 非破坏性编辑，保留编辑历史
- 专业标准，行业广泛使用
- 支持复杂的设计项目

**缺点：**

- 文件体积大
- 需要专用软件打开
- 某些功能其他软件可能不支持
- 专有格式，受 Adobe 控制



## 代码示例

### Python 读取 PSD

```python showLineNumbers
from psd_tools import PSDImage

# 打开 PSD 文件
psd = PSDImage.open('design.psd')

# 获取图像信息
print(f"图像尺寸: {psd.size}")
print(f"颜色模式: {psd.color_mode}")
print(f"图层数: {len(psd)}")

# 遍历图层
for layer in psd:
    print(f"图层: {layer.name}, 可见: {layer.visible}")

# 导出为图像
psd.composite().save('output.png', 'PNG')
```

### Python 使用 Pillow

```python showLineNumbers
from PIL import Image

# Pillow 可以读取 PSD，但功能有限
try:
    img = Image.open('design.psd')
    print(f"图像尺寸: {img.size}")
    # 注意：Pillow 只能读取合并后的图像，不能读取图层
except Exception as e:
    print(f"错误: {e}")
```



## 相关工具

- **编辑器**：
  - Adobe Photoshop：官方编辑器
  - GIMP：开源图像编辑器（部分支持）
  - Affinity Photo：专业图像编辑器
- **查看器**：
  - Adobe Bridge：文件浏览器
  - XnView：图像查看器
- **转换工具**：
  - ImageMagick：命令行转换工具
  - Adobe Photoshop：可以导出为其他格式
- **编程库**：
  - Python: `psd-tools`、`Pillow`（有限支持）
  - JavaScript: `psd.js`
  - C/C++: `libpsd`



## 相关链接

- [Adobe Photoshop 官方网站](https://www.adobe.com/products/photoshop.html)
- [PSD 文件格式说明](https://www.adobe.com/devnet-apps/photoshop/fileformatashtml/)



## 参考

- [PSD - Wikipedia](https://en.wikipedia.org/wiki/Adobe_Photoshop#File_format)
- [PSD 文件格式](https://en.wikipedia.org/wiki/Adobe_Photoshop#File_format)
- [psd-tools 文档](https://psd-tools.readthedocs.io/)

