---
sidebar_position: 9
slug: /react-event-handling
authors: [luhuadong]
---

# React 事件处理

在上一节中，你学会了如何通过 `useState` 管理组件的状态。本节你将进一步学习如何在 React 中处理用户的操作事件，比如何绑定事件监听器、传递参数、阻止默认行为，并结合状态一起使用，构建响应式的 UI，实现点击、输入、提交表单等功能。事件处理是构建交互式应用的核心部分。

:::tip

React 中的事件处理方式看起来像 HTML，但本质上是更接近 JavaScript 的函数式处理。

:::



## React 事件绑定语法

React 的事件使用驼峰命名法（camelCase），比如 `onClick` 而不是 HTML 中的 `onclick`。而且你传入的是一个函数，而不是字符串。

```tsx showLineNumbers
function ClickButton() {
  function handleClick() {
    alert('按钮被点击了！');
  }

  return <button onClick={handleClick}>点击我</button>;
}
```



## 箭头函数直接写在 JSX 中

如果事件处理逻辑比较简单，你可以直接在 JSX 中写箭头函数：

```tsx showLineNumbers
<button onClick={() => alert('点击了！')}>点一下</button>
```

但如果逻辑复杂，建议写成单独的函数，保持代码整洁。



## 在事件中更新 State

最常见的做法是事件触发后修改组件的状态，从而更新界面。

```tsx showLineNumbers
import { useState } from 'react';

function Counter() {
  const [count, setCount] = useState(0);

  function handleClick() {
    setCount(count + 1);
  }

  return (
    <div>
      <p>当前计数：{count}</p>
      <button onClick={handleClick}>增加</button>
    </div>
  );
}
```



## 事件对象（SyntheticEvent）

React 会自动封装原生事件对象成一个跨浏览器兼容的合成事件 `SyntheticEvent`，你可以像使用原生事件一样获取事件参数。

```tsx showLineNumbers
function InputDemo() {
  function handleChange(event) {
    console.log('输入值：', event.target.value);
  }

  return <input onChange={handleChange} />;
}
```



## 事件中传递参数

如果你希望给事件处理函数传递额外参数，可以用箭头函数包一层：

```tsx showLineNumbers
function GreetButton({ name }) {
  function handleClick(who) {
    alert(`你好，${who}`);
  }

  return <button onClick={() => handleClick(name)}>打招呼</button>;
}
```



## 阻止默认行为和事件冒泡

### 默认行为

在 HTML 中，某些元素具有 **默认行为**，比如：

- `<a href="...">` 点击后会跳转页面；
- `<form>` 提交后会刷新页面；
- `<input type="checkbox">` 勾选时会自动切换状态。

这些行为是浏览器自动执行的，不是由你编写的 JavaScript 控制的。

在 React 中，如果你希望“点击链接但不跳转”、“提交表单但不刷新”，就要用 `event.preventDefault()` 阻止默认行为。

**示例：阻止链接跳转**

```tsx showLineNumbers
function LinkButton() {
  function handleClick(e) {
    e.preventDefault(); // 阻止默认跳转
    alert('链接被点击了，但没有跳转');
  }

  return <a href="https://react.dev" onClick={handleClick}>React 官网</a>;
}
```

**示例：阻止表单刷新页面**

```tsx showLineNumbers
function FormExample() {
  function handleSubmit(e) {
    e.preventDefault(); // 阻止表单默认提交
    alert('表单已提交（不刷新）');
  }

  return (
    <form onSubmit={handleSubmit}>
      <input type="text" placeholder="输入点什么" />
      <button type="submit">提交</button>
    </form>
  );
}
```

### 事件冒泡

而事件冒泡则是指：**事件会从触发目标元素，一层一层向外传递到父元素**。

比如你点了一个按钮，它的 `onClick` 会先触发，然后父元素的 `onClick` 也会被触发，除非你阻止它。例如：

```tsx showLineNumbers
function BubbleExample() {
  function handleParentClick() {
    console.log('父元素被点击');
  }

  function handleButtonClick() {
    console.log('按钮被点击');
  }

  return (
    <div onClick={handleParentClick}>
      <button onClick={handleButtonClick}>点我</button>
    </div>
  );
}
```

点击按钮后，控制台会输出：

```bash showLineNumbers
按钮被点击
父元素被点击
```

这说明事件从按钮“冒泡”到了父元素。

那如何阻止事件冒泡？—— 使用 `event.stopPropagation()` 可以阻止事件向上传播，**防止父元素触发事件**。

**示例：阻止冒泡**

```tsx showLineNumbers
function StopBubble() {
  function handleParentClick() {
    alert('父元素点击');
  }

  function handleButtonClick(e) {
    e.stopPropagation(); // 阻止冒泡
    alert('按钮点击');
  }

  return (
    <div onClick={handleParentClick} style={{ padding: 20, background: '#eee' }}>
      <button onClick={handleButtonClick}>只触发按钮事件</button>
    </div>
  );
}
```

点击按钮时，只会弹出“按钮点击”，而不会触发父元素的点击事件。



## 常见事件类型

下表列出了 React 中常见的几种事件类型：

|   类型   |     事件名      |           说明           |
| :------: | :-------------: | :----------------------: |
| 鼠标事件 |    `onClick`    |           点击           |
|          | `onDoubleClick` |           双击           |
|          | `onMouseEnter`  |         鼠标移入         |
| 键盘事件 |   `onKeyDown`   |         键盘按下         |
|          |    `onKeyUp`    |         键盘松开         |
| 表单事件 |   `onChange`    | 值变化（输入框、下拉框） |
|          |   `onSubmit`    |         提交表单         |
| 焦点事件 |    `onFocus`    |         获取焦点         |
|          |    `onBlur`     |         失去焦点         |



## 小结

React 的事件系统简洁且强大，它使用类 HTML 的语法结合函数式调用，让你能轻松构建交互行为。事件处理通常会和 State 搭配使用，帮助组件根据用户操作动态响应，是构建前端应用不可或缺的一环。
