---
sidebar_position: 9
sidebar_label: HEIC 格式
slug: /heic
---

# HEIC 格式（高效压缩）

**HEIC**（High Efficiency Image Container，高效图像容器）格式由 MPEG 组织 2015 年基于 HEVC/H.265 标准开发，苹果在 iOS 11 中强制推广。通过帧间预测和四叉树分区编码，压缩效率比 JPEG 高 40%-50%，支持深度图、连拍序列和 Alpha 通道，但专利授权问题限制开源支持。



## 格式简介

HEIC 是一种现代图像格式，基于 HEVC（H.265）视频编码技术。HEIC 格式提供了比 JPEG 更高的压缩效率，同时支持更多功能，如透明度、深度图和连拍序列。

HEIC 文件扩展名为 `.heic` 或 `.heif`，MIME 类型为 `image/heic` 或 `image/heif`。HEIC 格式由 MPEG 组织制定，是 ISO/IEC 23008-12 标准的一部分。



## 技术特点

### 核心特性

- **高压缩比**：比 JPEG 节省 40%-50% 文件体积
- **高质量**：相同文件大小下质量更高
- **深度图支持**：支持景深信息
- **连拍序列**：可以存储多张相关图像
- **Alpha 通道**：支持透明度
- **16 位色深**：支持更高色深

### 编码技术

HEIC 使用 HEVC 编码技术：

- **帧内预测**：利用空间相关性
- **变换编码**：DCT 变换
- **量化**：自适应量化
- **熵编码**：CABAC 熵编码

### HEIC vs JPEG

- **压缩效率**：HEIC 比 JPEG 高 40%-50%
- **功能**：HEIC 支持更多功能（深度图、连拍等）
- **兼容性**：JPEG 兼容性更好
- **专利**：HEIC 有专利限制



## 文件结构

HEIC 文件基于 ISO 基础媒体文件格式（ISO Base Media File Format）：

```bash showLineNumbers
[ftyp]                  # 文件类型盒
[meta]                  # 元数据盒
  - ispe                # 图像尺寸
  - irot                # 图像旋转
  - colr                # 颜色信息
  - pixi                # 像素信息
[mdat]                  # 媒体数据盒（HEVC 编码数据）
```

### 关键盒说明

- **ftyp**：文件类型标识
- **meta**：包含图像元数据
- **mdat**：包含 HEVC 编码的图像数据



## 使用场景

### 适用场景

- **Apple 设备**：iPhone、iPad 默认照片格式
- **高质量照片存储**：需要高压缩比的场景
- **连拍照片**：存储连拍序列
- **深度图应用**：需要景深信息的应用

### 优缺点

**优点：**

- 压缩效率高，文件体积小
- 质量好，视觉损失小
- 支持丰富功能（深度图、连拍等）
- 支持 16 位色深

**缺点：**

- 专利限制，开源支持有限
- 兼容性不如 JPEG
- 某些设备和软件不支持
- 编码速度相对较慢



## 代码示例

### Python 处理 HEIC

```python showLineNumbers
from PIL import Image

# 注意：Pillow 需要 pillow-heif 插件支持 HEIC
try:
    from pillow_heif import register_heif_opener
    register_heif_opener()
    
    # 打开 HEIC 文件
    img = Image.open('photo.heic')
    print(f"图像尺寸: {img.size}")
    
    # 转换为 JPEG
    img.save('output.jpg', 'JPEG', quality=95)
except ImportError:
    print("需要安装 pillow-heif: pip install pillow-heif")
```

### 命令行工具

```bash showLineNumbers
# 使用 ImageMagick
magick convert input.heic output.jpg
magick convert input.jpg output.heic

# 使用 ffmpeg
ffmpeg -i input.heic output.jpg
ffmpeg -i input.jpg -c:v libx265 output.heic

# 使用 heif-convert（libheif 工具）
heif-convert input.heic output.jpg
```

### 使用 pyheif

```python showLineNumbers
import pyheif
from PIL import Image

# 读取 HEIC 文件
heif_file = pyheif.read('photo.heic')

# 转换为 PIL Image
image = Image.frombytes(
    heif_file.mode,
    heif_file.size,
    heif_file.data,
    "raw",
    heif_file.mode,
    heif_file.stride,
)

# 保存为 JPEG
image.save('output.jpg', 'JPEG')
```



## 相关工具

- **查看器**：
  - Apple Photos：macOS/iOS 原生支持
  - Windows 10+：内置支持（需要扩展）
  - ImageMagick：支持 HEIC
- **转换工具**：
  - ImageMagick：命令行转换工具
  - FFmpeg：支持 HEIC 编码解码
  - libheif：开源 HEIC 库
- **编程库**：
  - Python: `pillow-heif`、`pyheif`
  - C/C++: `libheif`
  - JavaScript: `heic2any`



## 相关链接

- [HEIC 标准 (ISO/IEC 23008-12)](https://www.iso.org/standard/66067.html)
- [libheif 项目](https://github.com/strukturag/libheif)
- [HEIF 规范](https://nokiatech.github.io/heif/technical.html)



## 参考

- [HEIC - Wikipedia](https://en.wikipedia.org/wiki/High_Efficiency_Image_File_Format)
- [HEIF 格式详解](https://nokiatech.github.io/heif/)
- [HEIC vs JPEG 对比](https://www.howtogeek.com/345418/what-is-a-heic-file-and-why-does-my-iphone-use-it/)
