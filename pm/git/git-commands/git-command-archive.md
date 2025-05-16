---
sidebar_position: 2
slug: /git-command-archive
---

# git archive 命令

`git archive` 命令用于将 Git 仓库中特定的提交或分支的内容导出成一个归档文件（如 `.zip` 或 `.tar` 格式），而不会包含 Git 版本控制的元数据。这样你可以快速打包某个版本的项目文件，便于发布、备份或分发。

它适合用来导出项目的某个快照，比如发布代码包，或者提供给不使用 Git 的用户。



## 命令语法

```bash
git archive [选项] <commit> [<路径>...]
```

参数 `<commit>` 可以是分支名、标签名或提交 ID。同时你也可以指定导出的路径，来只归档部分文件或目录。

**常用选项参数**

- `-o <文件名>`：将归档结果输出到指定文件，而不是默认输出到标准输出。
- `--format=<格式>`：指定归档格式，常见格式有 `tar`（默认）、`zip`、`tar.gz` 等。
- `--prefix=<前缀>/`：为归档内的所有文件加上路径前缀，通常用于解压后统一放在一个文件夹里。
- `--worktree-attributes`：使用工作区的 `.gitattributes` 文件中的导出设置。
- `--list`：列出支持的归档格式。



## 使用示例

将当前 `main` 分支的最新内容打包为 `project.zip`：

```bash
git archive -o project.zip --format=zip main
```

将某个标签版本 `v1.0` 导出成一个 `.tar` 归档，并为文件加上前缀目录 `project-v1.0/`：

```bash
git archive --format=tar --prefix=project-v1.0/ v1.0 > v1.0.tar
```

导出当前 `HEAD` 的某个子目录 `src`，生成压缩包 `src.zip`：

```bash
git archive -o src.zip --format=zip HEAD src
```

查看 Git 支持的归档格式：

```bash
git archive --list
```



## 小贴士

- `git archive` 只打包文件内容，不包含 `.git` 目录及版本历史，适合发布纯净代码包。
- 结合 `.gitattributes` 文件的 `export-ignore` 属性，可以排除不需要打包的文件，如测试目录或文档。
- 归档文件可以方便地传递给不使用 Git 的同事或部署环境。
