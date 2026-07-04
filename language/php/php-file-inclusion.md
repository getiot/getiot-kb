---
sidebar_position: 15
---

# PHP 文件包含

在 PHP 中，你可以通过**文件包含函数**将一个 PHP 文件的内容嵌入到另一个文件中执行。这使得你可以将公共代码（如头部、尾部、配置文件）拆分出来，便于维护和复用。



## 使用 `include`

`include` 会在脚本中包含并运行指定文件。如果找不到该文件，**会抛出一个警告（warning）但继续执行后续代码**。

例如下面示例包含 header.php 和 index.php 两个文件。

```php showLineNumbers title="header.php"
<?php
echo "<h1>欢迎访问我的网站</h1>";
?>
```

index.php 文件中通过 `include` 引用 header.php 文件。

```php showLineNumbers title="index.php"
<?php
include("header.php");
echo "这是主页内容";
?>
```

输出结果：

```bash
欢迎访问我的网站
这是主页内容
```

如果 header.php 不存在，PHP 会提示警告，但仍会继续执行 index.php 中的其他代码。



## 使用 `require`

`require` 的用法与 `include` 相似，但更严格。如果包含的文件不存在或出错，**会抛出致命错误（fatal error）并终止脚本执行**。

例如下面示例只有 index.php 文件，而没有 header.php 文件。

```php showLineNumbers title="index.php"
<?php
require("header.php");
echo "这是主页内容";
?>
```

如果 header.php 不存在，那么页面就会直接报错，后面的内容不会被执行。



## include_once 和 require_once

有时你可能需要在多个地方包含同一个文件，但又想避免重复执行（例如函数或类重复定义）。这时你可以使用 `include_once` 或 `require_once`。

- **`include_once`**：如果文件已经被包含，则不会再次包含。
- **`require_once`**：与 `require` 相同，但也会检测是否已加载过，避免重复。

示例：

```php showLineNumbers
<?php
include_once("config.php");
include_once("config.php"); // 不会重复执行
?>
```



## 使用场景推荐

|    使用方式    | 是否中断程序 | 推荐使用场景                       |
| :------------: | :----------: | ---------------------------------- |
|   `include`    |      否      | 可选的模块（如广告模块）           |
|   `require`    |      是      | 必须的模块（如数据库配置、验证）   |
| `include_once` |      否      | 可选且避免重复加载                 |
| `require_once` |      是      | 必须且只加载一次（如函数库、类库） |



## 路径说明

你可以使用相对路径或绝对路径进行文件包含：

```php showLineNumbers
include("includes/header.php"); // 相对路径
include($_SERVER['DOCUMENT_ROOT'] . "/config/config.php"); // 绝对路径
```

在实际开发中，推荐**使用 `__DIR__` 更安全**。

```php showLineNumbers
include(__DIR__ . "/config.php");
```

`__DIR__` 是当前文件所在目录的绝对路径，推荐用于大型项目中的文件包含，防止路径混乱。



## 注意事项

- 避免用户控制包含路径，防止文件包含漏洞（File Inclusion Vulnerability）。

- 永远不要使用用户传入的参数作为 `include()` 路径：

  ```php
  // 危险做法，可能被攻击者包含恶意文件
  include($_GET["page"] . ".php");
  ```

- 推荐做法是只从白名单中选择：

  ```php
  $allowed_pages = ["about", "contact"];
  $page = $_GET["page"];
  if (in_array($page, $allowed_pages)) {
      include("pages/" . $page . ".php");
  } else {
      echo "非法页面请求";
  }
  ```



## 小结

通过文件包含，你可以轻松实现代码模块化、复用和结构分离。掌握 `include` 和 `require` 以及它们的 `_once` 版本，将让你在构建 PHP 项目时更加灵活和高效。记住合理使用路径、避免重复加载、保护好包含文件的安全，是编写高质量 PHP 代码的重要一步。
