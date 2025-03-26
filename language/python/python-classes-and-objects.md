---
sidebar_position: 34
---

# Python 类和对象



Python 从一开始就被设计成一门面向对象的语言。不过，与 JavaScript 基于原型（prototype）的面向对象编程范式（normal form）不同，Python 的面向对象编程范式是中规中矩的基于类（class）的继承，并天然的支持多态（polymophine）。



## 类的定义

Python 使用 `class` 关键字定义类，例如：

```python showLineNumbers
class People:
    name = ""
    def __init__(self, name):
        self.name = name
    def getName(self):
        return self.name

person = People("Rudy")
print(person.getName())
```

在这里，我们使用关键字 class 定义了一个名为 Stu 的**类**。类是一些属性和方法的集合，通常用来描述具有相同的属性和方法的对象。

- Stu 类里面有 name 变量，它定义在类中且在函数体之外，称为类变量或类**属性**，它在整个实例化的对象中是公用的。
- 类中的函数通常称为**方法**，Stu 类有一个 `__init__()` 方法，它是一个魔术方法，在实例化的时候会自动调用，称为构造方法。
- Stu 类中还有一个 `get_name()` 方法，我们可以通过对象调用这个方法。`__init__()` 方法和 `get_name()` 方法的第一个参数都是 self，这个参数是必须的，它指向对象本身。
- 但 self 的名字不是固定的（只是约定俗成而已），我们也可以修改成 this。
- 接着，使用 `stu = Stu("Rudy")` 创建一个 stu 对象并传入一个学生名字，学生名字会作为参数传递给构造方法，这个过程称为实例化。
- 最后调用 stu 对象的 `get_name()` 方法，并将名字打印出来，实现了对象方法的调用。实际上，在这个例子中，我们也可以直接通过 stu.name 对象属性获取学生的名字。



## 实例化对象

Python 实例化对象特别简单，不需要像其他语言那样使用 new 关键字。

面向对象的三大特性是封装、继承和多态，上面的例子就是对“学生信息”这个类的简单封装。Python 同样支持类的继承，如果一种语言不支持继承，那么类就没有意义了。下面来看看继承和多态：

```python showLineNumbers
class Student(People):
    grade = ""
    def __init__(self, name, grade):
        People.__init__(self, name)
        self.grade = grade
    def getName(self):
        return ("Name:" + self.name)
    def getGrade(self):
        return self.grade

stu = Student("Tina", "A+")
print(stu.getName())
print(stu.getGrade())
```

类的继承只需要在类名称后面的圆括号中添加**基类**（又称父类）的名称即可。比如这里的 Student 类继承自 People 类，我们称 Student 为**派生类**（又称子类），显然 Student 继承了 People 的 name 属性和 getName() 方法。

对于构造方法，子类需要将相应的参数传递给父类的构造函数，已完成数据的初始化。Student 类中重新实现了 getName() 方法，它会覆盖父类中同名的方法，我们称之为**方法重写**，通过方法重写就可以实现**多态**。

此外，Student 类还增加了 grade 属性和 getGrade() 方法，这些属性和方法只属于 Student 类，这称为类的扩展。

**注意**：Python 中的方法重写和方法重载是一样的。它的意义在于，如果父类方法提供的功能不满足子类的需求，那么就可以在子类中重写父类的方法。

Python 有限的支持多继承形式，多继承方式如下：

```python showLineNumbers
class DerivedClassName(Base1, Base2, Base3):
    <statement-1>
    ...
    <statement-N>
```

值得一提的是，如果父类中有相同的方法名，而子类使用时并未指定，这时就需要特别关注圆括号中父类的顺序。也就是说，当方法在子类中未找到时，就会在继承序列中以**从左往右**的顺序，查找父类中是否包含该方法，调用最先找到的方法。



## 类的编码风格

下面是关于 Python 中类的编码风格的一些建议：

- Python 的类名应该使用**大驼峰命名法**，即类名中的每个单词的首字母都大写，而不是使用下划线；
- 实例名和模块名都采用小写格式，并在单词之间加下划线；
- 对于每个类，都要在类定义后面包含一个文档字符串，简要地描述类的功能，并遵循编写函数的文档字符串时采用的格式约定；
- 每个模块也应该包含一个文档字符串，对其中的类可用于做什么进行描述；
- 可以使用空行来组织代码，但不要滥用，在类中可使用一个空行来分隔方法，在模块中可使用两个空行来分隔类；
- 需要同时导入标准库中的模块和你编写的模块时，先编写导入标准库模块的 import 语句，再添加一个空行，然后编写导入你自己编写的模块的 import 语句。（在包含多条 import 语句的程序中，这种做法让人更容易明白程序使用的各个模块都来自何方）



## 私有属性与方法

前面的例子中，我们是可以直接访问 People 类中的 name 属性的，如果你愿意，还可以直接修改实例化对象的 name 属性。有时候直接修改属性会很方便，有时候却会带来麻烦，因为我们不想将所有类属性和方法都暴露出去，这显然破坏了面向对象的封装性。所以，我们有必要使用类的私有属性（private_attrs）和私有方法（private_method），以保护类的私密性。

Python 中类的私有属性和私有方法的定义很简单，只需要将属性和方法的名称定义为以**两个下划线开头**即可。

我们修改下前面的例子：

```python showLineNumbers
class People:
    __name = ""
    def __init__(self, name):
        self.__name = name
    def getName(self):
        return self.__name

person = People("Rudy")
print(person.getName())
print(person.__name)
```

访问 `person.__name` 的时候就会出现 Traceback，提示“AttributeError: 'People' object has no attribute '__name'”



## 静态方法和类成员方法

Python 类语法中有三种方法：实例方法（Instance method）、静态方法（Static method）、类成员方法（Class method）。实例方法只能被实例调用，静态方法和类成员方法可以被类或类的实例对象调用。我们前面定义的 getName() 和 getGrade() 都是实例对象。

- **实例方法**的第一个参数必须要默认传实例对象，一般习惯用 self；
- **静态方法**没有参数（没有参数要求），不需要创建对象即可调用；
- **类成员方法**的第一个参数必须要默认传类，一般习惯用 cls。

静态方法和类成员方法使用 `staticmethod()` 和 `classmethod()` 函数定义，或者使用 `@staticmethod` 和 `@classmethod` 装饰器修饰。举个栗子：

```python showLineNumbers
class Stu(object):
    name = "ET"
    def __init__(self, name):
        self.name = name

    def fun1(self):
        print("I am %s in instance method" %(self.name))

    @staticmethod
    def fun2():
        print("I am %s in static method" %(Stu.name))
    #fun2 = staticmethod(fun2)

    @classmethod
    def fun3(cls):
        print("I am %s in class method" %(cls.name))
    #fun3 = classmethod(fun3)

stu = Stu("Robot")
stu.fun1()
stu.fun2()
stu.fun3()

Stu.fun2()
Stu.fun3()
```

输出结果如下：

```python showLineNumbers
I am Robot in instance method
I am ET in static method
I am ET in class method
I am ET in static method
I am ET in class method
```

使用函数 `staticmethod()` 和 `classmethod()` 与使用装饰器 `@staticmethod` 和 `@classmethod` 的方法二者选其一即可。

可以看到，实例对象除了调用实例方法，还可以调用静态方法和类成员方法。但是类只能调用静态方法或类成员方法。

静态方法和类成员方法在格式上的区别是：前者无默认类参数，后者有默认类参数。静态方法和类成员方法的选择，通常考虑的是 —— 是否要在该方法中使用调用类属性和其他类方法。实际上，静态方法中也可以通过类型来调用类属性（就像上面例子中的 Stu.name），而类成员方法直接通过它的第一个参数 cls 来操作，这样会更加方便。这种细微的差别会造成两者在使用场景上有一些区别，比如下面这个例子：

```python showLineNumbers
class A:
    price = 99.9

    def __init__(self):
        pass

    @staticmethod
    def fun1():
        print("The price: %.2f" %(A.price))

    @classmethod
    def fun2(cls):
        print("The price: %.2f" %(cls.price))

class B(A):
    price = 59.9

    def __init__(self):
        A.__init__(self)

B.fun1()
B.fun2()
```

执行后输出的结果是：

```python showLineNumbers
The price: 99.90
The price: 59.90
```

可以看到，当 B 类继承 A 类的静态方法 fun1() 和类成员方法 fun2() 时，B 类中的 price 属性会覆盖 A 类中同名的属性。因此，`B.fun2()` 的输出变成了 59.90，而 `B.fun1()` 的输出依然是 A 类中的 99.90。

由于 Python 类中只能有一个初始化方法（即 `__init__()`），不能像 C++ 和 Java 等面向对象语言那样，按照不同的情况来初始化实例对象。因此，我们可以使用类成员方法来模拟，实现定义多个构造函数。例如：

```python showLineNumbers
class Book:
    def __init__(self, title):
        self.title = title

    @classmethod
    def create(cls, title):
        book = cls(title=title)
        return book

    @classmethod
    def create_price(cls, title, price):
        book = cls(title=title)
        book.price = price
        return book

book1 = Book.create("Pride and Prejudice")
print(book1.title)
book2 = Book.create_price("The Red and The Black", 19.9)
print(book2.title)
print(book2.price)
```

在这个例子中，我们通过类成员方法实现了构造函数 `create()` 和 `create_price()`。当然，使用静态方法也可以实现类似功能，但静态方法每次都要写上类的名字，会带来不便。

除此之外，静态方法和类方法也可以相互调用。

在其他语言中，静态方法可能会被大量使用，但是在 Python 中，我们可以使用大量的函数来解决问题，所以静态方法并不常用。



## 新式类与经典类

由于历史原因，在 Python 中存在新式类和经典类。幸运的是，Python 3.x 中取消了经典类，默认都是新式类，并且不必显式的继承 object。

也就是说，以下三种类定义方法并无区别：

```python showLineNumbers
class Person(object):
    pass

class Person():
    pass

class Person:
    pass
```

但是为了兼容，推荐使用第一种，即无论如何都加上 object，让所有类继承自 object 类，成为“一个是对象的类”。

它们之间最大的区别在于**继承搜索的顺序**发生了改变。经典类多继承搜索顺序为深度优先，即先深入继承树左侧查找，然后再返回，开始查找右侧；而新式类多继承搜索顺序为广度优先，即先在水平方向查找，然后再向上查找。



## 魔术方法

在 Python 中，双下划线开始和结尾的基本上都是魔术方法，魔术方法意味着是自动加载执行的，不需要人为调用。

很多魔术方法是针对类（面向对象）的，所以也称为类的专有方法，比如前面一直在用的 `__init__()` 构造方法。

下面列举的是类的专有方法：

- `__init__`：构造函数，在生成对象时调用
- `__del__`：析构函数，释放对象时使用
- `__str__`：使用 print(对象) 或者 str(对象) 的时候触发
- `__repr__`：打印，转换，在使用 repr(对象) 的时候触发
- `__setitem__`：按照索引赋值，每当属性被赋值的时候都会调用该方法：`self.__dict__[name] = value`
- `__getitem__`：按照索引获取值，当访问不存在的属性时会调用该方法
- `__delitem__(self, name)`：当删除属性时调用该方法
- `__len__`：获得长度
- `__cmp__`：比较运算
- `__call__`：函数调用
- `__add__`：加运算
- `__sub__`：减运算
- `__mul__`：乘运算
- `__div__`：除运算
- `__mod__`：求余运算
- `__pow__`：乘方
- ……

注意：每当属性被赋值的时候都会调用 `__setitem__` 方法，因此不能在该方法内赋值（self.name = value），否则会陷入死循环。

`__str__` 函数用于处理打印实例本身时的输出内容，如果没有重写该函数，则默认输出一个对象名称和内存地址。

这些专有方法有一部分是用于运算的，重写这些方法，可以实现运算符重载。比如重写 `__add__` 实现加（+）运算符重载：

```python showLineNumbers
class Vector:
    def __init__(self, a, b):
        self.a = a
        self.b = b

    def __str__(self):
        return 'Vector(%d, %d)' % (self.a, self.b)

    def __add__(self, other):
        return Vector(self.a + other.a, self.b + other.b)


v1 = Vector(2, 10)
v2 = Vector(5, -2)
print(v1 + v2)
```

执行后输入：

```python showLineNumbers
Vector(7, 8)
```



## 类属性

前面介绍的私有属性、私有方法、静态方法、类成员方法其实都是为了给面向对象提供更好的封装性。尤其对于类的属性，如果直接把它们暴露出来，虽然代码写起来简单，但存在风险。于是，我们通过 get_x 和 set_x 的方法将属性的操作保护起来，set_x 方法中可以设置多个参数（比如坐标值，GPS 值等），通常还会加入参数检查，从而避免直接赋值可能带来的错误。

但是如果每个需要保护的属性都要这样去处理的话，就太麻烦了！因此，优雅的 Python 为我们提供了 `property() 这里写代码片` 方法，简单来说，它就是将一个方法变成一个属性。其函数说明如下：

```python showLineNumbers
class property(object)
    property(fget=None, fset=None, fdel=None, doc=None) -> property attribute
```

使用 property() 可以绑定属性的 get、set、del 和 doc 方法。

- 描述：property() 函数的作用是在新式类中返回属性值参数
- 参数：
    - fget —— 获取属性值的函数
    - fset —— 设置属性值的函数（可选）
    - fdel —— 删除属性值的函数（可选）
    - doc —— 属性描述信息（可选）

举个栗子：

```python showLineNumbers
class C(object):
    def getX(self):
        return self._x

    def setX(self, value):
        self._x = value

    def delX(self):
        del self._x

    x = property(getX, setX, delX, "I'm the 'x' property.")

c = C()
c.x = 12
print(c.x)
del c.x
```

除了使用 `property()` 函数，我们还可以使用 `@property` 装饰器来给函数动态加上功能。比如上面的栗子可以改写为：

```python showLineNumbers
class C(object):
    @property
    def x(self):
        "I'm the 'x' property"
        return self._x

    @x.setter
    def x(self, value):
        self._x = value

    @x.deleter
    def x(self):
        del self._x

```

`@property` 把一个 getter 方法变成属性，然后又创建了另一个装饰器 `@x.setter`，把一个 setter 方法变成属性赋值，接着创建了 `@x.deleter` 装饰器将一个 deleter 方法变成属性删除。于是，我们就拥有一个可控的属性操作。

通过这种方式，我们就可以在对实例属性操作的时候，知道该属性很可能不是直接暴露的，而是通过 getter 和 setter 方法来实现的。如果只定义 getter 方法，没有定义 setter 方法，说明该属性是只读属性。

`@property` 广泛应用在类的定义中，可以让调用者写出简短的代码，同时保证对参数进行必要的检查，这样，**程序运行时就减少了出错的可能性**。

另外，我们可以使用 `hasattr()` 方法检查对象中是否包含某个属性和方法。如果要判断的方法和属性是私有的，或者不存在，则返回 False。比如上面删除 c.x 之前先判断一下：

```python showLineNumbers
if hasattr(c, "x"):
    del c.x
```


