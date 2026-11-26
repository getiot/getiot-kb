---
sidebar_position: 5
slug: /vscode-config-files
authors: [luhuadong]
---

# VS Code 配置文件



本文介绍 Visual Studio Code 中一些重要的配置文件，包括 settings.json、tasks.json、launch.json 等，它们通常保存在 .vscode 目录中。



## settings.json

`settings.json` 是 VS Code 中一个重要的配置文件，用于配置编辑器本身的行为（与项目无关），以及包括各种扩展的全局设置。在 C/C++ 开发中，`settings.json` 也可以包含一些与编译、调试、IntelliSense 等相关的设置。

在 VS Code 中，可以通过 "File" -> "Preferences" -> "Settings" 或快捷键 `Ctrl` + `,` 打开设置。然后，点击右上角的“Open Settings (JSON)”按钮，将打开 `settings.json` 文件。

或者使用快捷键 `Ctrl` + `Shift` + `P` ，然后搜索 `settings`。此时会匹配出多个选项：

- “首选项：打开设置（json）” 这个打开的是全局的 settings.json 文件
- “首选项：打开默认设置（json）” 这个打开的是 defaultSettings.json 文件
- “首选项：打开工作区设置（json）” 这个打开的是项目的 settings.json 文件

设置界面是 UI 形式还是 json 形式，可以通过下面这个图标来进行切换：

![](https://static.getiot.tech/vscode-open-json-button.png#center)

配置示例：

```json showLineNumbers title="settings.json"
{
    "files.autoSave": "afterDelay",
    "editor.formatOnSave": true,
    "editor.defaultFormatter": "ms-vscode.cpptools",
    "cSpell.language": "en, en-GB, en-US, de-DE, fr-FR",
    "editor.tabSize": 4,
    "c-cpp-flylint.cppcheck.enable": true,
    "c-cpp-flylint.cpplint.enable": true,
    "c-cpp-flylint.clangd.enable": true
}
```

上述示例配置包含了一些常见的全局设置，例如自动保存、在保存时格式化代码、设置默认的格式化程序、设置 Tab 大小等。其中，`c-cpp-flylint` 相关的设置用于启用一些 C/C++ 语言服务器的 lint 工具。

请注意，`settings.json` 文件是可选的，你可以根据需要进行配置。在项目中，你也可以在 `.vscode` 文件夹下创建 `settings.json` 文件，用于配置与该项目有关的设置。

:::tip

全局的 `settings.json` 文件保存在用户的 VS Code 配置目录中。具体的保存位置取决于操作系统。以下是一些常见的配置目录：

- **Windows**

  ```bash
  %APPDATA%\Code\User\settings.json
  ```

  例如：`C:\Users\YourUsername\AppData\Roaming\Code\User\settings.json`

- **macOS**

  ```bash
  $HOME/Library/Application Support/Code/User/settings.json
  ```

- **Linux**

  ```bash
  $HOME/.config/Code/User/settings.json
  ```

:::



## tasks.json

VSCode 中的 tasks.json 文件用于配置任务（例如构建任务），允许在 VS Code 中执行自定义的 shell 命令。配置内容包括任务的名称、类型、命令、参数等。

配置示例：

```json
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "build",
            "type": "shell",
            "command": "g++",
            "args": [
                "-g",
                "${file}",
                "-o",
                "${fileDirname}/${fileBasenameNoExtension}"
            ],
            "group": {
                "kind": "build",
                "isDefault": true
            }
        }
    ]
}
```

:::tip

tasks.json 用于在 launch.json 前执行任务，两者经常组合起来用于需要编译语言的自动编译+自动执行。

:::



## launch.json

VSCode 中的 launch.json 是用于配置调试环境的配置文件，包括调试器的类型、启动程序的路径、命令行参数等。它可以帮助我们在开发过程中调试代码，从而更快地查找并修复问题。

要配置 launch.json，需要打开 Debug 菜单，然后选择「打开调试配置」。此时，VSCode 将为您自动生成一个 launch.json 文件。你可以在其中添加以下常用配置：

- `configurations`：你可以配置多个调试配置，每个配置都是一个对象，并具有不同的配置选项。
- `type`：此选项指示调试器的类型，如 cppdbg、python、node 等。
- `request`：此选项指示调试请求的类型，如 launch、attach 等。
- `program`：此选项指定要调试的程序的路径。
- `args`：此选项指定传递给程序的命令行参数。
- `env`：此选项指定环境变量。
- `sourceMaps`：此选项指示是否使用源映射。

以上是 launch.json 配置文件的一些常用选项，你可以根据需要添加其他配置，以配置你的调试环境。

配置示例：

```json showLineNumbers title="settings.json"
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Debug",
            "type": "cppdbg",
            "request": "launch",
            "program": "${workspaceFolder}/build/your_executable",
            "args": [],
            "stopAtEntry": false,
            "cwd": "${workspaceFolder}",
            "environment": [],
            "externalConsole": false,
            "MIMode": "gdb",
            "setupCommands": [
                {
                    "description": "Enable pretty-printing for gdb",
                    "text": "-enable-pretty-printing",
                    "ignoreFailures": true
                }
            ],
            "preLaunchTask": "build"
        }
    ]
}
```



