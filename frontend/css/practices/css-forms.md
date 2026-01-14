---
sidebar_position: 4
slug: /css-forms
---

# CSS 表单样式

表单是网站中最重要的交互组件之一，用户通过表单提交数据、进行搜索、完成注册等操作。一个设计良好的表单不仅要有美观的外观，还要有良好的可用性和可访问性。本章将介绍如何美化表单元素，创建统一、易用的表单样式。

## 表单元素的特点

### 常见表单元素

- **输入框（input）**：文本、邮箱、密码、数字等
- **文本域（textarea）**：多行文本输入
- **选择框（select）**：下拉选择
- **复选框（checkbox）**：多选
- **单选按钮（radio）**：单选
- **按钮（button）**：提交、重置
- **标签（label）**：表单字段标签

### 表单元素的默认样式

不同浏览器对表单元素有默认样式，这些样式通常：
- 外观不一致
- 不够美观
- 难以自定义

## 表单样式的常见问题

### 1. 样式不统一

不同浏览器的默认样式不同，导致表单外观不一致。

### 2. 难以自定义

某些表单元素（如 select、checkbox）难以自定义样式。

### 3. 移动端体验差

默认样式在移动设备上可能不够友好。

### 4. 缺乏视觉反馈

缺少焦点、验证等状态的视觉反馈。

## 基础表单美化技巧

### 1. 输入框样式

```css
.input {
  width: 100%;
  padding: 10px 15px;
  font-size: 16px;
  border: 2px solid #ddd;
  border-radius: 4px;
  background-color: white;
  transition: border-color 0.3s, box-shadow 0.3s;
}

.input:focus {
  outline: none;
  border-color: #007bff;
  box-shadow: 0 0 0 3px rgba(0,123,255,0.25);
}

.input:disabled {
  background-color: #f5f5f5;
  cursor: not-allowed;
  opacity: 0.6;
}
```

### 2. 文本域样式

```css
.textarea {
  width: 100%;
  padding: 10px 15px;
  font-size: 16px;
  border: 2px solid #ddd;
  border-radius: 4px;
  resize: vertical;
  min-height: 100px;
  font-family: inherit;
}

.textarea:focus {
  outline: none;
  border-color: #007bff;
  box-shadow: 0 0 0 3px rgba(0,123,255,0.25);
}
```

### 3. 选择框样式

```css
.select {
  width: 100%;
  padding: 10px 15px;
  font-size: 16px;
  border: 2px solid #ddd;
  border-radius: 4px;
  background-color: white;
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23333' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
  background-repeat: no-repeat;
  background-position: right 15px center;
  padding-right: 40px;
  appearance: none;
  cursor: pointer;
}

.select:focus {
  outline: none;
  border-color: #007bff;
  box-shadow: 0 0 0 3px rgba(0,123,255,0.25);
}
```

### 4. 复选框和单选按钮

```css
.checkbox,
.radio {
  width: 20px;
  height: 20px;
  margin-right: 10px;
  cursor: pointer;
  accent-color: #007bff;
}

/* 自定义样式（使用伪元素） */
.custom-checkbox {
  position: relative;
  display: inline-block;
  width: 20px;
  height: 20px;
}

.custom-checkbox input {
  position: absolute;
  opacity: 0;
  cursor: pointer;
}

.custom-checkbox .checkmark {
  position: absolute;
  top: 0;
  left: 0;
  height: 20px;
  width: 20px;
  background-color: white;
  border: 2px solid #ddd;
  border-radius: 4px;
  transition: all 0.3s;
}

.custom-checkbox input:checked ~ .checkmark {
  background-color: #007bff;
  border-color: #007bff;
}

.custom-checkbox .checkmark::after {
  content: "";
  position: absolute;
  display: none;
  left: 6px;
  top: 2px;
  width: 5px;
  height: 10px;
  border: solid white;
  border-width: 0 2px 2px 0;
  transform: rotate(45deg);
}

.custom-checkbox input:checked ~ .checkmark::after {
  display: block;
}
```

## 表单布局设计

### 1. 垂直布局

```css
.form-group {
  margin-bottom: 20px;
}

.form-label {
  display: block;
  margin-bottom: 5px;
  font-weight: 500;
  color: #333;
}

.form-input {
  width: 100%;
  padding: 10px 15px;
  border: 2px solid #ddd;
  border-radius: 4px;
  font-size: 16px;
}

.form-help {
  margin-top: 5px;
  font-size: 14px;
  color: #666;
}

.form-error {
  margin-top: 5px;
  font-size: 14px;
  color: #dc3545;
}
```

### 2. 水平布局

```css
.form-group--horizontal {
  display: flex;
  align-items: center;
  gap: 15px;
}

.form-group--horizontal .form-label {
  width: 150px;
  margin-bottom: 0;
  flex-shrink: 0;
}

.form-group--horizontal .form-input {
  flex: 1;
}
```

### 3. 内联布局

```css
.form-inline {
  display: flex;
  gap: 10px;
  align-items: flex-end;
}

.form-inline .form-group {
  margin-bottom: 0;
  flex: 1;
}
```

### 4. 响应式表单

```css
.form-group {
  margin-bottom: 20px;
}

.form-label {
  display: block;
  margin-bottom: 5px;
}

@media (min-width: 768px) {
  .form-group {
    display: flex;
    align-items: center;
  }
  
  .form-label {
    width: 150px;
    margin-bottom: 0;
    margin-right: 15px;
  }
  
  .form-input {
    flex: 1;
  }
}
```

## 表单验证样式

### 1. 验证状态

```css
.form-input--valid {
  border-color: #28a745;
}

.form-input--valid:focus {
  border-color: #28a745;
  box-shadow: 0 0 0 3px rgba(40,167,69,0.25);
}

.form-input--invalid {
  border-color: #dc3545;
}

.form-input--invalid:focus {
  border-color: #dc3545;
  box-shadow: 0 0 0 3px rgba(220,53,69,0.25);
}
```

### 2. 验证图标

```css
.form-group {
  position: relative;
}

.form-input--valid + .form-icon::after {
  content: "✓";
  position: absolute;
  right: 15px;
  top: 50%;
  transform: translateY(-50%);
  color: #28a745;
}

.form-input--invalid + .form-icon::after {
  content: "✕";
  position: absolute;
  right: 15px;
  top: 50%;
  transform: translateY(-50%);
  color: #dc3545;
}
```

## 可访问性与可用性提示

### 1. 标签关联

```html
<label for="username">用户名</label>
<input type="text" id="username" name="username">
```

### 2. 必填字段标记

```css
.form-label--required::after {
  content: " *";
  color: #dc3545;
}
```

### 3. 占位符文本

```css
.form-input::placeholder {
  color: #999;
  opacity: 1;
}
```

### 4. 错误提示

```html
<div class="form-group">
  <label for="email">邮箱</label>
  <input type="email" id="email" class="form-input form-input--invalid">
  <div class="form-error">请输入有效的邮箱地址</div>
</div>
```

### 5. 帮助文本

```html
<div class="form-group">
  <label for="password">密码</label>
  <input type="password" id="password" class="form-input">
  <div class="form-help">密码至少包含 8 个字符</div>
</div>
```

## 完整示例

### 登录表单

```html
<form class="form">
  <div class="form-group">
    <label for="email" class="form-label">邮箱</label>
    <input 
      type="email" 
      id="email" 
      name="email" 
      class="form-input"
      placeholder="请输入邮箱"
      required
    >
  </div>
  
  <div class="form-group">
    <label for="password" class="form-label">密码</label>
    <input 
      type="password" 
      id="password" 
      name="password" 
      class="form-input"
      placeholder="请输入密码"
      required
    >
  </div>
  
  <div class="form-group">
    <label class="checkbox-label">
      <input type="checkbox" name="remember">
      <span>记住我</span>
    </label>
  </div>
  
  <button type="submit" class="btn btn--primary btn--block">登录</button>
</form>
```

```css
.form {
  max-width: 400px;
  margin: 0 auto;
  padding: 30px;
  background-color: white;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.form-group {
  margin-bottom: 20px;
}

.form-label {
  display: block;
  margin-bottom: 5px;
  font-weight: 500;
  color: #333;
}

.form-input {
  width: 100%;
  padding: 10px 15px;
  font-size: 16px;
  border: 2px solid #ddd;
  border-radius: 4px;
  transition: border-color 0.3s, box-shadow 0.3s;
}

.form-input:focus {
  outline: none;
  border-color: #007bff;
  box-shadow: 0 0 0 3px rgba(0,123,255,0.25);
}

.checkbox-label {
  display: flex;
  align-items: center;
  cursor: pointer;
}

.checkbox-label input {
  margin-right: 8px;
}

.btn--block {
  width: 100%;
}
```

## 小结

表单样式的实现要点：

- **基础美化**：统一输入框、文本域、选择框样式
- **布局设计**：垂直、水平、内联、响应式布局
- **验证样式**：有效、无效状态的视觉反馈
- **可访问性**：标签关联、必填标记、错误提示
- **用户体验**：清晰的反馈、友好的交互

**关键原则**：
- 保持样式一致性
- 提供清晰的视觉反馈
- 确保可访问性
- 优化移动端体验
- 合理使用验证样式

掌握了表单样式的实现，你就能创建专业、易用的表单。在下一章，我们将学习卡片与列表的实现。
