---
sidebar_position: 2
slug: /cmake-scene-how-to
authors: [luhuadong]
---

# CMake 情景速查

按常见需求快速查写法。

## 如何链接数学库（libm）

C 的 `sqrt` 等数学函数在 libm 中，需要显式链接。若只写：

```cmake showLineNumbers
add_executable(go_sqrt main.c)
```

可能得到：

```text
undefined reference to `sqrt'
```

在 **add_executable 之后** 添加：

```cmake showLineNumbers
target_link_libraries(go_sqrt PRIVATE m)
```

第一个参数为你的**目标名**，请按实际修改；`target_link_libraries` 必须写在对应 `add_executable` 之后。

示例项目可参考：[getiot/cmake-demo/link-math](https://github.com/getiot/cmake-demo/tree/main/link-math)。

## 小结

更多“如何做”可查阅 [CMake 最佳实践](/cmake/cmake-best-practices/) 和 [CMake 错误解决](/cmake/cmake-error-resolution/)；也可在官方文档中搜索对应命令或变量。
