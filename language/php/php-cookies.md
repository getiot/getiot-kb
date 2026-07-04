---
sidebar_position: 17
---

# PHP Cookies 设置和使用

Cookies（中文常称“浏览器小甜饼”🍪）是 Web 开发中常用的机制，用来在客户端（浏览器）保存少量数据，比如用户登录状态、偏好设置等。在 PHP 中，你可以很方便地创建、读取和删除 Cookies。接下来我们就详细讲解一下！

:::tip

Cookies 是存储在客户端的小数据文件，通常由服务器通过 HTTP 响应头设置，浏览器下次访问时会自动带上这些信息。

:::



## 设置 Cookie

在 PHP 中使用 `setcookie()` 来发送 Cookie 到浏览器。**注意：必须在输出任何内容之前调用，否则会报错！**

**基本语法：**

```php
setcookie(name, value, expire, path, domain, secure, httponly);
```

**最常用的参数：**

- `name`：Cookie 名称（字符串）
- `value`：Cookie 值（字符串）
- `expire`：过期时间（时间戳，单位为秒）
- `path`：指定 Cookie 可用的路径（默认为 `/`）
- 其余参数可选，通常用于增强安全性

**示例：设置一个简单的 Cookie**

```php
<?php
// 设置一个名为 user 的 cookie，有效期为 1 小时
setcookie("user", "Alice", time() + 3600);
?>
```



## 读取 Cookie

你可以通过 `$_COOKIE` 超全局数组来访问已设置的 Cookie。例如：

```php
<?php
if (isset($_COOKIE["user"])) {
    echo "欢迎回来，" . $_COOKIE["user"];
} else {
    echo "你好，新朋友！";
}
?>
```



## 修改 Cookie

修改 Cookie 的方式其实就是**重新调用 `setcookie()`** 一次，使用相同的名称。例如：

```php
setcookie("user", "Bob", time() + 3600); // 将 user 改为 Bob
```

浏览器会用新值覆盖旧值。



## 删除 Cookie

删除 Cookie 的方法是将其过期时间设置为过去。例如：

```php
setcookie("user", "", time() - 3600);
```

这会告诉浏览器立即删除名为 `user` 的 Cookie。



## 设置 Cookie 的路径和域名

**限制 Cookie 的作用路径：**

```php
setcookie("theme", "dark", time() + 3600, "/user");
```

这个 Cookie 只有在访问 `/user` 路径或子路径时才会生效。

**限定子域名：**

```php
setcookie("test", "1", time() + 3600, "/", ".example.com");
```

这样 `test` Cookie 在 `www.example.com`、`blog.example.com` 等子域都可用。



## 增强安全性

在 PHP 中，可以使用 `httponly` 和 `secure` 增强安全性。例如：

```php
setcookie("token", "abc123", time() + 3600, "/", "", true, true);
```

- 第 6 个参数 `secure=true`：只通过 HTTPS 发送；
- 第 7 个参数 `httponly=true`：JavaScript 无法访问此 Cookie，防止 XSS 攻击。



## 完整示例

下面是一个演示 PHP 中设置、读取、删除 Cookie 的完整示例。

```php showLineNumbers
<?php
// 设置 cookie（必须在 HTML 输出之前）
setcookie("lang", "zh-CN", time() + 86400); // 保存一天

// 读取 cookie
if (isset($_COOKIE["lang"])) {
    echo "你的语言偏好是：" . $_COOKIE["lang"];
} else {
    echo "语言偏好未设置。";
}

// 删除 cookie
setcookie("lang", "", time() - 3600);
?>
```



## Cookie 和 Session

在 Web 开发中，Session 是另一个常见的词，常和 Cookie 一起出现。下面是 Cookie 和 Session 的简单对比，你可以看到它们的核心区别。

| 特点     | Cookie           | Session              |
| -------- | ---------------- | -------------------- |
| 存储位置 | 客户端（浏览器） | 服务端               |
| 安全性   | 相对较低         | 更安全               |
| 存储容量 | 小（一般 4KB）   | 可以更大             |
| 生命周期 | 可持久化         | 通常随浏览器关闭失效 |
| 可见性   | 用户可见并可修改 | 用户不可见           |



## 小结

在 PHP 中操作 Cookie 十分简单，你只需要使用 `setcookie()` 设置，`$_COOKIE` 读取，通过修改过期时间即可删除。别忘了 `setcookie()` 要在输出内容之前调用！同时合理使用 `httponly` 和 `secure` 参数，有助于提高应用的安全性。

