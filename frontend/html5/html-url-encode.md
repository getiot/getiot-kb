---
sidebar_position: 23
---

# HTML URL 编码

在 Web 开发中，URL 编码是一个常见的概念，它用于将一些特殊字符转换为 URL 安全的格式。这样做的目的是确保 URL 在传输过程中不被误解或损坏。

## URL 简介

URL 是 Uniform Resource Locators 的缩写，中文名**统一资源定位符**。

URL 可以由字母组成，由网络协议和域名或 IP 地址等多个部分组成，如 "example.com"，或互联网协议（IP）地址：192.68.20.50。你可以简单直观地认为 URL 就是一个网页地址，我们通常都是通过 URL 来进入访问某个网站。

![](https://static.getiot.tech/uniform-resource-locator-example.jpg#center-500)

工作原理：

- Web 浏览器通过 URL 从 Web 服务器请求页面。
- 当我们点击 HTML 页面中的某个链接时，对应的 `<a>` 标签指向万维网上的一个地址。
- 一个统一资源定位符（URL）用于定位万维网上的文档。



## URL 语法规则

```bash
[scheme]://[host|domain][:port]/[path/filename]
```

下表是对 URL 各个组成部分的解释：

|     段     | 描述                                                         |
| :--------: | ------------------------------------------------------------ |
|  `scheme`  | 定义因特网服务的类型，简称协议类型，最常见的类型是 http      |
|   `host`   | 定义域主机（http 的默认主机是 www）                          |
|  `domain`  | 定义因特网域名，比如 getiot.tech                             |
|  `:port`   | 定义主机上的端口号（http 的默认端口号是 80）                 |
|   `path`   | 定义服务器上的路径（如果省略，则文档必须位于网站的根目录中） |
| `filename` | 定义文档/资源的名称                                          |



### 常见的 URL Scheme

下表列出了一些常见的 URL 协议类型。

| Scheme |        访问        |               描述                |
| :----: | :----------------: | :-------------------------------: |
|  http  |   超文本传输协议   | 以 http:// 开头的普通网页，不加密 |
| https  | 安全超文本传输协议 |    安全网页，加密所有信息交换     |
|  ftp   |    文件传输协议    |    用于将文件下载或上传至网站     |
|  file  |    电脑上的文件    |        访问计算机上的文件         |



## URL 字符编码

URL 只能使用 [ASCII 字符集](/computerbasics/ascii/) 来通过因特网进行发送，由于 URL 常常会包含 ASCII 集合之外的字符，URL 必须转换为有效的 ASCII 格式。这个过程就称为“URL 编码”（也叫百分号编码），即将 URL 中的一些字符（例如空格、特殊符号）转换为符合 URL 格式的编码。

URL 编码使用百分号（`%`）其后跟随两位的十六进制数来替换非 ASCII 字符。例如：

1. 空格（` `）会被编码为 `%20`
2. `&` 会被编码为 `%26`

这样做是为了避免 URL 中的特殊字符与 URL 中其他部分产生冲突，特别是当你需要传递数据时。



### 为什么需要 URL 编码？

1. **保证 URL 的有效性**：某些字符在 URL 中有特殊意义，比如 `?`、`&`、`=` 等。如果你想在 URL 中使用这些字符作为数据的一部分，就必须进行编码。
2. **支持非 ASCII 字符**：URL 编码还可以将非 ASCII 字符（比如中文、日文等）转化为 URL 可接受的格式。例如，中文字符 `你好` 会被编码为 `%E4%BD%A0%E5%A5%BD`。
3. **避免冲突和错误**：URL 编码可以避免字符与 URL 的其他部分冲突，确保数据能够正确传输。



### 常见 URL 编码列表

HTML5 中的默认字符集为 UTF-8，以下 URL 编码均为 UTF-8 编码。

| 字符  | URL 编码 | 字符 | URL 编码 | 字符 | URL 编码 |
| :---: | :------: | :--: | :------: | :--: | :------: |
| space |  `%20`   |  *   |  `%2A`   |  €   |  `%80`   |
|   !   |  `%21`   |  +   |  `%2B`   |  £   |  `%A3`   |
|   "   |  `%22`   |  ,   |  `%2C`   |  ©   |  `%A9`   |
|  \#   |  `%23`   |  \-  |  `%2D`   |  ®   |  `%AE`   |
|   $   |  `%24`   |  .   |  `%2E`   |  À   |  `%C0`   |
|   %   |  `%25`   |  /   |  `%2F`   |  Á   |  `%C1`   |
|   &   |  `%26`   |  :   |  `%3A`   |  Â   |  `%C2`   |
|   '   |  `%27`   |  ;   |  `%3B`   |  Ã   |  `%C3`   |
|   (   |  `%28`   |  =   |  `%3D`   |  Ä   |  `%C4`   |
|   )   |  `%29`   |  ?   |  `%3F`   |  Å   |  `%C5`   |

如果想要了解详细的 URL 编码，可以访问我们的 [URL 编码参考手册](https://www.w3school.com.cn/tags/html_ref_urlencode.asp)。



## 如何进行 URL 编码？

URL 编码的过程实际上是将字符转换成由 `%` 和两位十六进制数字组成的格式。你可以使用 `encodeURIComponent()` 和 `encodeURI()` 两个 JavaScript 函数来进行编码。

### 使用 JavaScript 编码

`encodeURIComponent()`：用于编码单个组件（如查询字符串中的值）。例如：

```javascript showLineNumbers
var str = "你好，世界!";
var encodedStr = encodeURIComponent(str);
console.log(encodedStr); // 输出: %E4%BD%A0%E5%A5%BD%EF%BC%8C%E4%B8%96%E7%95%8C%21
```

`encodeURI()`：用于编码整个 URL，保留一些 URL 中有特殊意义的字符（如 `?`、`&`）。例如：

```javascript showLineNumbers
var url = "https://www.example.com/search?query=你好，世界!";
var encodedUrl = encodeURI(url);
console.log(encodedUrl); // 输出: https://www.example.com/search?query=%E4%BD%A0%E5%A5%BD%EF%BC%8C%E4%B8%96%E7%95%8C%21
```

### 使用 PHP 编码

在 PHP 中，你可以使用 `urlencode()` 函数来编码 URL。

```php showLineNumbers
<?php
$str = "你好，世界!";
$encodedStr = urlencode($str);
echo $encodedStr; // 输出: %E4%BD%A0%E5%A5%BD%EF%BC%8C%E4%B8%96%E7%95%8C%21
?>
```



## 如何进行 URL 解码？

URL 解码是 URL 编码的逆操作，通常用于将编码后的 URL 恢复为原始字符。你可以使用 `decodeURIComponent()` 和 `decodeURI()` 来进行解码。

### 使用 JavaScript 解码

`decodeURIComponent()`：用于解码单个 URL 组件。

```javascript showLineNumbers
var encodedStr = "%E4%BD%A0%E5%A5%BD%EF%BC%8C%E4%B8%96%E7%95%8C%21";
var decodedStr = decodeURIComponent(encodedStr);
console.log(decodedStr); // 输出: 你好，世界!
```

`decodeURI()`：用于解码整个 URL。

```javascript showLineNumbers
var encodedUrl = "https://www.example.com/search?query=%E4%BD%A0%E5%A5%BD%EF%BC%8C%E4%B8%96%E7%95%8C%21";
var decodedUrl = decodeURI(encodedUrl);
console.log(decodedUrl); // 输出: https://www.example.com/search?query=你好，世界!
```

### 使用 PHP 解码

在 PHP 中，你可以使用 `urldecode()` 函数来解码 URL。

```php showLineNumbers
<?php
$encodedStr = "%E4%BD%A0%E5%A5%BD%EF%BC%8C%E4%B8%96%E7%95%8C%21";
$decodedStr = urldecode($encodedStr);
echo $decodedStr; // 输出: 你好，世界!
?>
```



## 小结

URL 编码是 Web 开发中不可或缺的一个步骤，尤其是在处理 URL 中的特殊字符和非 ASCII 字符时。掌握 URL 编码和解码的技术，你就能确保在处理表单数据、传递查询参数以及构建动态 URL 时，数据不会丢失或发生错误。记住，`encodeURIComponent()` 和 `encodeURI()` 是 JavaScript 中常用的编码工具，而 PHP 中的 `urlencode()` 和 `urldecode()` 函数则是处理 URL 编码的好帮手。



