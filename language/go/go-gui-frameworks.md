---
sidebar_position: 37
slug: /go-gui-frameworks
---

# Go 语言 GUI 框架

本文收集并介绍一些常用的 Golang GUI 框架，包括 fyne、go-gtk、gotk3、wails 等等。虽然 Go 语言最擅长的并不是图形界面开发，但鉴于它具有优秀的性能和并发特性，许多开发者希望能够使用 Go 语言进行图形界面开发，因此也诞生了一些使用的开源 GUI 图形界面库。



## fyne

Fyne 是 Go 语言编写的跨平台 GUI 库，它基于原生 Widget 实现，为开发者提供了一个简单而强大的界面构建框架。fyne 支持 Windows、Linux 和 macOS 等操作系统，并且同时支持桌面和移动端。

fyne 的核心是一个事件驱动的渲染引擎，它可以轻松地创建具有丰富交互性的图形界面。该框架提供了丰富的内置控件，如按钮、文本框、标签、列表等，并且支持自定义控件的创建。

GitHub 仓库：[https://github.com/fyne-io/fyne](https://github.com/fyne-io/fyne)



## go-gtk

go-gtk 是 Go 语言的一个 GTK+ 绑定库，通过使用 Go 编写 GTK+ 应用程序，可以实现跨平台的图形界面。GTK+ 是一种自由、开源的图形库，提供了丰富的控件和功能，可以快速搭建各种类型的界面。

GitHub 仓库：[https://github.com/mattn/go-gtk](https://github.com/mattn/go-gtk)



## gotk3

gotk3 是 GTK+3 的一个 Go 语言绑定，通过使用 Go 编写 GTK+3 应用程序。

GitHub 仓库：[https://github.com/gotk3/gotk3](https://github.com/gotk3/gotk3)



## wails

Wails 是一个用于构建桌面应用程序的 Web 前端技术栈和 Go 后端技术栈的框架，它支持 HTML、CSS 和 JavaScript 前端技术，同时也支持 Go 语言后端技术。

GitHub 仓库：[https://github.com/wailsapp/wails](https://github.com/wailsapp/wails)



## 参考

- [Go 每日一库之 fyne](https://darjun.github.io/2020/06/15/godailylib/fyne/)
- [Go语言图形API概述及应用场景](https://www.php.cn/faq/720788.html)
