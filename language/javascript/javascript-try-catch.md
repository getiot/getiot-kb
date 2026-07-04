---
sidebar_position: 27
---

# JavaScript 错误处理



JavaScript 编程的一个重要组成部分，是添加错误处理来应对可能会出现的问题。如果没有错误处理，那么在代码执行异常的情况下，JS 脚本可能会执行失败并且页面无法完成加载。为了增强代码的健壮性，我们应该把代码包装在一个 **try-catch** 块中。



## try-catch 块

为了防止代码完全崩溃，可以使用 **try-catch** 块来处理代码中的问题。如果在执行 JavaScript 的 try 块中的代码时遇到错误，那么它会跳出来，并执行 catch 部分，而不是停止执行整个脚本。当然，如果没有错误，那么整个 try 块将会被执行，并且不会执行 catch 块的代码。

例如，下面代码试图将一个名为 `badVarName` 的未定义的变量的值赋值到变量 x。

```javascript showLineNumbers
try {
    var x = badVarName;
} catch (err) {
    console.log(err.name + ': "' + err.message + '" occurred when assigning x.');
}
```

提示：**catch** 语句接受一个 `err` 参数，这是一个 error 对象。error 对象提供 `message` 属性，它提供了错误的描述。error 对象还提供了一个 `name` 属性，它是抛出的错误类型的名称。

执行上述代码将会产生一个异常，如下：

```bash
ReferenceError: "badVarName is not defined" occurred when assigning x.
```



## 抛出自定义错误

我们也可以使用 **throw** 语句抛出自己的错误。请看下面示例代码：

```javascript showLineNumbers
function sqrRoot(x) {
    try {
        if (x == "")  throw {message:"Can't Square Root Nothing"};
        if (isNaN(x)) throw {message:"Can't Square Root Strings"};
        if (x < 0)    throw {message:"Sorry No Imagination"};
        return "sqrt("+x+") = " + Math.sqrt(x);
    } catch (err) {
        return err.message;
    }
}

function writeIt() {
    console.log(sqrRoot("four"));
    console.log(sqrRoot(""));
    console.log(sqrRoot("4"));
    console.log(sqrRoot("-4"));
}

writeIt();
```

执行上述代码，控制台输出如下：

```bash
Can't Square Root Strings
Can't Square Root Nothing
sqrt(4) = 2
Sorry No Imagination
```



## 使用 finally

异常处理的另一个重要工具是 **finally** 关键字。我们可以在 try-catch 块的结尾部分添加 finally 关键字，在执行 try-catch 块代码时，无论是否有错误发生，最后都会执行 finally 块中的代码。

下面是一个简单示例：

```javascript showLineNumbers
function testTryCatch(value) {
    try {
        if (value < 0) {
            throw "too small";
        } else if (value > 10) {
            throw "too big";
        }
        console.log(value + " is a good number.");
    } catch (err) {
        console.log("The number was " + err);
    } finally {
        console.log("This is always written.");
    }
}
```

