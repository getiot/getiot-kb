---
sidebar_position: 27
---

# HTML script 标签



向 HTML 页面中插入 JavaScript 的主要方法，就是使用 `<script>` 标签。这个标签最初由 Netscape 创造，并在 Netscape Navigator 2 中首次实现，后来被正式加入到 HTML 规范中。



## 示例

```html
<script>
document.getElementById("demo").innerHTML = "Hello JavaScript!";
</script>
```



## 属性

| 属性           | 值                                                           | 描述                                                         |
| :------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| async          | async                                                        | 指定脚本与解析页面并行下载，并在可用时立即执行（在解析完成之前）<br />注意：仅适用于外部脚本 |
| crossorigin    | anonymous<br />use-credentials                               | 将请求的模式设置为 HTTP CORS 请求                            |
| defer          | defer                                                        | 指定与解析页面并行下载脚本，并在页面解析完成后执行<br />注意：仅适用于外部脚本 |
| integrity      | *filehash*                                                   | 允许浏览器检查获取的脚本，以确保如果源已被操纵，则永远不会加载代码 |
| nomodule       | True False                                                   | 指定脚本不应在支持 ES2015 模块的浏览器中执行                 |
| referrerpolicy | no-referrer<br />no-referrer-when-downgrade<br />origin<br />origin-when-cross-origin<br />same-origin<br />strict-origin<br />strict-origin-when-cross-origin<br />unsafe-url | 指定在获取脚本时要发送的引荐来源信息                         |
| src            | *URL*                                                        | 指定外部脚本文件的 URL                                       |
| type           | *scripttype*                                                 | 指定脚本的媒体类型                                           |

