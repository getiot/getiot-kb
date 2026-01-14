---
sidebar_position: 10
slug: /css-layers
---

# CSS 层（@layer）

`@layer` 提供了“层叠层”（Cascade Layers）机制，让你可以显式声明样式的层级顺序，从而控制不同来源、不同模块的覆盖关系，避免因选择器特异性大战而导致的维护难题。

## 为什么需要这个特性

1. **可预测的覆盖顺序**：显式定义层级顺序，避免特异性冲突  
2. **模块化管理**：为基础样式、组件、主题、工具类分层  
3. **易于维护**：减少 `!important` 和高特异性选择器的依赖  
4. **渐进增强**：可安全地添加新层而不破坏旧层  
5. **团队协作**：约定层级，避免样式互相踩踏

## 核心概念解释

### 声明层
使用 `@layer` 声明层。层的顺序由**第一次声明**的顺序决定。
```css
@layer reset, base, components, utilities;
```

### 定义样式
将样式放入对应层。
```css
@layer reset {
  * { margin: 0; padding: 0; box-sizing: border-box; }
}

@layer base {
  body { font-family: sans-serif; color: #333; }
}

@layer components {
  .button { padding: 10px 20px; border-radius: 6px; }
}

@layer utilities {
  .text-center { text-align: center; }
}
```

### 未声明的层
未显式列出的层，按出现顺序排在已声明层之后。

### 层与特异性
层级优先于特异性：**先比较层，后比较特异性**。上层样式会覆盖下层样式，即使特异性更低。

## 常见用法

### 1. 预定义层顺序
```css
@layer reset, base, components, utilities, overrides;
```

### 2. 模块分层
```css
@layer components.buttons {
  .btn { padding: 10px 20px; }
}

@layer components.cards {
  .card { border-radius: 8px; }
}
```

### 3. 主题与工具类
```css
@layer theme {
  :root { --color-primary: #007bff; }
}

@layer utilities {
  .bg-primary { background-color: var(--color-primary); }
}
```

## 示例

### 示例 1：基础分层
```css
@layer reset, base, components, utilities;

@layer reset {
  * { margin: 0; padding: 0; box-sizing: border-box; }
}

@layer base {
  body { font-family: \"Inter\", system-ui; color: #333; }
}

@layer components {
  .btn { padding: 10px 20px; border-radius: 6px; }
}

@layer utilities {
  .text-center { text-align: center; }
}
```

### 示例 2：覆盖顺序
```css
@layer base, theme, overrides;

@layer base {
  .btn { background: #eee; color: #333; }
}

@layer theme {
  .btn { background: #007bff; color: #fff; }
}

@layer overrides {
  .btn { background: #28a745; } /* 覆盖前面的层 */
}
```

## 注意事项

1. **声明顺序决定层级**：第一次声明的顺序生效，即使后续再次声明。  
2. **层优先于特异性**：高层的低特异性规则可以覆盖低层的高特异性规则。  
3. **与 @import 配合**：可在 `@import` 中使用 `layer` 关键字导入为某层。  
4. **渐进增强**：旧浏览器不支持 `@layer` 时，规则会当普通 CSS 处理，需测试关键样式。  
5. **命名约定**：团队约定层级和命名，常见：reset/base/components/utilities/theme/overrides。  
6. **避免滥用**：层过多会增加复杂度，保持简洁。  
7. **与 !important**：尽量用层解决覆盖，不要依赖 `!important`。

通过 `@layer`，你可以用更可控的方式管理样式的覆盖关系，减少特异性战争，使大型样式工程更易维护。 
