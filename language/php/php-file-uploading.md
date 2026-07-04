---
sidebar_position: 16
---

# PHP 文件上传

你可以使用 PHP 接收表单上传的文件，然后保存到服务器指定目录。上传文件通常通过 HTML 表单 + PHP 脚本实现，核心是使用 `$_FILES` 这个超级全局变量。



## 创建 HTML 上传表单

你需要一个带有 `enctype="multipart/form-data"` 属性的表单，这是上传文件的必要设置。

```html showLineNumbers
<form action="upload.php" method="post" enctype="multipart/form-data">
  选择文件上传：
  <input type="file" name="myfile">
  <input type="submit" value="上传文件">
</form>
```



## 处理上传的 PHP 脚本

```php showLineNumbers title="upload.php"
<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if (isset($_FILES["myfile"]) && $_FILES["myfile"]["error"] == 0) {
        $fileName = $_FILES["myfile"]["name"];
        $fileTmp = $_FILES["myfile"]["tmp_name"];
        $fileSize = $_FILES["myfile"]["size"];
        $fileType = $_FILES["myfile"]["type"];

        $uploadDir = "uploads/";
        $targetPath = $uploadDir . basename($fileName);

        // 检查 uploads 目录是否存在
        if (!is_dir($uploadDir)) {
            mkdir($uploadDir, 0755, true);
        }

        // 将文件移动到目标目录
        if (move_uploaded_file($fileTmp, $targetPath)) {
            echo "文件上传成功：" . $fileName;
        } else {
            echo "上传失败";
        }
    } else {
        echo "上传出错：" . $_FILES["myfile"]["error"];
    }
}
?>
```



## `$_FILES` 字段说明

下表列出 `$_FILES` 的重要字段及其说明。

| 字段名                          | 含义                                 |
| :------------------------------ | ------------------------------------ |
| `$_FILES['myfile']['name']`     | 上传文件的原始名称                   |
| `$_FILES['myfile']['type']`     | MIME 类型（例如 image/png）          |
| `$_FILES['myfile']['tmp_name']` | 临时存储路径（在服务器上的缓存文件） |
| `$_FILES['myfile']['error']`    | 错误代码（0 表示无错误）             |
| `$_FILES['myfile']['size']`     | 文件大小（单位：字节）               |



## 文件上传限制

你可以通过 `php.ini` 修改以下配置来限制上传的文件大小。

```ini showLineNumbers
file_uploads = On               ; 开启文件上传
upload_max_filesize = 2M        ; 单个文件最大限制
post_max_size = 8M              ; 表单提交总大小限制
```

⚠️ 如果上传超出大小限制，`$_FILES` 会为空，或者出现错误码 1、2。



## 添加文件类型与大小验证

你应始终校验上传文件的类型与大小，防止上传恶意脚本。

```php showLineNumbers
$allowedTypes = ['image/jpeg', 'image/png', 'application/pdf'];
$maxSize = 2 * 1024 * 1024; // 2MB

if (!in_array($fileType, $allowedTypes)) {
    die("不支持的文件类型");
}

if ($fileSize > $maxSize) {
    die("文件太大，不能超过 2MB");
}
```



## 获取扩展名并改名保存

为避免重名或文件覆盖，你可以使用 `pathinfo()` 获取扩展名，然后用 `uniqid()` 为文件重新命名。例如：

```php showLineNumbers
$ext = pathinfo($fileName, PATHINFO_EXTENSION);
$newName = uniqid("file_", true) . "." . $ext;
$targetPath = $uploadDir . $newName;
```



## 上传多个文件

表单中添加 `multiple` 属性：

```html showLineNumbers
<input type="file" name="myfiles[]" multiple>
```

在 PHP 中循环处理：

```php showLineNumbers
foreach ($_FILES["myfiles"]["tmp_name"] as $index => $tmpName) {
    $name = $_FILES["myfiles"]["name"][$index];
    move_uploaded_file($tmpName, "uploads/" . $name);
}
```



## 防止 CSRF 攻击（安全推荐）

上传表单建议加入 CSRF Token 验证，防止恶意伪造请求。

在 HTML 表单中添加 `csrf_token`：

```html showLineNumbers
<input type="hidden" name="csrf_token" value="<?php echo $_SESSION['csrf_token']; ?>">
```

然后在 PHP 上传脚本中验证：

```php showLineNumbers
if ($_POST['csrf_token'] !== $_SESSION['csrf_token']) {
    die("非法请求！");
}
```



## 小结

PHP 文件上传是一个实用又安全敏感的功能。你学会了使用 `$_FILES` 处理上传表单，掌握了如何验证类型、大小、重命名以及批量上传文件。记得始终关注安全性，做好类型检查和路径管理，防止潜在的安全问题。
