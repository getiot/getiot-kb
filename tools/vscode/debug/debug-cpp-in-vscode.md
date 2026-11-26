---
sidebar_position: 1
slug: /debug-cpp-in-vscode
authors: [luhuadong]
---

# VS Code 编译和调试 C/C++ 程序

本文以 Ubuntu 系统为例，介绍如何在 VS Code 上配置 C/C++ 的编译环境，并把工程运行、调试起来。



## 准备工作

### 安装编译器

首先需要安装编译器。因为 VS Code 只是一个代码编辑器，没有自带有 C/C++ 的编译器，因此我们需要安装一个 C/C++ 编译器，打开终端依次输入，确保安装好 gcc、g++ 和 gdb 等工具。

```bash
sudo apt install gcc g++ gdb
```

### 安装插件

然后，还需要在 VS Code 中安装 C/C++ 扩展，打开 Extensions 视图（快捷键：`Ctrl + Shift + X`），搜索并安装 "C/C++" 扩展。

![](https://static.getiot.tech/vscode-extensions-c-cpp-debugging.png#center)

### 下载示例工程

本示例完整工程代码可在 [GitHub](https://github.com/getiot/vscode-courses/tree/main/project/cppdbg-demo) 获取，下面展示 main 函数部分。在这个示例中有两个线程，一个线程生产随机数字并将其放入队列，另一个线程从队列中取出数字并打印。程序可以接收一个数字参数，用于设置随机数的最大值（默认是 100）。

```cpp showLineNumbers title="cppdbg-demo"
int main(int argc, char *argv[])
{
    if (argc > 1) {
        rangeMax = std::stoi(argv[1]);
    }
    
    // 设置随机数种子
    std::srand(std::time(0));

    // 启动生产者线程和消费者线程
    std::thread producer(producerThread);
    std::thread consumer(consumerThread);

    // 等待线程结束
    producer.join();
    consumer.join();

    return 0;
}
```



## 配置文件

想要在 VS Code 中运行和调试 C/C++ 程序，涉及三个配置文件：tasks.json、launch.json 和 c_cpp_properties.json。这三个配置文件一起提供了一个完整的 C/C++ 开发环境的配置。

- `tasks.json` 文件用于配置任务（例如编译）
- `launch.json` 文件用于配置调试器
- `c_cpp_properties.json` 文件用于配置 [IntelliSense](/dictionary/intellisense/) 功能

通过配置这些文件，你可以在 VS Code 中方便地进行 C/C++ 项目的编译和调试。（参考《[VS Code 配置文件](/vscode/vscode-config-files/)》）



### tasks.json

对于一个新的工程，首先需要创建 tasks.json 文件。点击左侧 “Run and Debug” 按钮打开运行和调试窗口，点击蓝色的“运行和调试”按钮，选择 “C++ (GDB/LLDB)” 调试器。

![](https://static.getiot.tech/vscode-create-tasks-json-file.png#center)

在这里会列出你的系统中已经安装的 C/C++ 编译器，选择你需要的即可。

![](https://static.getiot.tech/vscode-create-tasks-json-file-2.png#center)

现在，你可以看到在当前工程的 .vscode 目录下多了一个 tasks.json 文件。该文件包含用于编译的命令、编译器的地址、与 launch.json 中相同的标签以及其他一些信息等。

由于这里使用了多线程，因此需要添加 `-lpthread` 链接库信息，以下是修改后的 task.json 文件：

```json showLineNumbers title="tasks.json" {13}
{
    "tasks": [
        {
            "type": "cppbuild", // 任务执行的类型是 cppbuild
            "label": "C/C++: g++ 生成活动文件", // 任务的名字
            "command": "/usr/bin/g++",
            "args": [
                "-fdiagnostics-color=always",
                "-g",
                "${file}", // 当前文件名
                "-o",
                "${fileDirname}/${fileBasenameNoExtension}", // 当前文件名（去掉扩展名）
                "-lpthread"
            ],
            "options": {
                "cwd": "${fileDirname}"
            },
            "problemMatcher": [
                "$gcc" // 使用 gcc 捕获错误
            ],
            "group": {
                "kind": "build",
                "isDefault": true
                // 任务分组，因为是 tasks 而不是 task，意味着可以连着执行很多任务。
                // 如果任务分组是 build，可以用 `run build task` 来运行。
                // 如果任务分组是 test，可以用 `run test task` 来运行。
            },
            "detail": "调试器生成的任务。"
        }
    ],
    "version": "2.0.0"
}
```

tasks.json 中的字段大多数可以不太关注，但是唯独要特别注意的是，tasks.json 的 **label** 必须与 launch.json 的 **preLaunchTask** 匹配。并且它是区分大小写的，在 launch.json 中会调用这个名字。更具体来说：

- **label**：这是 tasks.json 文件所特有的，launch.json 使用它在执行之前调用 tasks.json。

- **command**：指向 g++ 编译器应用程序，因为在编译过程中需要用到它。

- **args**：这些参数与命令连接起来后就是用于编译 cpp 文件和创建可执行文件的命令，例如：

  ```bash
  g++ -std=c++11 -O2 -Wall ${file} -o ${fileDirname}\\${fileBasenameNoExtension}.exe
  ```



### launch.json

接着，需要创建 launch.json 文件。点击左侧 “Run and Debug” 按钮打开运行和调试窗口，点击 “创建 launch.json 文件” 链接，选择 “C++ (GDB/LLDB)” 调试器。

![](https://static.getiot.tech/vscode-create-launch-json-file.png#center)

此时，在 .vscode 目录中会创建出一个 launch.json 文件，内容如下：

```json showLineNumbers title="launch.json"
{
    // 使用 IntelliSense 了解相关属性。 
    // 悬停以查看现有属性的描述。
    // 欲了解更多信息，请访问: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": []
}
```

实际上，这个时候按 `F5` 键就可以开始编译并进入调试模式。但是为了更细致地配置工程，我们来设置 launch.json 文件的配置项，涉及调试器的名称、调试器的路径、当前 cpp 文件的目录以及有关数据的控制台等信息。下面是配置完成后的 launch.json 文件内容：

```json showLineNumbers title="launch.json" {6,10}
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Launch",
            "preLaunchTask": "C/C++: g++ 生成活动文件",
            "type": "cppdbg",
            "request": "launch",
            "program": "${fileDirname}/${fileBasenameNoExtension}",
            "args": ["1000"],
            "stopAtEntry": false,
            "cwd": "${workspaceFolder}",
            "environment": [],
            "externalConsole": false,
            "MIMode": "gdb",
            "miDebuggerPath": "/usr/bin/gdb",
            "setupCommands": [
                {
                    "description": "Enable pretty-printing for gdb",
                    "text": "-enable-pretty-printing",
                    "ignoreFailures": true
                }
            ]
        }
    ]
}
```

注意：**preLaunchTask** 项一定要与 tasks.json 中的任务名称一致。另外，第 10 行设置了启动程序的参数，我们传入了 1000 作为随机数的最大值。

你可以完全使用上面给出的代码，也可以使用机器中自动生成的代码。下面是一些比较重要的选项说明：

- **name** 和 **type**：分别指定 launch.json 的名称和类型。
- **preLaunchTask**：设定 tasks.json 文件的任务名称（可能会有多个任务）。
- **request**：指明 JSON 文件的类型。
- **program**：指明程序的具体路径。
- **cwd**：表示当前工作目录。请注意，launch.json 文件中的所有地址都是通用形式，它们不特定于任何文件。
- **externalConsole**：是否使用外部控制台，如果是 true，则启动外部控制台，否则使用 VS Code 的集成终端。
- **miDebuggerPath**：指明调试器的位置，这个也是因用户而异的。



### c_cpp_properties.json

c_cpp_properties.json 文件不是必须的，主要用于配置 C/C++ 扩展的 IntelliSense 设置，指定编译器路径、标准库路径、头文件路径、宏定义等信息。它影响的是编辑器对代码的智能提示、语法检查等功能，而不是编译任务。

创建 c_cpp_properties.json 文件的方法是：通过快捷键 `Ctrl + Shift + P` 打开执行命令的输入框，输入 “C/C++”，选择 “C/C++: 编辑配置(JSON)”。

![](https://static.getiot.tech/vscode-create-c_cpp_properties-json-file.png#center)

在我的 Ubuntu 系统中，生成的默认配置如下：

```json showLineNumbers title="c_cpp_properties.json"
{
    "configurations": [
        {
            "name": "Linux",
            "includePath": [
                "${workspaceFolder}/**"
            ],
            "defines": [],
            "compilerPath": "/usr/bin/clang-9",
            "cStandard": "c17",
            "cppStandard": "c++14",
            "intelliSenseMode": "linux-clang-x64"
        }
    ],
    "version": 4
}
```



## 运行调试

完成前面的准备工作后，就可以开始运行调试代码了。点击左侧 “Run and Debug” 按钮打开运行和调试窗口，点击窗口上方 Launch 旁边的绿色小三角按钮开始调试（也可以直接按 `F5` 键进入调试模式）。

![](https://static.getiot.tech/vscode-debugging-cpp-project.png#center)

你可以在你想要停下了的地方打上断点，例如 main 函数入口。此时，调试器会在断点处暂停，你可以在左侧的窗口中查看变量的值、调用堆栈等信息。

通过 VS Code 上方的调试控制面板可以控制程序执行过程，例如单步执行、单步调试、单步跳出等。这样，你的 C/C++ 工程就调试起来啦！

:::tip

掌握 [VS Code 快捷键](/vscode/vscode-keymap/) 可以提高调试效率。

:::



## 参考资料

- [Debugging in Visual Studio Code](https://code.visualstudio.com/docs/editor/debugging)
- [Configure launch.json for C/C++ debugging in Visual Studio Code](https://code.visualstudio.com/docs/cpp/launch-json-reference)

