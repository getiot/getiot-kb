---
sidebar_position: 3
sidebar_label: CMake 库的可见性
slug: /cmake-visibility
authors: [luhuadong]
---

# CMake 库的可见性：PUBLIC / PRIVATE / INTERFACE

在使用 `target_include_directories()`、`target_compile_definitions()`、`target_link_libraries()` 等命令时，需要指定**可见性**：该属性是仅自己用、还是也传给“链接了自己的目标”。可见性有三种：**PRIVATE**、**PUBLIC**、**INTERFACE**。



## 三种可见性

| 可见性 | 含义 |
|--------|------|
| **PRIVATE** | 仅当前目标使用，不传递给链接了本目标的其他目标。 |
| **PUBLIC** | 当前目标使用，并且**会**传递给链接了本目标的其他目标（依赖本目标的目标也会得到这些包含目录/定义/链接库）。 |
| **INTERFACE** | 当前目标**自己不使用**，只传递给链接了本目标的其他目标（常用于“仅头文件库”或接口层）。 |

可以简单记：

- 只有“我用”：**PRIVATE**
- “我用，且用我的人也要用”：**PUBLIC**
- “只有用我的人用，我自己不用”：**INTERFACE**



## 示例

**库 mylib 的头文件目录：**

- 若 mylib 自己实现要包含 `include/`，且使用 mylib 的 app 也要包含该目录才能包含 mylib 的头文件，应写 **`PUBLIC`**：

  ```cmake showLineNumbers
  target_include_directories(mylib PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)
  ```

- 若某个目录只是 mylib 内部实现用，不想暴露给使用者，应写 **`PRIVATE`**：

  ```cmake showLineNumbers
  target_include_directories(mylib PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/impl)
  ```

**可执行文件链接库：**

- 可执行文件一般不需要把“自己链接了谁”再传出去（没有别人链接可执行文件），所以用 **`PRIVATE`** 即可：

  ```cmake showLineNumbers
  target_link_libraries(myapp PRIVATE mylib)
  ```

**仅头文件库（header-only）：**

- 没有源文件，只有头文件，用 **`INTERFACE`** 提供包含目录和依赖：

  ```cmake showLineNumbers
  add_library(mylib_headers INTERFACE)
  target_include_directories(mylib_headers INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}/include)
  target_link_libraries(myapp PRIVATE mylib_headers)
  ```



## 小结

- **PRIVATE**：仅本目标；**PUBLIC**：本目标 + 依赖者；**INTERFACE**：仅依赖者。
- 库的对外头文件目录、需要暴露的编译定义/链接库用 **PUBLIC**；内部实现用 **PRIVATE**；纯接口/仅头文件库用 **INTERFACE**。
