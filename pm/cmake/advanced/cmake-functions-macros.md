---
sidebar_position: 2
slug: /cmake-functions-macros
authors: [luhuadong]
---

# CMake 函数和宏

CMake 支持用 **`function()`** 和 **`macro()`** 封装重复逻辑，区别在于**作用域**：函数有独立作用域，宏是内联展开、使用调用处的作用域。

## function（函数）

```cmake showLineNumbers
function(函数名 参数1 参数2 ...)
  # 参数可通过 ARGV、ARGN 访问，也可用形参名
  # 变量在函数内 set() 不会影响外部，除非 set(... PARENT_SCOPE)
endfunction()
```

- **ARGV**：所有传入参数列表；
- **ARGN**：超出形参个数的多余参数。
- 在函数内 `set(var value)` 只改变函数内变量；若要让父作用域可见，需 `set(var value PARENT_SCOPE)`。


## macro（宏）

```cmake showLineNumbers
macro(宏名 参数1 参数2 ...)
  # 宏体在调用处展开，使用调用处的变量作用域
endmacro()
```

- 宏没有独立作用域，其中 set() 会修改调用处的变量。
- 适合简单替换、重复一段“模板”式 CMake 代码。

## 何时用函数、何时用宏

- 希望“封装一段逻辑且不污染外部变量”时用 `function`。
- 希望“像写内联代码一样，直接读写当前变量”时用 `macro`；注意避免变量名冲突。

## 小结

- `function`：独立作用域，通过 `PARENT_SCOPE` 向父作用域传值。
- `macro`：无独立作用域，在调用处展开。

CMake 自身大量使用“命令”形式，其实现也常为函数或宏；自定义时优先用 `function` 更安全。
