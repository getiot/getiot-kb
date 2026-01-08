---
sidebar_position: 1
sidebar_label: EPUB 格式
slug: /epub
---

# EPUB 格式（开放电子书）

**EPUB**（Electronic Publication，电子出版物）格式由国际数字出版论坛（IDPF）于 2007 年制定，现由 W3C 维护（EPUB 3.0+）。基于开放标准（XHTML、CSS、ZIP），采用容器化结构打包多个 HTML 文件和资源，支持自适应布局、数学公式和多媒体内容，是数字出版和电子书阅读器的通用开放格式。



## 格式简介

EPUB 是一种开放的电子书标准格式，设计用于在不同设备和阅读器上提供一致的阅读体验。EPUB 格式基于 Web 标准（HTML、CSS、XML），使得电子书可以像网页一样灵活排版和显示。

EPUB 文件扩展名为 `.epub`，MIME 类型为 `application/epub+zip`。EPUB 格式是开放标准，不受单一厂商控制，被广泛用于数字出版。



## 技术特点

### 核心特性

- **开放标准**：基于 W3C 和 IDPF 标准，完全开放
- **Web 技术**：使用 HTML、CSS、JavaScript
- **自适应布局**：支持响应式设计，适应不同屏幕
- **可访问性**：支持屏幕阅读器和辅助技术
- **多媒体支持**：支持音频、视频、交互内容

### EPUB 版本

- **EPUB 2.0**：2007 年发布，基于 XHTML 1.1
- **EPUB 3.0**：2011 年发布，增强功能（HTML5、CSS3、JavaScript）
- **EPUB 3.1**：2017 年发布，进一步改进
- **EPUB 3.2**：2019 年发布，当前最新版本

### 内容格式

- **XHTML/HTML5**：文档内容
- **CSS**：样式和布局
- **SVG**：矢量图形
- **JavaScript**：交互功能（EPUB 3.0+）
- **MathML**：数学公式（EPUB 3.0+）



## 文件结构

EPUB 文件实际上是一个 ZIP 压缩包，包含以下结构：

```bash showLineNumbers
book.epub (ZIP 文件)
├── mimetype                    # MIME 类型声明（未压缩）
├── META-INF/
│   └── container.xml            # 容器文件，指向 OPF
├── OEBPS/                      # 内容目录（可自定义名称）
│   ├── content.opf             # 包文档（清单、元数据、导航）
│   ├── toc.ncx                 # 导航控制文件（EPUB 2.0）
│   ├── nav.xhtml               # 导航文档（EPUB 3.0）
│   ├── chapter1.xhtml          # 章节内容
│   ├── chapter2.xhtml
│   ├── styles.css              # 样式文件
│   └── images/                 # 图片资源
│       └── cover.jpg
└── [其他资源文件]
```

### 关键文件

- **mimetype**：必须包含 `application/epub+zip`，且必须未压缩
- **container.xml**：指向 OPF 文件的位置
- **content.opf**：包文档，包含清单、元数据和导航信息
- **toc.ncx**：EPUB 2.0 的导航文件
- **nav.xhtml**：EPUB 3.0 的导航文件



## 使用场景

### 适用场景

- **数字出版**：电子书、电子杂志、技术文档
- **教育内容**：教材、课程材料
- **企业文档**：手册、报告、培训材料
- **个人出版**：自出版电子书

### 优缺点

**优点：**

- 开放标准，不受厂商控制
- 基于 Web 技术，易于创建和编辑
- 支持丰富的格式和交互
- 自适应布局，适应不同设备
- 文件体积相对较小

**缺点：**

- 某些阅读器支持有限
- 复杂布局可能在不同设备上显示不一致
- 需要一定的技术知识来创建



## 代码示例

### Python 读取 EPUB

```python showLineNumbers
import zipfile
from xml.etree import ElementTree as ET

# EPUB 文件是 ZIP 压缩包
with zipfile.ZipFile('book.epub', 'r') as zip_file:
    # 读取容器文件
    container_xml = zip_file.read('META-INF/container.xml')
    root = ET.fromstring(container_xml)
    
    # 获取 OPF 文件路径
    opf_path = root.find('.//{urn:oasis:names:tc:opendocument:xmlns:container}rootfile').get('full-path')
    
    # 读取 OPF 文件
    opf_content = zip_file.read(opf_path)
    opf_root = ET.fromstring(opf_content)
    
    # 提取元数据
    metadata = opf_root.find('.//{http://www.idpf.org/2007/opf}metadata')
    title = metadata.find('.//{http://purl.org/dc/elements/1.1/}title').text
    print(f"书名: {title}")
```

### Python 使用 ebooklib

```python showLineNumbers
import ebooklib
from ebooklib import epub

# 读取 EPUB
book = epub.read_epub('book.epub')

# 获取元数据
print(f"标题: {book.get_metadata('DC', 'title')[0][0]}")
print(f"作者: {book.get_metadata('DC', 'creator')[0][0]}")

# 读取章节
for item in book.get_items():
    if item.get_type() == ebooklib.ITEM_DOCUMENT:
        content = item.get_content().decode('utf-8')
        print(content[:200])  # 打印前 200 个字符
```

### Python 创建 EPUB

```python showLineNumbers
import ebooklib
from ebooklib import epub

# 创建 EPUB 书籍
book = epub.EpubBook()

# 设置元数据
book.set_identifier('id123456')
book.set_title('示例电子书')
book.set_language('zh-CN')
book.add_author('作者姓名')

# 添加章节
chapter1 = epub.EpubHtml(title='第一章', file_name='chap01.xhtml', lang='zh-CN')
chapter1.content = '<h1>第一章</h1><p>这是第一章的内容。</p>'
book.add_item(chapter1)

# 添加默认 NCX 和 Nav 文件
book.toc = [chapter1]
book.add_item(epub.EpubNcx())
book.add_item(epub.EpubNav())

# 设置封面
book.set_cover('cover.jpg', open('cover.jpg', 'rb').read())

# 生成 EPUB 文件
epub.write_epub('output.epub', book)
```



## 相关工具

- **阅读器**：
  - Adobe Digital Editions：官方 EPUB 阅读器
  - Calibre：跨平台电子书管理工具
  - Apple Books：macOS/iOS 内置阅读器
  - Google Play Books：Android 阅读器
- **编辑器**：
  - Sigil：开源 EPUB 编辑器
  - Calibre Editor：Calibre 内置编辑器
  - Adobe InDesign：专业排版工具（可导出 EPUB）
- **转换工具**：
  - Calibre：支持多种格式转换
  - Pandoc：通用文档转换工具
- **编程库**：
  - Python: `ebooklib`、`epub2`、`pypub`
  - JavaScript: `epub.js`、`epub-gen`
  - Java: `epublib`



## 相关链接

- [EPUB 3.2 规范 (W3C)](https://www.w3.org/publishing/epub32/)
- [EPUB 官方网站](https://www.w3.org/publishing/epub/)
- [EPUB 示例文件](https://github.com/IDPF/epub3-samples)



## 参考

- [EPUB - Wikipedia](https://en.wikipedia.org/wiki/EPUB)
- [EPUB 3.2 规范](https://www.w3.org/TR/epub-32/)
- [EPUB 入门指南](https://www.w3.org/publishing/epub32/epub-spec.html)
