---
sidebar_position: 21
---

# HTML 颜色

在 HTML 中，你可以通过多种方式为网页元素设置颜色，无论是文本、背景、边框还是链接。颜色不仅能让页面更美观，还能提升可读性与用户体验。HTML 支持使用 **颜色名称**（Color Names）、**十六进制（Hex）**、**RGB / RGBA**、**HSL / HSLA** 等格式来指定颜色。



## 直接使用颜色名称

HTML 和 CSS 支持 140 种颜色名称（Color Names），这些名字是浏览器通用支持的。

例如：

```html
<p style="color:Tomato;">这是一个番茄色的段落。</p>
<p style="color:DodgerBlue;">这是一个道奇蓝的段落。</p>
<p style="color:MediumSeaGreen;">这是一个中海绿的段落。</p>
```

显示效果：

> <p class="text-tomato">这是一个番茄色的段落。</p>
> <p class="text-dodgerblue">这是一个道奇蓝的段落。</p>
> <p class="text-mediumseagreen">这是一个中海绿的段落。</p>



### 常见颜色预览

|     颜色名     |                           示例                            |
| :------------: | :-------------------------------------------------------: |
|     Tomato     |         <span class="text-tomato">Tomato</span>         |
|     Orange     |         <span class="text-orange">Orange</span>         |
|   DodgerBlue   |     <span class="text-dodgerblue">DodgerBlue</span>     |
| MediumSeaGreen | <span class="text-mediumseagreen">MediumSeaGreen</span> |
|      Gray      |           <span class="text-gray">Gray</span>           |
|   SlateBlue    |      <span class="text-slateblue">SlateBlue</span>      |
|     Violet     |         <span class="text-violet">Violet</span>         |
|   LightGray    |      <span class="text-lightgray">LightGray</span>      |

你可以在 [W3School HTML 颜色名称参考](https://www.w3school.com.cn/tags/html_ref_colornames.asp) 页面上查看所有支持的颜色名称。



## 其他颜色表示方式

除了颜色名称，你还可以使用以下方式来设置颜色：

### 十六进制颜色值（Hex）

使用 `#RRGGBB` 的格式表示颜色，例如：

```html
<p style="color:#ff6347;">这是番茄色（Tomato）</p>
```

### RGB 颜色值

```html
<p style="color:rgb(255, 99, 71);">使用 RGB 设置番茄色</p>
```

### RGBA 颜色值（带透明度）

```html
<p style="color:rgba(255, 99, 71, 0.5);">50% 透明的番茄色</p>
```

### HSL 颜色值

```html
<p style="color:hsl(9, 100%, 64%);">使用 HSL 设置番茄色</p>
```

### HSLA 颜色值（带透明度）

```html
<p style="color:hsla(9, 100%, 64%, 0.5);">50% 透明的番茄色</p>
```



## 颜色名与颜色值对照表

颜色名本质上是某种具体颜色值的别名，比如：

- `Tomato` 等价于 `#ff6347`
- `DodgerBlue` 等价于 `#1e90ff`
- `MediumSeaGreen` 等价于 `#3cb371`

这意味着你在选择颜色时，可以自由选择使用名称或数值形式，关键在于你自己的习惯与项目的风格规范。



## 小结

HTML5 提供了多种方式来设置颜色，最简单直观的就是使用颜色名称。作为初学者，你可以先熟悉常见的颜色名，掌握它们在网页中的表现，再逐步学习更灵活的颜色值写法，如十六进制、RGB、HSL 等。熟练掌握颜色设置技巧，不仅能让你的网页更好看，也能让你的前端技能更加扎实。
