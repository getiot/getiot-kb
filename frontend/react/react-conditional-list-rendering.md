---
sidebar_position: 10
sidebar_label: React 条件和列表渲染
slug: /react-conditional-list-rendering
authors: [luhuadong]
---

# React 条件渲染和列表渲染

在前面的章节中，你已经了解了如何通过 `props` 和 `state` 来动态控制组件行为。本篇将进一步讲解 React 中的两个核心渲染机制：

- **条件渲染**（Conditional Rendering）：根据条件显示或隐藏某些元素。
- **列表渲染**（List Rendering）：根据数组渲染多个组件或元素。

这两种渲染方式非常常见，你几乎会在所有真实项目中频繁使用它们。



## 条件渲染

条件渲染是根据某个条件判断是否显示某段内容，常见的方式包括：

**1. 使用 JavaScript 条件语句（if）**

```tsx showLineNumbers
function Greeting({ isLoggedIn }) {
  if (isLoggedIn) {
    return <h1>欢迎回来！</h1>;
  } else {
    return <h1>请先登录。</h1>;
  }
}
```

**2. 使用三元运算符（推荐）**

```tsx showLineNumbers
function UserStatus({ isOnline }) {
  return (
    <p>{isOnline ? '用户在线' : '用户离线'}</p>
  );
}
```

**3. 使用逻辑与（&&）**

当你只在满足某个条件时显示某个组件时，可以使用 `&&`：

```tsx showLineNumbers
function Warning({ show }) {
  return (
    <div>
      {show && <p style={{ color: 'red' }}>警告：你没有权限访问此内容！</p>}
    </div>
  );
}
```

**注意事项**

- 不要滥用嵌套 `if` 或多层三元表达式，避免代码难以阅读。
- JSX 中不能使用 `if...else` 表达式嵌在标签内部，建议提前处理好条件逻辑。



## 列表渲染

当你需要渲染一个数据数组时，可以使用 `Array.prototype.map()` 方法将每一项映射成一个 JSX 元素。

**示例：渲染一个用户列表**

```tsx showLineNumbers
function UserList({ users }) {
  return (
    <ul>
      {users.map(user => (
        <li key={user.id}>{user.name}</li>
      ))}
    </ul>
  );
}
```

**✅ 为什么需要 `key`？**

在上面的例子中，我们为每个 `<li>` 添加了 `key` 属性。React 需要通过 `key` 来追踪哪些元素被修改、添加或删除，从而提高性能。

:::tip

建议使用数组中每项的唯一标识符（如 id）作为 key，而不是数组索引。

:::



## 条件与列表结合使用

有时候，你可能需要对列表进行过滤并只渲染符合条件的项。那么可以将条件与列表结合使用，例如：

```tsx showLineNumbers
function OnlineUserList({ users }) {
  return (
    <ul>
      {users
        .filter(user => user.isOnline)
        .map(user => (
          <li key={user.id}>{user.name}</li>
        ))}
    </ul>
  );
}
```



## 注意事项

### 不推荐的写法：在循环中使用索引作为 key

```tsx showLineNumbers
// 不推荐
{items.map((item, index) => (
  <li key={index}>{item.name}</li>
))}
```

如果列表顺序发生变化（如插入、删除），使用索引作为 key 可能导致渲染错误。



### 小技巧：JSX 中也能使用函数调用

```tsx showLineNumbers
function renderStatus(status) {
  switch (status) {
    case 'loading':
      return <p>加载中...</p>;
    case 'success':
      return <p>加载成功！</p>;
    case 'error':
      return <p>加载失败，请重试。</p>;
    default:
      return null;
  }
}

function StatusDisplay({ status }) {
  return (
    <div>
      {renderStatus(status)}
    </div>
  );
}
```



## 小结

条件渲染和列表渲染是 React 中最基础也最常见的技巧。通过 `if`、三元运算符、逻辑与等方式，你可以灵活地控制元素的显示与隐藏；而使用 `map()` 方法加上唯一的 `key`，你可以优雅地渲染数据列表。理解这些基础将帮助你构建更加灵活和高效的组件。
