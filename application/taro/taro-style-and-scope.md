---
sidebar_position: 7
authors: [luhuadong]
---

# Taro 样式与样式隔离

在这一章中，你将学习如何在 Taro 中编写页面样式，以及如何实现样式隔离，避免不同组件或页面之间的样式冲突。我们会讲解常见的样式写法、作用范围的控制方式，以及推荐的组织方式，帮助你写出更清晰、可维护的 Taro 样式代码。



## 样式文件的基本使用

在 Taro 项目中，每个页面或组件都可以搭配一个对应的样式文件。Taro 默认支持多种样式语言，包括：

- `.css`
- `.scss`（推荐）
- `.less`
- `.styl`

你可以在页面中直接引入对应的样式文件：

```tsx
import './index.scss';
```

请看下面示例：

`src/pages/home/index.tsx` 文件：

```tsx showLineNumbers title="index.tsx"
import './index.scss';

const Home = () => {
  return (
    <View className="home-container">
      <Text className="home-title">欢迎使用 Taro</Text>
    </View>
  );
};
```

`src/pages/home/index.scss` 文件：

```scss showLineNumbers title="index.scss"
.home-container {
  background-color: #fffbe6;
  padding: 20px;
}

.home-title {
  font-size: 24px;
  text-align: center;
}
```



## 样式隔离的实现方式

Taro 默认并不会像 Vue 的 `scoped` 或 React 的 `CSS Modules` 那样自动启用样式隔离，因此你有两种选择：

### 方式一：使用命名空间前缀（推荐）

最简单直接的做法是在 class 名称中加上命名空间，避免不同页面或组件使用了相同的类名。例如：

```scss showLineNumbers title="index.scss"
.home-container { ... }
.home-title { ... }
```

这样就避免了与其他页面的 `.container`、`.title` 等类名冲突。

### 方式二：使用 CSS Modules

你也可以启用 CSS Modules 来实现样式自动隔离。只需要将样式文件命名为 `*.module.scss`，并以对象方式引入：

```tsx showLineNumbers title="index.tsx"
import styles from './index.module.scss';

const Home = () => {
  return (
    <View className={styles.homeContainer}>
      <Text className={styles.homeTitle}>你好，Taro</Text>
    </View>
  );
};
```

`index.module.scss` 文件：

```scss showLineNumbers title="index.module.scss"
.homeContainer {
  padding: 20px;
  background-color: #e6f7ff;
}

.homeTitle {
  font-size: 22px;
  color: #333;
}
```

在这种模式下，类名会被自动转换为唯一的哈希值，完全避免样式污染。



## 样式作用域小贴士

无论你使用哪种样式管理方式，以下建议都非常重要：

- 避免使用全局样式，除非是通用类名（如 `text-center`）。
- 避免过度嵌套（建议保持嵌套不超过 3 层）。
- 如果使用 CSS Modules，不要混用模块化和非模块化样式。
- 样式文件和页面或组件同名，便于维护（如：`index.tsx` 对应 `index.scss` 或 `index.module.scss`）。



## 如何配置全局样式

你可以在 `src/app.tsx` 中引入全局样式，例如：

```tsx
import './app.scss';
```

这通常用于设置全局字体、颜色变量、通用布局等。



## 小结

在 Taro 中，你可以使用标准的 CSS 或预处理器如 SCSS 来为页面和组件编写样式。你可以通过命名规范或者使用 CSS Modules 来实现样式隔离，从而避免样式冲突。推荐为每个页面和组件单独维护样式文件，并使用合理的命名空间，提升项目的可维护性。样式是界面表达的重要组成部分，建议你保持代码整洁，分层清晰。
