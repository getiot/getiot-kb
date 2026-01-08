---
sidebar_position: 3
sidebar_label: INI 格式
slug: /ini
---

# INI 文件格式

**INI**（Initialization File，初始化文件）格式起源于 1980 年代的 MS-DOS 和 Windows 系统，由微软引入用于存储程序配置信息。其核心特点是**键值对结构**，使用方括号 `[section]` 划分配置块，仅支持字符串类型数据。语法简单无嵌套，适用于小型配置（如 `boot.ini`），但缺乏复杂数据类型和标准化解析库。



## 格式简介

INI 文件是一种简单的配置文件格式，广泛用于存储应用程序的配置信息。INI 格式最初由微软在 MS-DOS 和 Windows 系统中引入，由于其简单性和可读性，至今仍被许多应用程序使用。

INI 文件扩展名通常为 `.ini`，但也可以使用 `.cfg`、`.conf` 等扩展名。虽然 INI 格式没有官方标准，但大多数实现都遵循类似的语法规则。



## 技术特点

### 基本特性

- **键值对结构**：使用 `key=value` 格式存储配置
- **节（Section）**：使用 `[section]` 组织相关配置
- **注释支持**：使用 `;` 或 `#` 表示注释
- **简单易读**：纯文本格式，人类可读
- **无嵌套**：不支持复杂的嵌套结构

### 语法规则

- **节名**：用方括号 `[]` 包围，如 `[section]`
- **键值对**：`key=value` 格式，等号两边可以有空格
- **注释**：以 `;` 或 `#` 开头的行被视为注释
- **空行**：空行被忽略
- **大小写**：通常大小写敏感（取决于实现）



## 文件结构

INI 文件的基本结构：

```ini showLineNumbers
; 这是注释
# 这也是注释

[section1]
key1=value1
key2=value2

[section2]
key3=value3
key4=value with spaces

[section3]
; 节内的注释
key5=value5
key6=value6
```

### 示例

**Windows boot.ini 示例：**

```ini showLineNumbers
[boot loader]
timeout=30
default=multi(0)disk(0)rdisk(0)partition(1)\WINDOWS

[operating systems]
multi(0)disk(0)rdisk(0)partition(1)\WINDOWS="Microsoft Windows XP Professional" /fastdetect
```

**应用程序配置示例：**

```ini showLineNumbers
[database]
host=localhost
port=3306
username=admin
password=secret123

[application]
name=MyApp
version=1.0.0
debug=true
```



## 使用场景

### 适用场景

- **应用程序配置**：桌面应用程序的配置文件
- **系统配置**：操作系统和系统服务的配置
- **游戏配置**：游戏设置和参数
- **简单配置**：不需要复杂结构的配置需求

### 优缺点

**优点：**

- 语法简单，易于理解和编辑
- 人类可读，无需特殊工具
- 文件体积小
- 广泛支持，几乎所有编程语言都有解析库

**缺点：**

- 缺乏数据类型定义（所有值都是字符串）
- 不支持嵌套结构
- 没有官方标准，不同实现可能有差异
- 不适合存储复杂配置
- 安全性较差（明文存储）



## 代码示例

### Python 解析 INI

```python showLineNumbers
import configparser

# 创建配置解析器
config = configparser.ConfigParser()

# 读取 INI 文件
config.read('config.ini')

# 读取配置值
database_host = config.get('database', 'host')
database_port = config.getint('database', 'port')
debug = config.getboolean('application', 'debug')

print(f"Database: {database_host}:{database_port}")
print(f"Debug mode: {debug}")
```

### Python 写入 INI

```python showLineNumbers
import configparser

config = configparser.ConfigParser()

# 添加节和配置
config['database'] = {
    'host': 'localhost',
    'port': '3306',
    'username': 'admin'
}

config['application'] = {
    'name': 'MyApp',
    'version': '1.0.0',
    'debug': 'true'
}

# 写入文件
with open('config.ini', 'w') as f:
    config.write(f)
```

### JavaScript 解析 INI

```javascript showLineNumbers
// 简单的 INI 解析器
function parseINI(content) {
    const result = {};
    let currentSection = null;
    
    const lines = content.split('\n');
    
    for (let line of lines) {
        line = line.trim();
        
        // 跳过空行和注释
        if (!line || line.startsWith(';') || line.startsWith('#')) {
            continue;
        }
        
        // 处理节
        if (line.startsWith('[') && line.endsWith(']')) {
            currentSection = line.slice(1, -1);
            result[currentSection] = {};
            continue;
        }
        
        // 处理键值对
        const [key, ...valueParts] = line.split('=');
        if (key && valueParts.length > 0) {
            const value = valueParts.join('=').trim();
            if (currentSection) {
                result[currentSection][key.trim()] = value;
            } else {
                result[key.trim()] = value;
            }
        }
    }
    
    return result;
}
```



## 相关工具

- **文本编辑器**：任何文本编辑器都可以编辑 INI 文件
- **编程库**：
  - Python: `configparser`（标准库）
  - Java: `java.util.Properties`、`ini4j`
  - C#: `System.Configuration`
  - JavaScript: `ini`（npm 包）
  - Go: `gopkg.in/ini.v1`



## 相关链接

- [INI 文件格式 - Wikipedia](https://en.wikipedia.org/wiki/INI_file)
- [Python configparser 文档](https://docs.python.org/3/library/configparser.html)



## 参考

- [INI 文件格式说明](https://en.wikipedia.org/wiki/INI_file)
- [TOML 格式](https://toml.io/)（INI 的现代替代方案）
