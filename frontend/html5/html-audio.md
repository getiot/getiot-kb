---
sidebar_position: 25
---

# HTML 音频

HTML5 为网页添加音频内容提供了原生的支持。使用 `<audio>` 标签，你可以轻松地在网页中嵌入音频文件，供用户播放。本文将带你了解如何使用 HTML5 音频标签，以及如何配置和控制音频播放。



## 什么是 `<audio>` 标签？

`<audio>` 标签用于在网页中嵌入音频文件，它允许你播放音频内容而不需要任何插件（如 Flash）。你可以直接嵌入音频文件，或者使用一些属性来控制音频的播放方式。

基本的音频标签格式如下：

```html
<audio src="https://static.getiot.tech/audio/example.mp3" controls></audio>
```

在这个例子中，`src` 属性指定了音频文件的位置，而 `controls` 属性则提供了播放、暂停和音量控制的控件。

显示效果：

<audio src="https://static.getiot.tech/audio/example.mp3" controls></audio>



## `<audio>` 标签的常用属性

### 1. `src` 属性

`src` 属性用于指定音频文件的路径，可以是本地文件，也可以是外部链接。支持多种音频格式，包括 MP3、OGG 和 WAV 等。

例如：

```html
<audio src="example.mp3" controls></audio>
```

### 2. `controls` 属性

`controls` 属性用于添加音频播放器的控制面板，如播放、暂停、音量调节等。当你添加 `controls` 属性时，浏览器会自动显示默认的音频播放器界面。

```html
<audio src="example.mp3" controls></audio>
```

### 3. `autoplay` 属性

`autoplay` 属性让音频文件在页面加载后自动播放。请注意，使用 `autoplay` 时，可能会影响用户体验，因此建议在不干扰用户操作的情况下使用。

```html
<audio src="example.mp3" autoplay></audio>
```

### 4. `loop` 属性

`loop` 属性使音频文件在播放完毕后自动重新开始，形成循环播放。

```html
<audio src="example.mp3" loop></audio>
```

### 5. `muted` 属性

`muted` 属性可以让音频播放时默认静音。通常与 `autoplay` 一起使用，以确保页面加载时不会发出声音。

```html
<audio src="example.mp3" autoplay muted></audio>
```

### 6. `preload` 属性

`preload` 属性告诉浏览器在页面加载时是否预加载音频文件。它有三个可能的值：

- `auto`：浏览器将尽量预加载整个音频文件。
- `metadata`：仅加载音频文件的元数据（如时长等）。
- `none`：不预加载任何数据。

```html
<audio src="example.mp3" preload="auto"></audio>
```



## 多格式音频支持

不同浏览器支持不同的音频格式，因此为了确保音频在所有浏览器中都能正常播放，通常建议提供多个音频格式。例如，你可以同时提供 MP3、OGG 和 WAV 格式的音频文件：

```html
<audio controls>
    <source src="example.mp3" type="audio/mp3">
    <source src="example.ogg" type="audio/ogg">
    <source src="example.wav" type="audio/wav">
    Your browser does not support the audio element.
</audio>
```

这样，如果浏览器不支持某个格式，它会尝试播放下一个格式，直到找到可播放的格式为止。



## 音频事件

HTML5 `<audio>` 元素支持多个事件，这些事件可以用来在播放过程中触发一些操作。例如，你可以监听 `play`、`pause`、`ended` 等事件，进行一些自定义的交互。

```html
<audio id="myAudio" src="example.mp3" controls></audio>
<script>
    var audio = document.getElementById("myAudio");
    audio.onplay = function() {
        console.log("音频开始播放");
    };
    audio.onended = function() {
        console.log("音频播放完毕");
    };
</script>
```



## 小结

HTML5 的 `<audio>` 标签为网页提供了简便的音频播放功能。你可以通过 `src` 属性指定音频文件，通过 `controls` 属性为用户提供控制面板，还可以使用其他属性如 `autoplay`、`loop`、`muted` 等来定制音频的播放方式。为了兼容不同浏览器，提供多个音频格式是一个好的实践。在开发网页时，掌握 HTML5 音频标签的使用可以让你轻松添加音频功能，提升用户体验。
