---
sidebar_position: 7
slug: /vscode-find-and-replace
authors: [luhuadong]
---

# VS Code 搜索与替换





## 使用正则表达式

1. 打开搜索和替换窗口（快捷键：`Ctrl + H` 或 `Cmd + H`）。
2. 在搜索框中点击正则表达式图标或使用快捷键 `Alt + R`，以启用正则表达式模式。



### 示例：替换 http 链接

将 `<https://xxx>` 风格的链接替换为 `[https://xxx](https://xxx)` 风格。

条件：图片链接必须是 http 开头，以后缀 png、jpg、jpeg 或 webp 结尾。

搜索栏：

```bash
<(http[^>]+)>
```

替换栏：

```bash
[$1]($1)
```



### 示例：在图片链接末尾添加标签

将 `![Linux Shell](https://xxx.png#center)` 替换为 `![Linux Shell](https://xxx.png#center)`

```bash
(!\[[^\]]*\]\()(http[^\s]+\.(png|jpg|jpeg|webp))(?:\))
```

替换内容：

```bash
$1$2#center)
```





