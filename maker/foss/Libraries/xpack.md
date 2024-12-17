---
sidebar_position: 2
slug: /xpack
---

# xpack 库



**xpack** 是一个用于在 C++ 结构体和 JSON、XML 数据格式之间互相转换的库，采用 Apache 2.0 开源许可协议。该项目的前身是 x2struct 库（已不再维护）。

xpack 库由 C++ 编写，只有头文件，无需编译库文件，只需要添加相应的头文件即可使用。

- Github 仓库：[https://github.com/xyz347/xpack](https://github.com/xyz347/xpack)

使用示例：

```cpp
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

