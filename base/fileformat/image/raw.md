---
sidebar_position: 11
sidebar_label: RAW 格式
slug: /raw
---

# RAW 格式（相机原始数据）

**RAW**（Raw Image Data，相机原始数据）由相机厂商自定义的传感器直出格式（如 .CR3、.NEF、.ARW）。记录未经处理的拜耳阵列数据，保留 12-16 bit 色深和完整动态范围，需通过 Lightroom 等软件进行解拜耳和色彩校正，是专业摄影后期制作的必备格式。



## 格式简介

RAW 是数码相机传感器直接输出的原始图像数据格式。RAW 文件包含未经处理的传感器数据，保留了完整的图像信息，为后期处理提供了最大的灵活性。不同相机厂商使用不同的 RAW 格式。

常见的 RAW 格式包括：
- **CR2/CR3**：Canon
- **NEF**：Nikon
- **ARW**：Sony
- **RAF**：Fujifilm
- **ORF**：Olympus
- **RW2**：Panasonic
- **DNG**：Adobe 通用 RAW 格式



## 技术特点

### 核心特性

- **未压缩数据**：保留传感器原始数据
- **高色深**：通常 12-16 位色深（JPEG 为 8 位）
- **完整动态范围**：保留完整的亮度范围
- **拜耳阵列**：需要解拜耳处理
- **元数据丰富**：包含相机设置、EXIF 等

### 拜耳阵列

RAW 文件使用拜耳阵列（Bayer Pattern）记录颜色信息：

- **红绿蓝滤镜**：每个像素只记录一种颜色
- **解拜耳**：通过插值算法重建完整颜色
- **去马赛克**：将单色像素转换为 RGB 像素

### RAW vs JPEG

- **文件大小**：RAW 文件通常比 JPEG 大 3-5 倍
- **处理需求**：RAW 需要后期处理，JPEG 可直接使用
- **灵活性**：RAW 提供更大的后期调整空间
- **质量**：RAW 保留更多细节和动态范围



## 使用场景

### 适用场景

- **专业摄影**：需要高质量输出的摄影
- **后期制作**：需要大量后期调整的照片
- **商业摄影**：产品摄影、人像摄影
- **风景摄影**：需要保留完整动态范围的场景
- **艺术创作**：需要最大创作自由度的场景

### 优缺点

**优点：**

- 保留完整图像信息
- 高色深，色彩过渡平滑
- 完整动态范围
- 后期调整空间大
- 无损处理

**缺点：**

- 文件体积大
- 需要专用软件处理
- 处理速度较慢
- 不同厂商格式不统一
- 不适合快速分享



## 代码示例

### Python 读取 RAW

```python showLineNumbers
from rawpy import RawPy
import imageio

# 打开 RAW 文件
with RawPy.imread('photo.CR2') as raw:
    # 获取图像信息
    print(f"图像尺寸: {raw.sizes}")
    print(f"颜色模式: {raw.color_desc}")
    
    # 处理 RAW 数据
    rgb = raw.postprocess(
        use_camera_wb=True,
        half_size=False,
        no_auto_bright=True,
        output_bps=16
    )
    
    # 保存为 TIFF
    imageio.imsave('output.tiff', rgb)
```

### Python 使用 rawpy

```python showLineNumbers
import rawpy
import numpy as np
from PIL import Image

# 读取 RAW
raw = rawpy.imread('photo.NEF')

# 处理 RAW
rgb = raw.postprocess()

# 转换为 PIL Image
img = Image.fromarray(rgb)
img.save('output.jpg', 'JPEG', quality=95)
```

### 使用 dcraw

```bash showLineNumbers
# 使用 dcraw 转换 RAW
dcraw -c -w photo.CR2 | pnmtojpeg > output.jpg

# 转换为 TIFF
dcraw -T photo.CR2

# 使用特定白平衡
dcraw -w -c photo.CR2 | pnmtojpeg > output.jpg
```



## 相关工具

- **RAW 处理软件**：
  - Adobe Lightroom：专业 RAW 处理
  - Adobe Camera Raw：Photoshop 插件
  - Capture One：专业 RAW 处理
  - Darktable：开源 RAW 处理
- **转换工具**：
  - dcraw：命令行 RAW 转换工具
  - Adobe DNG Converter：转换为 DNG 格式
  - ImageMagick：支持部分 RAW 格式
- **编程库**：
  - Python: `rawpy`、`rawkit`
  - C/C++: `libraw`、`dcraw`



## 相关链接

- [DNG 格式 (Adobe)](https://helpx.adobe.com/camera-raw/using/adobe-dng-converter.html)
- [libraw 项目](https://www.libraw.org/)
- [dcraw 工具](https://www.dechifro.org/dcraw/)



## 参考

- [RAW - Wikipedia](https://en.wikipedia.org/wiki/Raw_image_format)
- [RAW 格式对比](https://en.wikipedia.org/wiki/Raw_image_format#File_contents)
- [RAW 处理指南](https://helpx.adobe.com/camera-raw/using/introduction-camera-raw.html)

