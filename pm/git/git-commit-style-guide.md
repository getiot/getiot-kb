---
sidebar_position: 20
slug: /git-commit-style-guide
---

# Git 提交规范



本文介绍 Git 提交信息的编写规范，即在使用 `git commit -m` 命令时该如何填写提交信息。规范的 commit 信息，有利于项目的管理和跟踪。可以说，掌握 Git 提交规范是程序员的基本素养。

规范的提交信息在于定义提交消息格式，不同的项目有其各自的格式，因此你应该优先遵守你所参与项目的提交规范。如果是一个全新的项目，那么可以参考本文所推荐的方式。



## Git commit 规范

下面是推荐的 git commit 日志基本规范格式：

```bash
<type>(<scope>): <subject>
```



## 提交类型


在提交消息格式定义中，通常会约定提交消息的类型。例如，一个完整的项目通常需要区分开发和生产类型：

- 开发 —— 对更改进行分类的维护类型，针对**开发人员**，实际上并不影响生产代码，而是内部的开发环境和工作流程；
- 生产 —— 对更改进行分类的增强类型，针对**最终用户**，仅影响生产代码。

下表列出了一些常用的提交类型及其说明。

| 提交类型 | 说明                                                      |
| -------- | --------------------------------------------------------- |
| feat     | 添加新特性。                                              |
| fix      | 修复 Bug。                                                |
| docs     | 仅仅修改了文档，比如 README、CHANGELOG、CONTRIBUTE 等等。 |
| style    | 仅仅修改了空格、格式缩进、逗号等等，不改变代码逻辑。      |
| refactor | 代码重构，没有加新功能或者修复 Bug。                      |
| perf     | 优化相关，比如提升性能、体验。                            |
| test     | 测试用例，包括单元测试、集成测试等。                      |
| chore    | 改变构建流程、或者增加依赖库、工具等。                    |
| build    | 开发类型，改变了内部的开发环境和工作流程。                |
| release  | 修改发布信息。                                            |
| revert   | 回滚到上一个版本。                                        |
| ci       | 修改持续集成相关工具。                                    |



## 优秀案例

下面是来自 Vue.js 项目的部分提交信息：

```bash
chore: fix some broken links to v2 docs (#12839)
feat: add exports field + mjs build
release: v2.7.13
fix(types): style attribute svg (#12800)
feat(types): enhance type for onErrorCaptured (#12735)
```

下面是来自 LVGL 项目的部分提交信息：

```bash
docs(micropython): add coding conventions section(#3774)
feat(tiny_ttf): ttf support (#3680)
feat(ime_pinyin): add API to use Pinyin IME(Chinese input) (#3408)
chore: bump version numbers to v9.0.0-dev
fix(make): update lvgl.mk and remove unnecessary mk files
arch(env): move the zephyr folder into the env_support folder
```



## 插件工具

- [Git Semantic Commit](https://github.com/nitayneeman/vscode-git-semantic-commit)：一个可通过语义消息约定简化 Git 提交的 VS Code 扩展。

