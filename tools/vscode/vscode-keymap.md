---
sidebar_position: 4
slug: /vscode-keymap
authors: [luhuadong]
---

# VS Code 快捷键

本文介绍 Visual Studio Code 中一些常用的快捷方式，熟练掌握这些操作，将有助于提高你的开发效率，成为别人眼中的“大神”！

## 窗口操作

|             快捷键              |                             功能                             |
| :-----------------------------: | :----------------------------------------------------------: |
|          `Ctrl` + `J`           |                    显示/隐藏底部控制面板                     |
|          `Ctrl` + `B`           |                 显示/隐藏侧边栏（如文件栏）                  |
|     `Ctrl` + `Shift` + `N`      |                         新建一个窗口                         |
|     `Ctrl` + ( `+` 或 `-` )     |                        字体放大/缩小                         |
|        `Ctrl` + `1/2/3`         |                          拆分编辑器                          |
| `Ctrl` + `Shift` + `Left/Right` |                           切换窗口                           |
|          `Ctrl` + `W`           |                        关闭编辑器窗口                        |
|       `Ctrl` + `K` + `W`        |                         关闭所有窗口                         |
|              `F11`              |                           切换全屏                           |
|          `Ctrl` + `T`           |                         快速切换主题                         |
|          `Ctrl` + `P`           | 调出文件搜索框（按名字搜索，追加 `:` 转到行，追加 `@` 转到符号） |
|     `Ctrl` + `Shift` + `F`      |                      打开全局搜索输入框                      |
|     `Ctrl` + `Shift` + `P`      |                   调出用于执行命令的输入框                   |
|     `Ctrl` + `Shift` + `D`      |                   打开 Run and Debug 视图                    |
|     `Ctrl` + `Shift` + `X`      |                     打开 Extensions 视图                     |




## 代码编辑

|           快捷键            |             功能             |
| :-------------------------: | :--------------------------: |
|        `Ctrl` + `C`         |          复制当前行          |
|        `Ctrl` + `X`         |          删除当前行          |
|        `Ctrl` + `L`         |           选择整行           |
|   `Ctrl` + `Shift` + `K`    |           删除整行           |
|      `Alt` + `Up/Down`      |         移动选中的行         |
| `Shift` + `Alt` + `Up/Down` |           复制整行           |
|        `Ctrl` + `D`         |   批量更改变量（多按几次）   |
|      `Ctrl` + `Enter`       |      光标在任意位置换行      |
|    `Ctrl` + `Left/Right`    |      光标跳到下一个单词      |
|        `Ctrl` + `/`         |    单行注释/取消单行注释     |
|   `Ctrl` + `Shift` + `F`    |           全局搜索           |
|        `Ctrl` + `G`         |         跳转到指定行         |
|       `Shift` + `F12`       |           显示引用           |
|   `Ctrl` + `Shift` + `O`    | 显示当前文件所有符号（函数） |



<!--

**1、注释**：

　　a) 单行注释：[ctrl+k,ctrl+c] 或 ctrl+/

　　b) 取消单行注释：[ctrl+k,ctrl+u] (按下ctrl不放，再按k + u)

　　c) 多行注释：[alt+shift+A]

　　d) 多行注释：/**

**2、移动行**：alt+up/down

**4、复制当前行**：shift + alt +up/down

**5、删除当前行**：shift + ctrl + k

**6、控制台终端显示与隐藏**：ctrl + ~

**7、查找文件/安装vs code** **插件地址**：ctrl + p

**8、代码格式化**：shift + alt +f

**10、行增加缩进:** ctrl + [

**11、行减少缩进:** ctrl + ]

**12、裁剪尾随空格(去掉一行的末尾那些没用的空格)** : ctrl + shift + x

**19、自动换行** : alt + z

**20、显示git** : ctrl + shift + g

**21、全局查找文件：**ctrl + shift + f

**22、显示相关插件的命令(如：git log)**：ctrl + shift + p

**23、选中文字**：shift + left / right / up / down

**24、折叠代码**： ctrl + k + 0-9 (0是完全折叠)

**25、展开代码**： ctrl + k + j (完全展开代码)

**28、快速回到顶部** ： ctrl + home

**29、快速回到底部** : ctrl + end

**30、格式化选定代码** ：ctrl + k / ctrl +f

**31、选中代码 ：** shift + 鼠标左键

**32、多行同时添加内容（光标） ：**ctrl + alt + up/down

**33、全局替换：**ctrl + shift + h

**34、当前文件替换：**ctrl + h

**35、打开最近打开的文件：**ctrl + r

**36、打开新的命令窗：**ctrl + shift + c

-->



## 程序调试

|         快捷键          |        功能        |
| :---------------------: | :----------------: |
|          `F5`           |     运行/继续      |
|          `F6`           |        暂停        |
|          `F10`          |      单步跳过      |
|          `F11`          |      单步调试      |
|     `Shift` + `F11`     |      单步跳出      |
|     `Shift` + `F5`      |        停止        |
| `Ctrl` + `Shift` + `F5` |      重新运行      |
| `Ctrl` + `Shift` + `B`  | 运行 task 编译工程 |
|          `F9`           |      切换断点      |
| `Ctrl` + `Shift` + `-`  |        前进        |
|  `Ctrl` + `Alt` + `-`   |        后退        |
| `Ctrl` + `Shift` + `D`  |        运行        |



## 平台差异



### 代码格式化

- Windows ：`Shift` + `Alt` + `F`
- macOS ：`Shift` + `Option` + `F`
- Ubuntu ：`Ctrl` + `Shift` + `I`



### 函数跳转返回

- Windows：`Alt` + `-` （有的是 `Alt` + `←`）
- macOS：`control` + `-`
- Ubuntu：`Ctrl` + `Alt` + `-`
