---
sidebar_position: 20
---

# PHP 编程规范

掌握良好的编程规范对于写出**清晰、可维护、可协作的 PHP 代码**非常重要。本节内容将带你了解 PHP 中常见的编程规范，包括命名规则、代码风格、注释规范、PSR 标准等内容。



## 为什么要遵循编程规范？

良好的编程规范可以带来以下好处：

- 让代码更具**可读性**和一致性。
- 方便**团队协作**，减少沟通成本。
- 降低**维护成本**，更容易排查 bug。
- 让工具如代码格式化、自动补全、静态分析器更好地发挥作用。



:::tip 基本书写风格（以 PSR-12 为参考）

**PSR（PHP Standard Recommendation）** 是由 PHP-FIG（PHP Framework Interop Group）制定的 PHP 编码规范。其中，`PSR-1` 和 `PSR-12` 是目前主流推荐的书写标准。

:::



## ✅ 1. 文件结构规范

- PHP 文件必须以 `<?php` 开头。
- 每个 PHP 文件中 **只能声明一个类、接口或 trait**。
- 文件末尾**不要使用 `?>` 标签**（防止输出多余空格导致问题）。



## ✅ 2. 命名规范

| 类型      | 命名风格             | 示例                 |
| --------- | -------------------- | -------------------- |
| 变量      | 小驼峰（camelCase）  | `$userName`          |
| 函数/方法 | 小驼峰（camelCase）  | `getUserInfo()`      |
| 类名      | 大驼峰（PascalCase） | `UserController`     |
| 常量      | 全大写 + 下划线      | `MAX_LENGTH`         |
| 文件名    | 与类名一致           | `UserController.php` |



## ✅ 3. 缩进与空格

- 使用 **4 个空格** 进行缩进（不要用 Tab）。
- 运算符两边要保留一个空格（如 `$a + $b`）。
- `if`、`for`、`while` 等语句的括号和大括号之间 **加空格**：

```php
if ($a > $b) {
    echo "a 比 b 大";
}
```



## ✅ 4. 类和方法结构

- 方法之间留一个空行。
- 使用可见性关键词（`public`、`private`、`protected`）明确方法作用范围。
- 成员变量尽量声明为 `private`，通过 getter/setter 访问。

```php
class User {
    private $name;

    public function setName($name) {
        $this->name = $name;
    }

    public function getName() {
        return $this->name;
    }
}
```



## ✅ 5. 控制结构书写

以下写法更清晰：

```php
if ($user) {
    echo "欢迎，$user";
} else {
    echo "请登录";
}
```

❌ 不推荐这种写法：

```php
if($user){echo "欢迎，$user";}else{echo "请登录";}
```



## ✅ 6. 函数与参数

- 参数列表建议换行并对齐（超过三个参数时尤为推荐）：

```php
function createUser(
    string $name,
    int $age,
    string $email
) {
    // ...
}
```



## ✅ 7. 注释规范

使用 **单行注释（//）** 或 **块注释（/** */）** 来解释复杂逻辑、函数说明等。

```php
// 检查用户是否已登录
if (!isset($_SESSION["user"])) {
    // 跳转到登录页
    header("Location: login.php");
    exit;
}
```

推荐函数注释使用 PHPDoc 风格：

```php
/**
 * 计算两个数字的和
 *
 * @param int $a
 * @param int $b
 * @return int
 */
function add($a, $b) {
    return $a + $b;
}
```



## ✅ 8. 编码风格工具推荐

- **PHP-CS-Fixer**：根据 PSR-12 自动格式化代码。
- **PHP_CodeSniffer**：分析和修复不符合规范的代码。
- **EditorConfig**：统一不同编辑器的代码风格。
- **PHPStan / Psalm**：静态代码分析工具，检测潜在 bug。



## 常见 PSR 编码规范简介



| PSR 标准 | 说明                               |
| -------- | ---------------------------------- |
| PSR-1    | 基础代码风格规范                   |
| PSR-4    | 自动加载规范（命名空间与目录结构） |
| PSR-12   | PSR-1 的扩展，推荐书写格式         |
| PSR-3    | 日志接口规范                       |
| PSR-7    | HTTP 请求与响应接口规范            |



## 小结

良好的 PHP 编程规范不仅让你写出干净利落的代码，也能大大提升项目的可维护性。你可以参考 PSR-1 和 PSR-12 规范来规范自己的代码风格，也可以使用自动化工具来辅助检查和格式化。特别是在团队协作或开源项目中，遵循统一规范是高效沟通和协作的基础。
