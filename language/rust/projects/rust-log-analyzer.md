---
sidebar_position: 2
slug: /rust-log-analyzer
---

# 日志分析工具

这一节我们写一个简单日志分析工具，统计日志中不同级别出现的次数。

## 示例日志

```text title="app.log"
INFO server started
WARN retry connection
ERROR connection failed
INFO shutdown
```

## 编写代码

```rust title="src/main.rs" showLineNumbers
use std::collections::HashMap;
use std::fs;

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let text = fs::read_to_string("app.log")?;
    let mut counts: HashMap<&str, usize> = HashMap::new();

    for line in text.lines() {
        if let Some((level, _message)) = line.split_once(' ') {
            *counts.entry(level).or_insert(0) += 1;
        }
    }

    for level in ["ERROR", "WARN", "INFO", "DEBUG"] {
        let count = counts.get(level).copied().unwrap_or(0);
        println!("{level}: {count}");
    }

    Ok(())
}
```

## 运行结果

```text
ERROR: 1
WARN: 1
INFO: 2
DEBUG: 0
```

## 可以继续改进什么

- 支持命令行参数指定日志文件
- 支持按时间范围过滤
- 输出 JSON
- 用正则表达式解析更复杂日志

## 小结

日志分析工具能训练你处理文本、计数和错误路径。你会发现 Rust 写这类工具并不笨重，反而很适合做可靠的小程序。

