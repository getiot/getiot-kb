---
sidebar_position: 8
draft: true
---

# Qt 数据类型



| Qt 数据类型 | 等效定义               | 字节数 |
| ----------- | ---------------------- | ------ |
| qint8       | signed char            | 1      |
| qint16      | signed short           | 2      |
| qint32      | signed int             | 4      |
| qint64      | signed long long int   | 8      |
| qlonglong   | signed long long int   | 8      |
| quint8      | unsigned char          | 1      |
| quint16     | unsigned short         | 2      |
| quint32     | unsigned int           | 4      |
| quint64     | unsigned long long int | 8      |
| qulonglong  | unsigned long long int | 8      |
| uchar       | unsigned char          | 1      |
| ushort      | unsigned short         | 2      |
| uint        | unsigned int           | 4      |
| ulong       | unsigned long          | 8      |
| qreal       | double                 | 8      |
| qfloat16    |                        | 2      |

注：

- qreal 缺省是 8 字节 double 类型浮点数，如果 Qt 使用 `-qreal float` 选项进行配置，就是 4 字节 float 类型的浮点数。
- qfloat16 是 Qt 5.9.0 中新增的一个类，用于表示 16 位浮点数，要使用 qfloat16，需要包含头文件 `<QFloat16>`。



