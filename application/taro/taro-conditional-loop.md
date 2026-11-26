---
sidebar_position: 8
authors: [luhuadong]
---

# Taro 条件渲染与列表渲染

在这篇文章中，你将学习如何在 Taro 中使用条件渲染和列表渲染。这是构建动态界面时最基础也是最重要的内容。你将掌握 `if` 条件、三元表达式、`map()` 渲染列表等基本写法，并了解在跨端环境下需要注意的细节问题。



## 条件渲染

Taro 支持使用 JavaScript 的逻辑表达式来进行条件渲染。你可以使用 `if`、`&&`、三元运算符等方式。

### 使用三元表达式渲染

这是最常见的方式之一：

```tsx showLineNumbers
const isLoggedIn = true;

return (
  <View>
    {isLoggedIn ? <Text>欢迎回来</Text> : <Text>请登录</Text>}
  </View>
);
```

### 使用逻辑与 `&&` 渲染

这种方式适用于只在条件为 `true` 时才需要渲染某个元素：

```tsx showLineNumbers
const showBanner = true;

return (
  <View>
    {showBanner && <Image src="banner.png" />}
  </View>
);
```

注意：不要在 JSX 中使用常规的 `if` 语句。你需要在 JSX 外部提前处理好条件逻辑。



## 列表渲染

你可以使用 JavaScript 的 `map()` 方法对数组进行遍历，从而生成组件列表。

### 基本用法

```tsx showLineNumbers
const items = ['苹果', '香蕉', '橙子'];

return (
  <View>
    {items.map((item, index) => (
      <Text key={index}>{item}</Text>
    ))}
  </View>
);
```

这里的 `key` 属性是必须的，它有助于 React 正确识别哪些元素被添加、修改或删除。

### 渲染对象数组

```tsx showLineNumbers
const users = [
  { id: 1, name: '小明' },
  { id: 2, name: '小红' },
];

return (
  <View>
    {users.map(user => (
      <Text key={user.id}>{user.name}</Text>
    ))}
  </View>
);
```

建议使用对象的唯一标识符（如 `id`）作为 `key`，避免使用数组索引，尤其是在动态增删元素的场景下。



## 小技巧：列表嵌套与组合渲染

你还可以在列表中嵌套条件渲染，例如：

```tsx showLineNumbers
const items = ['苹果', '', '橙子'];

return (
  <View>
    {items.map((item, index) =>
      item ? <Text key={index}>{item}</Text> : null
    )}
  </View>
);
```

这可以防止渲染空的文本节点。



## 使用 Fragment 避免额外节点

如果你不希望渲染多余的 `<View>` 包裹元素，可以使用 `React.Fragment`：

```tsx showLineNumbers
import { Fragment } from 'react';

{items.map(item => (
  <Fragment key={item.id}>
    <Text>{item.name}</Text>
    <Text>{item.age}</Text>
  </Fragment>
))}
```



## 小结

条件渲染和列表渲染是构建 Taro 应用中不可或缺的一部分。你可以使用三元表达式和 `&&` 来实现灵活的条件逻辑，用 `map()` 遍历数组构建动态组件列表。掌握这些渲染技巧，将帮助你构建更丰富、交互性更强的界面。记得合理使用 `key`，并尽量保持 JSX 结构简洁清晰。
