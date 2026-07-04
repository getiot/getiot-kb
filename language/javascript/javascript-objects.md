---
sidebar_position: 12
---

# JavaScript 对象



JavaScript 的对象只是带有属性和方法的特殊数据类型。JavaScript 提供多个内建对象，比如 Array、String、Math、Date 等等。

实际上，在 JavaScript 中，布尔型可以是一个对象，数字型可以是一个对象，字符串也可以是一个对象，日期是一个对象，数学和正则表达式也是对象，数组是一个对象，甚至函数也可以是对象。



## 访问对象的属性

JavaScript 的属性是与对象相关的值，访问对象属性的语法如下：

```javascript showLineNumbers
objectName.propertyName
```

下面代码使用了 String 对象的 `length` 属性来获得字符串的长度：

```javascript showLineNumbers
var message = "Hello World!";
var x = message.length;
```



## 访问对象的方法

JavaScript 的方法是能够在对象上执行的动作，调用对象方法的语法如下：

```javascript showLineNumbers
objectName.methodName()
```

下面代码使用了 String 对象的 `toUpperCase()` 方法来将文本转换为大写：

```javascript showLineNumbers
var message = "Hello World!";
var x = message.toUpperCase();
```



## 创建 JavaScript 对象

JavaScript 允许我们定义并创建自己的对象，创建新对象有两种不同的方法：

1. 定义并创建对象的实例；
2. 使用函数来定义对象，然后创建新的对象实例。



### 创建直接的实例

下面的代码创建了对象的一个新实例，并向其添加了四个属性：

```javascript showLineNumbers
var person = new Object();
person.firstname = "Rudy";
person.lastname = "Lo";
person.age = 30;
person.eyecolor = "black";
```

上述代码也可以使用对象 literals 来简写：

```javascript showLineNumbers
var person = {
    firstname:"Rudy",
    lastname:"Lo",
    age:30,
    eyecolor:"black"
};
```



### 使用对象构造器

在 JavaScript 中可以使用函数来构造对象，例如：

```javascript showLineNumbers
function person(firstname, lastname, age, eyecolor)
{
    this.firstname = firstname;
    this.lastname = lastname;
    this.age = age;
    this.eyecolor = eyecolor;
}
```

提示：this 通常指向的是我们正在执行的函数本身，或者是指向该函数所属的对象（运行时）。

一旦有了对象构造器，就可以使用它来创建新的对象实例，例如：

```javascript showLineNumbers
var myFather = new person("Rudy", "Lo", 30, "black");
var myMother = new person("Tiny", "Ou", 29, "blue");
```

方法是附加在对象上的函数，我们可以在构造器函数内部定义对象的方法，例如：

```javascript showLineNumbers
function person(firstname, lastname, age, eyecolor)
{
    this.firstname = firstname;
    this.lastname = lastname;
    this.age = age;
    this.eyecolor = eyecolor;

    this.changeAge = changeAge;
    function changeAge(age) {
        this.age = age;
    }
}
```

这样就可以调用 `changeAge()` 方法

```javascript showLineNumbers
var my = new person("Rudy", "Lo", 30, "black");
my.changeAge(30);
```



## JavaScript 类

JavaScript 是基于原型（prototype）的语言，JavaScript 不使用类。换句话说，在 JavaScript 中不会创建类，也不会通过类来创建对象。

