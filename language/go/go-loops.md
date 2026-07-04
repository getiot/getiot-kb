---
sidebar_position: 11
slug: /go-loops
---

# Go 语言循环语句

在 Go 语言中，循环语句用于重复执行一段代码，直到满足退出条件。Go 语言提供了多种循环语句，包括 `for` 循环和 `range` 循环，以及循环控制语句 `break`、`continue` 以及 `goto` 语句等。循环语句对于需要处理规律性重复执行的操作非常有用，掌握本节内容可以帮助你写出更好的程序。

:::tip

本文所有示例代码可在 [GitHub](https://github.com/getiot/go-courses/tree/main/basic/loops) 下载。

:::

## for 循环

`for` 循环是 Go 语言中最常用的循环结构，可以执行指定次数的循环。它允许重复执行一段代码，直到指定的条件不再满足。

Go 语言的 `for` 循环有三种形式，只有其中的一种使用分号。

1. **和 C 语言的 `for` 一样：**

   ```go
   for init; condition; post { }
   ```

   其中，`init` 一般为赋值表达式，给控制变量赋初值；`condition` 是关系表达式或逻辑表达式，循环控制条件；`post` 一般为赋值表达式，给控制变量增量或减量。

   `for` 语句执行过程：先对表达式 `init` 赋初值；再判别赋值表达式 `init` 是否满足给定条件，若其值为真，满足循环条件，则执行循环体内语句；然后执行 `post`，进入第二次循环，再判别 `condition`；否则判断 `condition` 的值为假，不满足条件，就终止 `for` 循环，执行循环体外语句。

2. **和 C 的 `while` 一样：**

   ```go
   for condition { }
   ```

3. **和 C 的 `for(;;)` 一样：**

   ```go
   for { }
   ```

请看下面实例：

```go showLineNumbers title="for_example_01.go"
package main

import "fmt"

func main() {
    var a, b = 10, 12

    /* for 循环 */
    for i := 0; i < 5; i++ {
        fmt.Printf("i 的值为 %d\n", i)
    }

    for a < b {
        fmt.Printf("a 的值为 %d\n", a)
        a++
    }
}
```

以上实例运行输出结果为：

```bash
i 的值为 0
i 的值为 1
i 的值为 2
i 的值为 3
i 的值为 4
a 的值为 10
a 的值为 11
```



## range 循环

`for` 循环的 `range` 格式可以对 slice、map、数组、字符串等进行迭代循环。格式如下：

```go
for key, value := range oldMap {
    newMap[key] = value
}
```

请看下面实例：

```go showLineNumbers title="for_example_02.go"
package main

import "fmt"

func main() {

    numbers := [6]int{4, 6, 2, 17}

    for i, x := range numbers {
        fmt.Printf("第 %d 位 x 的值 = %d\n", i, x)
    }
}
```

以上实例运行输出结果为:

```bash
第 0 位 x 的值 = 4
第 1 位 x 的值 = 6
第 2 位 x 的值 = 2
第 3 位 x 的值 = 17
第 4 位 x 的值 = 0
第 5 位 x 的值 = 0
```



## 循环嵌套

Go 语言允许用户在循环内使用循环，也就是“循环嵌套”，理论上对嵌套的层数没有限制，但从代码可读性角度考虑，通常建议循环嵌套不要超过三层。

以下为 Go 语言嵌套循环的格式：

```go
for [condition |  ( init; condition; increment ) | Range]
{
    for [condition |  ( init; condition; increment ) | Range]
    {
        statement(s)
    }
    statement(s)
}
```

下面实例使用 `for` 循环嵌套打印九九乘法表：

```go showLineNumbers title="for_example_03.go"
package main

import "fmt"

func main() {
    for i := 1; i <= 9; i++ {
        for j := 1; j <= i; j++ {
            fmt.Printf("%d*%d=%d\t", j, i, i*j)
        }
        fmt.Println()
    }
}
```

以上实例运行输出结果为：

```bash
1*1=1
1*2=2   2*2=4
1*3=3   2*3=6   3*3=9
1*4=4   2*4=8   3*4=12  4*4=16
1*5=5   2*5=10  3*5=15  4*5=20  5*5=25
1*6=6   2*6=12  3*6=18  4*6=24  5*6=30  6*6=36
1*7=7   2*7=14  3*7=21  4*7=28  5*7=35  6*7=42  7*7=49
1*8=8   2*8=16  3*8=24  4*8=32  5*8=40  6*8=48  7*8=56  8*8=64
1*9=9   2*9=18  3*9=27  4*9=36  5*9=45  6*9=54  7*9=63  8*9=72  9*9=81
```



## break 语句

有时候，我们想要提前跳出循环，因此 Go 语言提供了 `break` 语句用于在循环语句中跳出循环，并开始执行循环之后的语句。

`break` 语法格式如下：

```go
break
```

请看下面实例：

```go showLineNumbers title="for_example_04.go"
package main

import "fmt"

func main() {
    /* 定义局部变量 */
    var a int = 10

    /* for 循环 */
    for a < 20 {
        fmt.Printf("%d\n", a)
        a++
        if a > 15 {
            /* 使用 break 语句跳出循环 */
            break
        }
    }
}
```

以上实例执行结果为：

```go
10
11
12
13
14
15
```

可以看到，当 a 大于 15 以后就停止打印了。



## continue 语句

`continue` 语句有点像 `break` 语句，也是控制循环的语句。但和 `break` 语句不同，`continue` 不是跳出循环，而是跳过当前循环执行下一次循环语句。

注意：在 `for` 循环中，执行 `continue` 语句会触发 `for` 增量语句的执行。

`continue` 语法格式如下：

```go
continue
```

请看下面实例：

```go showLineNumbers title="for_example_05.go"
package main

import "fmt"

func main() {
    /* 定义局部变量 */
    var a int = 10

    /* for 循环 */
    for a < 20 {
        if a == 15 {
            /* 跳过此次循环 */
            a = a + 1
            continue
        }
        fmt.Printf("%d\n", a)
        a++;     
     }  
}
```

以上实例执行结果为：

```bash
10
11
12
13
14
16
17
18
19
```

可以看到，打印的数据中缺少了 15。



## goto 语句

`goto` 语句允许无条件地跳转到程序中的标签，并继续执行从那里开始的代码。它通常用于处理错误或在特定条件下跳出循环。由于 `goto` 可以无条件地跳转，因此通常会和条件语句配合使用，用于实现条件转移、构成循环、跳出循环体等功能。但是，在结构化程序设计中一般不建议使用 `goto` 语句， 以免造成程序流程的混乱，使理解和调试程序都产生困难。

`goto` 语法格式如下：

```go
goto label
...
label: statement
```

`label` 是一个标签，可以是代码中的任意位置，但是必须在同一函数内。`goto` 语句将控制流转移到指定标签处的代码。

**示例1：使用 goto 退出多层循环**

下面这段代码在满足条件时，需要连续退出两层循环，使用传统的编码方式如下：

```go showLineNumbers
package main

import "fmt"

func main() {
    var breakAgain bool
    
    // 外循环
    for x := 0; x < 10; x++ {
        // 内循环
        for y := 0; y < 10; y++ {
            // 满足某个条件时, 退出循环
            if y == 2 {
                // 设置退出标记
                breakAgain = true
                // 退出本次循环（内循环）
                break
            }
        }
        // 根据标记, 还需要退出一次循环（外循环）
        if breakAgain {
            break
        }
    }
    fmt.Println("done")
}
```

将上面的代码使用Go语言的 goto 语句进行优化：

```go showLineNumbers title="for_example_06.go"
package main

import "fmt"

func main() {
    for x := 0; x < 10; x++ {
        for y := 0; y < 10; y++ {
            if y == 2 {
                // 跳转到标签
                goto breakHere
            }
        }
    }
    // 手动返回, 避免执行进入标签
    return
    // 标签
breakHere:
    fmt.Println("done")
}
```

**示例2：使用 goto 集中处理错误**

在程序设计中，多处错误处理存在代码重复时是非常棘手的。使用 `goto` 语句可以简化错误处理，例如：

```go showLineNumbers title="for_example_07.go"
package main

import (
    "errors"
    "fmt"
)

func main() {
    err := doSomething1()
    if err != nil {
        goto HandleError
    }

	err = doSomething2()
    if err != nil {
        goto HandleError
    }

    fmt.Println("Success")
    return

HandleError:
    fmt.Println("Error occurred:", err)
    // 错误处理代码
}

func doSomething1() error {
    // 模拟一个错误
    return errors.New("something 1 went wrong")
}

func doSomething2() error {
    // 模拟一个错误
    return errors.New("something 2 went wrong")
}
```

在这个示例中，`doSomething1` 和 `doSomething2` 函数模拟了一个可能返回错误的操作。在 `main` 函数中，我们分别调用了 `doSomething1` 和 `doSomething2` 函数，并检查其返回的错误。如果发生了错误，使用 `goto` 语句跳转到标签 `HandleError` 处，并打印错误信息。在实际开发中，你可以在 `HandleError` 标签下编写具体的错误处理代码。



## 无限循环

如果 `for` 循环中条件语句永远不为 `false` 则会进行无限循环（也称为“死循环”）。我们可以通过 `for` 循环语句中只设置一个永远为 `true` 的条件表达式来执行无限循环，例如：

```go showLineNumbers title="for_example_08.go"
package main

import "fmt"

func main() {
    for true {
        fmt.Println("这是一个无限循环")
    }
}
```

实际上，`for` 循环的条件表达式也可以省略，上述代码等效于：

```go showLineNumbers
package main

import "fmt"

func main() {
    for {
        fmt.Println("这是一个无限循环")
    }
}
```

