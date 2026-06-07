---
sidebar_label: xmllint 命令
sidebar_position: 24
slug: /xmllint
---

# Linux xmllint 命令 - 解析与校验 XML 文件



## 介绍

**xmllint** 是 libxml2 库提供的命令行 XML 工具，用于解析、格式化、校验 XML 和 HTML 文件。支持 DTD/XSD 验证、XPath 查询、XSLT 转换等，适合在脚本中检查配置文件格式或调试 XML 数据。

xmllint 命令由 libxml2-utils 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install libxml2-utils
```

**语法**：

```bash
xmllint [options] XMLfiles ...
```

**常用选项**：

- `--version`：显示 libxml2 版本
- `--noout`：不输出解析结果（仅用于校验）
- `--format`：格式化（美化）XML 输出
- `--recover`：尝试恢复并输出可解析的部分（用于损坏的 XML）
- `--valid`：根据 DTD 进行有效性验证
- `--dtdvalid URL`：根据指定 DTD 进行验证
- `--schema SCHEMA`：根据 XSD 模式进行验证
- `--xpath EXPRESSION`：执行 XPath 查询
- `--shell`：启动交互式导航 Shell
- `--html`：以 HTML 解析器处理输入
- `--encode ENCODING`：指定输出编码
- `--noent`：将实体引用替换为实际值
- `--nonet`：禁止通过网络获取 DTD 或实体
- `--nowarning`：不输出警告
- `--noblanks`：去除空白文本节点
- `--quiet`：成功时不输出任何信息
- `--timing`：显示解析耗时
- `--repeat N`：重复解析 N 次（用于性能测试）
- `--xinclude`：处理 XInclude

相关命令：[jq](/linux-command/jq/)、[grep](/linux-command/grep/)



## 示例

1、检查 XML 文件格式是否正确：

```bash
xmllint --noout config.xml
```

2、格式化（美化）XML 文件并输出到标准输出：

```bash
xmllint --format config.xml
```

3、格式化并覆盖原文件：

```bash
xmllint --format config.xml -o config.xml
```

4、根据 DTD 验证 XML 文件：

```bash
xmllint --noout --valid doc.xml
```

5、根据指定 XSD 模式验证：

```bash
xmllint --noout --schema schema.xsd doc.xml
```

6、使用 XPath 查询节点值：

```bash
xmllint --xpath "//title/text()" book.xml
```

7、禁止网络访问，离线验证 XML：

```bash
xmllint --noout --nonet config.xml
```

8、解析 HTML 文件：

```bash
xmllint --html --format page.html
```

9、静默校验，适合在脚本中判断格式：

```bash
if xmllint --noout --quiet config.xml 2>/dev/null; then
    echo "XML is valid"
else
    echo "XML is invalid"
fi
```

10、进入交互式 Shell 浏览 XML 结构：

```bash
xmllint --shell config.xml
# 在 shell 中可使用：cat（显示）、dir（列出子节点）、base（显示路径）等命令
```
