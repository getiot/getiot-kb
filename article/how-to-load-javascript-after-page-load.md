---
sidebar_position: 10
slug: /how-to-load-javascript-after-page-load
---

# 页面完全加载之后再执行 JS 代码



## 方法一：使用 onload 属性

使用 window 对象的 onload 属性，例如：

```html showLineNumbers
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <title>Demo</title>
    <script>
        function init() {
            var x = document.getElementById("intro");
            x.innerHTML = "人人都懂物联网";
        }
        window.onload = init;
    </script>
</head>
<body>
    <p id="intro">Hello World</p>
</body>
</html>
```

首先创建一个名为 `init` 的函数，将 JavaScript 代码放在这个函数中，然后将 `window.onload` 属性的值设置为 `init` 函数，表示当页面完全加载时要执行这个函数中的代码。

