---
sidebar_position: 1
sidebar_label: BMP 格式
slug: /bmp
---

# BMP 格式（Windows 位图）

**BMP**（Bitmap，位图格式）微软于 1990 年随 Windows 3.0 推出，采用设备无关位图（DIB）结构。以未压缩方式存储 RGB 像素数据，支持 1-32 bit 色深和简单 RLE 压缩，文件体积庞大，常用于图像处理中间过程保存或低性能设备显示。



## 格式简介

BMP 是 Windows 操作系统中的标准图像文件格式，采用设备无关位图（DIB，Device-Independent Bitmap）结构。BMP 格式设计简单，易于解析，但由于通常不进行压缩，文件体积较大。

BMP 文件扩展名为 `.bmp` 或 `.dib`，MIME 类型为 `image/bmp` 或 `image/x-ms-bmp`。虽然 BMP 格式文件较大，但在某些场景下仍然有用，如需要快速读取或作为图像处理的中间格式。



## 技术特点

### 压缩方式

BMP 格式支持多种压缩方式：

- **无压缩**：直接存储像素数据（最常见）
- **RLE 4**：4 位图像的行程编码压缩
- **RLE 8**：8 位图像的行程编码压缩
- **位域**：16 位和 32 位图像的压缩

### 色深支持

- **1 位**：单色（黑白）
- **4 位**：16 色
- **8 位**：256 色（使用调色板）
- **16 位**：高彩色（65536 色）
- **24 位**：真彩色（1600 万色）
- **32 位**：真彩色 + Alpha 通道

### 像素存储

- **自下而上**：默认情况下，BMP 图像从底部开始存储像素
- **自上而下**：某些 BMP 变体从上到下存储



## 文件结构

BMP 文件的基本结构：

```bash showLineNumbers
[文件头]                 # BITMAPFILEHEADER (14 字节)
  - 文件类型标识 (BM)
  - 文件大小
  - 保留字段
  - 数据偏移量
[信息头]                 # BITMAPINFOHEADER (40 字节)
  - 图像宽度
  - 图像高度
  - 色深
  - 压缩方式
  - 图像大小
  - 其他参数
[调色板]                 # 可选（索引色模式）
[像素数据]               # 实际图像数据
```



## 使用场景

### 适用场景

- **图像处理中间格式**：作为图像处理的临时格式
- **Windows 系统**：Windows 壁纸、图标等
- **简单图像存储**：不需要压缩的场景
- **兼容性要求**：需要广泛兼容的场景

### 优缺点

**优点：**

- 格式简单，易于解析
- 支持多种色深
- 无压缩时读取速度快
- Windows 原生支持

**缺点：**

- 文件体积大（通常无压缩）
- 不适合网络传输
- 不支持动画
- 逐渐被 PNG、JPEG 等格式替代



## 代码示例

### Python 处理 BMP

```python showLineNumbers
from PIL import Image

# 打开 BMP 文件
img = Image.open('image.bmp')
print(f"图像尺寸: {img.size}")
print(f"图像模式: {img.mode}")

# 保存为 BMP
img.save('output.bmp', 'BMP')

# 转换为其他格式
img.save('output.png', 'PNG')
img.save('output.jpg', 'JPEG', quality=95)
```

### C++ 读取 BMP

```cpp showLineNumbers
#include <fstream>
#include <iostream>

struct BMPHeader {
    char signature[2];      // "BM"
    uint32_t fileSize;
    uint16_t reserved1;
    uint16_t reserved2;
    uint32_t dataOffset;
};

struct BMPInfo {
    uint32_t headerSize;
    int32_t width;
    int32_t height;
    uint16_t planes;
    uint16_t bitCount;
    // ... 其他字段
};

// 读取 BMP 文件头
std::ifstream file("image.bmp", std::ios::binary);
BMPHeader header;
file.read(reinterpret_cast<char*>(&header), sizeof(header));
// ... 处理图像数据
```



## 相关工具

- **图像编辑器**：
  - Windows Paint、GIMP、Photoshop
- **编程库**：
  - Python: `Pillow (PIL)`
  - C/C++: Windows GDI+、FreeImage
  - Java: `javax.imageio`



## 参考

- [BMP - Wikipedia](https://en.wikipedia.org/wiki/BMP_file_format)
- [BMP 文件格式详解](https://en.wikipedia.org/wiki/BMP_file_format#File_structure)

