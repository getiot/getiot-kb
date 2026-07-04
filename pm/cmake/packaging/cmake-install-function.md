---
sidebar_position: 1
slug: /cmake-install-function
authors: [luhuadong]
---

# CMake INSTALL 指令

使用 CMake 构建项目时，最常见的几个步骤是：

```bash
mkdir build && cd build
cmake ..
cmake --build .
cmake --install .   # 或 make install
```

执行 `cmake --install`（或 `make install`）时，会执行你在 CMakeLists.txt 里通过 **install()** 命令定义的安装规则。不需要单独定义一个“install 目标”，只要写好 install 命令即可。



## install 命令概览

install 用于指定**安装时**要执行的动作，可安装目标文件（可执行文件、库）、普通文件、目录、脚本等：

```cmake showLineNumbers
install(TARGETS <target>... [...])
install(FILES <file>... [...])
install(PROGRAMS <file>... [...])
install(DIRECTORY <dir>... [...])
install(SCRIPT <file> [...])
install(CODE <code> [...])
install(EXPORT <export-name> [...])
```

常用变量 **CMAKE_INSTALL_PREFIX** 指定安装路径的前缀，例如：

```bash
cmake -DCMAKE_INSTALL_PREFIX=/usr ..
```

则安装目标会落在 `/usr/bin`、`/usr/lib` 等下面（具体由各 install 的 DESTINATION 决定）。



## 目标文件的安装

```cmake showLineNumbers
install(TARGETS targets... [EXPORT <export-name>]
        [[ARCHIVE|LIBRARY|RUNTIME|OBJECTS|FRAMEWORK|BUNDLE|
          PRIVATE_HEADER|PUBLIC_HEADER|RESOURCE]
         [DESTINATION <dir>]
         [PERMISSIONS permissions...]
         [CONFIGURATIONS [Debug|Release|...]]
         [COMPONENT <component>]
         [OPTIONAL] [EXCLUDE_FROM_ALL]
        ] [...]
        [INCLUDES DESTINATION [<dir> ...]]
)
```

常见目标类型与默认安装目录：

| 类型 | 含义 | 常用目录变量 | 默认目录 |
|:----:|:----:|:------------:|:--------:|
| `ARCHIVE` | 静态库 | `${CMAKE_INSTALL_LIBDIR}` | lib |
| `LIBRARY` | 动态库 | `${CMAKE_INSTALL_LIBDIR}` | lib |
| `RUNTIME` | 可执行文件 | `${CMAKE_INSTALL_BINDIR}` | bin |
| `PUBLIC_HEADER` | 库的公开头文件 | `${CMAKE_INSTALL_INCLUDEDIR}` | include |

示例：

```cmake showLineNumbers
install(TARGETS myrun mylib mystaticlib
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
)
```

- **`DESTINATION`**：安装到的目录（相对 `CMAKE_INSTALL_PREFIX` 或绝对路径）。
- **`PERMISSIONS`**：文件权限，如 `OWNER_READ`、`OWNER_WRITE`、`OWNER_EXECUTE` 等。
- **`CONFIGURATIONS`**：仅对指定构建类型（Debug/Release 等）生效；若写 `CONFIGURATIONS`，则 `DESTINATION` 等要写在 `CONFIGURATIONS` 后面。
- **`EXCLUDE_FROM_ALL`**：不参与默认安装，仅组件安装时安装。
- **`OPTIONAL`**：要安装的文件不存在时不报错。

按配置分别指定安装路径示例：

```cmake showLineNumbers
install(TARGETS myapp CONFIGURATIONS Debug  RUNTIME DESTINATION bin/debug)
install(TARGETS myapp CONFIGURATIONS Release RUNTIME DESTINATION bin/release)
```



## 普通文件与程序的安装

```cmake showLineNumbers
install(FILES files... DESTINATION <dir> [OPTIONAL] [...])
install(PROGRAMS files... DESTINATION <dir> [OPTIONAL] [...])
```

- **`FILES`**：普通文件（如配置文件、文档），相对路径相对于当前源码目录。
- **`PROGRAMS`**：脚本等可执行文件，安装后会自动加可执行权限（若未指定 PERMISSIONS，默认 755）。
- 也可使用 **`TYPE`** 使用预定义类型（BIN、LIB、INCLUDE、DOC 等），会有对应默认路径。



## 目录的安装

```cmake showLineNumbers
install(DIRECTORY dirs... DESTINATION <dir>
        [FILE_PERMISSIONS ...] [DIRECTORY_PERMISSIONS ...]
        [USE_SOURCE_PERMISSIONS] [OPTIONAL]
        [CONFIGURATIONS ...] [COMPONENT <component>] [EXCLUDE_FROM_ALL]
        [FILES_MATCHING] [[PATTERN <pattern>|REGEX <regex>] [EXCLUDE] [PERMISSIONS ...]] [...]
)
```

- 若写 **dir**（不以 `/` 结尾），则整个目录会作为子目录安装到 DESTINATION 下。
- 若写 **dir/**（以 `/` 结尾），则只安装该目录内容到 DESTINATION，不创建 dir 这一层。
- **`PATTERN` / `REGEX`**：可配合 EXCLUDE 排除，或 PERMISSIONS 为匹配文件设权限。

示例：安装 icons 目录和 scripts 目录内容，排除 CVS，并为 scripts 下文件设权限：

```cmake showLineNumbers
install(DIRECTORY icons scripts/ DESTINATION share/myproj
        PATTERN "CVS" EXCLUDE
        PATTERN "scripts/*" PERMISSIONS OWNER_EXECUTE OWNER_READ OWNER_WRITE GROUP_READ GROUP_EXECUTE
)
```



## 安装时执行脚本或代码

```cmake showLineNumbers
install(SCRIPT <file> [...])   # 执行 .cmake 脚本
install(CODE "..." [...])      # 执行一段 CMake 代码
```

示例：

```cmake showLineNumbers
install(CODE "message(\"Installing myapp...\")")
```

会在执行 install 时打印该消息。



## 小结

- 使用 **`install(TARGETS ...)`** 安装可执行文件、库；用 **`RUNTIME/LIBRARY/ARCHIVE`** 等指定类型和 **`DESTINATION`**。
- 使用 **`install(FILES/PROGRAMS ...)`**、**`install(DIRECTORY ...)`** 安装文件和目录。
- **`CMAKE_INSTALL_PREFIX`** 指定安装前缀；推荐 `DESTINATION` 使用 `${CMAKE_INSTALL_BINDIR}` 等变量以符合 FHS（Filesystem Hierarchy Standard，文件系统层次化标准）。
