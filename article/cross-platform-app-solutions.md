---
sidebar_position: 12
slug: /cross-platform-app-solutions
---

# 跨平台 App 方案对比



根据原理划分，目前的主流跨平台方案可以分为四大类。

1. 原生浏览器 + H5 的 Hybrid 技术（如：Cordova、Ionic、微信小程序）
2. JavaScript 开发 + 原生组件渲染（如：React Native、Weex、快应用）
3. 自绘 UI + 原生组件（如：Flutter）
4. 增强版 Web App（如：PWA）



## H5 + 原生混合开发

这种模式又称为 **Hybrid 开发**，现在很多 App 都用这种模式去开发，常见的有微信、淘宝、美团、爱奇艺等知名移动应用等。国内也有很多公司使用 Hybrid 模式去开发平台，供开发者使用，像 Dcloud、AppCan、Inoic 等，基本上都是参考 Cordova 衍生出的混合开发框架。

这类框架主要原理就是将 APP 的一部分需要动态变动的内容通过 H5 来实现，通过原生的网页加载控件 WebView（Android）或 WKWebView（iOS）来加载。这样的话，H5 部分就可以随时改变而不用发布版本，解决了动态化的需求。并且由于 H5 代码只需要一次开发，就能同时在 Android 和 iOS 两个平台运行，这也可以减小开发成本。采用混合模式开发的 App 我们称之为**混合应用**或 **Hybrid App**。

由于原生开发可以访问平台所有功能，而混合开发中，H5 代码是运行在 WebView 中，而 **WebView 实质上就是一个浏览器内核，其 JavaScript 代码依然运行在一个权限受限的沙箱中**。因此许多系统功能都没有访问权限，比如无法访问文件系统、不能使用蓝牙等。所以，对于 H5 不能实现的功能，都需要原生去做。而混合框架一般都会在原生代码中预先实现一些访问系统能力的 API，然后暴露给 WebView 以供 JavaScript 调用，这样一来，**WebView 就成为了 JavaScript 与原生 API 之间通信的桥梁**，主要负责 JavaScript 与原生之间传递调用消息，而消息的传递必须遵守一个标准的协议，它规定了消息的格式与含义，我们把依赖于 WebView 的用于在 JavaScript 与原生之间通信并实现了某种消息传输协议的工具称之为 **WebView JavaScript Bridge**, 简称 **JsBridge**，它也是**混合开发框架的核心**。

混合应用的优点是动态内容是 H5，使用 Web 技术栈就可以开发，社区及资源丰富，缺点是性能不好，对于复杂用户界面或动画，WebView 不堪重任。



## JavaScript 开发 + 原生渲染

这类开源框架的代表主要是 Facebook 的 React Native、阿里的 Weex，当然也有未开源的美团的 Picasso，以及最新推出的快应用。

JavaScript 开发 + 原生渲染的方式主要优点如下：

- 采用 Web 开发技术栈，社区庞大、上手快、开发成本相对较低。
- 原生渲染，性能相比 H5 提高很多。
- 动态化较好，支持热更新。

当然也有缺点如下：

- 渲染时需要 JavaScript 和原生之间通信，在有些场景如拖动可能会因为通信频繁导致卡顿。
- JavaScript 为脚本语言，执行时需要 JIT，执行效率和 AOT 代码仍有差距。

由于渲染依赖原生控件，不同平台的控件需要单独维护，并且当系统更新时，社区控件可能会滞后；除此之外，其控件系统也会受到原生 UI 系统限制。例如，在 Android 中，手势冲突消歧规则是固定的，这在使用不同人写的控件嵌套时，手势冲突问题将会变得非常棘手。



### React Native

**React Native**（简称 **RN**）是 Facebook 于2015年4月开源的跨平台移动应用开发框架，是 Facebook 早先开源的 JS 框架 React 在原生移动应用平台的衍生产物，目前支持 iOS 和 Android 两个平台。RN 使用 Javascript 语言，类似于 HTML 的 JSX，以及 CSS 来开发移动应用，因此熟悉 Web 前端开发的技术人员只需很少的学习就可以进入移动应用开发领域。

React Native 的原理和 React 设计一致，React 中虚拟 DOM 最终会映射为浏览器 DOM 树，而 RN 中虚拟 DOM 会通过 JavaScriptCore 映射为原生控件树。

JavaScriptCore 是一个 JavaScript 解释器，它在 React Native 中主要有两个作用：

- 为 JavaScript 提供运行环境。
- 是 JavaScript 与原生应用之间通信的桥梁，作用和 JsBridge 一样，事实上，在 iOS 中，很多 JsBridge 的实现都是基于 JavaScriptCore 。

而 RN 中将虚拟 DOM 映射为原生控件的过程中分两步：

- 布局消息传递（将虚拟 DOM 布局信息传递给原生）
- 原生根据布局信息通过对应的原生控件渲染控件树

由于 React Native 是原生控件渲染，所以性能会比混合应用中 H5 好很多，同时 React Native 是 Web 开发技术栈，只需维护一份代码，即可在多个平台上使用。

### Weex

**Weex** 是阿里巴巴于 2016 年发布的跨平台移动端开发框架，思想及原理和 React Native 类似，最大的不同是语法层面，React Native 使用 React.js 作为开发框架，而 Weex 则使用 Vue.js 作为开发框架。Vue 和 React 堪称前端领域最火的 JavaScript 框架，它们的易用性和功能性都非常强大，Weex 在淘宝上也有广泛的应用。

### 快应用

**快应用**是华为、小米、OPPO、魅族等国内 9 大手机厂商共同制定的轻量级应用标准，目标直指微信小程序。它也是采用 JavaScript 语言开发，原生控件渲染，与 React Native 和 Weex 相比主要有两点不同：

- 快应用自身不支持 Vue 或 React 语法，其采用原生 JavaScript 开发，其开发框架和微信小程序很像，值得一提的是小程序目前已经可以使用 Vue 语法开发（mpvue），从原理上来讲，Vue 的语法也可以移植到快应用上。
- React Native 和 Weex 的渲染/排版引擎是集成到框架中的，每一个 APP 都需要打包一份，安装包体积较大；而快应用渲染/排版引擎是集成到 ROM 中的，应用中无需打包，安装包体积小，正因如此，快应用才能在保证性能的同时做到快速分发。



## 自绘 UI + 原生

通过在不同平台实现一个统一接口的渲染引擎来绘制 UI，而不依赖系统原生控件，因此可以做到不同平台 UI 的一致性。注意，**自绘引擎解决的是 UI 的跨平台问题，如果涉及其它系统能力调用，依然要涉及原生开发**。这种平台技术的优点如下：

- 性能高。由于自绘引擎是直接调用系统 API 来绘制 UI，所以性能和原生控件接近。
- 灵活、组件库易维护、UI 外观保真度和一致性高。由于 UI 渲染不依赖原生控件，也就不需要根据不同平台的控件单独维护一套组件库，所以代码容易维护。由于组件库是同一套代码、同一个渲染引擎，所以在不同平台，组件显示外观可以做到高保真和高一致性；另外，由于不依赖原生控件，也就不会受原生布局系统的限制，这样布局系统会非常灵活。

不足之处：

- 动态性不足；为了保证 UI 绘制性能，自绘 UI 系统一般都会采用 AOT 模式编译其发布包，所以应用发布后，不能像 Hybrid 和 RN 那些使用 JavaScript（JIT）作为开发语言的框架那样动态下发代码。



### Flutter

**Flutter** 是 Google 推出并开源的移动应用开发框架，主打跨平台、高保真、高性能。开发者可以通过 Dart 语言开发 App，一套代码同时运行在 iOS 和 Android 平台。Flutter 提供了丰富的组件、接口，开发者可以很快地为 Flutter 添加原生扩展。

Flutter 既不使用 WebView，也不使用操作系统的原生控件。相反，Flutter 使用自己的高性能渲染引擎来绘制 widget。这样不仅可以保证在 Android 和 iOS 上 UI 的一致性，而且也可以避免对原生控件依赖而带来的限制及高昂的维护成本。

Flutter 使用 Skia 作为其 2D 渲染引擎，Skia 是 Google的一个2D图形处理函数库，包含字型、坐标转换，以及点阵图都有高效能且简洁的表现，Skia 是跨平台的，并提供了非常友好的 API，目前 Google Chrome 浏览器和 Android 均采用 Skia 作为其绘图引擎，值得一提的是，由于 Android 系统已经内置了 Skia，所以 Flutter 在打包 APK（Android 应用安装包）时，不需要再将 Skia 打入 APK 中，但 iOS 系统并未内置 Skia，所以构建 iPA 时，也必须将 Skia 一起打包，这也是为什么 Flutter App 的 Android 安装包比 iOS 安装包小的主要原因。

但是 Flutter 也有不足之处，不支持动态下发代码和热更新。



## PWA

**PWA**（Progress Web App）不属于上述跨平台开发的某一种。它是一种理念，本质上是 Web App，借助一些新技术也具备了 Native App 的一些特性，比如离线能力、本地缓存、和通知推送，兼具 Web App 和 Native App 的优点，看起来更像一个原生 App。

PWA 完全使用前端技术栈，不过它需要手机和浏览器的支持，目前支持 ServiceWorker 和 Google Play Service 的 Android 手机，以及搭载 11.3 以上的 iOS 手机可以使用 PWA。由于国内手机厂商和浏览器厂商的统一性问题，PWA 在国内发展不是很好，但是在国外并没有这些问题。



## 其他

### uni-app

**uni-app** 是一个使用 Vue.js 开发小程序、H5、App 的统一前端框架。

### Taro

**Taro** 是一个开放式跨端跨框架解决方案，支持使用 React/Vue/Nerv 等框架来开发 [微信](https://mp.weixin.qq.com/) / [京东](https://mp.jd.com/?entrance=taro) / [百度](https://smartprogram.baidu.com/) / [支付宝](https://mini.open.alipay.com/) / [字节跳动](https://microapp.bytedance.com/) / [QQ](https://q.qq.com/) / [飞书](https://open.feishu.cn/document/uYjL24iN/ucDOzYjL3gzM24yN4MjN) 小程序 / H5 / RN 等应用。





## 参考

- [一篇文章了解大前端](https://segmentfault.com/a/1190000018264176)
- [国内大厂都在使用哪些移动跨平台框架](https://segmentfault.com/a/1190000022961111)
