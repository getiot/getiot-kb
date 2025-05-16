---
sidebar_position: 29
slug: /git-command-sparse-checkout
---

# git sparse-checkout 命令

`git sparse-checkout` 命令用于配置稀疏检出（sparse checkout），让你只检出仓库中的一部分目录或文件到本地工作区，避免下载整个项目的全部内容。这个功能非常适合处理大型单体仓库（monorepo）时只关注特定子目录的场景。

使用 `git sparse-checkout` 前，需先启用稀疏模式，并结合 [`git clone --filter=blob:none`](/git/git-command-clone/) 或 `git sparse-checkout init` 使用。



## 命令语法

```bash
git sparse-checkout <子命令> [参数]
```

常用子命令包括：

- `init`：初始化稀疏检出支持。
- `set <路径>`：设置需要检出的路径。
- `add <路径>`：添加需要检出的路径。
- `list`：列出当前已设置的稀疏路径。
- `disable`：禁用稀疏检出，恢复完整检出。
- `reapply`：重新应用当前的稀疏设置（通常用于与其他 Git 命令配合使用）。

**常用选项参数**

- `--cone`：使用 cone 模式，简化路径匹配规则，推荐使用。
- `--no-cone`：禁用 cone 模式，使用旧的路径匹配语法。



## 使用示例

**1. 克隆大仓库但不检出全部内容**：

```bash
git clone --filter=blob:none --no-checkout https://github.com/example/big-repo.git
cd big-repo
git sparse-checkout init --cone
git sparse-checkout set docs/
```

这将只检出 `docs/` 目录的内容。

**2. 添加一个额外的目录到当前稀疏检出中**：

```bash
git sparse-checkout add src/
```

现在，工作区中包含了 `docs/` 和 `src/` 两个目录。

**3. 查看当前稀疏检出配置的路径**：

```bash
git sparse-checkout list
```

**4. 取消稀疏检出并恢复为完整工作区**：

```bash
git sparse-checkout disable
```



## 小贴士

- 建议配合 `--cone` 模式使用，语法更简单且更高效，只需指定顶层目录。
- 稀疏检出不会减少 Git 仓库的克隆大小（对象仍在本地 `.git` 目录中），但会减少你实际工作目录中的文件数量，加快操作速度。
- `git sparse-checkout` 适合处理包含多个子项目的大型 monorepo，让你只聚焦感兴趣的部分。
