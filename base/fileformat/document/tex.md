---
sidebar_position: 9
sidebar_label: TEX 格式
slug: /tex
---

# TEX 格式（LaTeX）

**TEX**（TeX 排版系统）由 [Donald Knuth](https://en.wikipedia.org/wiki/Donald_Knuth) 教授 1978 年开发，专注于科技文献精密排版。通过命令式语法（如 `\section{}`）定义复杂数学公式和交叉引用，生成 DVI 或 PDF 输出。需配合 LaTeX 宏包使用，学术论文排版的事实标准，但学习曲线陡峭。



## 格式简介

TeX 是一个功能强大的排版系统，特别适合处理复杂的数学公式和科技文献。TeX 由计算机科学家 Donald Knuth 开发，旨在创建高质量的排版输出。LaTeX 是建立在 TeX 基础上的宏包集合，提供了更高级的文档结构和命令，是目前最常用的 TeX 变体。

TeX/LaTeX 文件扩展名通常为 `.tex`，编译后可以生成 DVI、PDF 或 PostScript 格式的输出文件。



## 技术特点

### 核心特性

- **精确排版**：对排版细节有完全控制
- **数学公式**：强大的数学公式排版能力
- **交叉引用**：自动处理章节、图表、公式的编号和引用
- **书目管理**：强大的参考文献管理功能
- **分离内容与格式**：专注于内容，格式由样式文件控制

### TeX 与 LaTeX

- **TeX**：底层排版引擎，提供基础命令
- **LaTeX**：建立在 TeX 上的宏包，提供高级文档结构
- **XeTeX/LuaTeX**：支持 Unicode 和现代字体的 TeX 引擎



## 文件结构

LaTeX 文档的基本结构：

```latex showLineNumbers
\documentclass{article}        % 文档类
\usepackage{amsmath}           % 宏包

\begin{document}               % 文档开始

\title{文档标题}
\author{作者}
\date{\today}
\maketitle

\section{章节标题}

这是文档内容。

数学公式：$E = mc^2$

\begin{equation}
\int_0^\infty e^{-x^2} dx = \frac{\sqrt{\pi}}{2}
\end{equation}

\end{document}                 % 文档结束
```

### 主要元素

- **文档类**：`\documentclass{}` 定义文档类型（article、book、report 等）
- **宏包**：`\usepackage{}` 加载功能扩展
- **环境**：`\begin{}...\end{}` 定义特定格式区域
- **命令**：以反斜杠开头的命令（如 `\section{}`、`\textbf{}`）



## 使用场景

### 适用场景

- **学术论文**：期刊论文、学位论文
- **科技书籍**：数学、物理、计算机科学等专业书籍
- **技术报告**：需要精确排版的技术文档
- **演示文稿**：使用 Beamer 类制作幻灯片
- **简历**：使用专业模板制作简历

### 优缺点

**优点：**

- 排版质量极高，专业级输出
- 强大的数学公式支持
- 自动处理编号、引用、目录等
- 内容与格式分离，易于维护
- 开源免费，跨平台

**缺点：**

- 学习曲线陡峭
- 编译过程相对复杂
- 实时预览不如所见即所得编辑器
- 调试错误需要一定经验



## 代码示例

### 基本 LaTeX 文档

```latex showLineNumbers
\documentclass[12pt,a4paper]{article}
\usepackage[utf8]{inputenc}
\usepackage{amsmath}
\usepackage{graphicx}

\title{LaTeX 示例文档}
\author{作者姓名}
\date{\today}

\begin{document}

\maketitle

\section{引言}

这是文档的第一部分。

\subsection{子章节}

这是子章节内容。

\section{数学公式}

行内公式：$f(x) = x^2 + 2x + 1$

独立公式：
\begin{equation}
\int_{-\infty}^{\infty} e^{-x^2} dx = \sqrt{\pi}
\end{equation}

\end{document}
```

### Python 生成 LaTeX

```python showLineNumbers
def generate_latex_document(title, content):
    latex_template = f"""
\\documentclass{{article}}
\\usepackage[utf8]{{inputenc}}

\\title{{{title}}}
\\author{{Auto Generated}}
\\date{{\\today}}

\\begin{{document}}

\\maketitle

{content}

\\end{{document}}
"""
    return latex_template

# 使用示例
doc = generate_latex_document("示例文档", "这是文档内容。")
with open('output.tex', 'w', encoding='utf-8') as f:
    f.write(doc)
```



## 相关工具

- **编辑器**：
  - TeXstudio：功能丰富的 LaTeX 编辑器
  - Overleaf：在线 LaTeX 编辑器
  - VS Code：配合 LaTeX Workshop 扩展
- **编译工具**：
  - pdfTeX：生成 PDF
  - XeTeX：支持 Unicode 和现代字体
  - LuaTeX：支持 Lua 脚本
- **宏包管理器**：
  - TeX Live：完整的 TeX 发行版
  - MiKTeX：Windows 上的 TeX 发行版
- **在线服务**：
  - Overleaf：在线 LaTeX 编辑器
  - ShareLaTeX：在线协作平台



## 相关链接

- [LaTeX 官方网站](https://www.latex-project.org/)
- [Overleaf 学习资源](https://www.overleaf.com/learn)
- [CTAN（宏包仓库）](https://www.ctan.org/)



## 参考

- [TeX - Wikipedia](https://en.wikipedia.org/wiki/TeX)
- [LaTeX - Wikipedia](https://en.wikipedia.org/wiki/LaTeX)
- [LaTeX 入门](https://www.latex-tutorial.com/)
