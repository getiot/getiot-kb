---
sidebar_position: 3
slug: /lua-multi-dimensional-arrays
---

# Lua 多维数组

Lua 没有专门的多维数组类型。多维数组通常有两种表示方法：数组的数组，或者把多维坐标映射到一维 table。

初学时建议你优先使用“数组的数组”，它最直观，也更容易阅读。

## 数组的数组

二维数组可以写成这样：

```lua showLineNumbers title="main.lua"
local matrix = {
   {1, 2, 3},
   {4, 5, 6},
   {7, 8, 9},
}

print(matrix[1][1])
print(matrix[2][3])
```

输出：

```text
1
6
```

`matrix[2][3]` 表示第 2 行第 3 列。

## 动态创建二维数组

下面创建一个 3 行 4 列的表格：

```lua showLineNumbers title="main.lua"
local rows = 3
local cols = 4
local matrix = {}

for row = 1, rows do
   matrix[row] = {}

   for col = 1, cols do
      matrix[row][col] = row * col
   end
end

for row = 1, rows do
   for col = 1, cols do
      io.write(matrix[row][col], "\t")
   end
   print()
end
```

输出：

```text
1	2	3	4
2	4	6	8
3	6	9	12
```

注意这一行：

```lua
matrix[row] = {}
```

你必须先为每一行创建一个 table，才能写 `matrix[row][col]`。

## 常见错误：忘记创建内层 table

下面这段代码会报错：

```lua
local matrix = {}
matrix[1][1] = 10
```

因为 `matrix[1]` 还是 `nil`，你不能对 `nil` 使用 `[1]`。

正确写法：

```lua
local matrix = {}
matrix[1] = {}
matrix[1][1] = 10
```

## 用一维 table 表示二维数组

有时为了节省一些 table 开销，或者为了配合底层 C 数据结构，你也可以把二维数组压平成一维 table。

假设有 `rows` 行、`cols` 列，可以这样计算下标：

```lua
local index = (row - 1) * cols + col
```

完整示例：

```lua showLineNumbers title="main.lua"
local rows = 3
local cols = 4
local matrix = {}

for row = 1, rows do
   for col = 1, cols do
      local index = (row - 1) * cols + col
      matrix[index] = row * col
   end
end

for row = 1, rows do
   for col = 1, cols do
      local index = (row - 1) * cols + col
      io.write(matrix[index], "\t")
   end
   print()
end
```

输出：

```text
1	2	3	4
2	4	6	8
3	6	9	12
```

这种方式性能和内存布局更可控，但可读性差一些。初学阶段你只需要知道它存在。

## 三维数组

三维数组就是继续嵌套 table：

```lua showLineNumbers title="main.lua"
local cube = {}

for x = 1, 2 do
   cube[x] = {}

   for y = 1, 2 do
      cube[x][y] = {}

      for z = 1, 2 do
         cube[x][y][z] = x + y + z
      end
   end
end

print(cube[1][2][2])
```

输出：

```text
5
```

嵌套层级越深，代码越难读。实际项目中，如果数据结构变复杂，建议封装访问函数。

## 小结

你需要掌握：

- 多维数组通常使用嵌套 table 表示。
- 写 `matrix[row][col]` 前，必须先创建 `matrix[row]`。
- 二维数组可以压平成一维 table，但代码可读性会下降。
- 数据结构复杂时，建议封装读写函数。
