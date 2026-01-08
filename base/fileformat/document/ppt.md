---
sidebar_position: 4
side_label: PPT 格式
slug: /ppt
---

# PPT 和 PPTX 格式（PowerPoint）

**PPT/PPTX** 是 Microsoft PowerPoint 的演示文稿格式。PPT 是早期的二进制 OLE 复合文件（PowerPoint 97-2003），PPTX 是 2007 年起的 Office Open XML（OOXML）基于 ZIP 的开放标准（ISO/IEC 29500）。PPT 兼容老旧系统，PPTX 体积更小、可扩展性更好。



## 格式简介

- **PPT**：二进制格式存储于 OLE 复合文档，扩展名 `.ppt`，MIME `application/vnd.ms-powerpoint`
- **PPTX**：OOXML 标准，基于 ZIP 打包 XML 与资源，扩展名 `.pptx`，MIME `application/vnd.openxmlformats-officedocument.presentationml.presentation`



## 技术特点

### PPT（OLE 复合文档）

- OLE 复合文档，包含多流（Presentation、SummaryInfo 等）
- 二进制格式存储幻灯片、动画、媒体资源
- 兼容性好，结构封闭、扩展性弱

### PPTX（OOXML/ZIP）

- 基于 OPC（Open Packaging Convention），ZIP 打包 XML
- 清晰的部件：`ppt/presentation.xml`、`ppt/slides/*.xml`、`ppt/media/`、`ppt/theme/`
- 体积更小，支持媒体资源分离、样式分离，易于解析与扩展



## 文件结构

### PPT（简化示例）

```bash showLineNumbers
[OLE Header]
├── Presentation        # 演示文稿流（幻灯片/动画/格式）
├── SummaryInformation
└── DocumentSummaryInformation
```

### PPTX（简化示例）

```bash showLineNumbers
presentation.pptx (ZIP)
├── [Content_Types].xml          # 内容类型
├── _rels/.rels                  # 包级关系
├── ppt/presentation.xml         # 演示文稿定义
├── ppt/slides/slide1.xml        # 幻灯片内容
├── ppt/slides/slide2.xml
├── ppt/media/                   # 媒体资源
│   ├── image1.png
│   └── video1.mp4
├── ppt/theme/theme1.xml         # 主题
├── ppt/slideLayouts/            # 幻灯片布局
└── ppt/_rels/presentation.xml.rels  # 演示文稿关系
```



## 使用场景

### 适用场景

- **演示文稿**：商务演示、教学课件、产品展示
- **报告制作**：工作报告、项目汇报、学术报告
- **培训材料**：培训课件、教学材料
- **模板分发**：企业模板、设计模板

### 优缺点

**优点：**

- 广泛兼容，办公场景标准
- PPTX 体积小、易解析；PPT 兼容旧系统
- 支持动画、过渡效果、多媒体嵌入
- 支持模板、主题、母版设计

**缺点：**

- PPT 为专有二进制，扩展性差、易损坏
- 大文件加载速度慢，内存占用高
- PPTX 解压/解析相对开销
- 某些高级功能需要特定版本支持



## 代码示例

### Python（python-pptx 读取）

```python showLineNumbers
from pptx import Presentation

# 打开 PPTX 文件
prs = Presentation('presentation.pptx')

# 遍历幻灯片
for i, slide in enumerate(prs.slides):
    print(f"幻灯片 {i+1}:")
    # 遍历形状
    for shape in slide.shapes:
        if hasattr(shape, "text"):
            print(f"  文本: {shape.text}")
```

### Python（python-pptx 创建）

```python showLineNumbers
from pptx import Presentation
from pptx.util import Inches

# 创建新演示文稿
prs = Presentation()

# 添加幻灯片（使用标题和内容布局）
slide_layout = prs.slide_layouts[1]
slide = prs.slides.add_slide(slide_layout)

# 添加标题
title = slide.shapes.title
title.text = "演示文稿标题"

# 添加内容
content = slide.placeholders[1]
content.text = "这是幻灯片内容"

# 保存
prs.save('demo.pptx')
```

### Python（提取文本）

```python showLineNumbers
from pptx import Presentation

prs = Presentation('presentation.pptx')

# 提取所有文本
text_runs = []
for slide in prs.slides:
    for shape in slide.shapes:
        if hasattr(shape, "text"):
            text_runs.append(shape.text)

print('\n'.join(text_runs))
```

### 命令行转换（LibreOffice）

```bash showLineNumbers
# 转换为 PDF
libreoffice --headless --convert-to pdf input.pptx

# 转换为 PPT
libreoffice --headless --convert-to ppt input.pptx

# 转换为 HTML
libreoffice --headless --convert-to html input.pptx
```

### Python（提取图片）

```python showLineNumbers
from pptx import Presentation
import os

prs = Presentation('presentation.pptx')

# 创建输出目录
os.makedirs('extracted_images', exist_ok=True)

# 提取所有图片
for i, slide in enumerate(prs.slides):
    for j, shape in enumerate(slide.shapes):
        if hasattr(shape, "image"):
            image = shape.image
            image_bytes = image.blob
            image_ext = image.ext
            with open(f'extracted_images/slide{i}_img{j}.{image_ext}', 'wb') as f:
                f.write(image_bytes)
```



## 相关工具

- **编辑器**：
  - Microsoft PowerPoint：官方编辑器
  - WPS 演示：国产办公软件
  - LibreOffice Impress：开源演示软件
  - Google Slides：在线演示工具
- **转换/处理**：
  - `libreoffice-cli`：命令行转换工具
  - `unoconv`：文档转换工具
  - `pptx2pdf`：PPTX 转 PDF
- **编程库**：
  - Python: `python-pptx`、`python-pptx-template`
  - Java: `Apache POI`
  - JavaScript: `pptxgenjs`、`officegen`



## 相关链接

- [Office Open XML (ISO/IEC 29500)](https://www.iso.org/standard/71691.html)
- [Open Packaging Conventions](https://learn.microsoft.com/en-us/openspecs/office_standards/ms-opc/)
- [PowerPoint 文件格式说明](https://learn.microsoft.com/en-us/openspecs/office_file_formats/)



## 参考

- [PPT - Wikipedia](https://en.wikipedia.org/wiki/Microsoft_PowerPoint#File_formats)
- [PowerPoint 文件格式](https://en.wikipedia.org/wiki/Microsoft_PowerPoint#File_formats)
- [OOXML PresentationML](https://en.wikipedia.org/wiki/Office_Open_XML)
- [python-pptx 文档](https://python-pptx.readthedocs.io/)
