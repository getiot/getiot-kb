---
sidebar_position: 53
slug: /cpp-keywords
draft: true
---

# C++ 关键字



关键字（keyword）是计算机程序语言预先定义的一些具有特殊意义的名称。例如，`int` 就是 C++ 程序语言的一个关键字，用来表示语言内置的整数数据类型。



[C++](http://www.geeksforgeeks.org/c-plus-plus/) is a powerful language. In C++ we can write structured programs and [object-oriented programs](https://www.geeksforgeeks.org/oops-object-oriented-design/) also. C++ is a superset of [C](https://www.geeksforgeeks.org/c-programming-language/) and therefore most constructs of C are legal in C++ with their meaning unchanged. However, there are some exceptions and additions.

[**Token**](https://www.geeksforgeeks.org/cc-tokens/)**:** When the compiler is processing the source code of a C++ program, each group of characters separated by white space is called a token. Tokens are the smallest individual units in a program. A C++ program is written using tokens. It has the following tokens:

Want to learn from the best curated videos and practice problems, check out the [**C++ Foundation Course**](https://practice.geeksforgeeks.org/courses/CPP-Foundation?utm_source=GeeksforGeeks&utm_medium=Text&utm_campaign=GFG_Article_Bottom_Text_CPP) for Basic to Advanced C++ and [**C++ STL Course**](https://practice.geeksforgeeks.org/courses/cpp-stl?utm_source=GeeksforGeeks&utm_medium=Text&utm_campaign=GFG_Article_Bottom_Text_CPP_STL) for the language and STL. To complete your preparation from learning a language to DS Algo and many more, please refer [**Complete Interview Preparation Course**](https://practice.geeksforgeeks.org/courses/complete-interview-preparation?utm_source=GeeksforGeeks&utm_medium=Text&utm_campaign=GFG_Article_Bottom_Text_CIP)**.**

- [Keywords](https://www.geeksforgeeks.org/variables-and-keywords-in-c/)
- [Identifiers](https://www.geeksforgeeks.org/difference-between-keyword-and-identifier/)
- [Constants](https://www.geeksforgeeks.org/constants-in-c-cpp/)
- [Strings](https://www.geeksforgeeks.org/string-data-structure/)
- [Operators](https://www.geeksforgeeks.org/bitwise-operators-in-c-cpp/)



[**Keywords**](https://www.geeksforgeeks.org/variables-and-keywords-in-c/) (also known as **reserved words**) have special meaning to the [C++ compiler](https://www.geeksforgeeks.org/compiling-with-g-plus-plus/) and are always written or typed in short(lower) cases. Keywords are words that the language uses for a special purpose, such as **void**, **int**, **public**, etc. It can’t be used for a variable name or function name. Below is the table for the complete set of C++ keywords.



**C++ Keyword**

| **asm** :pushpin:    | double               | **new** :pushpin:       | switch                 |
| :------------------- | -------------------- | ----------------------- | ---------------------- |
| auto                 | else                 | **operator** :pushpin:  | **template** :pushpin: |
| break                | enum                 | **private** :pushpin:   | **this** :pushpin:     |
| case                 | extern               | **protected** :pushpin: | **throw** :pushpin:    |
| **catch** :pushpin:  | float                | **public** :pushpin:    | **try** :pushpin:      |
| char                 | for                  | register                | typedef                |
| **class** :pushpin:  | **friend** :pushpin: | return                  | union                  |
| const                | goto                 | short                   | unsigned               |
| continue             | if                   | signed                  | **virtual** :pushpin:  |
| default              | **inline** :pushpin: | sizedof                 | void                   |
| **delete** :pushpin: | int                  | static                  | volatile               |
| do                   | long                 | struct                  | while                  |



**Note:** *The keywords not found in ANSI C are shown here in boldface.*



- **asm**: To declare that a block of code is to be passed to the assembler.
- **auto**: A storage class specifier that is used to define objects in a block.
- **break**: Terminates a switch statement or a loop.
- **case**: Used specifically within a switch statement to specify a match for the statement’s expression.
- **catch**: Specifies actions taken when an exception occurs.
- **char**: Fundamental data type that defines character objects.
- **class**: To declare a user-defined type that encapsulates data members and operations or member functions.
- **const**: To define objects whose value will not alter throughout the lifetime of program execution.
- **continue**:- Transfers control to the start of a loop.
- **default**:- Handles expression values in a switch statement that are not handled by case.
- **delete**: Memory deallocation operator.
- **do**: indicate the start of a do-while statement in which the sub-statement is executed repeatedly until the value of the expression is logical-false.
- **double:** Fundamental data type used to define a floating-point number.
- **else:** Used specifically in an if-else statement.
- **enum:** To declare a user-defined enumeration data type.
- **extern**: An identifier specified as extern has external linkage to the block.
- **float**:- Fundamental data type used to define a floating-point number.
- **for**: Indicates the start of a statement to achieve repetitive control.
- **friend:** A class or operation whose implementation can access the private data members of a class.
- **goto**: Transfer control to a specified label.
- **if**: Indicate the start of an if statement to achieve selective control.
- **inline:** A function specifier that indicates to the compiler that inline substitution of the function body is to be preferred to the usual function call implementation.
- **int:** Fundamental data type used to define integer objects.
- **long:** A data type modifier that defines a 32-bit int or an extended double.
- **new**: Memory allocation operator.
- **operator:** Overloads a c++ operator with a new declaration.
- **private**: Declares class members which are not visible outside the class.
- **protected:** Declares class members which are private except to derived classes
- **public:** Declares class members who are visible outside the class.
- **register:** A storage class specifier that is an auto specifier, but which also indicates to the compiler that an object will be frequently used and should therefore be kept in a register.
- **return**: Returns an object to a function’s caller.
- **short:** A data type modifier that defines a 16-bit int number.
- **signed:** A data type modifier that indicates an object’s sign is to be stored in the high-order bit.
- **sizeof:** Returns the size of an object in bytes.
- **static:** The lifetime of an object-defined static exists throughout the lifetime of program execution.
- **struct:** To declare new types that encapsulate both data and member functions.
- **switch**: This keyword used in the “Switch statement”.
- **template**: parameterized or generic type.
- **this**:  A class pointer points to an object or instance of the class.
- **throw:** Generate an exception.
- **try**: Indicates the start of a block of exception handlers.
- **typedef**: Synonym for another integral or user-defined type.
- **union:** Similar to a structure, struct, in that it can hold different types of data, but a union can hold only one of its members at a given time.
- **unsigned:** A data type modifier that indicates the high-order bit is to be used for an object.
- **virtual**: A function specifier that declares a member function of a class that will be redefined by a derived class.
- **void:** Absent of a type or function parameter list.
- **volatile**: Define an object which may vary in value in a way that is undetectable to the compiler.
- **while**: Start of a while statement and end of a do-while statement.



### **What is identifier and how it is different from keywords:**

Identifiers refer to the name of variables, functions, arrays, classes, etc. created by the programmer. They are the fundamental requirement of any language.

Rules for naming identifiers:

- Identifier name can not start with a digit or any special character.
- A keyword cannot be used as s identifier name.
- Only alphabetic characters, digits, and underscores are permitted.
- The upper case and lower case letters are distinct. i.e., A and a are different in C++.
- The valid identifiers are GFG, gfg, geeks_for_geeks.





## 参考

- [C++ Keywords | GeeksforGeeks](https://www.geeksforgeeks.org/cpp-keywords/)

