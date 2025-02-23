---
sidebar_position: 6
---

# HTML 元素标识



在一个 HTML 页面中，通常包含许多元素（标签或控件）。为了更方便的操作这些元素，就需要给这些元素标识一个身份牌。标识的方式有三种，分别是 name、id 和 class。

- name：指定标签的名称
- id：指定标签的唯一标识
- class：指定标签的类名



## name

HTML 元素的 name 属性用于指定标签的名称，name 的值在当前 HTML 页面中并非唯一性。

格式如下：

```html
<input type="text" name="username" />
```

主要应用场景：

- form 表单：name 可作为转递给服务器表单列表的变量名。

- `input type='radio'`单选标签：把几个单选标签的 name 设为一个相同值时，将会进行单选操作。

  ```html
  <input type="radio" name='sex'/>男
  <input type="radio" name='sex'/>女
  ```

- 快速获取一组 name 相同的标签：获取拥有相同 name 的标签，一起进行操作，如：更改属性、注册事件等。

  ```javascript
  function changtxtcolor() {
      var txts = document.getElementsByName('txtcolor'); //获取所有name=txtcolor 的标签
      for (var i = 0; i < txts.length; i++) { //循环遍历标签，并把背景色改为red
          txts[i].style.backgroundColor = 'red';
      }
  }
  ```



## id

HTML 元素的 id 属性用于指定标签的唯一标识，id 的值在当前的 HTML 页面是唯一的。

格式如下：

```html
<input type=password id="userpwd" />
```

主要应用场景：

- 根据提供的唯一 id 号，快速获取标签对象。如：

  ```html
  document.getElementById(id)
  ```

- 用于充当 label 标签 for 属性的值：示例：

  ```html
  <label for='userid'>用户名：</label>
  ```

  表示单击此 label 标签时，id 为 userid 的标签获得焦点。



## class

HTML 元素的 class 属性用于指定标签的类名。

格式如下：

```html
<input type=button class="btnsubmit" />
```

在使用中，可以把多个类放在一个class属性里，但必须用空格隔开，例如：

```html
<input type=button class="btnsubmit btnopen" />
```

主要应用场景：

- CSS 操作，把一些特定样式放到一个 class 类中，需要此样式的标签，可以在添加此类。

