---
sidebar_position: 6
---

# HTML 元素标识

在构建网页时，你常常需要为 HTML 元素添加标识，以便在样式设置、脚本操作或表单提交中更方便地引用它们。HTML 提供了三种常用的标识方式：`name`、`id` 和 `class`。本节将带你了解它们的作用、使用方法以及适用场景。

- `name`：指定标签的名称
- `id`：指定标签的唯一标识
- `class`：指定标签的类名



## name 属性

`name` 属性用于为 HTML 元素指定名称。在一个页面中，多个元素可以拥有相同的 `name` 值。

格式如下：

```html
<input type="text" name="username" />
```

主要应用场景：

- **form 表单提交**：在表单中，`name` 属性的值会作为键，元素的值会作为值，一起提交到服务器。

- **单选按钮分组**：将多个单选按钮的 `name` 设置为相同的值，可以实现分组效果，使用户在同一组中只能选择一个选项。

  ```html
  <input type="radio" name="gender" value="male" /> 男
  <input type="radio" name="gender" value="female" /> 女
  ```

- **通过 JavaScript 获取元素集合**：可以使用 `document.getElementsByName()` 方法获取具有相同 `name` 值的元素集合，方便进行批量操作，例如更改属性、注册事件等。

  ```javascript
  function changtxtcolor() {
      // 获取所有 name=txtcolor 的标签
      var txts = document.getElementsByName('txtcolor');
      // 循环遍历标签，并把背景色改为 red
      for (var i = 0; i < txts.length; i++) {
          txts[i].style.backgroundColor = 'red';
      }
  }
  ```



## id 属性

`id` 属性用于为 HTML 元素指定唯一的标识符。在同一个 HTML 文档中，`id` 的值必须是唯一的。

格式如下：

```html
<input type=password id="userpwd" />
```

主要应用场景：

- **通过 JavaScript 快速获取元素**：使用 `document.getElementById()` 方法可以快速获取具有特定 `id` 的元素。

  ```javascript
  var passwordField = document.getElementById('userpwd');
  ```

- **与 `<label>` 标签关联**：通过在 `<label>` 标签的 `for` 属性中指定目标元素的 `id`，可以增强表单的可用性。当用户点击标签时，浏览器会自动将焦点移动到关联的输入控件上。

  ```html
  <label for="username">用户名：</label>
  <input type="text" id="username" />
  ```
  



## class 属性

`class` 属性用于为 HTML 元素指定一个或多个类名，通常用于将多个元素归为一类，以便统一应用样式或进行脚本操作。

格式如下：

```html
<input type=button class="btnsubmit" />
```

在使用中，可以把多个类放在一个class属性里，但必须用空格隔开，例如：

```html
<input type=button class="btnsubmit btnopen" />
```

主要应用场景：

- **应用 CSS 样式**：通过为元素指定类名，可以在 CSS 中定义相应的样式规则，统一管理页面的外观。

  ```css
  .btnsubmit {
    background-color: blue;
    color: white;
  }
  ```

- **多个类名的组合使用**：一个元素可以同时拥有多个类名，类名之间用空格分隔。这种方式可以灵活地组合不同的样式或行为。

  ```html
  <input type="button" class="btnsubmit btnlarge" />
  ```

  对应 CSS 样式：

  ```css
  .btnsubmit {
    background-color: blue;
  }
  
  .btnlarge {
    font-size: 20px;
    padding: 10px 20px;
  }
  ```



## 小结

在 HTML 中，`name`、`id` 和 `class` 是三种常用的元素标识方式。`name` 主要用于表单元素的命名和分组；`id` 用于为元素指定唯一标识，便于精确引用；`class` 用于将元素归类，便于统一应用样式或行为。合理使用这些属性，可以提高网页的结构清晰度和可维护性。
