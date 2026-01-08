---
sidebar_position: 3
sidebar_label: PNG 格式
slug: /png
---

# PNG 格式（透明通道）

**PNG**（Portable Network Graphics，便携式网络图形）格式于 1996 年由 W3C 为替代 GIF 推出，采用 DEFLATE 无损压缩算法。支持 24 bit 真彩色 + 8 bit Alpha 透明通道，提供扫描行过滤优化，适合保存图标、界面元素等需要透明背景的图形，文件体积比 BMP 小 70% 以上。



## 格式简介

PNG 是一种无损压缩的位图图像格式，设计目的是替代 GIF 格式。PNG 支持透明度、真彩色和更好的压缩比，同时避免了 GIF 的专利问题。PNG 格式特别适合存储需要透明背景的图像，如网页图标、界面元素等。

PNG 文件扩展名为 `.png`，MIME 类型为 `image/png`。PNG 格式由 W3C 制定，现已成为 Web 图像的标准格式之一。



## 技术特点

### 压缩算法

PNG 使用 DEFLATE 压缩算法（与 ZIP 相同），包含两个阶段：

1. **过滤**：对每个扫描行应用预测过滤器（0-4 五种类型）
2. **压缩**：使用 DEFLATE 算法压缩过滤后的数据

### PNG 类型

- **PNG-8**：8 位色深，256 色，支持单色透明
- **PNG-24**：24 位色深，1600 万色，不支持透明
- **PNG-32**：32 位色深（24 位颜色 + 8 位 Alpha），支持半透明

### 核心特性

- **无损压缩**：压缩后图像质量不变
- **Alpha 通道**：支持 8 位透明度（256 级透明）
- **真彩色**：支持 24 位真彩色（1600 万色）
- **交错显示**：支持 Adam7 交错，逐步显示图像
- **伽马校正**：支持跨平台颜色一致性



## 文件结构

PNG 文件由 PNG 签名和一系列数据块（Chunk）组成：

```bash showLineNumbers
[PNG 签名]               # 89 50 4E 47 0D 0A 1A 0A
[IHDR]                   # 图像头块（宽高、色深等）
[可选数据块]
  - PLTE                 # 调色板（索引色模式）
  - tRNS                 # 透明度信息
  - gAMA                 # 伽马值
  - cHRM                 # 色度信息
  - IDAT                 # 图像数据块（可多个）
  - IEND                 # 图像结束块
```

### 数据块结构

每个数据块包含：
- **长度**（4 字节）：数据长度
- **类型**（4 字节）：块类型标识
- **数据**（可变长度）：实际数据
- **CRC**（4 字节）：循环冗余校验



## 使用场景

### 适用场景

- **网页图标**：需要透明背景的图标、Logo
- **界面元素**：UI 设计、按钮、装饰元素
- **截图保存**：需要无损保存的截图
- **图像编辑**：图像处理软件的中间格式
- **图表图形**：需要精确颜色的图表、示意图

### 优缺点

**优点：**

- 无损压缩，图像质量完美
- 支持 Alpha 透明通道
- 支持真彩色
- 广泛支持，所有浏览器都支持
- 无专利限制

**缺点：**

- 文件体积通常比 JPEG 大
- 不支持动画（需使用 APNG）
- 压缩比不如 JPEG（照片类图像）
- 某些旧版浏览器支持有限



## 代码示例

### Python 处理 PNG

```python showLineNumbers
from PIL import Image

# 打开 PNG 图像
img = Image.open('image.png')
print(f"图像尺寸: {img.size}")
print(f"图像模式: {img.mode}")  # RGBA 表示支持透明

# 处理透明通道
if img.mode == 'RGBA':
    # 创建白色背景
    background = Image.new('RGB', img.size, (255, 255, 255))
    background.paste(img, mask=img.split()[3])  # 使用 Alpha 通道作为蒙版
    background.save('output.jpg', 'JPEG', quality=95)

# 保存为 PNG
img.save('output.png', 'PNG', optimize=True)

# 调整透明度
if img.mode == 'RGBA':
    # 降低透明度
    r, g, b, a = img.split()
    a = a.point(lambda x: x * 0.8)  # 透明度降低到 80%
    img = Image.merge('RGBA', (r, g, b, a))
    img.save('semi_transparent.png', 'PNG')
```

### JavaScript 处理 PNG

```javascript showLineNumbers
// 在浏览器中处理 PNG
const img = new Image();
img.onload = function() {
    const canvas = document.createElement('canvas');
    canvas.width = img.width;
    canvas.height = img.height;
    const ctx = canvas.getContext('2d');
    
    // 绘制图像（保留透明通道）
    ctx.drawImage(img, 0, 0);
    
    // 转换为 Blob
    canvas.toBlob((blob) => {
        console.log('PNG Blob:', blob);
    }, 'image/png');
    
    // 获取像素数据
    const imageData = ctx.getImageData(0, 0, canvas.width, canvas.height);
    console.log('像素数据:', imageData.data);
};
img.src = 'image.png';
```



## 相关工具

- **图像编辑器**：
  - Adobe Photoshop、GIMP、Paint.NET
  - 在线工具：TinyPNG、Squoosh
- **命令行工具**：
  - `pngquant`：PNG 压缩工具
  - `optipng`：PNG 优化工具
  - `pngcrush`：PNG 压缩工具
- **编程库**：
  - Python: `Pillow (PIL)`、`png`、`pypng`
  - JavaScript: `sharp`、`pngjs`
  - C/C++: `libpng`



## 相关链接

- [PNG 规范 (W3C)](https://www.w3.org/TR/PNG/)
- [libpng 官方网站](http://www.libpng.org/)



## 参考

- [PNG - Wikipedia](https://en.wikipedia.org/wiki/Portable_Network_Graphics)
- [PNG 文件格式详解](https://www.w3.org/TR/PNG/)

