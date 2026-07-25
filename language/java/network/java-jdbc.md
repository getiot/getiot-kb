---
sidebar_position: 4
slug: /java-jdbc
sidebar_label: Java JDBC 数据库连接
---

# Java JDBC 数据库连接

JDBC（Java Database Connectivity）是 Java 访问数据库的标准 API。理解 JDBC 的使用是进行数据库应用开发的基础。本章将详细介绍 Java 中的 JDBC 使用。

## JDBC 驱动与连接

### JDBC 概述

**JDBC**是 Java 访问数据库的标准接口，提供了统一的数据库访问方式。

**JDBC 架构**：
```
Java 应用程序
    ↓
JDBC API
    ↓
JDBC 驱动
    ↓
数据库
```

### JDBC 驱动类型

**四种 JDBC 驱动类型**：

1. **Type 1：JDBC-ODBC Bridge**（已过时）
2. **Type 2：Native API Driver**
3. **Type 3：Network Protocol Driver**
4. **Type 4：Pure Java Driver**（推荐）

### 加载驱动

```java
import java.sql.*;

// 方式 1：显式加载（Java 5+ 可以省略）
Class.forName("com.mysql.cj.jdbc.Driver");

// 方式 2：使用 DriverManager（Java 6+ 自动加载）
// 不需要显式加载
```

### 建立连接

```java
import java.sql.*;

// 数据库连接 URL
String url = "jdbc:mysql://localhost:3306/mydb?useSSL=false&serverTimezone=UTC";
String username = "root";
String password = "password";

// 建立连接
Connection connection = DriverManager.getConnection(url, username, password);

// 或使用 Properties
Properties props = new Properties();
props.setProperty("user", username);
props.setProperty("password", password);
Connection connection2 = DriverManager.getConnection(url, props);
```

### 常用数据库连接 URL

```java
// MySQL
String mysqlUrl = "jdbc:mysql://localhost:3306/mydb";

// PostgreSQL
String pgUrl = "jdbc:postgresql://localhost:5432/mydb";

// SQLite
String sqliteUrl = "jdbc:sqlite:mydb.db";

// Oracle
String oracleUrl = "jdbc:oracle:thin:@localhost:1521:orcl";

// SQL Server
String sqlServerUrl = "jdbc:sqlserver://localhost:1433;databaseName=mydb";
```

## SQL 执行与结果查询

### Statement

**`Statement`** 用于执行静态 SQL 语句。

```java
Connection connection = DriverManager.getConnection(url, username, password);
Statement statement = connection.createStatement();

// 执行查询
ResultSet rs = statement.executeQuery("SELECT * FROM users");

// 执行更新
int rows = statement.executeUpdate("UPDATE users SET name='张三' WHERE id=1");

// 执行任意 SQL
boolean hasResult = statement.execute("SELECT * FROM users");

statement.close();
connection.close();
```

### PreparedStatement（推荐）

**`PreparedStatement`** 用于执行预编译的 SQL 语句，防止 SQL 注入。

```java
// 使用占位符
String sql = "SELECT * FROM users WHERE id = ? AND name = ?";
PreparedStatement pstmt = connection.prepareStatement(sql);

// 设置参数
pstmt.setInt(1, 1);
pstmt.setString(2, "张三");

// 执行查询
ResultSet rs = pstmt.executeQuery();

// 执行更新
String updateSql = "UPDATE users SET name = ? WHERE id = ?";
PreparedStatement updateStmt = connection.prepareStatement(updateSql);
updateStmt.setString(1, "李四");
updateStmt.setInt(2, 1);
int rows = updateStmt.executeUpdate();

pstmt.close();
```

**优势**：
- 防止 SQL 注入
- 性能更好（预编译）
- 代码更清晰

### ResultSet

**`ResultSet`** 表示查询结果集。

```java
String sql = "SELECT id, name, age FROM users";
PreparedStatement pstmt = connection.prepareStatement(sql);
ResultSet rs = pstmt.executeQuery();

// 遍历结果集
while (rs.next()) {
    int id = rs.getInt("id");
    String name = rs.getString("name");
    int age = rs.getInt("age");
    
    System.out.println("ID: " + id + ", Name: " + name + ", Age: " + age);
}

// 或使用索引
while (rs.next()) {
    int id = rs.getInt(1);
    String name = rs.getString(2);
    int age = rs.getInt(3);
}

rs.close();
```

### ResultSet 的常用方法

```java
// 移动光标
rs.next();        // 下一行
rs.previous();    // 上一行
rs.first();       // 第一行
rs.last();        // 最后一行
rs.absolute(5);   // 移动到第 5 行

// 获取数据
rs.getInt("id");
rs.getString("name");
rs.getDouble("price");
rs.getDate("birthday");
rs.getTimestamp("created_at");

// 检查
boolean hasNext = rs.next();
boolean isFirst = rs.isFirst();
boolean isLast = rs.isLast();
```

## 数据库增删改查示例

### 示例 1：查询数据

```java
import java.sql.*;

public class QueryExample {
    public static void queryUsers() throws SQLException {
        String url = "jdbc:mysql://localhost:3306/mydb";
        String username = "root";
        String password = "password";
        
        try (Connection connection = DriverManager.getConnection(url, username, password);
             PreparedStatement pstmt = connection.prepareStatement(
                 "SELECT id, name, email FROM users WHERE age > ?")) {
            
            pstmt.setInt(1, 18);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    String email = rs.getString("email");
                    System.out.println("ID: " + id + ", Name: " + name + ", Email: " + email);
                }
            }
        }
    }
}
```

### 示例 2：插入数据

```java
public class InsertExample {
    public static void insertUser(String name, String email, int age) throws SQLException {
        String url = "jdbc:mysql://localhost:3306/mydb";
        String username = "root";
        String password = "password";
        
        String sql = "INSERT INTO users (name, email, age) VALUES (?, ?, ?)";
        
        try (Connection connection = DriverManager.getConnection(url, username, password);
             PreparedStatement pstmt = connection.prepareStatement(sql)) {
            
            pstmt.setString(1, name);
            pstmt.setString(2, email);
            pstmt.setInt(3, age);
            
            int rows = pstmt.executeUpdate();
            System.out.println("插入 " + rows + " 行");
        }
    }
}
```

### 示例 3：更新数据

```java
public class UpdateExample {
    public static void updateUser(int id, String newName) throws SQLException {
        String url = "jdbc:mysql://localhost:3306/mydb";
        String username = "root";
        String password = "password";
        
        String sql = "UPDATE users SET name = ? WHERE id = ?";
        
        try (Connection connection = DriverManager.getConnection(url, username, password);
             PreparedStatement pstmt = connection.prepareStatement(sql)) {
            
            pstmt.setString(1, newName);
            pstmt.setInt(2, id);
            
            int rows = pstmt.executeUpdate();
            System.out.println("更新 " + rows + " 行");
        }
    }
}
```

### 示例 4：删除数据

```java
public class DeleteExample {
    public static void deleteUser(int id) throws SQLException {
        String url = "jdbc:mysql://localhost:3306/mydb";
        String username = "root";
        String password = "password";
        
        String sql = "DELETE FROM users WHERE id = ?";
        
        try (Connection connection = DriverManager.getConnection(url, username, password);
             PreparedStatement pstmt = connection.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            
            int rows = pstmt.executeUpdate();
            System.out.println("删除 " + rows + " 行");
        }
    }
}
```

### 示例 5：获取自增主键

```java
public class AutoIncrementExample {
    public static int insertUserWithId(String name, String email) throws SQLException {
        String url = "jdbc:mysql://localhost:3306/mydb";
        String username = "root";
        String password = "password";
        
        String sql = "INSERT INTO users (name, email) VALUES (?, ?)";
        
        try (Connection connection = DriverManager.getConnection(url, username, password);
             PreparedStatement pstmt = connection.prepareStatement(
                 sql, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setString(1, name);
            pstmt.setString(2, email);
            pstmt.executeUpdate();
            
            // 获取生成的主键
            try (ResultSet rs = pstmt.getGeneratedKeys()) {
                if (rs.next()) {
                    int id = rs.getInt(1);
                    System.out.println("插入的用户 ID：" + id);
                    return id;
                }
            }
        }
        return -1;
    }
}
```

## 事务与批处理

### 事务处理

**事务**用于保证数据库操作的原子性。

```java
Connection connection = DriverManager.getConnection(url, username, password);

try {
    // 关闭自动提交
    connection.setAutoCommit(false);
    
    // 执行多个操作
    PreparedStatement pstmt1 = connection.prepareStatement("UPDATE account SET balance = balance - ? WHERE id = ?");
    pstmt1.setDouble(1, 100);
    pstmt1.setInt(2, 1);
    pstmt1.executeUpdate();
    
    PreparedStatement pstmt2 = connection.prepareStatement("UPDATE account SET balance = balance + ? WHERE id = ?");
    pstmt2.setDouble(1, 100);
    pstmt2.setInt(2, 2);
    pstmt2.executeUpdate();
    
    // 提交事务
    connection.commit();
    System.out.println("事务提交成功");
    
} catch (SQLException e) {
    // 回滚事务
    connection.rollback();
    System.out.println("事务回滚");
    e.printStackTrace();
} finally {
    connection.setAutoCommit(true);
    connection.close();
}
```

### 批处理

**批处理**用于提高批量操作的性能。

```java
String sql = "INSERT INTO users (name, email) VALUES (?, ?)";

try (Connection connection = DriverManager.getConnection(url, username, password);
     PreparedStatement pstmt = connection.prepareStatement(sql)) {
    
    // 关闭自动提交
    connection.setAutoCommit(false);
    
    // 添加多个批处理
    for (int i = 0; i < 1000; i++) {
        pstmt.setString(1, "User" + i);
        pstmt.setString(2, "user" + i + "@example.com");
        pstmt.addBatch();  // 添加到批处理
    }
    
    // 执行批处理
    int[] results = pstmt.executeBatch();
    connection.commit();
    
    System.out.println("批处理完成，插入 " + results.length + " 行");
}
```

## 实际示例

### 示例 1：完整的 CRUD 操作

```java
import java.sql.*;

public class UserDAO {
    private String url;
    private String username;
    private String password;
    
    public UserDAO(String url, String username, String password) {
        this.url = url;
        this.username = username;
        this.password = password;
    }
    
    // 查询
    public void findAll() throws SQLException {
        String sql = "SELECT * FROM users";
        try (Connection conn = DriverManager.getConnection(url, username, password);
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                System.out.println("ID: " + rs.getInt("id") + 
                    ", Name: " + rs.getString("name"));
            }
        }
    }
    
    // 插入
    public int insert(String name, String email) throws SQLException {
        String sql = "INSERT INTO users (name, email) VALUES (?, ?)";
        try (Connection conn = DriverManager.getConnection(url, username, password);
             PreparedStatement pstmt = conn.prepareStatement(sql, 
                 Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setString(1, name);
            pstmt.setString(2, email);
            pstmt.executeUpdate();
            
            try (ResultSet rs = pstmt.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return -1;
    }
    
    // 更新
    public int update(int id, String name) throws SQLException {
        String sql = "UPDATE users SET name = ? WHERE id = ?";
        try (Connection conn = DriverManager.getConnection(url, username, password);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, name);
            pstmt.setInt(2, id);
            return pstmt.executeUpdate();
        }
    }
    
    // 删除
    public int delete(int id) throws SQLException {
        String sql = "DELETE FROM users WHERE id = ?";
        try (Connection conn = DriverManager.getConnection(url, username, password);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            return pstmt.executeUpdate();
        }
    }
}
```

### 示例 2：事务示例

```java
public class TransactionExample {
    public static void transfer(int fromId, int toId, double amount) throws SQLException {
        String url = "jdbc:mysql://localhost:3306/mydb";
        String username = "root";
        String password = "password";
        
        try (Connection conn = DriverManager.getConnection(url, username, password)) {
            conn.setAutoCommit(false);
            
            try {
                // 扣款
                PreparedStatement pstmt1 = conn.prepareStatement(
                    "UPDATE account SET balance = balance - ? WHERE id = ?");
                pstmt1.setDouble(1, amount);
                pstmt1.setInt(2, fromId);
                pstmt1.executeUpdate();
                
                // 存款
                PreparedStatement pstmt2 = conn.prepareStatement(
                    "UPDATE account SET balance = balance + ? WHERE id = ?");
                pstmt2.setDouble(1, amount);
                pstmt2.setInt(2, toId);
                pstmt2.executeUpdate();
                
                conn.commit();
                System.out.println("转账成功");
            } catch (SQLException e) {
                conn.rollback();
                System.out.println("转账失败，已回滚");
                throw e;
            } finally {
                conn.setAutoCommit(true);
            }
        }
    }
}
```

## JDBC 的最佳实践

### 1. 使用 try-with-resources

```java
// ✅ 推荐：自动关闭资源
try (Connection conn = DriverManager.getConnection(url, username, password);
     PreparedStatement pstmt = conn.prepareStatement(sql);
     ResultSet rs = pstmt.executeQuery()) {
    // 使用资源
}
```

### 2. 使用 PreparedStatement

```java
// ✅ 推荐：防止 SQL 注入，性能更好
PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM users WHERE id = ?");

// ❌ 不推荐：SQL 注入风险
// Statement stmt = conn.createStatement();
// stmt.executeQuery("SELECT * FROM users WHERE id = " + id);
```

### 3. 使用连接池

```java
// 使用连接池（如 HikariCP）
HikariConfig config = new HikariConfig();
config.setJdbcUrl(url);
config.setUsername(username);
config.setPassword(password);
HikariDataSource dataSource = new HikariDataSource(config);

Connection conn = dataSource.getConnection();
```

### 4. 正确处理异常

```java
try {
    // JDBC 操作
} catch (SQLException e) {
    System.err.println("SQL 错误：" + e.getMessage());
    System.err.println("错误码：" + e.getErrorCode());
    System.err.println("SQL 状态：" + e.getSQLState());
    e.printStackTrace();
}
```

## 小结

Java JDBC 数据库连接要点：

- **JDBC 驱动**：连接 Java 和数据库
- **Connection**：数据库连接
- **Statement/PreparedStatement**：执行 SQL 语句
- **ResultSet**：查询结果集
- **事务**：保证操作原子性
- **批处理**：提高批量操作性能

**关键要点**：
- 使用 PreparedStatement 防止 SQL 注入
- 使用 try-with-resources 自动关闭资源
- 使用事务保证数据一致性
- 使用批处理提高性能
- 使用连接池管理连接

理解了 JDBC，你就能进行数据库应用开发。恭喜你完成了第八部分的学习！
