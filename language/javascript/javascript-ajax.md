---
sidebar_position: 31
---

# JavaScript AJAX 技术



虽然 AJAX 不是 JavaScript 规范的一部分，但它们的关系非常紧密，因此我们决定还是在这里介绍一下 AJAX。

**AJAX** 全称为 Asynchronous JavaScript And XML，意为异步 JavaScript 和 XML。AJAX 在不重新加载整个页面的情况下，可以与服务器交换数据并更新部分网页内容。



## 两者区别

JavaScript 是一种在客户端执行的脚本语言。AJAX 是基于 JavaScript 的一种技术，它主要用途是提供异步刷新（只刷新页面的一部分，而不是整个页面都刷新）。一个是语言，一个是技术，两者有本质区别。



## 使用示例

AJAX 的使用分为以下几个步骤。

1、**创建 XMLHttpRequest 对象**，代码如下：

```javascript showLineNumbers
var xmlhttp;
if (window.XMLHttpRequest) {
    // IE7+, Firefox, Chrome, Opera, Safari
    xmlhttp = new XMLHttpRequest();
} else {
    // IE6, IE5
    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
}
```

2、**向服务器发送请求**，代码如下：

```javascript showLineNumbers
xmlhttp.open("GET", "ajax_info.txt", true);
xmlhttp.send();
```

说明：

- open 方法中第1个参数为请求的类型（GET 或 POST），第2个参数为 URL（请求接口地址），第3个参数为是否异步处理请求（true 为异步，false 为同步）。
- send方法是将请求发送到服务器。

3、**等待 onreadystatechange 事件**

当请求被发送到服务器时，需要执行一些基于响应的任务。每当 readyState 改变时，就会触发 onreadystatechange 事件。

```javascript showLineNumbers
xmlhttp.onreadystatechange = function() {
    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
        console.log(xmlhttp.responseText);
    }
}
```

readyState 属性存有 XMLHttpRequest 的状态，并从 0 到 4 发生变化。

- 0：请求未初始化。
- 1：服务器连接已建立。
- 2：请求已接收。
- 3：请求处理中。
- 4：请求已完成，且响应已就绪。

status 属性是 http 状态码，常用的 200 表示请求成功，404 表示找不到网页，500 一般表示服务端出错。

