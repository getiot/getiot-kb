---
sidebar_position: 30
slug: /git-faq
---

# Git 常见问题（FAQs）

这里收集 Git 使用过程中的常见问题。



## git status 不能显示中文

现象：在 Windows 环境下，执行 `git status` 查看工作空间状态时，对于已修改但未提交的文件总是以数字串形式显示（看起来是八进制的字符编码），而不能显示中文文件名。

解决方法：将 Git 配置文件 `core.quotepath` 项设置为 `false`。在 Git Bash 终端执行如下命令：

```bash
git config --global core.quotepath false
```

这里的 `quotepath` 表示引用路径，加上 `--global` 表示全局配置。

再次执行 `git status` 就可以看到中文啦！

