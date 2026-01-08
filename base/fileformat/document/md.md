---
sidebar_position: 8
sidebar_label: MD 格式
slug: /md
---

# MD 格式（Markdown）

**MD**（Markdown，标记式轻量文本）由 [John Gruber](https://en.wikipedia.org/wiki/John_Gruber) 和 [Aaron Swartz](https://en.wikipedia.org/wiki/Aaron_Swartz) 于 2004 年设计，旨在通过易读易写的纯文本格式生成 HTML。采用 `#`、`*` 等符号标记标题、列表等基础排版元素，支持扩展语法（如表格、数学公式）。因其低学习成本和跨平台特性，成为 GitHub 文档、技术博客和笔记工具（如 Obsidian）的标配格式。



## 格式简介

Markdown 是一种轻量级标记语言，使用易读易写的纯文本格式编写文档，然后转换成有效的 HTML 或其他格式。Markdown 的设计目标是让文档更容易阅读和编写，同时保持可读性。

Markdown 文件扩展名通常为 `.md` 或 `.markdown`，MIME 类型为 `text/markdown`。Markdown 已成为技术文档、博客、README 文件等的标准格式。



## 技术特点

### 基本语法

- **标题**：使用 `#` 表示不同级别的标题
- **强调**：`*斜体*` 或 `**粗体**`
- **列表**：有序列表（数字）和无序列表（`-` 或 `*`）
- **链接**：`[文本](URL)`
- **代码**：行内代码用反引号，代码块用三个反引号
- **引用**：使用 `>` 表示引用块

### Markdown 变体

- **CommonMark**：标准化的 Markdown 规范
- **GitHub Flavored Markdown (GFM)**：GitHub 扩展版本
- **Markdown Extra**：PHP Markdown 的扩展版本
- **Pandoc Markdown**：Pandoc 支持的扩展版本



## 文件结构

Markdown 文件是纯文本文件，使用简单的标记语法：

```markdown showLineNumbers
# 一级标题

## 二级标题

这是普通段落文本。

- 无序列表项 1
- 无序列表项 2

1. 有序列表项 1
2. 有序列表项 2

**粗体文本** 和 *斜体文本*

[链接文本](https://example.com)

```代码块```
```



## 使用场景

### 适用场景

- **技术文档**：API 文档、开发文档
- **README 文件**：项目说明文件
- **博客文章**：静态网站生成器的内容格式
- **笔记应用**：Obsidian、Notion、Typora 等
- **代码注释**：代码中的文档字符串
- **邮件**：某些邮件客户端支持 Markdown

### 优缺点

**优点：**

- 语法简单，学习成本低
- 人类可读，即使不渲染也易于理解
- 纯文本格式，易于版本控制
- 可以转换为多种格式（HTML、PDF、DOCX 等）
- 广泛支持，大量工具和平台支持

**缺点：**

- 标准不统一，不同实现有差异
- 复杂表格和数学公式需要扩展语法
- 某些高级格式支持有限
- 渲染结果可能因工具而异



## 代码示例

### Python 解析 Markdown

```python showLineNumbers
import markdown

# 将 Markdown 转换为 HTML
md_text = """
# 标题

这是 **粗体** 文本。
"""

html = markdown.markdown(md_text)
print(html)
```

### Python 使用扩展语法

```python showLineNumbers
import markdown

md = markdown.Markdown(extensions=['tables', 'fenced_code', 'toc'])

text = """
# 文档标题

| 列1 | 列2 |
|-----|-----|
| 数据1 | 数据2 |

\```python
print("Hello, Markdown!")
\```
"""

html = md.convert(text)
print(html)
```

### JavaScript 解析 Markdown

```javascript showLineNumbers
// 使用 marked 库
const marked = require('marked');

const markdown = `
# 标题

这是 **Markdown** 内容。
`;

const html = marked.parse(markdown);
console.log(html);
```



## 相关工具

- **编辑器**：
  - Typora：所见即所得编辑器
  - Mark Text：开源 Markdown 编辑器
  - VS Code：代码编辑器，支持 Markdown 预览
- **转换工具**：
  - Pandoc：通用文档转换工具
  - Marked：JavaScript Markdown 解析器
- **静态网站生成器**：
  - Jekyll、Hugo、Hexo、Docusaurus
- **编程库**：
  - Python: `markdown`、`mistune`、`markdown2`
  - JavaScript: `marked`、`markdown-it`、`remark`
  - Go: `blackfriday`、`goldmark`



## 相关链接

- [Markdown 官方网站](https://daringfireball.net/projects/markdown/)
- [CommonMark 规范](https://commonmark.org/)
- [GitHub Flavored Markdown](https://github.github.com/gfm/)



## 参考

- [Markdown - Wikipedia](https://en.wikipedia.org/wiki/Markdown)
- [Markdown 语法指南](https://www.markdownguide.org/)
