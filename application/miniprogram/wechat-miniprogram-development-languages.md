---
sidebar_position: 4
authors: [luhuadong]
---

# 微信小程序开发语言

微信小程序的开发主要涉及四种编程语言，分别是：WXML、WXSS、JavaScript（或 TypeScript）和 JSON。每种语言都有其特定的作用和使用场景，下面我们将逐一介绍它们的作用和基本用法。



## WXML（微信标记语言）

WXML 是微信小程序的标记语言，用于描述页面的结构和布局。它类似于 HTML，但有一些特定的语法和规则。

下面是 WXML 的基本语法：

1. **标签**

   WXML 使用标签来定义页面元素，例如：

   ```xml showLineNumbers
   <view>这是一个视图容器</view>
   <text>这是一个文本元素</text>
   <button>这是一个按钮</button>
   ```

2. **数据绑定**

   WXML 支持数据绑定，可以通过 `{{ }}` 语法将页面元素与数据绑定起来。例如：

   ```xml showLineNumbers
   <view>用户名：{{username}}</view>
   ```

3. **条件渲染**

   使用 `wx:if`、`wx:elif` 和 `wx:else` 来实现条件渲染：

   ```xml showLineNumbers
   <view wx:if="{{condition}}">条件为真时显示</view>
   <view wx:elif="{{anotherCondition}}">条件为假时显示</view>
   <view wx:else>其他情况显示</view>
   ```

4. **列表渲染**

   使用 `wx:for` 来循环渲染列表：

   ```xml showLineNumbers
   <view wx:for="{{items}}" wx:key="*this">
       {{item.name}}
   </view>
   ```



## WXSS（微信样式表）

WXSS 是微信小程序的样式表语言，用于定义页面的样式。它类似于 CSS，但有一些特定的规则和扩展。

下面是 WXSS 的基本语法：

1. **样式规则**

   WXSS 的样式规则与 CSS 类似，例如：

   ```css showLineNumbers
   .container {
       display: flex;
       flex-direction: column;
       align-items: center;
       padding: 20px;
   }
   .text {
       color: #333;
       font-size: 18px;
   }
   ```

2. **尺寸单位**

   微信小程序支持多种尺寸单位，如 `px`、`rpx`（响应式单位）等：

   ```css showLineNumbers
   .button {
       width: 200rpx;
       height: 50rpx;
       background-color: #007aff;
       color: white;
       font-size: 16px;
   }
   ```

3. **样式继承与覆盖**

   WXSS 支持样式继承和覆盖，与 CSS 的规则类似。



## JavaScript / TypeScript

JavaScript 是微信小程序开发的传统选择，也是小程序框架最初支持的语言，用于处理页面的逻辑和交互。但由于 JavaScript 缺少类型检查，不容易发现数据类型造成的潜在错误，因此微信小程序开发工具已经全面支持 TypeScript 语言。对于大型项目，TypeScript 的类型系统可以帮助更好地管理代码结构，减少维护成本。

下面是 JavaScript 的基本语法：

1. **数据处理**

   在 JavaScript 文件中，可以定义数据并将其绑定到页面：

   ```javascript showLineNumbers
   Page({
       data: {
           username: 'GetIoT',
           users: [
               { name: 'Alice', age: 25 },
               { name: 'Bob', age: 30 }
           ]
       },
       onTap: function () {
           console.log('按钮被点击了');
       }
   });
   ```

2. **事件处理**

   使用 `bindtap` 等属性绑定事件处理函数：

   ```xml showLineNumbers
   <button bindtap="onTap">点击我</button>
   ```

3. **调用微信小程序 API**

   微信小程序提供了丰富的 API，例如发起网络请求：

   ```javascript showLineNumbers
   wx.request({
       url: 'https://example.com/data',
       success: function (res) {
           console.log('请求成功', res.data);
       },
       fail: function (err) {
           console.log('请求失败', err);
       }
   });
   ```



:::tip

虽然 JavaScript 仍然是微信小程序开发的主流语言，但随着项目复杂度的增加和团队开发的需求，**推荐使用 TypeScript**。TypeScript 提供了静态类型检查、代码提示和自动补全等功能，能够显著提高开发效率和代码质量，尤其适合大型项目和团队开发。

:::



## JSON

JSON 用于配置小程序的全局设置和页面设置。它是一个轻量级的数据交换格式。

下面是 JSON 的基本语法：

1. **全局配置**

   在 `app.json` 文件中，可以配置小程序的全局设置：

   ```json showLineNumbers
   {
       "pages": [
           "pages/index/index",
           "pages/about/about"
       ],
       "window": {
           "navigationBarTitleText": "微信小程序",
           "navigationBarBackgroundColor": "#ffffff",
           "navigationBarTextStyle": "black"
       },
       "tabBar": {
           "list": [
               {
                   "pagePath": "pages/index/index",
                   "text": "首页"
               },
               {
                   "pagePath": "pages/about/about",
                   "text": "关于"
               }
           ]
       }
   }
   ```

2. **页面配置**

   在页面的 JSON 文件中，可以配置页面的设置：

   ```json showLineNumbers
   {
       "navigationBarTitleText": "首页",
       "navigationBarBackgroundColor": "#007aff",
       "navigationBarTextStyle": "white"
   }
   ```



## 综合示例

以下是使用 TypeScript 开发微信小程序的简化示例，这个示例将展示如何使用 TypeScript 来开发一个简单的微信小程序页面，包括数据绑定、事件处理等基本功能。

文件结构如下：

```bash showLineNumbers
project-name/
├── app.ts
├── app.json
├── app.wxss
├── pages/
│   ├── index/
│   │   ├── index.wxml
│   │   ├── index.wxss
│   │   ├── index.ts
│   │   └── index.json
```

`app.json` 示例代码：

```json showLineNumbers title="app.json"
{
    "pages": [
        "pages/index/index"
    ],
    "window": {
        "navigationBarTitleText": "微信小程序",
        "navigationBarBackgroundColor": "#ffffff",
        "navigationBarTextStyle": "black"
    }
}
```

`app.wxss` 示例代码：

```css showLineNumbers title="app.wxss"
/* 全局样式 */
.container {
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 20px;
}
.text {
    color: #333;
    font-size: 18px;
}
.button {
    width: 200rpx;
    height: 50rpx;
    background-color: #007aff;
    color: white;
    font-size: 16px;
    margin-top: 20px;
}
```

`pages/index/index.wxml` 示例代码：

```xml showLineNumbers title="pages/index/index.wxml"
<view class="container">
    <text class="text">欢迎来到微信小程序</text>
    <button class="button" bindtap="onTap">点击我</button>
</view>
```

`pages/index/index.wxss` 示例代码：

```css showLineNumbers title="pages/index/index.wxss"
/* 页面样式 */
/* 由于使用了全局样式，这里可以为空 */
```

`pages/index/index.ts` 示例代码：

```typescript showLineNumbers title="pages/index/index.ts"
// 引入 Page
import { Page } from 'wx/types';

// 定义页面数据类型
interface PageData {
    username: string;
}

// 定义页面逻辑
const IndexPage: Page<PageData> = {
    data: {
        username: 'GetIoT'
    },
    onLoad() {
        console.log('首页加载完成');
    },
    onTap() {
        wx.showToast({
            title: '按钮被点击了',
            icon: 'success',
            duration: 2000
        });
    }
};

// 注册页面
Page(IndexPage);
```

`pages/index/index.json` 示例代码：

```json showLineNumbers title="pages/index/index.json"
{
    "navigationBarTitleText": "首页",
    "navigationBarBackgroundColor": "#007aff",
    "navigationBarTextStyle": "white"
}
```

代码说明：

- **TypeScript 支持**：
  - 微信小程序开发工具已经全面支持 TypeScript，可以直接在项目中使用 `.ts` 文件。
  - 在 `index.ts` 文件中，我们定义了页面的逻辑和数据类型，使用了 TypeScript 的类型系统来增强代码的可读性和可维护性。
- **数据绑定**：
  - 在 `index.wxml` 中，通过 `{{username}}` 绑定了页面数据，数据来源于 `index.ts` 中的 `data`。
- **事件处理**：
  - 在 `index.ts` 中定义了 `onTap` 方法，该方法会在按钮被点击时触发，并调用 `wx.showToast` 显示提示信息。
- **页面配置**：
  - 在 `index.json` 中，配置了页面的导航栏标题、背景颜色和文字颜色。



## 小结

本文介绍了微信小程序开发的四种主要编程语言（WXML、WXSS、JavaScript / TypeScript 和 JSON）的作用和基本语法。并通过一个示例开发了微信小程序首页，展示了如何结合 WXML、WXSS、TypeScript 和 JSON 来开发微信小程序。

