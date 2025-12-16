---
sidebar_position: 5
sidebar_label: xpack
slug: /xpack
---

# xpack 序列化/反序列化库

**xpack** 是一个轻量级的 C++ 序列化/反序列化库，支持将 JSON、XML 和 BSON 等格式的数据与 C++ 结构体进行高效映射（互相转换）。它基于模板和宏机制，简化了数据结构与文本格式之间的转换过程，适用于配置解析、网络通信、数据库交互等多种场景。

:::tip

- xpack 采用 Apache 2.0 开源许可协议，它的前身是 x2struct 库（已不再维护）。
- xpack 库由 C++ 编写，只有头文件，无需编译库文件，只需要添加相应的头文件即可使用。

:::



## 主要特点

- **多格式支持**：同时支持 JSON、XML 和 BSON 的序列化与反序列化，满足多样化的数据交换需求。
- **简洁的宏定义**：通过 `XPACK` 宏快速定义结构体与字段的映射关系，减少重复代码。
- **高性能**：内部使用 RapidJSON 和 RapidXML 等高效库，确保解析和生成速度。
- **灵活扩展**：支持自定义类型的序列化逻辑，满足复杂数据结构的处理需求。
- **开源许可**：遵循 Apache-2.0 许可证，适合商业和开源项目集成。



## 使用方法

#### 1. 安装

xpack 是一个头文件库，无需编译。只需将 [xpack](https://github.com/xyz347/xpack) 仓库中的源代码包含到项目中即可。

#### 2. 定义结构体

使用 `XPACK` 宏定义结构体与字段的映射关系：

```cpp showLineNumbers
#include "xpack/json.h"

struct User {
    int id;
    std::string name;
    XPACK(O(id, name));
};
```

#### 3. 序列化与反序列化

将结构体序列化为 JSON 字符串：

```cpp showLineNumbers
User user = {1, "Alice"};
std::string json_str = xpack::json::encode(user);
```

从 JSON 字符串反序列化为结构体：

```cpp showLineNumbers
User user;
xpack::json::decode(json_str, user);
```

类似地，xpack 也支持 XML 和 BSON 格式的编码与解码。

#### 4. 完整示例

```cpp showLineNumbers title="xpack_demo.cpp"
#include <iostream>
#include "xpack/json.h" // Json包含这个头文件，xml则包含xpack/xml.h

using namespace std;

struct User {
    int id;
    string  name;
    XPACK(O(id, name)); // 添加宏定义XPACK在结构体定义结尾
};

int main(int argc, char *argv[]) {
    User u;
    string data = "{\"id\":12345, \"name\":\"xpack\"}";

    xpack::json::decode(data, u);          // json转结构体
    cout<<u.id<<';'<<u.name<<endl;

    string json = xpack::json::encode(u);  // 结构体转json
    cout<<json<<endl;

    return 0;
}
```



## 常用 API

将对象编码为 JSON 字符串：

```cpp
xpack::json::encode(const T& obj)
```

从 JSON 字符串解码为对象：

```cpp
xpack::json::decode(const std::string& str, T& obj)
```

将对象编码为 XML 字符串：

```cpp
xpack::xml::encode(const T& obj)
```

从 XML 字符串解码为对象：

```cpp
xpack::xml::decode(const std::string& str, T& obj)
```

将对象编码为 BSON 数据：

```cpp
xpack::bson::encode(const T& obj)
```

从 BSON 数据解码为对象：

```cpp
xpack::bson::decode(const std::string& data, T& obj)
```



## 相关链接

- [xpack 代码仓库（Github）](https://github.com/xyz347/xpack)
