---
sidebar_position: 7
sidebar_label: 数据库操作基础（SQL）
---

# 数据库中的数据操作基础（SQL 指令）

你已经了解了数据库的基本概念、模型以及事务机制等重要知识。接下来，我们将进入更加“动手”的阶段，也就是如何操作数据库中的数据。

在本节中，你将学习：

- 数据操作语言（DML）的基本类型
- 如何向数据库中添加、更新、删除数据
- 如何使用查询语句读取数据
- 常用的数据操作语法示例（以 SQL 为例）

虽然这部分内容以 SQL 为例讲解，但这些操作思想适用于大多数数据库系统。



## 数据操作语言（DML）简介

在数据库中，数据的“增、删、改、查”被统称为 **数据操作**（DML，Data Manipulation Language）。

| 操作类别 | 关键词   | 作用                     |
| -------- | -------- | ------------------------ |
| 增加数据 | `INSERT` | 向表中添加一条或多条记录 |
| 删除数据 | `DELETE` | 删除表中的一条或多条记录 |
| 修改数据 | `UPDATE` | 修改已有记录中的字段     |
| 查询数据 | `SELECT` | 获取指定的数据内容       |

:::tip 小技巧

你可以记住“增删改查”是数据库操作的四大基本功。

:::



## 添加数据：`INSERT`

你可以使用 `INSERT INTO` 语句向表中插入新数据。

**示例：假设你有一个 `students` 表，包含字段 `id`、`name` 和 `class`**

```sql showLineNumbers
INSERT INTO students (id, name, class)
VALUES (1, '小明', '三年级');
```

注意：字段顺序和插入的值要一一对应，字符型数据要加引号。

你也可以插入多条数据：

```sql showLineNumbers
INSERT INTO students (id, name, class)
VALUES 
(2, '小红', '三年级'),
(3, '小强', '四年级');
```



## 删除数据：`DELETE`

删除数据时要小心！`DELETE` 会永久移除数据（除非你有事务回滚机制）。

**示例：删除 ID 为 2 的学生**

```sql showLineNumbers
DELETE FROM students WHERE id = 2;
```

如果你忘了写 `WHERE` 条件，那就是把整张表清空了：

```sql showLineNumbers
DELETE FROM students;
-- 小心使用！
```



## 修改数据：`UPDATE`

你可以使用 `UPDATE` 修改已有数据的某些字段。

**示例：把学号为 3 的学生班级改为“五年级”**

```sql showLineNumbers
UPDATE students
SET class = '五年级'
WHERE id = 3;
```

🌟 如果你不加 `WHERE` 条件，所有学生的班级都会被改成“五年级”哦。



## 查询数据：`SELECT`

这是你操作最频繁的语句，用于读取数据。

### 示例 1：查询所有学生

```sql showLineNumbers
SELECT * FROM students;
```

### 示例 2：只查询姓名和班级

```sql showLineNumbers
SELECT name, class FROM students;
```

### 示例 3：查询三年级的学生

```sql showLineNumbers
SELECT * FROM students
WHERE class = '三年级';
```

你可以在 `SELECT` 中配合更多语句使用，比如：

- `ORDER BY`（排序）
- `LIMIT`（限制返回数量）
- `GROUP BY`（分组统计）

我们将在后续章节详细讲解。



## 数据操作中的注意事项

- 使用 `DELETE` 和 `UPDATE` 时 **一定要加 `WHERE` 条件**，防止误删或误改。
- 对于频繁操作的数据表，建议你先备份。
- 有些数据库支持 `RETURNING` 关键字，可以在插入或更新时直接返回修改结果（PostgreSQL、Oracle 等支持）。



## 小结

在本节中，你掌握了数据库中最基本的数据操作方法：

- 使用 `INSERT` 向表中添加数据
- 使用 `DELETE` 删除已有数据（注意 `WHERE` 条件）
- 使用 `UPDATE` 修改已有数据
- 使用 `SELECT` 查询数据内容（可以选字段、加条件）

这些操作是你今后与数据库“打交道”的核心技能。熟练掌握这些语句，将为你后续进行复杂查询和业务逻辑开发打下坚实基础。
