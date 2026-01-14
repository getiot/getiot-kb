---
sidebar_position: 2
slug: /css-navbar
---

# CSS 导航栏与菜单

导航栏是网站最重要的组件之一，它帮助用户快速找到所需内容。本章将介绍如何实现各种类型的导航栏和菜单，包括水平导航、垂直导航、下拉菜单和响应式导航。

## 导航栏的常见结构

### 基本结构

```html
<nav class="navbar">
  <div class="navbar-brand">Logo</div>
  <ul class="navbar-menu">
    <li><a href="#">首页</a></li>
    <li><a href="#">关于</a></li>
    <li><a href="#">服务</a></li>
    <li><a href="#">联系</a></li>
  </ul>
</nav>
```

## 水平导航与垂直导航

### 水平导航

```css
.navbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px 20px;
  background-color: #333;
}

.navbar-menu {
  display: flex;
  list-style: none;
  gap: 30px;
  margin: 0;
  padding: 0;
}

.navbar-menu a {
  color: white;
  text-decoration: none;
  padding: 10px;
  transition: color 0.3s;
}

.navbar-menu a:hover {
  color: #007bff;
}
```

### 垂直导航

```css
.navbar {
  display: flex;
  flex-direction: column;
  width: 200px;
  background-color: #333;
  padding: 20px;
}

.navbar-menu {
  display: flex;
  flex-direction: column;
  list-style: none;
  gap: 10px;
  margin: 0;
  padding: 0;
}

.navbar-menu a {
  color: white;
  text-decoration: none;
  padding: 10px;
  display: block;
  border-radius: 4px;
  transition: background-color 0.3s;
}

.navbar-menu a:hover {
  background-color: #555;
}
```

## 下拉菜单的基本实现

### 基础下拉菜单

```html
<nav class="navbar">
  <ul class="navbar-menu">
    <li>
      <a href="#">产品</a>
      <ul class="dropdown">
        <li><a href="#">产品 1</a></li>
        <li><a href="#">产品 2</a></li>
        <li><a href="#">产品 3</a></li>
      </ul>
    </li>
  </ul>
</nav>
```

```css
.navbar-menu {
  display: flex;
  list-style: none;
  position: relative;
}

.navbar-menu > li {
  position: relative;
}

.dropdown {
  position: absolute;
  top: 100%;
  left: 0;
  display: none;
  list-style: none;
  background-color: white;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  min-width: 200px;
  padding: 10px 0;
  margin: 0;
}

.navbar-menu > li:hover .dropdown {
  display: block;
}

.dropdown li {
  padding: 0;
}

.dropdown a {
  display: block;
  padding: 10px 20px;
  color: #333;
  text-decoration: none;
  transition: background-color 0.3s;
}

.dropdown a:hover {
  background-color: #f5f5f5;
}
```

### 带动画的下拉菜单

```css
.dropdown {
  position: absolute;
  top: 100%;
  left: 0;
  opacity: 0;
  visibility: hidden;
  transform: translateY(-10px);
  transition: opacity 0.3s, transform 0.3s, visibility 0.3s;
  list-style: none;
  background-color: white;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  min-width: 200px;
  padding: 10px 0;
  margin: 0;
}

.navbar-menu > li:hover .dropdown {
  opacity: 1;
  visibility: visible;
  transform: translateY(0);
}
```

## 悬停与激活状态设计

### 悬停效果

```css
.navbar-menu a {
  position: relative;
  color: #333;
  text-decoration: none;
  padding: 10px 20px;
  transition: color 0.3s;
}

.navbar-menu a::after {
  content: "";
  position: absolute;
  bottom: 0;
  left: 50%;
  width: 0;
  height: 2px;
  background-color: #007bff;
  transition: width 0.3s, left 0.3s;
}

.navbar-menu a:hover::after {
  width: 100%;
  left: 0;
}
```

### 激活状态

```css
.navbar-menu a.active {
  color: #007bff;
  font-weight: bold;
}

.navbar-menu a.active::after {
  width: 100%;
  left: 0;
}
```

## 响应式导航的思路

### 移动优先的响应式导航

```html
<nav class="navbar">
  <div class="navbar-brand">Logo</div>
  <button class="navbar-toggle" aria-label="切换菜单">
    <span></span>
    <span></span>
    <span></span>
  </button>
  <ul class="navbar-menu">
    <li><a href="#">首页</a></li>
    <li><a href="#">关于</a></li>
    <li><a href="#">服务</a></li>
    <li><a href="#">联系</a></li>
  </ul>
</nav>
```

```css
.navbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px 20px;
  background-color: #333;
}

.navbar-toggle {
  display: block;
  background: none;
  border: none;
  cursor: pointer;
  padding: 5px;
}

.navbar-toggle span {
  display: block;
  width: 25px;
  height: 3px;
  background-color: white;
  margin: 5px 0;
  transition: transform 0.3s;
}

.navbar-menu {
  position: fixed;
  top: 60px;
  left: -100%;
  width: 100%;
  height: calc(100vh - 60px);
  background-color: #333;
  list-style: none;
  margin: 0;
  padding: 20px 0;
  transition: left 0.3s;
  flex-direction: column;
  gap: 0;
}

.navbar-menu.active {
  left: 0;
}

.navbar-menu li {
  width: 100%;
}

.navbar-menu a {
  display: block;
  color: white;
  text-decoration: none;
  padding: 15px 20px;
  border-bottom: 1px solid #555;
}

/* 桌面端 */
@media (min-width: 768px) {
  .navbar-toggle {
    display: none;
  }
  
  .navbar-menu {
    position: static;
    display: flex;
    flex-direction: row;
    width: auto;
    height: auto;
    background-color: transparent;
    padding: 0;
    gap: 30px;
  }
  
  .navbar-menu a {
    border-bottom: none;
    padding: 10px;
  }
}
```

## 示例拆解

### 完整示例：现代响应式导航栏

```html
<nav class="navbar">
  <div class="navbar-container">
    <div class="navbar-brand">
      <a href="#">Logo</a>
    </div>
    <button class="navbar-toggle" id="navbarToggle">
      <span class="hamburger"></span>
    </button>
    <ul class="navbar-menu" id="navbarMenu">
      <li><a href="#" class="active">首页</a></li>
      <li><a href="#">关于</a></li>
      <li class="dropdown-item">
        <a href="#">服务 <span class="arrow">▼</span></a>
        <ul class="dropdown">
          <li><a href="#">服务 1</a></li>
          <li><a href="#">服务 2</a></li>
          <li><a href="#">服务 3</a></li>
        </ul>
      </li>
      <li><a href="#">联系</a></li>
    </ul>
  </div>
</nav>
```

```css
.navbar {
  background-color: white;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  position: sticky;
  top: 0;
  z-index: 1000;
}

.navbar-container {
  max-width: 1200px;
  margin: 0 auto;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0 20px;
}

.navbar-brand a {
  font-size: 24px;
  font-weight: bold;
  color: #333;
  text-decoration: none;
}

.navbar-toggle {
  display: none;
  background: none;
  border: none;
  cursor: pointer;
  padding: 10px;
}

.hamburger {
  display: block;
  width: 25px;
  height: 3px;
  background-color: #333;
  position: relative;
  transition: background-color 0.3s;
}

.hamburger::before,
.hamburger::after {
  content: "";
  position: absolute;
  width: 100%;
  height: 3px;
  background-color: #333;
  transition: transform 0.3s;
}

.hamburger::before {
  top: -8px;
}

.hamburger::after {
  bottom: -8px;
}

.navbar-toggle.active .hamburger {
  background-color: transparent;
}

.navbar-toggle.active .hamburger::before {
  transform: rotate(45deg);
  top: 0;
}

.navbar-toggle.active .hamburger::after {
  transform: rotate(-45deg);
  bottom: 0;
}

.navbar-menu {
  display: flex;
  list-style: none;
  gap: 30px;
  margin: 0;
  padding: 0;
}

.navbar-menu a {
  color: #333;
  text-decoration: none;
  padding: 15px 0;
  display: block;
  position: relative;
  transition: color 0.3s;
}

.navbar-menu a::after {
  content: "";
  position: absolute;
  bottom: 10px;
  left: 0;
  width: 0;
  height: 2px;
  background-color: #007bff;
  transition: width 0.3s;
}

.navbar-menu a:hover,
.navbar-menu a.active {
  color: #007bff;
}

.navbar-menu a:hover::after,
.navbar-menu a.active::after {
  width: 100%;
}

.dropdown-item {
  position: relative;
}

.dropdown {
  position: absolute;
  top: 100%;
  left: 0;
  display: none;
  list-style: none;
  background-color: white;
  box-shadow: 0 4px 8px rgba(0,0,0,0.1);
  min-width: 200px;
  padding: 10px 0;
  margin: 0;
  border-radius: 4px;
}

.dropdown-item:hover .dropdown {
  display: block;
}

.dropdown a {
  padding: 10px 20px;
}

.dropdown a::after {
  display: none;
}

/* 响应式 */
@media (max-width: 767px) {
  .navbar-toggle {
    display: block;
  }
  
  .navbar-menu {
    position: fixed;
    top: 60px;
    left: -100%;
    width: 100%;
    height: calc(100vh - 60px);
    background-color: white;
    flex-direction: column;
    gap: 0;
    padding: 20px 0;
    transition: left 0.3s;
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
  }
  
  .navbar-menu.active {
    left: 0;
  }
  
  .navbar-menu li {
    width: 100%;
  }
  
  .navbar-menu a {
    padding: 15px 20px;
    border-bottom: 1px solid #f0f0f0;
  }
  
  .dropdown {
    position: static;
    display: none;
    box-shadow: none;
    background-color: #f5f5f5;
  }
  
  .dropdown-item.active .dropdown {
    display: block;
  }
}
```

```javascript
// JavaScript 控制菜单切换
const toggle = document.getElementById('navbarToggle');
const menu = document.getElementById('navbarMenu');

toggle.addEventListener('click', () => {
  toggle.classList.toggle('active');
  menu.classList.toggle('active');
});
```

## 小结

导航栏与菜单的实现要点：

- **基本结构**：Logo + 菜单列表
- **水平/垂直导航**：使用 Flexbox 控制方向
- **下拉菜单**：使用绝对定位和悬停显示
- **状态设计**：悬停和激活状态的视觉反馈
- **响应式设计**：移动端折叠菜单，桌面端展开

**关键技巧**：
- 使用 Flexbox 简化布局
- 使用绝对定位实现下拉菜单
- 添加过渡动画提升体验
- 移动优先的响应式设计
- 考虑可访问性（键盘导航、ARIA 标签）

掌握了导航栏的实现，你就能创建专业的网站导航。在下一章，我们将学习按钮与交互元素的实现。
