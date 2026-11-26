---
sidebar_position: 3
---

# 万能 Makefile 模板（C++）



[前面](/makefile/simple-makefile-template/)针对 C 语言写了一个万能 Makefile 模板，这里我们再针对 C++ 写一个 Makefile 模板，可用于遍历当前目录下的所有 cpp 文件，并将每个 cpp 编译成一个可执行文件。同时，还支持使用 `make clean` 命令清除所有生成的可执行文件。

这个 Makefile 模板适用于大多数个人学习项目。

```makefile showLineNumbers
CXX := g++ # 编译器命令
CXXFLAGS := -std=c++11 -Wall -Wextra # 编译器选项
LIBS := -pthread # 链接线程库，可修改为任意你需要链接的库
SRCS := $(wildcard *.cpp) # 获取当前目录下所有.cpp文件的列表
EXES := $(SRCS:.cpp=) # 通过去除.cpp后缀，生成对应的可执行文件名列表

# 默认目标，编译所有可执行文件
all: $(EXES)

# 编译生成可执行文件
%: %.cpp
    $(CXX) $(CXXFLAGS) $(LIBS) -o $@ $^

# 清除生成的文件
clean:
    rm -f $(EXES)

.PHONY: all clean
```

在 Makefile 中，我们使用了 `wildcard` 函数来获取当前目录下所有 `.cpp` 文件的列表，并将其存储在变量 `SRCS` 中。然后，我们通过将每个 `.cpp` 文件的后缀替换为空来生成可执行文件的名称，并将其存储在变量 `EXES` 中。

Makefile 定义了两个目标：

1. `all`：默认目标，用于编译生成所有的可执行文件。它依赖于变量 `$(EXES)`，表示所有可执行文件的列表。对于列表中的每个可执行文件，我们使用通配符规则 `%: %.cpp` 来生成对应的目标，并使用编译器命令 `$(CXX)` 和选项 `$(CXXFLAGS)` 来编译生成可执行文件。
2. `clean`：用于清除生成文件的目标。它使用 `rm -f`命令将`$(EXES)` 中列出的所有可执行文件删除。

要使用此 Makefile，请在存储 Makefile 的目录中打开终端，并执行以下命令：

```bash
make
```

这将使用 Makefile 中定义的规则来遍历当前目录下的所有 `.cpp` 文件，并将每个文件编译成一个对应的可执行文件。

如果你想清除所有生成的可执行文件，可以运行以下命令：

```bash
make clean
```

提示：请确保在执行`make`命令之前，你的系统上安装了C++编译器（例如`g++`）。
