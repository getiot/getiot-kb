---
sidebar_position: 2
sidebar_label: MOBI 格式
slug: /mobi
---

# MOBI 格式（Kindle 原生）

**MOBI**（Mobipocket）格式由法国 Mobipocket 公司 2000 年开发，2005 年被 Amazon 收购后成为 Kindle 设备的原生格式。基于 Palm Database 格式，采用压缩 HTML 和专有 DRM 保护，支持书签、注释和字典查找。虽然 Amazon 已转向 AZW3 格式，但 MOBI 仍被广泛用于 Kindle 设备兼容。



## 格式简介

MOBI 是一种专为电子阅读器设计的电子书格式，最初由 Mobipocket 公司开发。2005 年，Amazon 收购了 Mobipocket，并将 MOBI 格式作为 Kindle 设备的主要格式。虽然 Amazon 后来推出了 AZW3 格式，但 MOBI 格式仍然被广泛使用，特别是在较旧的 Kindle 设备上。

MOBI 文件扩展名为 `.mobi`，MIME 类型为 `application/x-mobipocket-ebook`。MOBI 格式是专有格式，但可以通过工具进行转换。



## 技术特点

### 核心特性

- **压缩存储**：使用 Palm Database 格式压缩 HTML 内容
- **DRM 保护**：支持数字版权管理
- **优化显示**：针对小屏幕设备优化
- **快速加载**：压缩格式，加载速度快
- **离线阅读**：完全离线支持

### MOBI 版本

- **MOBI 6**：早期版本，基础功能
- **MOBI 7**：增强版本，改进压缩和功能
- **MOBI 8 (KF8)**：Kindle Format 8，接近 AZW3

### 内容格式

- **HTML**：文档内容（压缩存储）
- **图像**：JPEG、GIF、PNG（压缩）
- **元数据**：书名、作者、封面等信息



## 文件结构

MOBI 文件基于 Palm Database 格式，包含以下部分：

```bash showLineNumbers
[Palm Database 头]      # Palm 数据库文件头
[MOBI 头]              # MOBI 格式特定头信息
[EXTH 头]              # 扩展头（元数据）
[压缩的 HTML 内容]      # 实际的电子书内容（压缩）
[图像资源]              # 嵌入的图像文件
[索引]                 # 用于快速查找的索引
```

### 关键组件

- **Palm Database 头**：标识文件为 Palm 数据库格式
- **MOBI 头**：包含 MOBI 格式版本和特性
- **EXTH 头**：扩展元数据（作者、ISBN、封面等）
- **压缩内容**：使用 Palm 压缩算法压缩的 HTML



## 使用场景

### 适用场景

- **Kindle 设备**：Amazon Kindle 电子阅读器
- **Kindle 应用**：Kindle 移动应用和桌面应用
- **电子书分发**：通过 Amazon 平台分发的电子书
- **个人阅读**：个人电子书收藏

### 优缺点

**优点：**

- Kindle 设备原生支持
- 文件体积小（压缩格式）
- 加载速度快
- 支持 DRM 保护
- 离线阅读体验好

**缺点：**

- 专有格式，受 Amazon 控制
- 编辑和转换相对困难
- 某些高级功能支持有限
- 逐渐被 AZW3 替代
- 非 Kindle 设备支持有限



## 代码示例

### Python 读取 MOBI

```python showLineNumbers
from mobi import Mobi

# 读取 MOBI 文件
with open('book.mobi', 'rb') as f:
    mobi = Mobi(f)
    
    # 获取元数据
    print(f"标题: {mobi.title}")
    print(f"作者: {mobi.author}")
    
    # 读取内容
    content = mobi.get_content()
    print(content[:500])  # 打印前 500 个字符
```

### Python 使用 ebooklib 转换

```python showLineNumbers
import ebooklib
from ebooklib import epub
import subprocess

# 先转换为 EPUB（使用 Calibre）
# calibre 命令行工具需要单独安装
subprocess.run(['ebook-convert', 'book.mobi', 'book.epub'])

# 然后使用 ebooklib 处理 EPUB
book = epub.read_epub('book.epub')
# ... 处理 EPUB 内容
```

### 使用 Calibre 命令行转换

```bash showLineNumbers
# 安装 Calibre 后，使用命令行转换
ebook-convert book.mobi book.epub
ebook-convert book.mobi book.pdf
ebook-convert book.epub book.mobi
```



## 相关工具

- **阅读器**：
  - Amazon Kindle：官方阅读器和应用
  - Calibre：跨平台电子书管理工具
- **转换工具**：
  - Calibre：支持 MOBI 与其他格式互转
  - KindleGen：Amazon 官方转换工具
  - Online-Convert：在线转换工具
- **编辑工具**：
  - Calibre Editor：可以编辑 MOBI（需先转换）
  - MobiUnpack：解包 MOBI 文件
- **编程库**：
  - Python: `mobi`、`kindleunpack`
  - JavaScript: `mobi-js`



## 相关链接

- [Mobipocket 格式说明](https://wiki.mobileread.com/wiki/MOBI)
- [Calibre 官方网站](https://calibre-ebook.com/)
- [KindleGen 下载](https://www.amazon.com/gp/feature.html?docId=1000765211)



## 参考

- [MOBI - Wikipedia](https://en.wikipedia.org/wiki/Mobipocket)
- [MOBI 文件格式详解](https://wiki.mobileread.com/wiki/MOBI)
- [Kindle 格式说明](https://www.amazon.com/gp/feature.html?docId=1000234621)
