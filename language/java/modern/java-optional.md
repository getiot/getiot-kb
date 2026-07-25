---
sidebar_position: 4
slug: /java-optional
sidebar_label: Java Optional 的使用
---

# Java Optional 的使用

Optional 是 Java 8 引入的容器类，用于表示可能为 null 的值。理解 Optional 的使用可以避免 NullPointerException，使代码更加安全。本章将详细介绍 Java 中的 Optional。

## Optional 创建与常用方法

### 创建 Optional

```java
import java.util.Optional;

// 创建空的 Optional
Optional<String> empty = Optional.empty();

// 创建非空的 Optional
Optional<String> nonEmpty = Optional.of("Hello");

// 创建可能为 null 的 Optional
String value = null;
Optional<String> nullable = Optional.ofNullable(value);  // Optional.empty()

String value2 = "Hello";
Optional<String> nullable2 = Optional.ofNullable(value2);  // Optional["Hello"]
```

### 常用方法

```java
Optional<String> optional = Optional.of("Hello");

// 判断是否有值
boolean isPresent = optional.isPresent();  // true

// 获取值（如果为空抛出异常）
String value = optional.get();  // "Hello"

// 如果为空返回默认值
String result = optional.orElse("默认值");  // "Hello"
String result2 = Optional.empty().orElse("默认值");  // "默认值"

// 如果为空使用 Supplier 提供默认值
String result3 = optional.orElseGet(() -> "默认值");

// 如果为空抛出异常
String result4 = optional.orElseThrow();  // 如果为空抛出 NoSuchElementException
String result5 = optional.orElseThrow(() -> new RuntimeException("值为空"));
```

## 避免 NullPointerException

### 传统方式的问题

```java
// ❌ 传统方式：容易产生 NullPointerException
public String getUserName(User user) {
    if (user != null) {
        if (user.getName() != null) {
            return user.getName().toUpperCase();
        }
    }
    return "未知";
}
```

### 使用 Optional

```java
// ✅ 使用 Optional：更安全
public String getUserName(User user) {
    return Optional.ofNullable(user)
        .map(User::getName)
        .map(String::toUpperCase)
        .orElse("未知");
}
```

### 实际示例

```java
import java.util.Optional;

public class OptionalExample {
    // 传统方式
    public static String getCityTraditional(User user) {
        if (user != null) {
            Address address = user.getAddress();
            if (address != null) {
                return address.getCity();
            }
        }
        return "未知城市";
    }
    
    // Optional 方式
    public static String getCityOptional(User user) {
        return Optional.ofNullable(user)
            .map(User::getAddress)
            .map(Address::getCity)
            .orElse("未知城市");
    }
}

class User {
    private Address address;
    public Address getAddress() { return address; }
}

class Address {
    private String city;
    public String getCity() { return city; }
}
```

## 示例：链式调用

### 示例 1：基本链式调用

```java
Optional<String> optional = Optional.of("Hello");

// map：转换值
Optional<String> upper = optional.map(String::toUpperCase);
// 结果：Optional["HELLO"]

// filter：过滤
Optional<String> filtered = optional.filter(s -> s.length() > 3);
// 结果：Optional["Hello"]

// flatMap：扁平化
Optional<String> flatMapped = optional.flatMap(s -> Optional.of(s + " World"));
// 结果：Optional["Hello World"]
```

### 示例 2：复杂链式调用

```java
public class OptionalChainExample {
    public static String processUser(User user) {
        return Optional.ofNullable(user)
            .map(User::getAddress)
            .map(Address::getCity)
            .filter(city -> city.length() > 3)
            .map(String::toUpperCase)
            .orElse("默认城市");
    }
    
    public static void main(String[] args) {
        User user = new User();
        user.setAddress(new Address("北京"));
        
        String city = processUser(user);
        System.out.println(city);  // "北京"
        
        String city2 = processUser(null);
        System.out.println(city2);  // "默认城市"
    }
}
```

### 示例 3：条件处理

```java
Optional<String> optional = Optional.of("Hello");

// ifPresent：如果有值则执行
optional.ifPresent(System.out::println);  // 输出：Hello

// ifPresentOrElse：如果有值执行一个操作，否则执行另一个
optional.ifPresentOrElse(
    System.out::println,  // 有值时执行
    () -> System.out.println("值为空")  // 空时执行
);
```

### 示例 4：组合多个 Optional

```java
Optional<String> name = Optional.of("张三");
Optional<Integer> age = Optional.of(25);

// 组合两个 Optional
Optional<Person> person = name.flatMap(n -> 
    age.map(a -> new Person(n, a))
);

// 或使用辅助方法
Person person2 = name.flatMap(n -> 
    age.map(a -> new Person(n, a))
).orElse(new Person("未知", 0));
```

### 示例 5：集合中的 Optional

```java
import java.util.*;
import java.util.stream.Collectors;

List<String> names = Arrays.asList("张三", "李四", null, "王五");

// 过滤 null 值
List<String> nonNull = names.stream()
    .filter(Objects::nonNull)
    .collect(Collectors.toList());

// 使用 Optional 处理
List<String> processed = names.stream()
    .map(Optional::ofNullable)
    .filter(Optional::isPresent)
    .map(Optional::get)
    .collect(Collectors.toList());

// 更简洁的方式
List<String> processed2 = names.stream()
    .map(Optional::ofNullable)
    .flatMap(opt -> opt.map(Stream::of).orElseGet(Stream::empty))
    .collect(Collectors.toList());
```

## Optional 的最佳实践

### 1. 不要将 Optional 作为字段

```java
// ❌ 不推荐
public class User {
    private Optional<String> name;  // 不推荐
}

// ✅ 推荐
public class User {
    private String name;  // 可以为 null
}
```

### 2. 不要将 Optional 作为方法参数

```java
// ❌ 不推荐
public void process(Optional<String> value) {
    // ...
}

// ✅ 推荐
public void process(String value) {
    Optional.ofNullable(value)
        .ifPresent(this::doProcess);
}
```

### 3. 使用 Optional 作为返回值

```java
// ✅ 推荐：表示可能为空
public Optional<User> findUserById(int id) {
    // 可能返回 null
    User user = userRepository.findById(id);
    return Optional.ofNullable(user);
}

// 使用
Optional<User> user = findUserById(1);
user.ifPresent(u -> System.out.println(u.getName()));
```

### 4. 避免使用 get()

```java
// ❌ 不推荐：可能抛出异常
String value = optional.get();

// ✅ 推荐：使用 orElse 或 orElseGet
String value = optional.orElse("默认值");
String value2 = optional.orElseGet(() -> "默认值");
```

### 5. 使用 map 和 flatMap

```java
// ✅ 推荐：使用 map 转换
Optional<String> upper = optional.map(String::toUpperCase);

// ✅ 推荐：使用 flatMap 扁平化
Optional<String> result = optional.flatMap(s -> 
    Optional.of(s + " World")
);
```

## 实际示例

### 示例 1：用户服务

```java
import java.util.Optional;

public class UserService {
    public Optional<User> findUserById(int id) {
        // 模拟数据库查询
        if (id > 0) {
            return Optional.of(new User(id, "张三"));
        }
        return Optional.empty();
    }
    
    public String getUserName(int id) {
        return findUserById(id)
            .map(User::getName)
            .orElse("未知用户");
    }
    
    public void printUserInfo(int id) {
        findUserById(id).ifPresent(user -> {
            System.out.println("用户ID：" + user.getId());
            System.out.println("用户名：" + user.getName());
        });
    }
}

class User {
    private int id;
    private String name;
    
    public User(int id, String name) {
        this.id = id;
        this.name = name;
    }
    
    public int getId() { return id; }
    public String getName() { return name; }
}
```

### 示例 2：配置读取

```java
import java.util.Optional;

public class ConfigReader {
    private Map<String, String> config = new HashMap<>();
    
    public Optional<String> getConfig(String key) {
        return Optional.ofNullable(config.get(key));
    }
    
    public String getConfigWithDefault(String key, String defaultValue) {
        return getConfig(key).orElse(defaultValue);
    }
    
    public int getIntConfig(String key, int defaultValue) {
        return getConfig(key)
            .map(Integer::parseInt)
            .orElse(defaultValue);
    }
}
```

### 示例 3：数据验证

```java
import java.util.Optional;

public class ValidationExample {
    public static Optional<String> validateEmail(String email) {
        if (email != null && email.contains("@")) {
            return Optional.of(email);
        }
        return Optional.empty();
    }
    
    public static Optional<String> validatePhone(String phone) {
        if (phone != null && phone.matches("\\d{11}")) {
            return Optional.of(phone);
        }
        return Optional.empty();
    }
    
    public static void main(String[] args) {
        String email = "test@example.com";
        String phone = "13800138000";
        
        Optional<String> validEmail = validateEmail(email);
        Optional<String> validPhone = validatePhone(phone);
        
        if (validEmail.isPresent() && validPhone.isPresent()) {
            System.out.println("验证通过");
        } else {
            System.out.println("验证失败");
        }
    }
}
```

## 小结

Java Optional 使用要点：

- **创建 Optional**：empty()、of()、ofNullable()
- **常用方法**：isPresent()、get()、orElse()、orElseGet()
- **链式调用**：map()、flatMap()、filter()
- **避免空指针**：使用 Optional 处理可能为 null 的值
- **最佳实践**：作为返回值，不作为字段或参数

**关键要点**：
- Optional 用于表示可能为 null 的值
- 使用链式调用处理 Optional
- 避免使用 get()，使用 orElse() 或 orElseGet()
- Optional 作为返回值，不作为字段或参数
- 使用 map 和 flatMap 进行转换

理解了 Optional，你就能编写更安全的代码。在下一章，我们将学习 Java 模块系统。
