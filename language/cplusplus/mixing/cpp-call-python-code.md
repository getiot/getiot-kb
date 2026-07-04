---
sidebar_position: 2
slug: /cpp-call-python-code
---

# C++ 调用 Python



使用 Boost.Python：Boost.Python 是一个 C++ 库，允许你将 C++ 代码与 Python 集成得更加紧密。虽然它主要针对C++，但也可以在C程序中使用。

## 简单调用

```cpp showLineNumbers showLineNumbers
int main()
{
    // 初始化 Python 解释器
    Py_Initialize();
    np::initialize();

    try {
        // 导入所需的 Python 模块
        boost::python::object main_module = boost::python::import("__main__");
        boost::python::object main_namespace = main_module.attr("__dict__");
		
        // 使用 Python 方法打印 Hello World
        boost::python::exec("print('Hello World!')", main_namespace);
        
    } catch (boost::python::error_already_set const&) {
        PyErr_Print();
    }

    // 清理 Python 解释器
    Py_Finalize();

    return 0;
}
```



## 传递参数和返回值

```python
import numpy as np
arr = np.array([1, 2, 3, 4, 5])  # array([1, 2, 3, 4, 5])
squared = np.square(arr)         # array([ 1,  4,  9, 16, 25])
```

打印结果

```python
>>> arr
array([1, 2, 3, 4, 5])
>>> squared
array([ 1,  4,  9, 16, 25])
```

