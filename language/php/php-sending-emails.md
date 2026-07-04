---
sidebar_position: 19
---

# PHP 发送邮件

发送邮件是 PHP 的一个非常实用功能，你可以用它来实现用户注册验证、找回密码、通知提醒等功能。接下来，我们就来学习在 PHP 中如何发送邮件。本教程会带你掌握基础语法、常见用法和更强大的邮件发送库（如 PHPMailer）的使用方式。



## 使用 PHP 原生函数发送邮件

PHP 内置了一个非常基础的函数 `mail()`，可以用来发送电子邮件。语法如下：

```php
mail(to, subject, message, headers, parameters);
```

参数说明：

- `to`：收件人地址（字符串或逗号分隔的多个地址）
- `subject`：邮件主题
- `message`：邮件正文（支持换行）
- `headers`：可选，额外的邮件头部信息，如发件人、内容类型等
- `parameters`：可选，用于发送邮件时额外的参数

### 示例：使用 `mail()` 发送邮件

```php showLineNumbers
<?php
$to = "someone@example.com";
$subject = "测试邮件";
$message = "你好，这是来自 PHP 的测试邮件。";
$headers = "From: webmaster@example.com";

if (mail($to, $subject, $message, $headers)) {
    echo "邮件发送成功。";
} else {
    echo "邮件发送失败。";
}
?>
```



:::tip 注意

在 Windows 下，`mail()` 依赖本地配置的 SMTP 服务；在 Linux 上，它通常依赖 `sendmail` 或 `postfix`。很多虚拟主机支持 `mail()`，但如果在本地使用，需要配置邮件服务器或使用模拟服务。

:::



### 示例：发送 HTML 格式的邮件

要发送带格式的 HTML 邮件，你需要设置 `Content-type` 为 `text/html`：

```php showLineNumbers
<?php
$to = "someone@example.com";
$subject = "HTML 邮件示例";
$message = "
<html>
<head><title>HTML 邮件</title></head>
<body>
<p>这是带 <strong>HTML</strong> 格式的邮件！</p>
</body>
</html>
";

$headers  = "MIME-Version: 1.0" . "\r\n";
$headers .= "Content-type: text/html; charset=UTF-8" . "\r\n";
$headers .= "From: webmaster@example.com";

if (mail($to, $subject, $message, $headers)) {
    echo "HTML 邮件已发送。";
} else {
    echo "邮件发送失败。";
}
?>
```



### 为什么很多时候 `mail()` 不起作用？

可能原因包括：

1. 没有正确配置邮件服务器（尤其是本地环境）。
2. 被 SMTP 拦截或标记为垃圾邮件。
3. 发件人（From）域名与服务器不匹配。
4. 没有设置 SPF、DKIM 等反垃圾策略（尤其在正式环境）。

因此，**生产环境推荐使用邮件发送库**（例如 PHPMailer、SwiftMailer、Symfony Mailer 等）。



## 使用 PHPMailer 发送邮件

[PHPMailer](https://github.com/PHPMailer/PHPMailer) 是一个流行的邮件发送类库，支持 SMTP、附件、HTML、身份验证等，它可以更安全地发送邮件。

首先你需要安装 phpmailer，我们推荐使用 Composer 方式安装，命令如下：

```bash
composer require phpmailer/phpmailer
```

### 示例：通过 SMTP 发送邮件

```php showLineNumbers
<?php
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require 'vendor/autoload.php';

$mail = new PHPMailer(true);

try {
    // 配置 SMTP
    $mail->isSMTP();
    $mail->Host = 'smtp.example.com';  // SMTP 服务器地址
    $mail->SMTPAuth = true;
    $mail->Username = 'your_email@example.com';  // SMTP 用户名
    $mail->Password = 'your_password';           // SMTP 密码
    $mail->SMTPSecure = 'tls';                   // 加密方式：ssl 或 tls
    $mail->Port = 587;

    // 发件人和收件人
    $mail->setFrom('your_email@example.com', '你的名字');
    $mail->addAddress('recipient@example.com', '收件人姓名');

    // 邮件内容
    $mail->isHTML(true);
    $mail->Subject = 'PHPMailer 测试';
    $mail->Body    = '这是 <b>HTML</b> 格式的邮件内容！';
    $mail->AltBody = '这是纯文本内容（兼容旧邮件客户端）';

    $mail->send();
    echo '邮件已发送';
} catch (Exception $e) {
    echo "邮件发送失败：{$mail->ErrorInfo}";
}
?>
```



### 示例：发送带附件的邮件

```php showLineNumbers
$mail->addAttachment('/path/to/file.pdf', '用户手册.pdf');
```



## 小结

在这节中，你学习了如何使用 PHP 原生的 `mail()` 函数和更强大的 PHPMailer 库发送邮件。虽然 `mail()` 简单易用，但在生产环境中建议使用 PHPMailer 来处理发送 HTML、附件、SMTP 身份验证等复杂需求。邮件发送是一项敏感操作，记得保护好邮箱账号信息，并避免将敏感密码写死在代码中。
