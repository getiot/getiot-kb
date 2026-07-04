---
sidebar_position: 3
slug: /cmake-custom-commands
authors: [luhuadong]
---

# CMake 自定义命令

除了“编译源文件生成目标”，有时需要在构建过程中执行自定义命令，例如生成头文件、运行代码生成器、拷贝资源等。CMake 通过 **`add_custom_command()`** 和 **`add_custom_target()`** 实现。



## add_custom_command

用于为某个目标的构建附加一条（或一组）在构建时执行的命令。

**生成文件的用法（OUTPUT 形式）：**

```cmake showLineNumbers
add_custom_command(OUTPUT generated.h
  COMMAND my_generator ${CMAKE_CURRENT_SOURCE_DIR}/input.txt generated.h
  DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/input.txt
  COMMENT "Generating generated.h"
)
add_executable(myapp main.cpp generated.h)
```

表示：要生成 `generated.h` 时执行 `COMMAND`；`DEPENDS` 表示依赖输入文件；某个目标（如 myapp）依赖 `OUTPUT` 时，构建该目标前会先执行这条命令。

**针对某个目标的用法（TARGET 形式）：**

```cmake showLineNumbers
add_custom_command(TARGET myapp POST_BUILD
  COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:myapp> ${CMAKE_BINARY_DIR}/bin/
  COMMENT "Copying myapp to bin/"
)
```

在 myapp 构建完成后执行 `POST_BUILD` 命令（如拷贝可执行文件）。



## add_custom_target

定义一个总是可被构建的“目标”（不对应一个文件），通常用于“运行脚本”“执行测试”等。其他目标可通过 **`add_dependencies(目标 custom_target_name)`** 依赖它，从而控制执行顺序。

```cmake showLineNumbers
add_custom_target(run_script
  COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_SOURCE_DIR}/myscript.cmake
  COMMENT "Running custom script"
)
```

构建时执行 `cmake --build . --target run_script` 就会运行该命令。



## 小结

- **add_custom_command(OUTPUT ...)**：生成文件，被其他目标依赖时在构建时执行。
- **add_custom_command(TARGET ... POST_BUILD)**：在指定目标构建后执行。
- **add_custom_target**：定义一个“虚拟”目标，用于执行任意命令，可通过 add_dependencies 参与依赖关系。
