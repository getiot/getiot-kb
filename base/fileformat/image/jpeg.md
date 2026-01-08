---
sidebar_position: 2
sidebar_label: JPG 格式
slug: /jpeg
---

# JPG/JPEG 格式（有损压缩）

**JPG**/**JPEG**（Joint Photographic Experts Group，联合图像专家组）格式由 ISO/IEC 联合团队于 1992 年制定，采用离散余弦变换（DCT）和量化表实现**有损压缩**。通过舍弃高频细节将图像压缩至原体积的 1/10-1/20，支持渐进式加载，仍是数码照片和网络图像的主流格式，但不支持透明通道。



## 格式简介

JPEG 是一种广泛使用的有损压缩图像格式，特别适合存储照片和具有丰富颜色渐变的图像。JPEG 格式通过牺牲一些图像质量来大幅减小文件体积，这种权衡使其成为数码摄影和网络图像传输的主流格式。

JPEG 文件扩展名通常为 `.jpg` 或 `.jpeg`，MIME 类型为 `image/jpeg`。JPEG 标准由 ISO/IEC 10918 定义，支持多种压缩质量级别。



## 技术特点

### 压缩算法

JPEG 使用离散余弦变换（DCT）和量化技术进行压缩：

1. **颜色空间转换**：将 RGB 转换为 YCbCr 颜色空间
2. **分块处理**：将图像分成 8×8 像素块
3. **DCT 变换**：对每个块进行离散余弦变换
4. **量化**：使用量化表减少高频信息
5. **熵编码**：使用霍夫曼编码进一步压缩

### JPEG 变体

- **JPEG**：标准 JPEG 格式（基线 JPEG）
- **JPEG Progressive**：渐进式 JPEG，支持逐步加载显示
- **JPEG 2000**：使用小波变换的新标准（扩展名 `.jp2`）
- **JPEG XR**：微软开发的高动态范围格式

### 压缩质量

JPEG 压缩质量通常用 0-100 的数值表示：
- **90-100**：高质量，文件较大，适合打印
- **70-90**：中等质量，平衡质量和文件大小
- **50-70**：较低质量，文件较小，适合网络传输
- **0-50**：低质量，明显压缩伪影



## 文件结构

JPEG 文件由多个段（Segment）组成：

```bash showLineNumbers
[SOI]                    # 文件开始标记 (0xFFD8)
[APP0]                   # 应用数据段（可选）
[APPn]                   # 其他应用数据段
[DQT]                    # 量化表
[SOF0]                   # 帧开始（基线 JPEG）
[DHT]                    # 霍夫曼表
[SOS]                    # 扫描开始
[压缩图像数据]
[EOI]                    # 文件结束标记 (0xFFD9)
```

### 主要标记

- **SOI (0xFFD8)**：图像开始
- **EOI (0xFFD9)**：图像结束
- **APP0-APP15**：应用数据段
- **DQT**：定义量化表
- **SOF**：帧开始，定义图像参数
- **DHT**：定义霍夫曼表
- **SOS**：扫描开始，压缩数据开始



## 使用场景

### 适用场景

- **数码摄影**：相机和手机拍摄的照片
- **网络图像**：网页、社交媒体图片
- **图像存储**：需要压缩存储空间的场景
- **照片分享**：在线相册、图片分享平台

### 优缺点

**优点：**

- 压缩率高，文件体积小
- 支持 1600 万色（24 位真彩色）
- 广泛支持，几乎所有设备都支持
- 支持渐进式加载
- 压缩质量可调

**缺点：**

- 有损压缩，会丢失图像细节
- 不适合存储文字、线条图（会产生伪影）
- 不支持透明通道
- 不支持动画
- 多次编辑会累积质量损失



## 代码示例

### Python 处理 JPEG

```python showLineNumbers
from PIL import Image

# 打开 JPEG 图像
img = Image.open('photo.jpg')
print(f"图像尺寸: {img.size}")
print(f"图像模式: {img.mode}")

# 调整质量保存
img.save('output.jpg', 'JPEG', quality=85, optimize=True)

# 转换为其他格式
img.save('output.png', 'PNG')

# 调整大小
img_resized = img.resize((800, 600), Image.Resampling.LANCZOS)
img_resized.save('resized.jpg', 'JPEG', quality=90)
```

### Python 读取 JPEG 元数据

```python showLineNumbers
from PIL import Image
from PIL.ExifTags import TAGS

img = Image.open('photo.jpg')

# 读取 EXIF 数据
exifdata = img.getexif()
for tag_id, value in exifdata.items():
    tag = TAGS.get(tag_id, tag_id)
    print(f"{tag}: {value}")
```

### JavaScript 处理 JPEG

```javascript showLineNumbers
// 在浏览器中读取 JPEG
const img = new Image();
img.onload = function() {
    console.log(`图像尺寸: ${img.width} x ${img.height}`);
    
    // 绘制到 Canvas 并转换
    const canvas = document.createElement('canvas');
    canvas.width = img.width;
    canvas.height = img.height;
    const ctx = canvas.getContext('2d');
    ctx.drawImage(img, 0, 0);
    
    // 转换为 Blob
    canvas.toBlob((blob) => {
        console.log('JPEG Blob:', blob);
    }, 'image/jpeg', 0.9);
};
img.src = 'photo.jpg';
```



## 相关工具

- **图像编辑器**：
  - Adobe Photoshop、GIMP、Paint.NET
  - 在线工具：TinyJPG、Squoosh
- **命令行工具**：
  - `jpegoptim`：JPEG 优化工具
  - `cjpeg`：JPEG 压缩工具（来自 libjpeg）
- **编程库**：
  - Python: `Pillow (PIL)`、`opencv-python`
  - JavaScript: `sharp`、`jimp`
  - C/C++: `libjpeg`、`libjpeg-turbo`



## 相关链接

- [JPEG 标准 (ISO/IEC 10918)](https://www.iso.org/standard/18902.html)
- [libjpeg 官方网站](https://ijg.org/)



## 参考

- [JPEG - Wikipedia](https://en.wikipedia.org/wiki/JPEG)
- [JPEG 压缩原理](https://en.wikipedia.org/wiki/JPEG#JPEG_codec_example)

