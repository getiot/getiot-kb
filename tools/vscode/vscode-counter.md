---
sidebar_position: 8
slug: /vscode-counter
authors: [luhuadong]
---

# VS Code 统计代码量



在 VS Code 中，统计代码量（例如代码行数、注释行数、各编程语言类型等数据）非常简单，只需要安装 **VS Code Counter** 插件。

按住按 Ctrl + Shift + P 键，输入 `Count lines in workspace` 并回车，将会统计当前工作空间中的所有代码量。

统计完成后，将在当前工作空间下自动生成 .VSCodeCounter 目录，其中包含了以当前日期时刻命名的子目录，存放了各种格式的统计结果。

```bash
$ tree .VSCodeCounter/
.VSCodeCounter/
└── 2022-09-15_15-24-46
    ├── details.md
    ├── diff.csv
    ├── diff-details.md
    ├── diff.md
    ├── diff.txt
    ├── results.csv
    ├── results.json
    ├── results.md
    └── results.txt

1 directory, 9 files
```

VS Code Counter 插件会自动打开 results.md 文件，展示统计结果。部分统计数据如下所示。

```bash
Date : 2022-09-15 15:24:46
Directory : /home/rudy/workspace/GetIoT/src
Total : 847 files,  98562 codes, 21863 comments, 16954 blanks, all 137379 lines

Languages
+--------------+------------+------------+------------+------------+------------+
| language     | files      | code       | comment    | blank      | total      |
+--------------+------------+------------+------------+------------+------------+
| C++          |        358 |     44,268 |     16,032 |     10,182 |     70,482 |
| XML          |         79 |     25,870 |        130 |        470 |     26,470 |
| CMake        |        266 |     14,047 |      1,867 |      2,696 |     18,610 |
| Diff         |         26 |      5,219 |        197 |        287 |      5,703 |
| Python       |         37 |      3,968 |      1,607 |      1,267 |      6,842 |
| Markdown     |         22 |      1,900 |          0 |        788 |      2,688 |
| kconfig      |         24 |      1,233 |      1,748 |        728 |      3,709 |
| C            |          4 |        630 |         84 |        144 |        858 |
| YAML         |         10 |        601 |        116 |        109 |        826 |
| Lua          |          4 |        478 |         41 |        187 |        706 |
| Shell Script |          8 |        226 |         35 |         72 |        333 |
| JSON         |          3 |         41 |          0 |          1 |         42 |
| PowerShell   |          3 |         39 |          0 |         10 |         49 |
| Docker       |          2 |         36 |          6 |         10 |         52 |
| Makefile     |          1 |          6 |          0 |          3 |          9 |
+--------------+------------+------------+------------+------------+------------+
```

