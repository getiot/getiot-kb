---
sidebar_position: 2
side_label: DOC 格式
slug: /doc
---

# DOC 和 DOCX 格式（Word）

**DOC** 是微软 1997 年推出的二进制文档格式（Word 97-2003），采用复合文件结构存储图文混排内容。**DOCX** 于 2007 年随 Office 2007 发布，基于 Office Open XML 标准（ISO/IEC 29500），使用 ZIP 压缩打包 XML 文件和资源，支持高级排版、宏脚本和数字签名，现为办公文档主流格式。



## 格式简介

DOC 和 DOCX 是 Microsoft Word 文档的两种主要格式。DOC 是传统的二进制格式，而 DOCX 是基于 XML 的开放标准格式。DOCX 格式的出现标志着微软从专有格式向开放标准的转变，提高了文档的可移植性和互操作性。

- **DOC**：Microsoft Word 97-2003 使用的二进制格式，文件扩展名为 `.doc`
- **DOCX**：Microsoft Word 2007 及以后版本使用的格式，文件扩展名为 `.docx`，基于 Office Open XML 标准



## 技术特点

### DOC 格式特点

- **复合文件结构**：采用 OLE（Object Linking and Embedding）复合文档格式
- **二进制存储**：以二进制形式存储文档内容、格式和元数据
- **向后兼容**：新版本 Word 仍支持打开和编辑 DOC 文件
- **文件较大**：相比 DOCX，文件体积通常更大

### DOCX 格式特点

- **基于 XML**：文档内容以 XML 格式存储，人类可读
- **ZIP 压缩**：实际上是一个 ZIP 压缩包，包含多个 XML 文件
- **模块化结构**：文档、样式、媒体资源分离存储
- **开放标准**：ISO/IEC 29500 国际标准，可被其他软件解析
- **文件较小**：压缩后体积通常比 DOC 格式小 20-30%



## 文件结构

### DOCX 文件结构

DOCX 文件实际上是一个 ZIP 压缩包，解压后包含以下结构：

```bash showLineNumbers
document.docx (ZIP 文件)
├── [Content_Types].xml          # 内容类型定义
├── _rels/                        # 关系文件
│   └── .rels
├── docProps/                     # 文档属性
│   ├── app.xml
│   └── core.xml
└── word/                         # 文档主体
    ├── document.xml              # 主文档内容
    ├── styles.xml                # 样式定义
    ├── settings.xml              # 文档设置
    ├── webSettings.xml           # Web 设置
    ├── fontTable.xml             # 字体表
    ├── numbering.xml             # 编号定义
    ├── theme/                    # 主题
    └── media/                    # 媒体文件（图片等）
```

### DOC 文件结构

DOC 文件采用 OLE 复合文档格式（CFB，Compound File Binary Format），结构复杂，包含：

- **文件头**：版本信息、文件属性
- **流（Streams）**：存储不同类型的数据
- **存储（Storages）**：目录结构
- **扇区分配表**：管理文件空间



## 使用场景

### 适用场景

- **办公文档**：报告、信函、合同等正式文档
- **学术论文**：论文、研究报告等学术文档
- **商业文档**：商业计划、提案、手册等
- **模板文档**：各种文档模板

### 优缺点

**DOCX 优点：**

- 开放标准，可被多种软件支持
- 文件体积相对较小
- 结构清晰，易于程序解析
- 支持高级功能（数字签名、内容控件等）

**DOCX 缺点：**

- 需要支持 ZIP 和 XML 的软件才能打开
- 某些旧版软件可能不支持

**DOC 优点：**

- 兼容性极好，几乎所有文字处理软件都支持
- 格式成熟稳定

**DOC 缺点：**

- 专有格式，结构复杂
- 文件体积较大
- 已不再更新，逐渐被淘汰



## 代码示例

### Python 读取 DOCX

```python showLineNumbers
from docx import Document

# 读取 DOCX 文件
doc = Document('document.docx')

# 读取段落
for paragraph in doc.paragraphs:
    print(paragraph.text)

# 读取表格
for table in doc.tables:
    for row in table.rows:
        for cell in row.cells:
            print(cell.text)
```

### Python 创建 DOCX

```python showLineNumbers
from docx import Document
from docx.shared import Inches

# 创建新文档
doc = Document()

# 添加标题
doc.add_heading('文档标题', 0)

# 添加段落
doc.add_paragraph('这是一个段落。')

# 添加表格
table = doc.add_table(rows=2, cols=2)
table.cell(0, 0).text = '单元格1'
table.cell(0, 1).text = '单元格2'

# 保存文档
doc.save('output.docx')
```

### 直接解析 DOCX（ZIP + XML）

```python showLineNumbers
import zipfile
from xml.etree import ElementTree as ET

# DOCX 文件是 ZIP 压缩包
with zipfile.ZipFile('document.docx', 'r') as zip_file:
    # 读取主文档内容
    xml_content = zip_file.read('word/document.xml')
    root = ET.fromstring(xml_content)
    
    # 解析 XML 内容
    # ... 处理 XML 节点
```



## 相关工具

- **Microsoft Word**：官方编辑器
- **LibreOffice Writer**：开源替代方案，支持 DOC/DOCX
- **Google Docs**：在线编辑器，支持 DOCX
- **WPS Office**：国产办公软件，支持 DOC/DOCX
- **编程库**：
  - Python: `python-docx`、`docx2python`
  - Java: `Apache POI`
  - JavaScript: `docx`、`mammoth.js`



## 相关链接

- [Office Open XML 标准 (ISO/IEC 29500)](https://www.iso.org/standard/71691.html)
- [python-docx 文档](https://python-docx.readthedocs.io/)
- [Apache POI 文档](https://poi.apache.org/)



## 参考

- [DOCX 文件格式 - Wikipedia](https://en.wikipedia.org/wiki/Office_Open_XML)
- [Microsoft Office 文件格式](https://docs.microsoft.com/en-us/openspecs/office_file_formats/)
