---
sidebar_position: 6
---

# Makefile 常见问题



### 命令前加 @ 和 - 符号是什么意思？

许多项目的 Makefile 文件会在执行命令前加上一个 @ 或 - 符号，例如：

```makefile showLineNumbers
$(BINDIR)/$(TARGET): $(OBJECTS)
	@mkdir -p $(BINDIR)
	@$(LINKER) $(OBJECTS) $(LFLAGS) -o $@
	@echo "Linking complete!"
```

其实这是有特殊作用的：

1. 如果在 Makefile 执行的命令前面加上 “@” 号，则表示不显示命令本身而只显示执行结果；
2. 通常 make 执行的命令出错（该命令的退出状态非 0）就立刻终止，不再执行后续命令，但是如果命令前面加上 “-” 号，则表示即使这条命令出错，Makefile 也会继续执行后续命令的。





