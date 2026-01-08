---
sidebar_position: 7
sidebar_label: ODT 格式
slug: /odt
---

# ODT 格式（OpenOffice）

**ODT**（OpenDocument Text，开放文档文本）由 OASIS 组织 2005 年制定（ISO/IEC 26300），作为开源办公套件（LibreOffice/OpenOffice）的默认格式。基于 XML 和 ZIP 压缩技术，支持段落样式、目录索引和嵌入式对象，文件结构开放可解析，是 DOCX 格式的主要开源替代方案。



## 格式简介

ODT 是 OpenDocument 格式系列中的文本文档格式，由 OASIS（Organization for the Advancement of Structured Information Standards）组织制定，2006 年成为 ISO/IEC 26300 国际标准。ODT 格式是开源办公软件（如 LibreOffice、OpenOffice）的默认文档格式，旨在提供一个开放的、基于 XML 的文档格式标准。

ODT 文件扩展名为 `.odt`，MIME 类型为 `application/vnd.oasis.opendocument.text`。



## 技术特点

### 核心特性

- **开放标准**：ISO/IEC 26300 国际标准，完全开放
- **基于 XML**：文档内容以 XML 格式存储
- **ZIP 压缩**：实际上是一个 ZIP 压缩包
- **模块化设计**：内容、样式、元数据分离
- **向后兼容**：支持版本升级和迁移

### OpenDocument 格式系列

- **ODT**：文本文档（OpenDocument Text）
- **ODS**：电子表格（OpenDocument Spreadsheet）
- **ODP**：演示文稿（OpenDocument Presentation）
- **ODG**：图形（OpenDocument Graphics）



## 文件结构

ODT 文件是一个 ZIP 压缩包，解压后包含以下结构：

```bash showLineNumbers
document.odt (ZIP 文件)
├── mimetype                    # MIME 类型声明（未压缩）
├── META-INF/
│   └── manifest.xml            # 文件清单
├── content.xml                 # 文档主体内容
├── styles.xml                  # 样式定义
├── meta.xml                    # 元数据
├── settings.xml                # 文档设置
└── Configurations2/            # 配置信息
```

### 主要 XML 文件

- **content.xml**：文档的实际内容（文本、段落、表格等）
- **styles.xml**：样式定义（段落样式、字符样式等）
- **meta.xml**：文档元数据（作者、创建日期等）
- **settings.xml**：文档设置（视图设置、打印设置等）



## 使用场景

### 适用场景

- **开源办公环境**：LibreOffice、OpenOffice 用户
- **跨平台文档交换**：需要开放格式的场景
- **文档归档**：长期保存的文档（开放标准）
- **政府机构**：许多政府机构要求使用开放格式

### 优缺点

**优点：**

- 完全开放的 ISO 标准
- 文件结构清晰，易于解析
- 支持丰富的格式和功能
- 不受单一厂商控制
- 文件体积相对较小

**缺点：**

- 与 Microsoft Office 的兼容性可能存在问题
- 某些复杂格式可能无法完美转换
- 用户普及度不如 DOCX



## 代码示例

### Python 读取 ODT

```python showLineNumbers
import zipfile
from xml.etree import ElementTree as ET

# ODT 文件是 ZIP 压缩包
with zipfile.ZipFile('document.odt', 'r') as zip_file:
    # 读取文档内容
    content_xml = zip_file.read('content.xml')
    root = ET.fromstring(content_xml)
    
    # 解析文本内容
    # ODT 使用特定的命名空间
    namespaces = {
        'text': 'urn:oasis:names:tc:opendocument:xmlns:text:1.0',
        'office': 'urn:oasis:names:tc:opendocument:xmlns:office:1.0'
    }
    
    # 提取所有文本段落
    paragraphs = root.findall('.//text:p', namespaces)
    for para in paragraphs:
        if para.text:
            print(para.text)
```

### 使用 odfpy 库

```python showLineNumbers
from odf.opendocument import load
from odf.text import P

# 加载 ODT 文件
doc = load('document.odt')

# 读取段落
for paragraph in doc.getElementsByType(P):
    print(paragraph)
```



## 相关工具

- **LibreOffice Writer**：主要的 ODT 编辑器
- **OpenOffice Writer**：另一个开源编辑器
- **Google Docs**：支持导入/导出 ODT
- **Microsoft Word**：可以打开和保存 ODT（兼容性可能有限）
- **编程库**：
  - Python: `odfpy`、`python-odf`
  - Java: `ODFDOM`（Apache）



## 相关链接

- [OpenDocument 标准 (ISO/IEC 26300)](https://www.iso.org/standard/43485.html)
- [OASIS OpenDocument 规范](https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=office)
- [odfpy 文档](https://github.com/eea/odfpy)



## 参考

- [OpenDocument - Wikipedia](https://en.wikipedia.org/wiki/OpenDocument)
- [LibreOffice 文档](https://www.libreoffice.org/)
