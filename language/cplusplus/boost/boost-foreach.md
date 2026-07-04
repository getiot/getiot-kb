---
sidebar_position: 3
slug: /boost-foreach
draft: true
---

# Boost Foreach 遍历



In C++, writing a loop that iterates over a sequence is tedious. We can either use iterators, which requires a considerable amount of boiler-plate, or we can use the `std::for_each()` algorithm and move our loop body into a predicate, which requires no less boiler-plate and forces us to move our logic far from where it will be used. In contrast, some other languages, like Perl, provide a dedicated "foreach" construct that automates this process. `BOOST_FOREACH` is just such a construct for C++. It iterates over sequences for us, freeing us from having to deal directly with iterators or write predicates.

`BOOST_FOREACH` is designed for ease-of-use and efficiency. It does no dynamic allocations, makes no virtual function calls or calls through function pointers, and makes no calls that are not transparent to the compiler's optimizer. This results in near-optimal code generation; the performance of `BOOST_FOREACH` is usually within a few percent of the equivalent hand-coded loop. And although `BOOST_FOREACH` is a macro, it is a remarkably well-behaved one. It evaluates its arguments exactly once, leading to no nasty surprises.



Below is a sample program that uses `BOOST_FOREACH` to loop over the contents of a `std::string`.

```cpp showLineNumbers
#include <string>
#include <iostream>
#include <boost/foreach.hpp>

int main()
{
    std::string hello( "Hello, world!" );

    BOOST_FOREACH( char ch, hello )
    {
        std::cout << ch;
        std::cout << " ";
    }
    std::cout << std::endl;

    return 0;
}
```



## 示例

Below are some examples that demonstrate all the different ways we can use `BOOST_FOREACH`.

Iterate over an STL container:

```cpp showLineNumbers
std::list<int> list_int( /*...*/ );
BOOST_FOREACH( int i, list_int )
{
    // do something with i
}
```

Iterate over an array, with covariance (i.e., the type of the iteration variable is not exactly the same as the element type of the container):

```cpp showLineNumbers
short array_short[] = {1,2,3};
BOOST_FOREACH( int i, array_short )
{
    // The short was implicitly converted to an int
}
```

Predeclare the loop variable, and use `break`, `continue`, and `return` in the loop body:

```cpp showLineNumbers
std::deque<int> deque_int( /*...*/ );
int i = 0;
BOOST_FOREACH( i, deque_int )
{
    if( i == 0 ) return;
    if( i == 1 ) continue;
    if( i == 2 ) break;
}
```

Iterate over a sequence by reference, and modify the underlying sequence:

```cpp showLineNumbers
short array_short[] = { 1, 2, 3 };
BOOST_FOREACH( short & i, array_short )
{
    ++i;
}
// array_short contains {2,3,4} here
```

Iterate over a vector of vectors with nested `BOOST_FOREACH` loops. In this example, notice that braces around the loop body are not necessary:

```cpp showLineNumbers
std::vector<std::vector<int> > matrix_int;
BOOST_FOREACH( std::vector<int> & row, matrix_int )
    BOOST_FOREACH( int & i, row )
        ++i;
```

Iterate over an expression that returns a sequence by value (i.e. an rvalue):

```cpp showLineNumbers
extern std::vector<float> get_vector_float();
BOOST_FOREACH( float f, get_vector_float() )
{
    // Note: get_vector_float() will be called exactly once
}
```

Iterate in reverse:

```cpp showLineNumbers
std::list<int> list_int( /*...*/ );
BOOST_REVERSE_FOREACH( int i, list_int )
{
    // do something with i
}
```

Iterating over rvalues doesn't work on some older compilers. Check the [Portability](https://www.boost.org/doc/libs/1_71_0/doc/html/foreach/portability.html) section to see whether your compiler supports this.



## 优化

People have complained about the name `BOOST_FOREACH`. It's too long. `ALL CAPS` can get tiresome to look at. That may be true, but `BOOST_FOREACH` is merely following the [Boost Naming Convention](https://www.boost.org/more/lib_guide.htm). That doesn't mean you're stuck with it, though. If you would like to use a different identifier (`foreach_`, perhaps), you can simply do:

```cpp showLineNumbers
#define foreach_         BOOST_FOREACH
#define foreach_r_       BOOST_REVERSE_FOREACH
```

Only do this if you are sure that the identifier you choose will not cause name conflicts in your code.

注意：Do not use `#define foreach_(x,y) BOOST_FOREACH(x,y)`. This can be problematic if the arguments are macros themselves. This would result in an additional expansion of these macros. Instead, use the form shown above.

Lastly, a word of warning. Lots of folks use a `foreach` macro as a short form for `BOOST_FOREACH`. I discourage this. It leads to name conflicts within the `BOOST_FOREACH` macro itself, where `foreach` is the name of a namespace. Besides, `foreach` is a common-enough identifier; even [Qt](http://qt.digia.com/) defines it as a macro. If you insist on using `foreach`, you might try something like this:

```cpp showLineNumbers
#include <boost/foreach.hpp>

namespace boost
{
    // Suggested work-around for https://svn.boost.org/trac/boost/ticket/6131
    namespace BOOST_FOREACH = foreach;
}

#define foreach   BOOST_FOREACH
```

This will work around *some* of the problems you're likely to encounter, but not all. Prefer using a different identifier.





## 参考

- [Chapter 13. Boost.Foreach](https://www.boost.org/doc/libs/1_65_1/doc/html/foreach.html)

