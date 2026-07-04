---
sidebar_position: 2
slug: /cmake-subdirectories
authors: [luhuadong]
---

# CMake 子目录管理

**add_subdirectory()** 用于把子目录纳入当前构建，子目录中的 CMakeLists.txt 会在此处被处理，其中定义的目标（可执行文件、库）可在父或兄弟目录中通过名称引用（如 target_link_libraries）。## 基本用法

```cmake showLineNumbers
add_subdirectory(source_dir [binary_dir] [EXCLUDE_FROM_ALL])
```

- **source_dir**：相对当前 CMakeLists.txt 的源码子目录（或绝对路径）。
- **binary_dir**：可选，该子目录对应的构建输出目录；不写时默认为 `build/source_dir`。
- **EXCLUDE_FROM_ALL**：该子目录中的目标默认不参与“全部构建”，需单独指定构建或作为其它目标的依赖才会被构建。

示例：

```cmake showLineNumbers
add_subdirectory(lib)                    # 构建输出在 build/lib
add_subdirectory(app bin_app)            # 构建输出在 build/bin_app
add_subdirectory(tests EXCLUDE_FROM_ALL) # 测试默认不随 all 构建
```

## 依赖顺序

子目录的添加顺序会影响“谁先被处理”。若 app 依赖 lib，应先 `add_subdirectory(lib)` 再 `add_subdirectory(app)`，这样 app 的 CMakeLists.txt 里才能 `target_link_libraries(app PRIVATE mylib)` 引用 lib 中定义的目标。

## 变量作用域

子目录中 `set()` 的普通变量不会自动传到父目录；若要在子目录中修改“父目录看到的变量”，需 `set(... PARENT_SCOPE)`。缓存变量（CACHE）和 target 则在全局可见，子目录定义的目标可在父目录链接。

## 小结

- 用 **add_subdirectory(子目录)** 纳入子目录，可选 **binary_dir**、**EXCLUDE_FROM_ALL**。
- 注意 add_subdirectory 顺序，保证被依赖的库先被添加。
- 子目录目标名在父/兄弟目录中可直接使用，用于 target_link_libraries 等。
