---
sidebar_position: 41
---

# Python HTTP 服务



1、python开启http服务器

```shell
python -m SimpleHTTPServer 8080
```

如果提示错误：python.exe: No module named SimpleHTTPServer

则试一下命令：

```shell
python -m http.server
```



2、执行 py 脚本文件，开启 cgi 映射

```shell
python -m http.server --cgi 8000
```



py代码里添加

```python showLineNumbers
header = 'Content-Type: text/html\n'
print(header)
```



比如/cgi-bin/1.py文件代码：

```python showLineNumbers
header = 'Content-Type: text/html\n'
html = 'abc'
print(header)
print(html)
```

访问http://127.0.0.1:8000/cgi-bin/1.py

可以正常输出 abc



Ps：

py代码文件默认目录在cgi-bin或者htbin

http.server官方文档 https://docs.python.org/3/library/http.server.html
