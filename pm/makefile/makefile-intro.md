---
sidebar_position: 1
---

# Makefile 简介

在软件开发的世界中，构建（build）是一个不可或缺的环节。Makefile（或称为 Makefile 文件）作为一种构建工具的配置文件，扮演着自动化构建过程的重要角色。本文将介绍什么是 Makefile，其起源、用途以及基本原理。

## 什么是 Makefile？

Makefile 是一个包含构建规则的文本文件，用于定义如何编译和链接源代码以生成可执行文件、库文件或其他构建目标。它是 `make` 工具的输入文件，`make` 工具根据 Makefile 中定义的规则自动执行编译和链接操作。

实际上，Makefile 的历史可以追溯到 1970 年代。最早的 Make 工具出现在 UNIX 系统中，它的任务是根据源代码之间的依赖关系来自动构建程序。此工具的配置文件被命名为 Makefile，其中定义了源文件、目标文件和构建规则。

## 主要用途

Makefile 的主要用途包括：

- **自动化构建**：定义源文件、目标文件以及构建规则，实现对代码的自动编译、链接和构建。
- **管理依赖关系**：Makefile 中可以明确指定源文件之间的依赖关系，确保在源文件发生变化时，相关的目标会被正确重新构建。
- **跨平台构建**：Makefile 的语法是跨平台的，可以在不同操作系统上运行，使得项目能够在多个平台上方便地构建。

## 语法规则

Makefile 包含了一系列规则，每个规则定义了一个构建目标、依赖关系以及构建命令。规则的语法通常如下：

```makefile showLineNumbers
target: dependencies
	command
```

- `target` 表示构建的目标，可以是可执行文件、库文件等。
- `dependencies` 是 `target` 依赖的源文件或其他目标。
- `command` 是构建 `target` 的命令，通常包括编译、链接等操作。

:::tip

注意：`command` 前面必须是一个制表符（`TAB` 键），不能使用空格替代。

:::

## 简单示例

一个简单的 Makefile 示例，用于编译一个名为 `hello` 的可执行文件：

```makefile showLineNumbers
hello: main.c
	gcc -o hello main.c
```

这个示例中，`hello` 是目标，`main.c` 是依赖，`gcc -o hello main.c` 是构建命令。

## 小结

Makefile 是构建过程中不可或缺的工具之一，尤其是 Linux 程序，它通过简洁的规则描述实现了代码的自动构建。掌握 Makefile 的基本原理和语法，有助于提高项目的可维护性和构建效率。
