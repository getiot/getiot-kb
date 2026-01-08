---
sidebar_position: 2
sidebar_label: XML 格式
slug: /xml
---

# XML 文件格式

**XML**（Extensible Markup Language，可扩展标记语言）是一种通用且广泛使用的文件格式，用于以结构化且人类可读的方式存储和传输数据。XML 于 1998 年由万维网联盟（W3C）首次推荐，已成为系统和应用程序之间数据交换的基石。

XML 基于 SGML 简化而来，通过**自定义标签**和属性定义数据层级（如 `<user><name>Rudy</name></user>`），支持 DTD/XSD 模式验证和 XSLT 转换。虽因冗余语法（需闭合标签）导致体积较大，但仍是 SOAP 协议、Android 布局文件和 RSS 订阅的标准格式。



## XML 主要特点

- **人类和机器可读**：XML 文档是基于文本的，既便于人类阅读和理解，也便于机器解析。
- **自描述性**：XML 中的标签为所包含的数据提供上下文，使结构本身具有自解释性。
- **跨平台与语言独立**：XML 可跨不同平台和编程语言使用，无需修改。
- **可扩展性**：XML 没有预定义的标签，用户可以根据具体需求定义自定义标签。
- **支持 Unicode**：XML 支持广泛的字符集，适用于全球化应用。



## XML 文档结构

XML 文档遵循分层结构，包括以下组成部分：

1. **序言（Prolog）**：包含有关 XML 文件的元数据，包括 XML 声明和可选的注释或处理指令。例如：

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   ```

2. **根元素**：XML 文档的起点，包含所有其他元素。每个 XML 文件必须且只能有一个根元素。

3. **元素**：用标签表示的数据。元素可以嵌套，并可能包含属性。例如：

   ```xml
   <book id="123">
       <title>人人都懂物联网</title>
       <author>阿基米东</author>
   </book>
   ```

4. **属性**：以键值对的形式为元素提供额外的元数据。

5. **注释**：允许在文档中添加人类可读的备注，使用 `<!-- -->` 包裹。例如：

   ```xml
   <!-- 这是一个注释 -->
   ```



## XML 的优势

- **互操作性**：XML 被广泛接受并受到多种工具的支持，是异构系统之间数据交换的理想选择。
- **可定制性**：用户可以定义自己的模式，确保 XML 能适应多样化的应用需求。
- **验证功能**：XML 支持通过 DTD（文档类型定义）或 XSD（XML 架构定义）进行验证，确保数据完整性。
- **内容与表现分离**：XML 将数据存储与显示方式分开，可通过 XSLT（可扩展样式表转换语言）实现灵活的展示风格。



## 使用场景

### 适用场景

- **网页开发**：XML 用于 SOAP 等网络服务，以及 RSS 和 Atom 等数据源
- **配置文件**：许多软件应用使用 XML 存储配置信息（如 Android 布局文件、Maven 配置等）
- **数据交换**：XML 是系统之间数据交换的标准格式，特别是在企业环境中
- **文档存储**：XML 用于存储结构化文档，例如发票、简历和电子书（如 EPUB 格式）
- **Web 服务**：SOAP、RESTful API 的响应格式

### 优缺点

**优点：**

- 人类和机器都可读
- 自描述性，结构清晰
- 跨平台、跨语言支持
- 可扩展，支持自定义标签
- 支持验证（DTD/XSD）
- 支持转换（XSLT）

**缺点：**

- 语法冗余，文件体积较大
- 解析性能相对较低
- 学习曲线相对较陡
- 在某些场景下已被 JSON 替代



## 代码示例

### Python 解析 XML

```python showLineNumbers
import xml.etree.ElementTree as ET

# 解析 XML 文件
tree = ET.parse('data.xml')
root = tree.getroot()

# 遍历元素
for child in root:
    print(child.tag, child.text)

# 查找特定元素
for book in root.findall('book'):
    title = book.find('title').text
    author = book.find('author').text
    print(f"{title} by {author}")
```

### Python 创建 XML

```python showLineNumbers
import xml.etree.ElementTree as ET

# 创建根元素
root = ET.Element('books')

# 添加子元素
book1 = ET.SubElement(root, 'book', id='1')
ET.SubElement(book1, 'title').text = '人人都懂物联网'
ET.SubElement(book1, 'author').text = '阿基米东'

# 保存为文件
tree = ET.ElementTree(root)
tree.write('output.xml', encoding='utf-8', xml_declaration=True)
```

### JavaScript 解析 XML

```javascript showLineNumbers
// 使用 DOMParser
const parser = new DOMParser();
const xmlString = '<books><book><title>人人都懂物联网</title></book></books>';
const xmlDoc = parser.parseFromString(xmlString, 'text/xml');

// 获取元素
const books = xmlDoc.getElementsByTagName('book');
for (let book of books) {
    const title = book.getElementsByTagName('title')[0].textContent;
    console.log(title);
}
```



## 相关工具

- **编辑器**：
  - XMLSpy：专业 XML 编辑器
  - Notepad++：支持 XML 语法高亮
  - VS Code：支持 XML 验证和格式化
- **验证工具**：
  - XML Validator：在线验证工具
  - xmllint：命令行验证工具
- **转换工具**：
  - XSLT 处理器：Saxon、Xalan
- **编程库**：
  - Python: `xml.etree.ElementTree`（标准库）、`lxml`
  - Java: `javax.xml`、`DOM4J`
  - JavaScript: `DOMParser`、`xml2js`



## 相关链接

- [XML 标准 (W3C)](https://www.w3.org/XML/)
- [XML 教程 (W3Schools)](https://www.w3schools.com/xml/)
- [XPath 教程](https://www.w3schools.com/xml/xpath_intro.asp)



## 参考

- [XML - Wikipedia](https://en.wikipedia.org/wiki/XML)
- [XML 1.0 规范](https://www.w3.org/TR/xml/)
