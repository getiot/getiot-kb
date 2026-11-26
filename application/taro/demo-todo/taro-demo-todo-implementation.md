---
sidebar_position: 2
sidebar_label: ToDo 应用页面与逻辑实现
authors: [luhuadong]
---

# Taro 项目实战：ToDo 应用 - 页面与逻辑实现

在本节中，你将开始真正动手搭建 ToDo 应用的页面和核心交互逻辑。我们会使用 React 组件的方式，结合 Taro 提供的 API，完成添加、显示、切换状态和删除事项等功能。项目使用 TypeScript 编写，帮助你养成更规范的开发习惯。

:::info 项目代码

ToDo 应用示例的完整代码可在 [GitHub](https://github.com/getiot/taro-courses/tree/main/todo-app) 获取。

:::



## 准备工作

首先，通过 Taro CLI 创建了一个项目 `todo-app`，项目介绍为“ToDo 应用”。

```bash
taro init todo-app
```

因为这个项目需要运行在微信小程序、H5、React Native 等平台，因此我们需要指定各平台的输出目录。修改 `config/index.ts` 文件中的 `outputRoot` 配置项，如下：

```typescript showLineNumbers title="config/index.ts"
const config = {
  outputRoot: `dist/${process.env.TARO_ENV}`,
  // 其他配置...
};
```

尝试编译，确保已经能正常运行 H5 或小程序预览。

```bash
npm run dev:h5       # 运行 H5 版本
npm run dev:weapp    # 运行微信小程序版本
```

如果你还没有设置页面路由，可以在 `src/app.config.ts` 中配置首页：

```tsx showLineNumbers title="src/app.config.ts"
export default defineAppConfig({
  pages: ['pages/index/index'],
  window: {
    navigationBarTitleText: 'ToDo 应用',
  },
});
```



## 页面结构设计

我们只需要一个页面（`pages/index/index.tsx`）来处理所有交互，因此 UI 设计也保持简洁。

基本布局包含三个部分：

1. 输入框 + 添加按钮
2. 待办事项列表
3. 每项支持点击切换完成状态和删除



## 定义类型

我们先定义 ToDo 项的数据结构，放在 `pages/index/index.tsx` 顶部：

```tsx showLineNumbers
interface TodoItem {
  id: number;
  title: string;
  done: boolean;
}
```



## 编写页面逻辑

这是页面组件的完整代码，你可以粘贴进 `pages/index/index.tsx` 文件中：

```tsx showLineNumbers title="pages/index/index.tsx"
import { useState } from 'react';
import { View, Input, Button, Text } from '@tarojs/components';
import Taro from '@tarojs/taro';
import './index.scss'

interface TodoItem {
  id: number;
  title: string;
  done: boolean;
}

export default function Index () {
  const [todos, setTodos] = useState<TodoItem[]>([]);
  const [inputValue, setInputValue] = useState('');

  const addTodo = () => {
    const trimmed = inputValue.trim();
    if (!trimmed) {
      Taro.showToast({ title: '请输入内容', icon: 'none' });
      return;
    }
    const newTodo: TodoItem = {
      id: Date.now(),
      title: trimmed,
      done: false,
    };
    setTodos([...todos, newTodo]);
    setInputValue('');
  };

  const toggleTodo = (id: number) => {
    const updated = todos.map(item =>
      item.id === id ? { ...item, done: !item.done } : item
    );
    setTodos(updated);
  };

  const removeTodo = (id: number) => {
    const filtered = todos.filter(item => item.id !== id);
    setTodos(filtered);
  };

  return (
    <View className="container">
      <View className="input-area">
        <Input
          className="input"
          type="text"
          value={inputValue}
          onInput={e => setInputValue(e.detail.value)}
          placeholder="添加一条待办事项"
        />
        <Button className="add-btn" onClick={addTodo}>添加</Button>
      </View>

      <View className="list">
        {todos.length === 0 ? (
          <Text className="empty">暂无待办事项</Text>
        ) : (
          todos.map(item => (
            <View
              key={item.id}
              className="todo-item"
              onClick={() => toggleTodo(item.id)}
            >
              <Text className={`todo-text ${item.done ? 'done' : ''}`}>{item.title}</Text>
              <Button
                className="delete-btn"
                size="mini"
                onClick={e => {
                  e.stopPropagation();
                  removeTodo(item.id);
                }}
              >
                删除
              </Button>
            </View>
          ))
        )}
      </View>
    </View>
  )
}
```



## 样式编写

你可以在 `pages/index/index.scss` 中添加以下样式：

```scss showLineNumbers title="pages/index/index.scss"
.container {
  padding: 20px;
  background-color: mediumseagreen;
}

.input-area {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 20px;

  .input {
    flex: 1;
    height: 40px;
    padding: 8px 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 18px;
    box-sizing: border-box;
  }

  .add-btn {
    flex: 1;
    width: 80px;
    height: 40px;
    line-height: 40px;
    padding: 0;
    background-color: #6190e8;
    color: #fff;
    font-size: 14px;
    text-align: center;
    border-radius: 4px;
    white-space: nowrap;
  }
}

.list {
  .todo-item {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 12px;
    border-bottom: 1px solid #eee;

    .todo-text {
      flex: 1;
      font-size: 20px;
      word-break: break-all;
    }

    .todo-text.done {
      text-decoration: line-through;
      color: #444;
    }

    .delete-btn {
      background-color: #ff4d4f;
      color: white;
      border: none;
      padding: 4px 10px;
      border-radius: 4px;
      font-size: 14px;
      cursor: pointer;
      flex-shrink: 0;
    }
  }

  .empty {
    color: #666;
    text-align: center;
    margin-top: 40px;
  }
}
```

执行 `npm run dev:h5` 编译 H5 页面，打开浏览器，可以看到如下 ToDo 界面。你可以尝试添加待办事项，测试删除、已完成等功能。

![ToDo 应用界面](https://static.getiot.tech/taro-demo-todo-h5.jpg#center)



## 事件绑定说明

- `onInput` 是 Taro 中对 input 组件的监听事件，注意它不是 React 原生的 `onChange`。
- 在删除按钮的点击事件中，你需要使用 `e.stopPropagation()` 来阻止事件冒泡，防止误触切换状态。



## 下一步预告

目前我们的待办事项数据是保存在内存中的，刷新页面后会丢失。在下一节《数据存储与优化》中，你将学习如何使用 Taro 提供的本地存储 API 将数据持久化下来，并进一步优化体验。



## 小结

本节你完成了 ToDo 应用的核心页面和交互逻辑，实现了添加、删除、切换完成状态等功能。你还初步接触了 TypeScript 类型定义，以及如何在 Taro 中使用组件、事件和状态管理。接下来，让我们把这些数据保存下来，让你的 ToDo 更加持久可靠。
