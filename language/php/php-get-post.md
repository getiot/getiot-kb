---
sidebar_position: 13
---

# PHP GET 和 POST 请求

在 Web 开发中，HTTP 协议中的 **GET** 和 **POST** 是最常用的两种请求方式。你通过 HTML 表单提交的数据，或是用户在浏览器地址栏中输入的查询参数，都会以这两种方式被发送给服务器。

PHP 提供了两个超级全局数组 `$_GET` 和 `$_POST` 来接收这些数据。



## GET 请求

PHP 中 GET 请求的特点：

- 数据附加在 URL 后（通过 `?` 分隔参数）。
- 请求参数可直接在浏览器地址栏中看到。
- 适用于获取资源、查询操作。
- 有长度限制（受浏览器和服务器限制，一般为 2048 字符以内）。

**示例：HTML 表单使用 GET 方法**

```html showLineNumbers
<form action="welcome.php" method="get">
  姓名: <input type="text" name="name">
  年龄: <input type="text" name="age">
  <input type="submit" value="提交">
</form>
```

welcome.php 实现接收数据的功能：

```php showLineNumbers title="welcome.php"
<?php
$name = $_GET["name"];
$age = $_GET["age"];

echo "你好，$name，你今年 $age 岁。";
?>
```

提交后的 URL 示例：

```bash
http://example.com/welcome.php?name=小明&age=18
```



## POST 请求

PHP 中 POST 请求的特点：

- 数据不会显示在 URL 中，而是封装在请求体（body）中。
- 更安全（相比 GET），适合提交表单、发送敏感信息（如密码）。
- 没有长度限制（受服务器设置约束，一般很大）。
- 不会被缓存，也不会保留在浏览器历史记录中。

**示例：HTML 表单使用 POST 方法**

```html showLineNumbers
<form action="welcome.php" method="post">
  用户名: <input type="text" name="username">
  密码: <input type="password" name="password">
  <input type="submit" value="登录">
</form>
```

welcome.php 实现接收数据的功能：

```php showLineNumbers title="welcome.php"
<?php
$username = $_POST["username"];
$password = $_POST["password"];

echo "欢迎，$username！";
?>
```



## 超级全局数组 `$_REQUEST`

PHP 还提供了一个 `$_REQUEST` 数组，它可以同时接收 GET 和 POST 参数（以及 COOKIE）。

```php showLineNumbers
<?php
echo $_REQUEST["username"];
?>
```

但**不建议使用**该方式，因为来源不确定，可能带来安全隐患。



## GET 和 POST 的区别对比

| 项目           | GET                      | POST                            |
| -------------- | ------------------------ | ------------------------------- |
| 数据位置       | URL 地址栏中             | HTTP 请求体中                   |
| 可见性         | 可见，容易被复制和分享   | 不可见，适合敏感数据            |
| 数据长度限制   | 有（如 2048 字符）       | 无明显限制（取决于服务器配置）  |
| 安全性         | 较差，容易被篡改         | 相对更安全（仍需防护 XSS/CSRF） |
| 使用场景       | 查询、搜索、分页、导航等 | 登录、提交表单、修改数据等      |
| 浏览器缓存支持 | 支持                     | 不支持                          |
| 历史记录       | 会记录参数               | 不记录请求体数据                |



## 判断 GET 和 POST 请求

如果你想区分当前请求是 GET 还是 POST，可以通过 `$_SERVER['REQUEST_METHOD']` 来判断。例如：

```php showLineNumbers
<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    echo "你提交了一个 POST 请求";
} elseif ($_SERVER["REQUEST_METHOD"] == "GET") {
    echo "你发起了一个 GET 请求";
}
?>
```



## 获取完整请求数据

如果你通过 AJAX 或 Fetch API 发送 JSON 数据，可以使用以下方式获取：

```php showLineNumbers
<?php
$data = json_decode(file_get_contents("php://input"), true);
echo $data["message"];
?>
```



## 小结

PHP 中的 `$_GET` 和 `$_POST` 是你与前端数据交互的桥梁。GET 适合查询类操作，POST 更适合提交和修改类操作。理解它们的区别、应用场景与安全风险，是开发稳定 Web 应用的关键。学会判断请求类型、转义用户输入，将使你的 PHP 项目更加健壮安全。
