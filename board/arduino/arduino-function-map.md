---
sidebar_position: 16
authors: [luhuadong]
---

# Arduino map 函数



**`map()`** 函数的作用是将数字从一个范围重新映射到另一个范围。不将值限制在范围内，因为超出范围的值有时是有意且有用的。如果需要限制范围，可以在此函数之前或之后使用 `constrain()` 函数。



## 函数原型

```cpp showLineNumbers
map(value, fromLow, fromHigh, toLow, toHigh)
```

**参数**

- `value`：需要映射的数值。
- `fromLow`：当前尺度范围的下限。
- `fromHigh`：当前尺度范围的上限。
- `toLow`：目标尺度范围的下限。
- `toHigh`：目标尺度范围的上限。

**返回值**

重新映射后的值。

**注意**：任一范围的“下限”可能大于或小于“上限”，并且可以是负数。



## 应用示例

使用 `map()` 函数来反转数字范围

```cpp showLineNumbers
y = map(x, 1, 50, 50, 1);
```

反转数字范围到负数范围

```cpp showLineNumbers
y = map(x, 1, 50, 50, -100);
```

将数值从 0-1023 范围映射到 0-255 范围。

```cpp showLineNumbers
/* Map an analog value to 8 bits (0 to 255) */
void setup() {}

void loop() {
  int val = analogRead(0);
  val = map(val, 0, 1023, 0, 255);
  analogWrite(9, val);
}
```



## 函数实现

```cpp showLineNumbers
long map(long x, long in_min, long in_max, long out_min, long out_max) {
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}
```



## 注意事项

`map()` 函数使用整数转换，因此，分数可能会因此而被抑制。例如，像 3/2、4/3、5/4 这样的分数都会从 map() 函数返回为 1，尽管它们的实际值不同。因此，如果你的项目需要精确计算（例如电压精确到小数点后 3 位），请考虑避免使用 map() 并自己在代码中手动实现计算。


