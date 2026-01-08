---
sidebar_position: 3
side_label: XLS 格式
slug: /xls
---

# XLS 和 XLSX 格式（Excel）

**XLS/XLSX** 是 Microsoft Excel 的工作簿格式。XLS 是早期的二进制 BIFF/OLE 复合文件（Excel 97-2003），XLSX 是 2007 年起的 Office Open XML（OOXML）基于 ZIP 的开放标准（ISO/IEC 29500）。另外，XLSM 是包含宏的 XLSX 格式，XLSB 是 Excel 二进制工作簿格式。

简单来说，XLS 兼容老旧系统，XLSX 体积更小、可扩展性更好，XLSM 支持宏功能，XLSB 加载速度更快。



## 格式简介

- **XLS**：二进制 BIFF 记录存储于 OLE 复合文档，扩展名 `.xls`，MIME `application/vnd.ms-excel`
- **XLSX**：OOXML 标准，基于 ZIP 打包 XML 与资源，扩展名 `.xlsx`，MIME `application/vnd.openxmlformats-officedocument.spreadsheetml.sheet`
- **XLSM**：包含宏的 XLSX 格式，扩展名 `.xlsm`，MIME `application/vnd.ms-excel.sheet.macroEnabled.12`
- **XLSB**：Excel 二进制工作簿格式，基于 BIFF12 二进制格式，扩展名 `.xlsb`，MIME `application/vnd.ms-excel.sheet.binary.macroEnabled.12`



## 技术特点

### XLS（BIFF/OLE）
- OLE 复合文档，包含多流（Workbook、SummaryInfo 等）
- BIFF 记录顺序存储单元格、格式、公式
- 兼容性好，结构封闭、扩展性弱

### XLSX（OOXML/ZIP）
- 基于 OPC（Open Packaging Convention），ZIP 打包 XML
- 清晰的部件：`xl/workbook.xml`、`xl/worksheets/*.xml`、`xl/sharedStrings.xml`、`xl/styles.xml`
- 体积更小，支持共享字符串、样式分离，易于解析与扩展

### XLSM（宏启用工作簿）
- 与 XLSX 结构相同，但包含 `xl/vbaProject.bin` 宏项目文件
- 支持 VBA 宏和 ActiveX 控件
- 安全考虑：打开时可能提示启用宏

### XLSB（二进制工作簿）
- 基于 BIFF12 二进制格式，而非 XML
- 使用 ZIP 打包二进制流文件（`.bin`）
- 加载和保存速度更快，文件体积通常更小
- 适合处理大量数据的工作簿



## 文件结构

### XLS（简化示例）
```bash showLineNumbers
[OLE Header]
├── Workbook          # BIFF 记录流（单元格/公式/格式）
├── SummaryInformation
└── DocumentSummaryInformation
```

### XLSX（简化示例）
```bash showLineNumbers
workbook.xlsx (ZIP)
├── [Content_Types].xml          # 内容类型
├── _rels/.rels                  # 包级关系
├── xl/workbook.xml              # 工作簿
├── xl/worksheets/sheet1.xml     # 工作表
├── xl/sharedStrings.xml         # 共享字符串
├── xl/styles.xml                # 样式与格式
└── xl/_rels/workbook.xml.rels   # 工作簿关系
```

### XLSM（简化示例）
```bash showLineNumbers
workbook.xlsm (ZIP)
├── [Content_Types].xml          # 内容类型（包含宏类型）
├── _rels/.rels
├── xl/workbook.xml              # 工作簿
├── xl/worksheets/sheet1.xml     # 工作表
├── xl/sharedStrings.xml
├── xl/styles.xml
├── xl/vbaProject.bin            # VBA 宏项目（关键区别）
└── xl/_rels/workbook.xml.rels
```

### XLSB（简化示例）
```bash showLineNumbers
workbook.xlsb (ZIP)
├── [Content_Types].xml          # 内容类型
├── _rels/.rels
├── xl/workbook.bin              # 工作簿（二进制）
├── xl/worksheets/sheet1.bin     # 工作表（二进制）
├── xl/sharedStrings.bin         # 共享字符串（二进制）
├── xl/styles.bin                # 样式（二进制）
└── xl/_rels/workbook.bin.rels
```



## 使用场景

### 适用场景
- **XLS**：兼容旧系统、历史数据归档
- **XLSX**：标准办公数据表、预算、报表、数据交换（BI 报表导出、数据导入）
- **XLSM**：包含 VBA 宏的自动化表单、模板、复杂业务逻辑
- **XLSB**：大型数据集、需要快速加载的工作簿、性能敏感场景

### 优缺点
**优点：**
- 广泛兼容，办公场景标准
- XLSX 体积小、易解析；XLS 兼容旧系统
- XLSM 支持 VBA 宏和自动化功能
- XLSB 加载和保存速度快，适合大文件
- 支持公式、样式、数据验证、图表

**缺点：**
- XLS 为专有二进制，扩展性差、易损坏
- XLSX 解压/解析相对开销
- XLSM 存在安全风险（宏病毒），需要谨慎处理
- XLSB 为二进制格式，不易直接解析和编辑
- 大文件加载速度慢，内存占用高



## 代码示例

### Python（pandas 读写）
```python showLineNumbers
import pandas as pd

# 读取
df = pd.read_excel("data.xlsx", sheet_name="Sheet1")

# 写入
df.to_excel("output.xlsx", sheet_name="Sheet1", index=False)
```

### Python（openpyxl 创建）
```python showLineNumbers
from openpyxl import Workbook

wb = Workbook()
ws = wb.active
ws.title = "Sheet1"
ws["A1"] = "Hello Excel"
wb.save("demo.xlsx")
```

### Python（读取 XLSM）
```python showLineNumbers
import pandas as pd

# 读取包含宏的 XLSM 文件（pandas 可以读取数据，但不执行宏）
df = pd.read_excel("workbook.xlsm", sheet_name="Sheet1", engine='openpyxl')
print(df)
```

### Python（读取 XLSB）
```python showLineNumbers
import pyxlsb

# 使用 pyxlsb 读取 XLSB 文件
with pyxlsb.open_workbook('workbook.xlsb') as wb:
    with wb.get_sheet(1) as sheet:
        for row in sheet.rows():
            print([item.v for item in row])
```

### Python（pandas 处理 XLSB）
```python showLineNumbers
import pandas as pd

# pandas 也支持 XLSB（需要 pyxlsb）
df = pd.read_excel("workbook.xlsb", sheet_name="Sheet1", engine='pyxlsb')
df.to_excel("output.xlsx", index=False)
```

### 命令行转换（LibreOffice）
```bash showLineNumbers
libreoffice --headless --convert-to xlsx input.xls
libreoffice --headless --convert-to csv  input.xlsx
```



## 相关工具
- **编辑器**：
  - Microsoft Excel：官方编辑器，支持所有格式
  - WPS 表格：国产办公软件，支持 XLS/XLSX/XLSM
  - LibreOffice Calc：开源电子表格，支持 XLS/XLSX（XLSM 宏支持有限）
- **转换/处理**：
  - `libreoffice-cli`：命令行转换工具
  - `xlsx2csv`：XLSX 转 CSV
  - `csvkit`：CSV 处理工具
- **编程库**：
  - Python: `pandas`（支持 XLS/XLSX/XLSM/XLSB）、`openpyxl`（XLSX/XLSM）、`xlrd/xlwt`（XLS）、`pyxlsb`（XLSB）
  - Java: `Apache POI`（支持所有格式）
  - JavaScript: `exceljs`、`xlsx`



## 相关链接
- [Office Open XML (ISO/IEC 29500)](https://www.iso.org/standard/71691.html)
- [Open Packaging Conventions](https://learn.microsoft.com/en-us/openspecs/office_standards/ms-opc/)
- [Excel 文件格式说明](https://learn.microsoft.com/en-us/openspecs/office_file_formats/)



## 参考
- [XLS - Wikipedia](https://en.wikipedia.org/wiki/Microsoft_Excel#File_formats)
- [BIFF 记录](https://learn.microsoft.com/en-us/openspecs/office_file_formats/ms-xlsb)
- [OOXML SpreadsheetML](https://en.wikipedia.org/wiki/Office_Open_XML)
- [Excel 文件格式对比](https://support.microsoft.com/en-us/office/file-formats-that-are-supported-in-excel-0943ff2c-6014-4d8d-aaca-b516d9a0464d)
- [XLSB 格式说明](https://learn.microsoft.com/en-us/openspecs/office_file_formats/ms-xlsb)
