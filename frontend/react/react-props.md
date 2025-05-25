---
sidebar_position: 7
sidebar_label: React 属性 Props
slug: /react-props
authors: [luhuadong]
---

# React 属性 Props（组件传参）

在上一节中，你已经接触过组件的基本写法，并用 `props` 向组件传递数据。现在，让我们更深入地理解 props 的工作机制，学会如何在组件之间灵活地传参。

在 React 中，组件之间的数据传递主要依赖 `props`（属性）。你可以把 props 理解为函数参数，它们由父组件传递给子组件，帮助你构建灵活、可配置的 UI 模块。本章将带你全面掌握 props 的用法，包括传递字符串、数字、对象、函数、默认值，以及 props 的只读性等重要概念。



## 什么是 Props？

`props` 是 “properties”（属性） 的缩写，是组件的输入。你可以通过在组件标签中添加属性的方式，将数据传入子组件：

```tsx showLineNumbers
function Welcome(props) {
  return <h1>你好，{props.name}！</h1>;
}

function App() {
  return <Welcome name="小明" />;
}
```

**等价于函数参数：**

```tsx showLineNumbers
function Welcome({ name }) {
  return <h1>你好，{name}！</h1>;
}
```



## 传递各种类型的值

你可以向组件传递任何类型的数据，只要用花括号包裹非字符串内容。

#### 字符串

```tsx showLineNumbers
<Hello message="你好" />
```

#### 数字 / 布尔值

```tsx showLineNumbers
<User age={18} isStudent={true} />
```

#### 对象 / 数组

```tsx showLineNumbers
<Person info={{ name: '张三', age: 20 }} />
<List items={['香蕉', '苹果', '橘子']} />
```

#### 函数

```tsx showLineNumbers
<Button onClick={() => alert('点击了按钮！')} />
```



## 组件中使用 props

在组件内部，通过访问 `props` 或解构来使用传入的属性：

```tsx showLineNumbers
function UserCard({ name, age }) {
  return (
    <div>
      <p>姓名：{name}</p>
      <p>年龄：{age}</p>
    </div>
  );
}
```

调用：

```tsx showLineNumbers
<UserCard name="小明" age={18} />
```



## props 是只读的

React 中的 props 是不可变的（immutable），你不能在子组件中修改它。

```tsx showLineNumbers
// 错误示例（不要这么做）
props.name = '李四'; // ❌ 会报错或导致不可预测的行为
```

如果你需要更改数据，应该通过父组件管理 state，再通过 props 传递更新后的值。



## props.children：组件嵌套内容

React 提供了一个特殊的属性 `props.children`，用于表示**组件标签内部嵌套的内容**。你可以把它理解为 HTML 标签的“内部内容”。

```tsx showLineNumbers
function Wrapper(props) {
  return <div className="box">{props.children}</div>;
}

function App() {
  return (
    <Wrapper>
      <h1>标题</h1>
      <p>这是正文。</p>
    </Wrapper>
  );
}
```

在这个例子中，`<Wrapper>` 组件接收到的 `props.children` 就是：

```tsx showLineNumbers
[
  <h1>标题</h1>
  <p>这是正文。</p>
]
```

:::tip

任何你写在组件标签内部的内容，都会自动变成该组件的 `props.children`，由组件内部决定如何渲染它。

:::



## 设置默认 props 值（defaultProps）

如果某个 prop 没有传入，你可以为它指定默认值。

例如，在函数组件中设置默认值：

```tsx showLineNumbers
function Welcome({ name = 'React 用户' }) {
  return <h1>你好，{name}！</h1>;
}
```

类组件中也可以使用 `defaultProps`：

```tsx showLineNumbers
class Welcome extends React.Component {
  static defaultProps = {
    name: 'React 用户'
  };
  render() {
    return <h1>你好，{this.props.name}</h1>;
  }
}
```



## props 类型校验

你可以使用 `prop-types` 包来校验 props 类型（在学习 TypeScript 前，它很有用）。

安装方法：

```bash showLineNumbers
npm install prop-types
```

使用示例：

```tsx showLineNumbers
import PropTypes from 'prop-types';

function Greeting({ name }) {
  return <p>你好，{name}</p>;
}

Greeting.propTypes = {
  name: PropTypes.string.isRequired
};
```

如果你使用的是 TypeScript，推荐方式是**使用接口（interface）或类型别名（type）对 props 进行静态类型检查**。例如：

```tsx showLineNumbers
import React from 'react';

// 定义 props 类型
interface WelcomeProps {
  name: string;
  age?: number; // 可选属性
}

// 使用泛型指定 props 类型
function Welcome(props: WelcomeProps) {
  return (
    <div>
      <h1>你好，{props.name}！</h1>
      {props.age && <p>你今年 {props.age} 岁。</p>}
    </div>
  );
}

export default Welcome;
```

使用组件：

```tsx showLineNumbers
<Welcome name="小明" age={18} />
```

说明：

- `interface` 或 `type` 定义的是静态类型，开发时会有更好的提示和校验。
- 使用 `age?: number` 表示这是一个可选的 prop。
- 和 JavaScript 不同，TypeScript 不再推荐使用 `PropTypes`，因为 TypeScript 本身已经能提供更强大的类型检查。



## 小结

props 是 React 组件之间通信的桥梁，就像函数参数一样，帮助你构建灵活、可复用的组件。通过 props，你可以向组件传递各种类型的数据，包括文本、数字、对象、函数，甚至嵌套的子元素。掌握 props 后，你的组件就像乐高积木一样，可以随心组合，为后续学习状态（state）管理和组件交互打下坚实基础。
