---
sidebar_position: 5
slug: /css-cards
---

# CSS 卡片与列表

卡片和列表是展示内容最常用的组件。卡片将相关信息组织在一起，提供清晰的视觉层次；列表则用于展示一系列相关项目。本章将介绍如何创建美观、实用的卡片和列表组件。

## 卡片与列表的使用场景

### 卡片的使用场景

- **产品展示**：商品卡片、服务卡片
- **内容展示**：文章卡片、博客卡片
- **用户信息**：用户卡片、个人资料
- **功能模块**：功能卡片、特性卡片

### 列表的使用场景

- **导航菜单**：侧边栏菜单、导航列表
- **内容列表**：文章列表、新闻列表
- **数据展示**：数据列表、统计列表
- **操作列表**：操作菜单、设置列表

## 卡片结构拆解

### 基本卡片结构

```html
<div class="card">
  <div class="card-image">
    <img src="image.jpg" alt="图片">
  </div>
  <div class="card-body">
    <h3 class="card-title">卡片标题</h3>
    <p class="card-text">卡片描述文字</p>
    <a href="#" class="card-link">了解更多</a>
  </div>
</div>
```

### 卡片样式

```css
.card {
  background-color: white;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  overflow: hidden;
  transition: transform 0.3s, box-shadow 0.3s;
}

.card:hover {
  transform: translateY(-4px);
  box-shadow: 0 4px 8px rgba(0,0,0,0.15);
}

.card-image {
  width: 100%;
  height: 200px;
  overflow: hidden;
}

.card-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.3s;
}

.card:hover .card-image img {
  transform: scale(1.05);
}

.card-body {
  padding: 20px;
}

.card-title {
  margin: 0 0 10px 0;
  font-size: 20px;
  font-weight: 600;
  color: #333;
}

.card-text {
  margin: 0 0 15px 0;
  color: #666;
  line-height: 1.6;
}

.card-link {
  color: #007bff;
  text-decoration: none;
  font-weight: 500;
  transition: color 0.3s;
}

.card-link:hover {
  color: #0056b3;
}
```

## 列表样式设计

### 1. 基础列表

```css
.list {
  list-style: none;
  padding: 0;
  margin: 0;
}

.list-item {
  padding: 12px 15px;
  border-bottom: 1px solid #eee;
  transition: background-color 0.3s;
}

.list-item:hover {
  background-color: #f5f5f5;
}

.list-item:last-child {
  border-bottom: none;
}
```

### 2. 带图标的列表

```html
<ul class="list">
  <li class="list-item">
    <span class="list-icon">📧</span>
    <span class="list-text">邮箱</span>
  </li>
  <li class="list-item">
    <span class="list-icon">📱</span>
    <span class="list-text">手机</span>
  </li>
</ul>
```

```css
.list-item {
  display: flex;
  align-items: center;
  gap: 15px;
  padding: 12px 15px;
}

.list-icon {
  font-size: 20px;
  width: 30px;
  text-align: center;
}

.list-text {
  flex: 1;
}
```

### 3. 操作列表

```html
<ul class="list">
  <li class="list-item">
    <span>设置</span>
    <button class="list-action">编辑</button>
  </li>
  <li class="list-item">
    <span>隐私</span>
    <button class="list-action">编辑</button>
  </li>
</ul>
```

```css
.list-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px 15px;
}

.list-action {
  padding: 5px 15px;
  background-color: #007bff;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}
```

## 多卡片布局方式

### 1. Flexbox 布局

```css
.card-grid {
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
}

.card {
  flex: 1 1 300px;
  min-width: 0;
}
```

### 2. Grid 布局

```css
.card-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 20px;
}
```

### 3. 响应式网格

```css
.card-grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 20px;
}

@media (min-width: 768px) {
  .card-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (min-width: 1200px) {
  .card-grid {
    grid-template-columns: repeat(3, 1fr);
  }
}
```

## 示例演示

### 示例 1：产品卡片

```html
<div class="card">
  <div class="card-image">
    <img src="product.jpg" alt="产品">
    <span class="card-badge">新品</span>
  </div>
  <div class="card-body">
    <h3 class="card-title">产品名称</h3>
    <p class="card-text">产品描述信息</p>
    <div class="card-footer">
      <span class="card-price">¥99.00</span>
      <button class="btn btn--primary">购买</button>
    </div>
  </div>
</div>
```

```css
.card {
  background-color: white;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  overflow: hidden;
  transition: transform 0.3s, box-shadow 0.3s;
}

.card:hover {
  transform: translateY(-4px);
  box-shadow: 0 4px 8px rgba(0,0,0,0.15);
}

.card-image {
  position: relative;
  width: 100%;
  height: 200px;
  overflow: hidden;
}

.card-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.card-badge {
  position: absolute;
  top: 10px;
  right: 10px;
  background-color: #ff6b6b;
  color: white;
  padding: 4px 8px;
  border-radius: 4px;
  font-size: 12px;
}

.card-body {
  padding: 20px;
}

.card-title {
  margin: 0 0 10px 0;
  font-size: 18px;
  font-weight: 600;
}

.card-text {
  margin: 0 0 15px 0;
  color: #666;
  line-height: 1.6;
}

.card-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.card-price {
  font-size: 20px;
  font-weight: bold;
  color: #ff6b6b;
}
```

### 示例 2：文章卡片

```html
<div class="card card--article">
  <div class="card-image">
    <img src="article.jpg" alt="文章">
  </div>
  <div class="card-body">
    <div class="card-meta">
      <span class="card-date">2024-01-01</span>
      <span class="card-category">技术</span>
    </div>
    <h3 class="card-title">文章标题</h3>
    <p class="card-text">文章摘要内容...</p>
    <a href="#" class="card-link">阅读全文 →</a>
  </div>
</div>
```

```css
.card--article .card-meta {
  display: flex;
  gap: 15px;
  margin-bottom: 10px;
  font-size: 14px;
  color: #999;
}

.card--article .card-title {
  margin-bottom: 10px;
}

.card--article .card-text {
  margin-bottom: 15px;
  display: -webkit-box;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
```

### 示例 3：用户卡片

```html
<div class="card card--user">
  <div class="card-header">
    <img src="avatar.jpg" alt="头像" class="card-avatar">
    <h3 class="card-name">用户名</h3>
    <p class="card-role">前端开发</p>
  </div>
  <div class="card-body">
    <p class="card-bio">个人简介信息...</p>
    <div class="card-stats">
      <div class="stat">
        <span class="stat-value">120</span>
        <span class="stat-label">文章</span>
      </div>
      <div class="stat">
        <span class="stat-value">1.2k</span>
        <span class="stat-label">粉丝</span>
      </div>
    </div>
  </div>
</div>
```

```css
.card--user {
  text-align: center;
}

.card-header {
  padding: 20px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
}

.card-avatar {
  width: 80px;
  height: 80px;
  border-radius: 50%;
  border: 4px solid white;
  margin-bottom: 10px;
}

.card-name {
  margin: 0 0 5px 0;
  font-size: 20px;
}

.card-role {
  margin: 0;
  opacity: 0.9;
}

.card-bio {
  padding: 20px;
  margin: 0;
  color: #666;
}

.card-stats {
  display: flex;
  justify-content: space-around;
  padding: 20px;
  border-top: 1px solid #eee;
}

.stat {
  display: flex;
  flex-direction: column;
}

.stat-value {
  font-size: 24px;
  font-weight: bold;
  color: #333;
}

.stat-label {
  font-size: 14px;
  color: #999;
}
```

## 小结

卡片与列表的实现要点：

- **卡片结构**：图片、标题、内容、操作
- **列表样式**：基础列表、图标列表、操作列表
- **布局方式**：Flexbox、Grid、响应式网格
- **交互效果**：悬停、点击、过渡动画
- **内容展示**：产品、文章、用户等不同场景

**关键原则**：
- 保持视觉层次清晰
- 提供适当的交互反馈
- 响应式设计适配不同设备
- 内容优先，样式为辅

掌握了卡片与列表的实现，你就能创建丰富的内容展示界面。在下一章，我们将学习加载动画与反馈的实现。
