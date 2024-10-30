---
sidebar_label: ronn 命令
sidebar_position: 5
slug: /ronn
---

# ronn 命令 - 转换 Markdown 为 man 页



## 介绍

**ronn** 命令用于将 markdown 文档（roff 格式）转换成 Linux 标准的 manpages 帮助文档。

ronn-format 基于 markdown，但包含额外的规则和语法，用于编写手册。关于 ronn-format 的介绍可以通过 `man ronn-format` 获取。	

在默认模式下，ronn 将一个或多个输入文件转换为 HTML 或 roff 输出文件。--roff、--html 和 --fragment 选项指示生成哪些输出文件。可以指定多个格式参数来生成多个输出文件。输出文件以输入文件命名并写入相同的目录。--server 和 --man 选项将输出行为从文件生成更改为提供动态生成的 HTML 联机帮助页或与 man 一样查看文件。

如果没有文件参数，ronn 将充当简单的过滤器。Ronn 源文本从标准输入读取，roff 输出写入标准输出。使用 --html、--roff 和 / 或 --fragment 选项来选择输出格式。 

**语法**：

```shell
ronn <options> <file>...
ronn -m|--man <file>
ronn -S|--server <file> ...
ronn --pipe [<file>...]
ronn < file
```

**选项**：

- 模式选项改变生成文件的默认行为：
  - `--pipe` ：写入标准输出而不是生成文件。
  - `-m`, `--man` ：像 man 一样显示帮助手册。
  - `-S`, `--server` ：在 [http://localhost:1207/](http://localhost:1207/) 提供服务文件。
  - `--port <port>` ：使用指定端口而不是默认的 1207 运行服务器。
  - `-o`, `--output-dir <dir>` ：将生成的文件写入指定目录。
- 格式选项控制生成哪些文件格式：
  - `-r`, `--roff` ：生成 roff 格式输出。
  - `-5`, `--html` ：生成带有布局的整个 HTML 页面。
  - `-f`, `--fragment` ：生成 HTML 片段。
  - `--markdown` ：生成后处理的（post-processed）markdown 格式输出。
- 文档属性：
  - `--date=<date>` ：发布日期（底部居中），格式为 YYYY-MM-DD。
  - `--manual=<name>` ：手册名称（顶部居中）。
  - `--organization=<name>` ：出版团体或个人（左下）。
- 其他选项：
  - `-w`, `--warnings` ：在 stderr 上显示 troff 警告。
  - `-W disable` ：预先启用的 troff 警告。
  - `--version` ：显示 ronn 的版本信息。
  - `--help` ：显示帮助信息。



## 示例

转换 atinout.1.ronn 文件

```shell
ronn atinout.1.ronn
```

