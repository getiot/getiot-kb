---
sidebar_position: 2
slug: /java-generics
sidebar_label: Java 泛型
---

# Java 泛型（Generics）

泛型是 Java 5 引入的重要特性，它提供了类型安全的集合和类。理解泛型的使用是编写类型安全代码的关键。本章将详细介绍 Java 中的泛型机制。

## 泛型类与泛型方法

### 什么是泛型

**泛型**（Generics）允许在定义类、接口和方法时使用类型参数，在使用时指定具体类型。

**优势**：
- **类型安全**：编译时检查类型
- **消除强制转换**：不需要手动类型转换
- **代码复用**：一个类可以处理多种类型

### 泛型类

定义泛型类：

```java
// 泛型类定义
public class Box<T> {
    private T item;
    
    public void setItem(T item) {
        this.item = item;
    }
    
    public T getItem() {
        return item;
    }
}

// 使用泛型类
Box<String> stringBox = new Box<>();
stringBox.setItem("Hello");
String item = stringBox.getItem();  // 不需要强制转换

Box<Integer> intBox = new Box<>();
intBox.setItem(100);
Integer number = intBox.getItem();  // 类型安全
```

### 多个类型参数

```java
public class Pair<K, V> {
    private K key;
    private V value;
    
    public Pair(K key, V value) {
        this.key = key;
        this.value = value;
    }
    
    public K getKey() {
        return key;
    }
    
    public V getValue() {
        return value;
    }
}

// 使用
Pair<String, Integer> pair = new Pair<>("age", 25);
String key = pair.getKey();      // "age"
Integer value = pair.getValue(); // 25
```

### 泛型方法

定义泛型方法：

```java
public class Utils {
    // 泛型方法
    public static <T> void printArray(T[] array) {
        for (T element : array) {
            System.out.println(element);
        }
    }
    
    // 泛型方法返回类型
    public static <T> T getFirst(T[] array) {
        if (array.length > 0) {
            return array[0];
        }
        return null;
    }
    
    // 多个类型参数
    public static <T, U> void printPair(T first, U second) {
        System.out.println("First: " + first);
        System.out.println("Second: " + second);
    }
}

// 使用
String[] strings = {"a", "b", "c"};
Utils.printArray(strings);

Integer[] numbers = {1, 2, 3};
Integer first = Utils.getFirst(numbers);
```

### 泛型接口

```java
// 泛型接口
public interface Comparable<T> {
    int compareTo(T other);
}

// 实现泛型接口
public class Student implements Comparable<Student> {
    private String name;
    private int score;
    
    @Override
    public int compareTo(Student other) {
        return Integer.compare(this.score, other.score);
    }
}
```

## 类型通配符

### 无界通配符（?）

`?` 表示未知类型：

```java
// 可以接受任何类型的 List
public void printList(List<?> list) {
    for (Object item : list) {
        System.out.println(item);
    }
}

// 使用
List<String> stringList = Arrays.asList("a", "b");
List<Integer> intList = Arrays.asList(1, 2, 3);
printList(stringList);  // ✅ 可以
printList(intList);     // ✅ 可以
```

### 上界通配符（? extends）

`? extends T` 表示 T 或其子类型：

```java
// 可以接受 Number 及其子类型的 List
public void processNumbers(List<? extends Number> numbers) {
    for (Number num : numbers) {
        System.out.println(num.doubleValue());
    }
}

// 使用
List<Integer> integers = Arrays.asList(1, 2, 3);
List<Double> doubles = Arrays.asList(1.0, 2.0, 3.0);
processNumbers(integers);  // ✅ 可以（Integer extends Number）
processNumbers(doubles);   // ✅ 可以（Double extends Number）

// ❌ 错误：不能添加元素（除了 null）
// numbers.add(10);  // 编译错误
```

**特点**：
- 可以读取元素
- 不能添加元素（除了 null）
- 用于"生产者"场景

### 下界通配符（? super）

`? super T` 表示 T 或其父类型：

```java
// 可以接受 Integer 及其父类型的 List
public void addNumbers(List<? super Integer> numbers) {
    numbers.add(10);  // ✅ 可以添加 Integer
    numbers.add(20);
}

// 使用
List<Number> numberList = new ArrayList<>();
List<Object> objectList = new ArrayList<>();
addNumbers(numberList);  // ✅ 可以（Number super Integer）
addNumbers(objectList);  // ✅ 可以（Object super Integer）

// ❌ 错误：不能读取为具体类型
// Integer num = numbers.get(0);  // 编译错误
```

**特点**：
- 可以添加元素
- 不能读取为具体类型（只能读取为 Object）
- 用于"消费者"场景

### PECS 原则

**Producer Extends, Consumer Super**：

- **Producer（生产者）**：使用 `? extends T`
- **Consumer（消费者）**：使用 `? super T`

```java
// 生产者：从集合读取
public void copy(List<? extends Number> source, List<? super Number> dest) {
    for (Number num : source) {
        dest.add(num);  // 从 source 读取，添加到 dest
    }
}
```

## 泛型擦除与限制

### 类型擦除

**Java 的泛型是编译时特性，运行时会被擦除**：

```java
// 编译时
List<String> stringList = new ArrayList<>();
List<Integer> intList = new ArrayList<>();

// 运行时：类型信息被擦除
// stringList 和 intList 的类型都是 List（原始类型）
System.out.println(stringList.getClass() == intList.getClass());  // true
```

**擦除后的类型**：
- `List<String>` → `List`
- `Box<Integer>` → `Box`
- `Pair<String, Integer>` → `Pair`

### 泛型的限制

#### 1. 不能使用基本类型

```java
// ❌ 错误：不能使用基本类型
// List<int> list = new ArrayList<>();

// ✅ 正确：使用包装类型
List<Integer> list = new ArrayList<>();
```

#### 2. 不能创建泛型数组

```java
// ❌ 错误：不能创建泛型数组
// List<String>[] array = new List<String>[10];

// ✅ 正确：使用原始类型或通配符
List<String>[] array = (List<String>[]) new List[10];
List<?>[] array2 = new List<?>[10];
```

#### 3. 不能实例化类型参数

```java
public class Box<T> {
    // ❌ 错误：不能实例化类型参数
    // private T item = new T();
    
    // ✅ 正确：使用反射（需要 Class 参数）
    private T createInstance(Class<T> clazz) throws Exception {
        return clazz.newInstance();
    }
}
```

#### 4. 静态成员不能使用类型参数

```java
public class Box<T> {
    // ❌ 错误：静态成员不能使用类型参数
    // private static T staticField;
    
    // ✅ 正确：静态方法可以使用自己的类型参数
    public static <U> void staticMethod(U item) {
        // ...
    }
}
```

#### 5. 不能捕获泛型异常

```java
// ❌ 错误：不能捕获泛型异常
// try {
//     // ...
// } catch (Exception<T> e) { }

// ✅ 正确：使用通配符
// } catch (Exception<?> e) { }
```

## 示例：泛型集合、泛型方法

### 示例 1：泛型类

```java
public class GenericStack<T> {
    private List<T> stack = new ArrayList<>();
    
    public void push(T item) {
        stack.add(item);
    }
    
    public T pop() {
        if (stack.isEmpty()) {
            throw new IllegalStateException("栈为空");
        }
        return stack.remove(stack.size() - 1);
    }
    
    public T peek() {
        if (stack.isEmpty()) {
            throw new IllegalStateException("栈为空");
        }
        return stack.get(stack.size() - 1);
    }
    
    public boolean isEmpty() {
        return stack.isEmpty();
    }
    
    public int size() {
        return stack.size();
    }
}

// 使用
GenericStack<String> stringStack = new GenericStack<>();
stringStack.push("first");
stringStack.push("second");
System.out.println(stringStack.pop());  // "second"

GenericStack<Integer> intStack = new GenericStack<>();
intStack.push(1);
intStack.push(2);
System.out.println(intStack.pop());  // 2
```

### 示例 2：泛型方法

```java
public class ArrayUtils {
    // 交换数组元素
    public static <T> void swap(T[] array, int i, int j) {
        T temp = array[i];
        array[i] = array[j];
        array[j] = temp;
    }
    
    // 查找最大值
    public static <T extends Comparable<T>> T max(T[] array) {
        if (array.length == 0) {
            throw new IllegalArgumentException("数组为空");
        }
        T max = array[0];
        for (int i = 1; i < array.length; i++) {
            if (array[i].compareTo(max) > 0) {
                max = array[i];
            }
        }
        return max;
    }
    
    // 查找元素
    public static <T> int indexOf(T[] array, T target) {
        for (int i = 0; i < array.length; i++) {
            if (array[i].equals(target)) {
                return i;
            }
        }
        return -1;
    }
}

// 使用
String[] strings = {"a", "b", "c"};
ArrayUtils.swap(strings, 0, 2);
System.out.println(Arrays.toString(strings));  // ["c", "b", "a"]

Integer[] numbers = {3, 1, 4, 1, 5};
Integer max = ArrayUtils.max(numbers);
System.out.println("最大值：" + max);  // 5
```

### 示例 3：类型通配符

```java
import java.util.*;

public class WildcardExample {
    // 上界通配符：读取
    public static double sum(List<? extends Number> numbers) {
        double sum = 0.0;
        for (Number num : numbers) {
            sum += num.doubleValue();
        }
        return sum;
    }
    
    // 下界通配符：写入
    public static void addNumbers(List<? super Integer> numbers) {
        numbers.add(1);
        numbers.add(2);
        numbers.add(3);
    }
    
    // 无界通配符：只读取
    public static void printList(List<?> list) {
        for (Object item : list) {
            System.out.println(item);
        }
    }
    
    public static void main(String[] args) {
        // 上界通配符
        List<Integer> integers = Arrays.asList(1, 2, 3);
        List<Double> doubles = Arrays.asList(1.0, 2.0, 3.0);
        System.out.println("整数和：" + sum(integers));
        System.out.println("浮点数和：" + sum(doubles));
        
        // 下界通配符
        List<Number> numbers = new ArrayList<>();
        addNumbers(numbers);
        System.out.println("数字列表：" + numbers);
        
        // 无界通配符
        printList(integers);
        printList(doubles);
    }
}
```

### 示例 4：泛型接口实现

```java
// 泛型接口
public interface Repository<T> {
    void save(T entity);
    T findById(Long id);
    List<T> findAll();
    void delete(Long id);
}

// 实现泛型接口
public class UserRepository implements Repository<User> {
    private List<User> users = new ArrayList<>();
    
    @Override
    public void save(User user) {
        users.add(user);
    }
    
    @Override
    public User findById(Long id) {
        return users.stream()
            .filter(u -> u.getId().equals(id))
            .findFirst()
            .orElse(null);
    }
    
    @Override
    public List<User> findAll() {
        return new ArrayList<>(users);
    }
    
    @Override
    public void delete(Long id) {
        users.removeIf(u -> u.getId().equals(id));
    }
}
```

## 泛型最佳实践

### 1. 使用有意义的类型参数名

```java
// ✅ 推荐
public class Box<T> { }
public class Pair<K, V> { }
public class Repository<E> { }

// ❌ 不推荐
public class Box<A> { }
public class Pair<X, Y> { }
```

### 2. 优先使用泛型方法

```java
// ✅ 推荐：泛型方法更灵活
public static <T> void swap(List<T> list, int i, int j) { }

// ❌ 不推荐：需要泛型类
// public class Utils<T> {
//     public void swap(List<T> list, int i, int j) { }
// }
```

### 3. 使用通配符提高灵活性

```java
// ✅ 推荐：使用通配符
public void process(List<? extends Number> numbers) { }

// ❌ 不推荐：限制太严格
// public void process(List<Number> numbers) { }
```

### 4. 避免原始类型

```java
// ❌ 不推荐：使用原始类型
List list = new ArrayList();

// ✅ 推荐：使用泛型
List<String> list = new ArrayList<>();
```

## 小结

Java 泛型要点：

- **泛型类**：定义时使用类型参数，使用时指定具体类型
- **泛型方法**：方法级别的类型参数
- **类型通配符**：`?`、`? extends T`、`? super T`
- **类型擦除**：运行时类型信息被擦除
- **限制**：不能使用基本类型、不能创建泛型数组等

**关键要点**：
- 泛型提供类型安全
- 使用 `? extends T` 读取（生产者）
- 使用 `? super T` 写入（消费者）
- 理解类型擦除的影响
- 避免使用原始类型

理解了泛型，你就能编写类型安全的代码。在下一章，我们将学习 Java 的 List 集合。
