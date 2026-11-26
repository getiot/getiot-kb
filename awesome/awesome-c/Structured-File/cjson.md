---
sidebar_position: 1
slug: /cjson
---

# cJSON 使用教程



**cJSON** 是一个使用 C 语言编写的 JSON 解析器，具有超轻便、可移植、单文件等特点，遵循 MIT 开源许可协议。



## 快速上手

下面通过一个简单示例，带大家快速上手 cJSON 库。

使用的时候，只需要将这两个文件复制到工程目录，然后包含头文件 `cJSON.h` 即可，如下：

```c
#include "cJSON.h"
```



### 解析

首先是一个简单的键值对字符串，要解析的目标如下：

```json
{"firstName": "Rudy"}
```

对于这个简单的例子，只需要调用cJSON的三个接口函数就可以实现解析了，这三个函数的原型如下：

```c
cJSON *cJSON_Parse(const char *value);
cJSON *cJSON_GetObjectItem(cJSON *object, const char *string);
void cJSON_Delete(cJSON *c); 
```



## 设计思想

cJSON 对象的实现采用了树形结构，每个对象是树的一个节点，每个节点由 cJSON 这个结构体组成，对象中的元素也由 cJSON 这个结构体组成。同一层的对象和元素是双向链表结构，由 next 和 prev 指针链接。不同层的对象或元素由 child 指针链接起来。type 表示对象或元素类型，string 表示对象或节点的名称。元素的值存储在 valuestring、valueint 和 valuedouble 中，cJSON.h 中有详细的注释。

为什么选择使用 cJSON 来构造和解析 JSON 字符串？因为它具有超轻便，可移植，单文件的特点，使用 MIT 开源协议。其中主要包括两个文件 cjson.c 和 cjson.h。

- **cjson.h** 文件中包含了对于 JSON 格式的结构体定义以及一些操作 JSON 格式的功能函数，包括创建 JSON、向 JSON 格式中添加数字，字符，布尔值等等、读取 JSON 格式、将 JSON 格式转化为字符串等。
- **cjson.c** 文件中就是功能函数的具体实现。



### cJSON 结构体

```c
typedef struct cJSON
{
    /* next/prev allow you to walk array/object chains. Alternatively, use GetArraySize/GetArrayItem/GetObjectItem */
    struct cJSON *next;
    struct cJSON *prev;
    /* An array or object item will have a child pointer pointing to a chain of the items in the array/object. */
    struct cJSON *child;

    /* The type of the item, as above. */
    int type;

    /* The item's string, if type==cJSON_String  and type == cJSON_Raw */
    char *valuestring;
    /* writing to valueint is DEPRECATED, use cJSON_SetNumberValue instead */
    int valueint;
    /* The item's number, if type==cJSON_Number */
    double valuedouble;

    /* The item's name string, if this item is the child of, or is in the list of subitems of an object. */
    char *string;
} cJSON;
```



## 相关链接

- [cJSON 代码仓库](https://github.com/DaveGamble/cJSON)



<!--

## 参考

- [C语言：cJSON库用法详解](https://bbs.huaweicloud.com/blogs/detail/226805)
- [cJSON使用詳細教程 | 一個輕量級C語言JSON解析器](https://www.gushiciku.cn/pl/g8LE/zh-tw)
- [cJSON使用详细教程 | 一个轻量级C语言JSON解析器](https://blog.csdn.net/Mculover666/article/details/103796256)



-->
