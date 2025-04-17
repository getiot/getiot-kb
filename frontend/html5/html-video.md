---
sidebar_position: 26
---

# HTML 视频

HTML5 为网页添加视频内容提供了原生的支持。通过 `<video>` 标签，你可以在网页中嵌入视频文件，并为用户提供基本的播放控制。本文将带你了解如何使用 HTML5 视频标签，如何配置视频播放，以及如何处理不同的视频格式。



## 什么是 `<video>` 标签？

`<video>` 标签用于在网页中嵌入视频文件，允许你在网页上直接播放视频，而无需任何额外插件（如 Flash）。HTML5 的 `<video>` 标签提供了简单的方式来控制视频的播放、暂停、音量等。

基本的 `<video>` 标签格式如下：

```html
<video src="https://static.getiot.tech/video/example.mp4" controls></video>
```

在这个例子中，`src` 属性指定了视频文件的位置，而 `controls` 属性提供了播放、暂停、音量控制等基本控件。

显示效果：

<video src="https://static.getiot.tech/video/example.mp4" controls></video>



## `<video>` 标签的常用属性

### 1. `src` 属性

`src` 属性用于指定视频文件的路径。你可以使用本地文件，也可以使用外部链接。常见的视频格式有 MP4、WebM 和 Ogg 等。

```html
<video src="example.mp4" controls></video>
```

### 2. `controls` 属性

`controls` 属性用于添加视频播放器的控制面板，如播放、暂停、音量调节等。当你添加 `controls` 属性时，浏览器会自动显示视频播放器的默认界面。

```html
<video src="example.mp4" controls></video>
```

### 3. `autoplay` 属性

`autoplay` 属性让视频文件在页面加载后自动播放。请注意，自动播放可能会影响用户体验，建议在不干扰用户操作的情况下使用。

```html
<video src="example.mp4" autoplay></video>
```

### 4. `loop` 属性

`loop` 属性使视频在播放完毕后自动重新开始，形成循环播放。

```html
<video src="example.mp4" loop></video>
```

### 5. `muted` 属性

`muted` 属性用于将视频的音量设置为静音，通常与 `autoplay` 一起使用，以确保页面加载时不会发出声音。

```html
<video src="example.mp4" autoplay muted></video>
```

### 6. `preload` 属性

`preload` 属性告诉浏览器在页面加载时是否预加载视频文件。它有三个值可选：

- `auto`：浏览器将尽量预加载整个视频文件。
- `metadata`：仅加载视频的元数据（如时长、尺寸等）。
- `none`：不预加载任何数据。

```html
<video src="example.mp4" preload="auto"></video>
```

### 7. `poster` 属性

`poster` 属性用于在视频开始播放前显示一张图片，作为视频的封面图。这对于未加载视频时，可以提供一个预览图。

```html
<video src="example.mp4" poster="thumbnail.jpg" controls></video>
```



## 多格式视频支持

为了确保视频在所有浏览器中都能正常播放，通常建议提供多种格式的视频文件。例如，你可以同时提供 MP4、WebM 和 Ogg 格式的视频文件：

```html
<video controls>
    <source src="example.mp4" type="video/mp4">
    <source src="movie.webm" type="video/webm">
    <source src="movie.ogv" type="video/ogg">
    Your browser does not support the video element.
</video>
```

这样，如果浏览器不支持某个格式，它会尝试播放下一个格式，直到找到可播放的格式为止。



## 视频事件

HTML5 `<video>` 元素支持多个事件，你可以在视频播放过程中执行一些操作。例如，你可以监听 `play`、`pause`、`ended` 等事件，以便进行自定义的交互。

```html
<video id="myVideo" src="example.mp4" controls></video>
<script>
    var video = document.getElementById("myVideo");
    video.onplay = function() {
        console.log("视频开始播放");
    };
    video.onended = function() {
        console.log("视频播放完毕");
    };
</script>
```



## 小结

HTML5 `<video>` 标签提供了一种简单的方式来在网页中嵌入视频。通过使用 `src`、`controls`、`autoplay` 等属性，你可以轻松控制视频的播放方式。在开发网页时，使用 HTML5 视频标签不仅能够提升用户体验，还能避免使用过时的插件（如 Flash）。为了确保兼容性，最好提供多个视频格式，以便在各种浏览器中正常播放。在实际应用中，你可以通过 `poster`、`loop`、`muted` 等属性进一步优化视频播放效果，创造更丰富的互动体验。
