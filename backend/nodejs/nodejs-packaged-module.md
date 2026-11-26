---
sidebar_position: 5
slug: /nodejs-packaged-module
---

# Node 封装模块



## 概述

Node.js 框架的最强大功能之一是能够轻松使用 [NPM](/nodejs/nodejs-npm/)（Node 包管理器）安装各种各样的 **Node 封装模块**（Node Packaged Module）。

所谓的“Node 封装模块”，其实就是一个按照 Node.js 规定打包的 JavaScript 库。这样就可以很容易地在不同的项目中被分享、重用和安装。Node 封装模块由许多不同的第三方机构创建，Node.js 社区每天都有许多模块被新增或更新，为 Node.js 框架提供了各式各样的功能。



## Node 模块组成

每个 Node 封装模块都包括一个 package.json 文件，它包含了 Node 模块的元数据信息，如名称、版本、作者和贡献者，以及控制元数据，比如依赖和当执行诸如安装与发布动作时，Node 包管理器将使用的其他要求。



### package.json 文件

所有 Node 模块必须在其根目录中包含一个 package.json 文件，是用于定义模块及其依赖关系的一个简单的 JSON 文本文件。该文件可以包含多个不同的指令来告诉 Node 包管理器如何处理模块。

下面是一个包含名称、版本、描述和依赖关系的 package.json 文件的例子：

```json
{
    "name": "my_module",
    "version": "0.1.0",
    "description": "a simple node.js module",
    "dependencies": {
        "express": "latest"
    }
}
```

其中，必需的指令只有名称（name）和版本（version），其余可以按需添加。如果执行 `npm install` 命令没有指定模块，那么 npm 会查找 package.json 文件，根据依赖关系安装模块。

下面是 package.json 文件中各指令的说明和示例。

**name** 是包的唯一名字，例如：

```json
"name": "getiot"
```

**preferGlobal** 表示该模块更倾向于在全局范围内安装，例如：

```json
"preperGlobal": true
```

**version** 是该模块的版本，例如：

```json
"version": 0.0.1
```

**author** 是项目的作者，例如：

```json
"author": "rudy@getiot.tech"
```

**description** 是模块的文字说明，例如：

```json
"description": "a peace planet"
```

**contributors** 是模块的其他贡献者，例如：

```json
"contributors": [{
    "name": "tina",
    "email": "tina@getiot.tech"
}]
```

**bin** 表示随项目安装的二进制文件，例如：

```json
"bin": {
    "excalibur": "./bin/flower"
}
```

**scripts** 表示启动 Node 时执行的控制台应用程序的参数，例如：

```json
"scripts": {
    "start": "node ./bin/flower",
    "test": "echo testing"
}
```

**main** 表示应用程序的主入口点，它可以是一个二进制或 .js 文件，例如：

```json
"main": "./bin/flower"
```

**repository** 表示存储库类型和包的位置，例如：

```json
"repository": {
    "type": "git",
    "location": "https://github.com/getiot/xxx.git"
}
```

**keywords** 表示出现在 `npm search` 中的关键词，例如：

```json
"keywords": [ "iot", "sensor" ]
```

**dependencies** 表示此模块依赖的模块和版本，可以使用 `*` 和 `x` 通配符，例如：

```json
"dependencies": {
    "express": "latest",
    "connect": "2.x.x",
    "cookies": "*"
}
```

**engines** 表示此包可使用的 Node 版本，例如：

```json
"engines": {
    "node": ">=0.6"
}
```

