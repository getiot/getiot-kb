---
sidebar_position: 6
sidebar_label: RTF 格式
slug: /rtf
---

# RTF 格式（富文本）

**RTF**（Rich Text Format，富文本格式）格式由微软于 1987 年推出，用于跨文字处理软件交换格式化文本。使用 ANSI 控制码和 `{\}` 标记定义字体、颜色等属性，兼容性强但文件结构复杂冗余。曾是 Windows 系统剪贴板标准格式，现逐渐被 HTML/DOCX 取代。



## 格式简介

RTF 是一种跨平台的文档格式，用于在不同文字处理软件之间交换格式化文本。RTF 文件是纯文本文件，但包含格式控制代码，可以表示字体、颜色、段落格式、表格等丰富的格式信息。

RTF 格式由微软开发，但被广泛采用，许多文字处理软件都支持 RTF 格式。文件扩展名通常为 `.rtf`，MIME 类型为 `application/rtf` 或 `text/rtf`。



## 技术特点

### 基本特性

- **纯文本格式**：虽然包含格式信息，但本质上是文本文件
- **跨平台兼容**：可在不同操作系统和软件间交换
- **格式丰富**：支持字体、颜色、段落、表格、图片等
- **可读性**：虽然复杂，但人类仍可阅读和理解

### RTF 版本

- **RTF 1.0**：1987 年发布，基础版本
- **RTF 1.2**：1990 年，增加表格支持
- **RTF 1.3**：1992 年，增强功能
- **RTF 1.4**：1994 年，支持 Unicode
- **RTF 1.5**：1997 年，支持 HTML 标签
- **RTF 1.6**：1999 年，支持 XML
- **RTF 1.7**：2001 年，支持更多格式
- **RTF 1.8**：2004 年，最新版本



## 文件结构

RTF 文件的基本结构：

```rtf showLineNumbers
{\rtf1\ansi\deff0
{\fonttbl{\f0 Times New Roman;}}
{\colortbl;\red0\green0\blue0;}
\f0\fs24 这是 RTF 文档内容。
}
```

### 主要元素

- **文件头**：`{\rtf1` 标识 RTF 版本和字符集
- **字体表**：`{\fonttbl}` 定义可用字体
- **颜色表**：`{\colortbl}` 定义颜色
- **文档内容**：格式化的文本内容
- **控制字**：以反斜杠开头的命令（如 `\b` 表示粗体）



## 使用场景

### 适用场景

- **文档交换**：在不同文字处理软件间交换格式化文档
- **剪贴板格式**：Windows 系统剪贴板的标准格式之一
- **邮件附件**：某些邮件客户端使用 RTF 格式
- **简单格式化**：需要保留基本格式但不需要复杂功能的场景

### 优缺点

**优点：**

- 跨平台兼容性好
- 纯文本格式，易于程序处理
- 支持丰富的格式信息
- 文件相对较小

**缺点：**

- 语法复杂，难以手动编辑
- 文件结构冗余
- 逐渐被 HTML 和 DOCX 取代
- 某些高级功能支持有限



## 代码示例

### Python 读取 RTF

```python showLineNumbers
import striprtf

# 读取 RTF 文件
with open('document.rtf', 'r', encoding='utf-8') as file:
    rtf_content = file.read()
    
# 转换为纯文本
text = striprtf.striprtf(rtf_content)
print(text)
```

### Python 创建 RTF

```python showLineNumbers
def create_rtf(content, filename):
    rtf_header = r"{\rtf1\ansi\deff0"
    rtf_footer = r"}"
    
    with open(filename, 'w', encoding='utf-8') as f:
        f.write(rtf_header)
        f.write(content)
        f.write(rtf_footer)

# 使用示例
content = r"\b 粗体文本 \b0 普通文本"
create_rtf(content, 'output.rtf')
```



## 相关工具

- **Microsoft Word**：支持 RTF 格式
- **LibreOffice Writer**：支持 RTF 格式
- **文本编辑器**：大多数文本编辑器可以打开 RTF 文件
- **编程库**：
  - Python: `striprtf`、`pyth`（RTF 解析）
  - Java: `Apache POI`（部分支持）



## 相关链接

- [RTF 规范 (Microsoft)](https://www.microsoft.com/en-us/download/details.aspx?id=10725)
- [RTF 1.8 规范](https://www.biblioscape.com/rtf15_spec.htm)



## 参考

- [RTF - Wikipedia](https://en.wikipedia.org/wiki/Rich_Text_Format)
- [RTF 格式说明](https://www.microsoft.com/en-us/download/details.aspx?id=10725)
