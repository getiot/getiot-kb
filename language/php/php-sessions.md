---
sidebar_position: 18
---

# PHP Sessions 会话

Session（会话）在 PHP 中是非常重要的功能，它能让你在多个页面之间保存用户数据，比如登录状态、购物车内容等，属于服务端存储机制，相比 Cookie 更安全也更灵活。本章我们就来学习 PHP Session 的相关概念和操作。

:::tip

Session 是一种在服务器端存储用户数据的机制。当用户访问网站时，服务器会为该用户创建一个唯一的会话 ID（Session ID），并通过 Cookie 将这个 ID 返回给浏览器。浏览器每次请求都会携带这个 ID，服务器就能识别出这个用户是谁。

:::



## 启动 Session

在每个需要使用 Session 的 PHP 页面开头，都要调用一次 `session_start()`。这个函数会初始化或恢复会话。

```php
<?php
session_start(); // 启动 Session
?>
```

⚠️ 注意：`session_start()` 必须在任何 HTML 输出之前调用，否则会报错！



## 设置 Session 变量

Session 使用的是 `$_SESSION` 超全局数组，你可以像操作普通数组那样设置值：

```php
<?php
session_start();
$_SESSION["username"] = "Alice";
$_SESSION["email"] = "alice@example.com";
?>
```



## 读取 Session 变量

```php
<?php
session_start();
echo "欢迎，" . $_SESSION["username"];
?>
```



## 检查 Session 是否已设置

```php
<?php
session_start();
if (isset($_SESSION["username"])) {
    echo "你好，" . $_SESSION["username"];
} else {
    echo "你尚未登录。";
}
?>
```



## 删除 Session 变量

删除某个 Session 变量可以使用 `unset()` 函数。例如：

```php
unset($_SESSION["username"]);
```



## 销毁整个 Session

如果想要销毁整个 Session 会话，可以使用 `session_destroy()` 函数。例如：

```php
<?php
session_start();
session_destroy(); // 清除所有 Session 数据
?>
```

⚠️ `session_destroy()` 只会清除服务器端的会话数据，不会清空 `$_SESSION` 数组，建议搭配 `session_unset()` 使用。



## Session 文件默认保存位置

PHP 默认会将 Session 数据保存在服务器的临时目录（如 `/tmp`）下，每个用户的 Session 对应一个 `.sess_<session_id>` 文件。

你可以通过配置 `php.ini` 或运行时设置来修改保存路径：

```php
session_save_path("/path/to/your/session/dir");
```



## Session 与 Cookie 的关系

虽然 Session 数据保存在服务器，但客户端还是需要依靠 Cookie 来存储 Session ID（默认名为 `PHPSESSID`）。

你也可以手动传递 Session ID，例如通过 URL：

```html
<a href="dashboard.php?PHPSESSID=xxxxx">进入仪表盘</a>
```

但这不安全，容易被劫持，建议总是通过 Cookie 管理 Session ID。



## 示例：简单登录机制

这个登录系统由三个核心文件组成：`login.php`、`dashboard.php` 和 `logout.php`。

**login.php - 处理登录请求**

```php showLineNumbers title="login.php"
<?php
session_start();

if ($_POST["username"] == "admin" && $_POST["password"] == "123456") {
    $_SESSION["username"] = "admin";
    echo "登录成功";
} else {
    echo "用户名或密码错误";
}
?>
```

说明：

- `session_start()`：必须在最前面调用，用来启动 Session 或恢复用户的会话数据。
- `$_POST["username"]` 和 `$_POST["password"]`：从 HTML 表单获取用户提交的数据。
- 判断用户名和密码是否为预设值（这里简单地写死为 admin / 123456）。
- 如果验证成功，就把 `username` 存入 `$_SESSION` 中。这样在后续页面中就可以识别用户身份。
- 如果验证失败，则输出错误信息。

**dashboard.php - 登录后的用户页面**

```php showLineNumbers title="dashboard.php"
<?php
session_start();
if (!isset($_SESSION["username"])) {
    echo "请先登录";
    exit;
}
echo "欢迎你，" . $_SESSION["username"];
```

说明：

- 启动 Session 后，先判断是否设置了 `$_SESSION["username"]`。
- 如果没有说明用户尚未登录，直接提示并停止脚本执行。
- 如果 Session 中存在用户名，说明用户已经登录，可以显示欢迎信息。

👉 这种做法就实现了简单的**登录访问控制**：只有登录后才能访问这个页面。

**logout.php - 用户退出登录**

```php showLineNumbers title="logout.php"
<?php
session_start();
session_unset();
session_destroy();
echo "你已退出登录";
?>
```

说明：

- `session_unset()` 会清除 `$_SESSION` 数组中的所有变量。
- `session_destroy()` 会销毁服务器上的 Session 文件，使会话彻底无效。
- 这两个函数通常配合使用，确保用户退出后无法再访问受保护页面。



## 小结

Session 是 PHP 中强大而安全的用户状态管理机制。你学会了如何用 `session_start()` 开启 Session，用 `$_SESSION` 读写数据，并掌握了销毁 Session 的方式。相比 Cookie，Session 更安全，因为它将敏感数据保存在服务器端，客户端只保留一个不可预测的 ID。

