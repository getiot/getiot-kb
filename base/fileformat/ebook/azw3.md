---
sidebar_position: 3
sidebar_label: AZW3 格式
slug: /azw3
---

# AZW3 格式（Kindle 增强）

**AZW3**（Kindle Format 8，KF8）格式由 Amazon 于 2011 年推出，作为 MOBI 格式的增强替代方案。基于 EPUB 3.0 标准改进，采用 HTML5/CSS3 技术，支持更丰富的排版、数学公式和 JavaScript 交互。虽然结构类似 EPUB，但使用专有 DRM 保护和 Amazon 特定的扩展，是当前 Kindle 设备的主流格式。



## 格式简介

AZW3 是 Amazon Kindle 设备的现代电子书格式，也被称为 Kindle Format 8 (KF8)。AZW3 格式基于 EPUB 3.0 标准，但添加了 Amazon 特定的扩展和 DRM 保护。AZW3 格式提供了比 MOBI 格式更强大的排版和交互能力。

AZW3 文件扩展名为 `.azw3`，MIME 类型为 `application/vnd.amazon.ebook`。AZW3 格式是专有格式，主要用于 Amazon Kindle 生态系统。



## 技术特点

### 核心特性

- **基于 EPUB 3.0**：采用 EPUB 3.0 的开放标准
- **HTML5/CSS3**：支持现代 Web 技术
- **增强排版**：支持复杂布局和样式
- **JavaScript 支持**：支持交互式内容
- **DRM 保护**：Amazon 专有 DRM 系统
- **数学公式**：支持 MathML 数学公式

### 与 MOBI 的区别

- **更强大的排版**：支持更复杂的 CSS 样式
- **更好的图像支持**：支持 SVG 和高质量图像
- **交互功能**：支持 JavaScript 交互
- **数学公式**：原生支持 MathML
- **更好的字体支持**：支持嵌入字体

### 与 EPUB 的关系

AZW3 格式在结构上非常接近 EPUB 3.0，但有以下区别：

- **DRM 保护**：使用 Amazon 专有 DRM
- **专有扩展**：包含 Amazon 特定的元数据和功能
- **文件扩展名**：使用 `.azw3` 而非 `.epub`



## 文件结构

AZW3 文件结构类似于 EPUB，实际上是一个 ZIP 压缩包：

```bash showLineNumbers
book.azw3 (ZIP 文件)
├── mimetype                    # MIME 类型（application/epub+zip）
├── META-INF/
│   ├── container.xml           # 容器文件
│   └── encryption.xml          # DRM 加密信息
├── OEBPS/                      # 内容目录
│   ├── content.opf             # 包文档
│   ├── nav.xhtml               # 导航文档
│   ├── chapter1.xhtml          # 章节内容
│   ├── styles.css              # 样式文件
│   └── images/                 # 图片资源
└── [DRM 相关文件]
```

### 关键组件

- **container.xml**：指向 OPF 文件
- **content.opf**：包含清单、元数据和导航
- **encryption.xml**：DRM 加密信息（如果存在）
- **HTML/CSS 内容**：实际的电子书内容



## 使用场景

### 适用场景

- **Kindle 设备**：现代 Kindle 电子阅读器
- **Kindle 应用**：Kindle 移动和桌面应用
- **Amazon 平台**：通过 Amazon 购买和分发的电子书
- **专业出版**：需要复杂排版的专业电子书

### 优缺点

**优点：**

- 强大的排版能力
- 支持交互式内容
- 支持数学公式
- 现代 Kindle 设备原生支持
- 文件体积相对较小

**缺点：**

- 专有格式，受 Amazon 控制
- DRM 保护限制使用
- 非 Kindle 设备支持有限
- 编辑和转换相对困难
- 需要授权工具才能创建



## 代码示例

### Python 读取 AZW3（需去除 DRM）

```python showLineNumbers
import zipfile
from xml.etree import ElementTree as ET

# 注意：读取受 DRM 保护的 AZW3 文件需要先去除 DRM
# 这里仅展示文件结构读取

with zipfile.ZipFile('book.azw3', 'r') as zip_file:
    # 读取容器文件
    try:
        container_xml = zip_file.read('META-INF/container.xml')
        root = ET.fromstring(container_xml)
        print("文件结构正常")
    except:
        print("文件可能受 DRM 保护或格式不正确")
```

### 使用 Calibre 转换

```bash showLineNumbers
# 使用 Calibre 命令行工具转换 AZW3
ebook-convert book.azw3 book.epub
ebook-convert book.azw3 book.pdf
ebook-convert book.epub book.azw3
```

### Python 使用 Calibre API

```python showLineNumbers
from calibre.ebooks.conversion.cli import main as convert_main
import sys

# 注意：这需要 Calibre 库支持
# 实际使用中，通常通过命令行调用 Calibre

# 转换 AZW3 到 EPUB
# convert_main(['book.azw3', 'book.epub'])
```



## 相关工具

- **阅读器**：
  - Amazon Kindle：官方阅读器和应用
  - Calibre：可以读取未受 DRM 保护的 AZW3
- **转换工具**：
  - Calibre：支持 AZW3 与其他格式互转（需去除 DRM）
  - KindleUnpack：解包 AZW3 文件
- **编辑工具**：
  - Calibre Editor：可以编辑转换后的 EPUB
  - Sigil：编辑 EPUB 后可以转换回 AZW3
- **编程库**：
  - Python: `calibre`（需要完整安装 Calibre）
  - JavaScript: 有限支持



## 相关链接

- [Kindle Format 8 说明](https://www.amazon.com/gp/feature.html?docId=1000765211)
- [Calibre 官方网站](https://calibre-ebook.com/)
- [KindleUnpack 工具](https://github.com/apprenticeharper/DeDRM_tools)



## 参考

- [AZW3 - Wikipedia](https://en.wikipedia.org/wiki/Amazon_Kindle#File_formats)
- [Kindle Format 8 文档](https://wiki.mobileread.com/wiki/AZW3)
- [Kindle 格式对比](https://www.amazon.com/gp/help/customer/display.html?nodeId=200505520)
