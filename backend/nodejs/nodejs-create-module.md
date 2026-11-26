---
sidebar_position: 6
slug: /nodejs-create-module
---

# 创建 Node.js 模块



通过前面 [Node 包管理器](/nodejs/nodejs-npm/) 和 [Node 封装模块](/nodejs/nodejs-packaged-module/) 的学习，相信你已经对 Node.js 有了足够的了解。那么接下来，我们将学习如何创建和发布自己的 Node 封装模块，并在 Node.js 应用程序中使用它。



## 自定义 Node.js 模块

我们准备创建一个名为 **tinycensorify** 的模块，它的功能是检查并屏蔽一些预定义的敏感词。

1、首先在 GitHub 上创建一个 [tinycensorify](https://github.com/getiot/tinycensorify) 仓库，并克隆到本地。例如：

```bash
git clone https://github.com/getiot/tinycensorify.git
```

2、切换到 tinycensorify 目录，创建一个名为 censortext.js 的文件，代码如下：

```javascript
const censoredWords = ["sad", "bad", "mad"];
const customCensoredWords = [];

function censor(inStr) {
    for (idx in censoredWords) {
        inStr = inStr.replace(censoredWords[idx], "****");
    }
    for (idx in customCensoredWords) {
        inStr = inStr.replace(customCensoredWords[idx], "****");
    }
    return inStr;
}

function addCensoredWord(word) {
    customCensoredWords.push(word);
}

function getCensoredWords() {
    return censoredWords.concat(customCensoredWords);
}

exports.censor = censor;
exports.addCensoredWord = addCensoredWord;
exports.getCensoredWords = getCensoredWords;
```

3、添加 package.json 文件，内容如下：

```json
{
    "author": "Rudy Lo",
    "name": "tinycensorify",
    "version": "0.0.1",
    "description": "Censors words out of text",
    "main": "censortext",
    "dependencies": {},
    "engines": {
        "node": "*"
    }
}
```

4、添加 README.md 文件，根据你的需要添加任何自述说明。此时的目录结构如下：

```bash
tinycensorify
├── censortext.js
├── package.json
└── README.md
```

5、在 tinycensorify 目录下执行 `npm pack` 打包 Node.js 封装模块。输出如下：

```bash
$ npm pack
npm notice 
npm notice 📦  censorify@0.0.1
npm notice === Tarball Contents === 
npm notice 502B  .vscode/settings.json
npm notice 1.1kB LICENSE              
npm notice 44B   README.md            
npm notice 604B  censortext.js        
npm notice 218B  package.json         
npm notice === Tarball Details === 
npm notice name:          censorify                               
npm notice version:       0.0.1                                   
npm notice filename:      censorify-0.0.1.tgz                     
npm notice package size:  1.4 kB                                  
npm notice unpacked size: 2.4 kB                                  
npm notice shasum:        4cee9ef0b4333f8d06e3cab91d501d905e970b36
npm notice integrity:     sha512-OY07Sdo0PdOT1[...]OVb0YxxMZR/rg==
npm notice total files:   5                                       
npm notice 
censorify-0.0.1.tgz
```

这个就是你的第一个 Node.js 模块啦！



## 将模块发布到 NPM

为了方便大家使用你的 Node.js 模块，你还可以将模块发布到 NPM 平台。步骤如下：

1、在 [npmjs.com](https://www.npmjs.com/) 注册一个账号。

2、修改 package.json 文件，添加 repository 存储库和 keywords 关键字信息。

```json
{
    "author": "Rudy Lo",
    "name": "tinycensorify",
    "version": "0.0.1",
    "description": "Censors words out of text",
    "main": "censortext",
    "repository": {
        "type": "git",
        "url": "https://github.com/getiot/tinycensorify.git"
    },
    "keywords": ["censor", "words"],
    "dependencies": {},
    "engines": {
        "node": "*"
    }
}
```

3、将 tinycensorify 目录的文件提交到 GitHub 仓库。

```bash
git add .
git commit -m "this is my first Node.js packaged module"
git push origin main
```

4、执行下面命令，并按提示输入用户名、密码和邮箱等信息，将 NPM 账户信息添加到开发环境。

```bash
npm adduser
```

5、执行下面命令，将 tinycensorify 模块发布到 NPM 平台。

```bash
npm publish
```

6、现在，打开 [NPM 网页](https://www.npmjs.com/package/tinycensorify) 搜索“tinycensorify”，就能找到你刚刚发布的包。

![](https://static.getiot.tech/nodejs-tinycensorify.png#center)

如果需要取消发布 Node 模块，可以使用 `unpublish` 命令，例如：

```bash
npm unpublish tinycensorify
```

如果无法取消发布，可以使用 `--force` 选项，例如：

```bash
npm unpublish tinycensorify --force
```



## 使用你的 Node.js 模块

有了 Node.js 模块之后，只需要两步，我们就可以在应用程序中使用它了！

1. 将模块安装到你的应用程序的结构中；
2. 使用 `require()` 方法加载该模块。

下面我们编写一个应用程序 readwords 来验证 tinycensorify 模块的功能。步骤如下：

1、首先创建一个 readwords 目录。

```bash
mkdir readwords
cd readwords
```

2、安装 tinycensorify 模块。（当然你也可以使用本地模块）

```bash
npm install tinycensorify
```

3、创建一个 readwords.js 文件。代码如下：

```javascript
var censor = require("tinycensorify");

console.log(censor.getCensoredWords());
console.log(censor.censor("Some very sad, bad and mad text."));

censor.addCensoredWord("gloomy");
console.log(censor.getCensoredWords());
console.log(censor.censor("A very gloomy day."));
```

4、运行程序。输出如下：

```bash
$ node readwords.js 
[ 'sad', 'bad', 'mad' ]
Some very ****, **** and **** text.
[ 'sad', 'bad', 'mad', 'gloomy' ]
A very **** day.
```

可以看到，预设和新增的审查词都被屏蔽了，说明 tinycensorify 模块运行正常！



