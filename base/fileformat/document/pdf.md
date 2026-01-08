---
sidebar_position: 5
sidebar_label: PDF 格式
slug: /pdf
---

# PDF 格式（跨平台文档）

**PDF**（Portable Document Format，便携式文档格式）由 Adobe 公司 1993 年发布（现为 ISO 32000 标准），采用 PostScript 语言子集描述页面布局。通过嵌入字体、矢量图形和压缩算法实现跨平台格式一致性，支持数字签名、注释和权限控制，是电子书、学术论文和官方文件的通用分发格式。



## 格式简介

PDF 是一种用于呈现文档的独立于应用软件、硬件和操作系统的文件格式。PDF 文件可以包含文本、图形、链接、表单字段、音频、视频和业务逻辑等元素，并且能够保持文档的原始格式和布局，无论使用什么设备或软件查看。

PDF 格式最初由 Adobe 开发，2008 年成为开放标准（ISO 32000），现在由 ISO 委员会维护。PDF 文件扩展名通常为 `.pdf`，MIME 类型为 `application/pdf`。



## 技术特点

### 核心特性

- **跨平台一致性**：在任何设备上显示效果相同
- **字体嵌入**：可以嵌入字体，确保文档显示一致
- **压缩支持**：支持多种压缩算法（Flate、LZW、JPEG 等）
- **矢量图形**：支持矢量图形，缩放不失真
- **安全性**：支持密码保护、数字签名、权限控制
- **交互性**：支持表单、链接、书签等交互元素

### PDF 版本

- **PDF 1.0-1.3**：早期版本，基础功能
- **PDF 1.4**：支持透明度、JavaScript
- **PDF 1.5**：支持对象流、交叉引用流
- **PDF 1.6**：支持 3D 注释、OpenType 字体
- **PDF 1.7**：成为 ISO 32000-1:2008 标准
- **PDF 2.0**：ISO 32000-2:2020，增强安全性和可访问性



## 文件结构

PDF 文件由以下部分组成：

```bash showLineNumbers
%PDF-1.7                    # PDF 版本标识
[对象]                       # PDF 对象（页面、字体、图像等）
xref                        # 交叉引用表
trailer                     # 文件尾
%%EOF                       # 文件结束标记
```

### 主要对象类型

- **页面对象（Page）**：定义页面内容和属性
- **字体对象（Font）**：定义使用的字体
- **图像对象（Image）**：嵌入的图像数据
- **流对象（Stream）**：压缩的数据流
- **字典对象（Dictionary）**：键值对结构
- **数组对象（Array）**：有序对象列表



## 使用场景

### 适用场景

- **电子书**：电子出版物、电子杂志
- **学术论文**：期刊论文、学位论文
- **官方文档**：政府文件、法律文档、合同
- **技术文档**：产品手册、技术规范
- **表单**：可填写的 PDF 表单
- **演示文稿**：幻灯片、报告

### 优缺点

**优点：**

- 跨平台显示一致
- 文件体积相对较小（压缩后）
- 支持交互元素和多媒体
- 安全性好，支持加密和签名
- 广泛支持，几乎所有设备都能查看

**缺点：**

- 编辑相对困难（需要专业工具）
- 某些复杂布局可能在不同查看器中显示略有差异
- 文件结构复杂，解析需要专业知识



## 代码示例

### Python 读取 PDF

```python showLineNumbers
import PyPDF2

# 读取 PDF 文件
with open('document.pdf', 'rb') as file:
    pdf_reader = PyPDF2.PdfFileReader(file)
    
    # 获取页数
    num_pages = pdf_reader.numPages
    
    # 读取文本
    for page_num in range(num_pages):
        page = pdf_reader.getPage(page_num)
        text = page.extractText()
        print(text)
```

### Python 创建 PDF

```python showLineNumbers
from reportlab.lib.pagesizes import letter
from reportlab.pdfgen import canvas

# 创建 PDF
c = canvas.Canvas("output.pdf", pagesize=letter)

# 添加文本
c.drawString(100, 750, "Hello, PDF!")

# 保存
c.save()
```

### 使用 pdfplumber 提取表格

```python showLineNumbers
import pdfplumber

with pdfplumber.open('document.pdf') as pdf:
    for page in pdf.pages:
        # 提取表格
        tables = page.extract_tables()
        for table in tables:
            for row in table:
                print(row)
```



## 相关工具

- **Adobe Acrobat**：官方 PDF 编辑器
- **PDF Reader**：各种 PDF 阅读器（Adobe Reader、Foxit Reader 等）
- **在线工具**：PDF 合并、分割、转换等在线服务
- **编程库**：
  - Python: `PyPDF2`、`pdfplumber`、`reportlab`、`fpdf`
  - Java: `Apache PDFBox`、`iText`
  - JavaScript: `pdf.js`、`pdf-lib`



## 相关链接

- [PDF 标准 (ISO 32000)](https://www.iso.org/standard/51502.html)
- [Adobe PDF 参考文档](https://www.adobe.com/devnet/pdf/pdf_reference.html)
- [PyPDF2 文档](https://pypdf2.readthedocs.io/)



## 参考

- [PDF - Wikipedia](https://en.wikipedia.org/wiki/PDF)
- [PDF 文件格式详解](https://www.adobe.com/content/dam/acom/en/devnet/pdf/pdfs/PDF32000_2008.pdf)
