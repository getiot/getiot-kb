---
sidebar_position: 5
slug: /react-jsx-guide
authors: [luhuadong]
---

# React JSX 语法详解

**JSX** 是 React 中最核心的语法，用于更方便地描述用户界面和逻辑，这也是 React 与其他前端框架最不一样的地方。注意，JSX 并不是一门新语言，而是 Facebook 提出的一种语法方案 —— 在 JavaScript 代码中直接书写 HTML 标签的语法糖。

JSX 看起来像 HTML，却不是 HTML。它本质上是 JavaScript 的语法扩展，可通过构建工具（如 Webpack）解析生成 JavaScript 代码。JSX 写起来直观，读起来清晰。如果你理解了 JSX，那么你就能更高效地构建 React 组件。



## 什么是 JSX？

JSX（JavaScript XML）是一种 JavaScript 的语法扩展，允许你在 JavaScript 中直接写“类 HTML”代码。

示例：

```tsx showLineNumbers
const element = <h1>Hello, React!</h1>;
```

这段代码虽然看起来像 HTML，但实际上会被编译成如下 JavaScript：

```tsx showLineNumbers
const element = React.createElement('h1', null, 'Hello, React!');
```

所以别担心，它依然是 JavaScript，只是长得像 HTML 而已。



## JSX 的基本规则

#### 1. 每个 JSX 表达式只能有一个根节点

错误写法：

```tsx showLineNumbers
return (
  <h1>标题</h1>
  <p>段落</p>
);
```

正确写法：

```tsx showLineNumbers
return (
  <div>
    <h1>标题</h1>
    <p>段落</p>
  </div>
);
```

你也可以用 `<>` 和 `</>` 这种 **Fragment** 简写：

```tsx showLineNumbers
return (
  <>
    <h1>标题</h1>
    <p>段落</p>
  </>
);
```



#### 2. 使用小驼峰命名的属性（class → className）

JSX 中不能使用 HTML 的属性名，如 `class`、`for`，必须改成 JavaScript 识别的属性名：

| HTML  |    JSX    |
| :---: | :-------: |
| class | className |
|  for  |  htmlFor  |

示例：

```tsx showLineNumbers
<p className="text">这是一段文本</p>
```



#### 3. 使用花括号插入表达式

你可以使用花括号 `{}` 在 JSX 中插入任何 JavaScript 表达式：

```tsx showLineNumbers
const name = 'React';

return <h1>Hello, {name}!</h1>;
```

支持的表达式包括变量、函数调用、三元运算符、数组等。



## 条件渲染

JSX 不支持 `if` 语句，但你可以用三元运算符或逻辑与（&&）实现条件渲染。

**三元运算符：**

```tsx showLineNumbers
{isLoggedIn ? <p>欢迎回来</p> : <p>请先登录</p>}
```

**逻辑与：**

```tsx showLineNumbers
{unreadMessages.length > 0 && <p>你有新消息</p>}
```



## 列表渲染

你可以使用 `map()` 渲染数组：

```tsx showLineNumbers
const fruits = ['🍎', '🍌', '🍇'];

return (
  <ul>
    {fruits.map((fruit, index) => (
      <li key={index}>{fruit}</li>
    ))}
  </ul>
);
```

:::tip

每个列表项都需要提供一个唯一的 `key` 属性，否则会出现性能或渲染问题。

:::



## 内联样式

JSX 支持使用对象的形式添加内联样式，样式属性名使用驼峰式命名。

```tsx showLineNumbers
const style = {
  color: 'red',
  fontSize: '20px'
};

return <p style={style}>红色文字</p>;
```

也可以直接写在标签里：

```tsx showLineNumbers
<p style={{ color: 'blue' }}>蓝色文字</p>
```



## JSX 中的注释

注释需要写在花括号中，不能像 HTML 那样写 `<!-- -->`：

```tsx showLineNumbers
{/* 这是一个注释 */}
```



## JSX 表达式嵌套与组合

JSX 支持嵌套组件：

```tsx showLineNumbers
function Welcome(props) {
  return <h1>Hello, {props.name}</h1>;
}

function App() {
  return (
    <div>
      <Welcome name="React" />
      <Welcome name="JSX" />
    </div>
  );
}
```

你可以像使用 HTML 标签一样复用 React 组件。



## 小结

JSX 是 React 的核心语法，你可以像写 HTML 一样构建用户界面，同时享受 JavaScript 的灵活性。掌握 JSX 后，你会发现开发体验变得更自然，逻辑和界面更紧密地结合在一起。在接下来的内容中，我们会继续学习如何创建和组合 React 组件，让页面变得更加模块化和强大。
