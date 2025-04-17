---
sidebar_position: 19
---

# HTML 表单

在 Web 开发中，如果你想收集用户的输入（比如姓名、邮箱、留言等），那就需要使用 **HTML 表单（Form）**。HTML 表单是与用户进行交互的关键组件。



## 表单的基本结构

HTML 表单使用 `<form>` 元素来定义。表单内部可以包含多个用于收集信息的输入字段，比如文本框、单选按钮、复选框、提交按钮等。

```html
<form action="/submit.php" method="post">
  <label for="username">用户名：</label>
  <input type="text" id="username" name="username"><br><br>
  <input type="submit" value="提交">
</form>
```

属性说明：

- `action`：指定表单数据提交的目标地址（通常是一个 PHP 文件）。
- `method`：指定提交方式，常见的有 `GET` 和 `POST`。



## 表单控件类型

### `<input>` 标签

`<input>` 是最常用的表单控件之一。它可以通过 `type` 属性表示不同的输入类型，例如：

```html
<input type="text">      <!-- 文本输入框 -->
<input type="password">  <!-- 密码框 -->
<input type="checkbox">  <!-- 复选框 -->
<input type="radio">     <!-- 单选按钮 -->
<input type="submit">    <!-- 提交按钮 -->
<input type="reset">     <!-- 重置按钮 -->
```

### `<label>` 标签

`<label>` 标签可提升表单的可访问性。当你点击 label 时，相关联的输入框也会被聚焦。

```html
<label for="email">电子邮件：</label>
<input type="email" id="email" name="email">
```

### `<textarea>` 多行文本框

用于输入多行文本内容，如留言或评论。

```html
<textarea name="message" rows="4" cols="50"></textarea>
```

### `<select>` 下拉列表

用来创建一个下拉选择菜单：

```html
<select name="fruit">
  <option value="apple">苹果</option>
  <option value="banana">香蕉</option>
  <option value="orange">橙子</option>
</select>
```



## GET 与 POST 方法的区别

| 特性         | GET                        | POST                       |
| ------------ | -------------------------- | -------------------------- |
| 数据显示     | 数据会附加在 URL 后        | 数据不会显示在 URL 中      |
| 安全性       | 较低，容易被查看           | 较高，数据封装在请求体中   |
| 数据长度限制 | 有限制（通常 2048 个字符） | 理论上无限制               |
| 用途         | 查询或从服务器获取数据     | 提交数据（如登录、注册等） |

通常，如果你在处理用户登录、评论、文件上传等敏感操作时，推荐使用 `POST` 方法。



## 示例：简单的表单页面

```html showLineNumbers
<!DOCTYPE html>
<html>
  <body>

    <h2>用户注册表单</h2>

    <form action="/register.php" method="post">
      <label for="username">用户名：</label>
      <input type="text" id="username" name="username"><br><br>

      <label for="password">密码：</label>
      <input type="password" id="password" name="password"><br><br>

      <label for="gender">性别：</label>
      <input type="radio" id="male" name="gender" value="male"> 男
      <input type="radio" id="female" name="gender" value="female"> 女<br><br>

      <label for="hobby">兴趣爱好：</label>
      <input type="checkbox" name="hobby" value="reading"> 阅读
      <input type="checkbox" name="hobby" value="travel"> 旅游
      <input type="checkbox" name="hobby" value="coding"> 编程<br><br>

      <input type="submit" value="注册">
    </form>

  </body>
</html>
```



## 表单提交的数据示例

假设你填写如下内容：

- 用户名：tom
- 密码：123456
- 性别：male
- 兴趣爱好：reading、coding

表单提交到服务器后，若使用 `POST` 方法，服务端可以通过 PHP 的 `$_POST` 数组获取这些值：

```php showLineNumbers
$username = $_POST['username'];
$password = $_POST['password'];
$gender   = $_POST['gender'];
$hobby    = $_POST['hobby']; // 如果是数组，请使用 $_POST['hobby'][] 的方式处理
```



## 表单验证

虽然详细的表单验证属于 HTML5 和 JavaScript 的高级内容，但你可以先了解一些 HTML5 内置验证功能：

- `required`：字段不能为空
- `type="email"`：要求输入合法的邮箱格式
- `min` / `max`：限定数值范围
- `pattern`：用正则表达式匹配格式

示例：

```html
<input type="email" name="email" required>
```



## 小结

HTML 表单是网页中最常用的功能之一，它允许你从用户那里收集信息并提交给服务器处理。通过 `<form>`、`<input>`、`<textarea>`、`<select>` 等标签，你可以构建各种表单类型。掌握基本的布局和属性，就能轻松搭建出实用的输入界面。了解 `GET` 和 `POST` 方法的区别，也有助于你日后更安全地处理用户数据。随着学习深入，你还可以继续了解表单验证、文件上传等进阶技巧。
