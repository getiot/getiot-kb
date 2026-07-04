---
sidebar_position: 5
slug: /boost-asio-set-buffer-size
---

# Boost.Asio 设置 socket 缓冲区大小



```cpp showLineNumbers
#include <boost/asio.hpp>
#include <iostream>

using namespace boost;

int main()
{
    // 后面的socket构造函数需要
    asio::io_context ioc;

    // 创建tcp对象
    asio::ip::tcp protocol = asio::ip::tcp::v4();

    // 创建套接字
    asio::ip::tcp::socket socket(ioc);

    // 打开套接字
    boost::system::error_code ec;

    std::cout << "Open a socket" << std::endl;
    socket.open(protocol, ec);

    // 异常处理
    if (ec.value() != 0)
    {
        std::cout
            << "Failed to open the socket!"
            << "Error code = "
            << ec.value() << ". Message: " << ec.message();
        return ec.value();
    }

    // 获取接收缓冲区大小
    boost::asio::socket_base::receive_buffer_size option;
    socket.get_option(option);
    int size = option.value();
    std::cout << "The receive buffer size is " << size << " bytes" << std::endl;

    // 将接收缓冲区大小扩大两倍
    socket.set_option(boost::asio::socket_base::receive_buffer_size(size * 2));
    
    // 重新查看接收缓冲区大小
    socket.get_option(option);
    size = option.value();
    std::cout << "The receive buffer size is " << size << " bytes" << std::endl;

    std::cout << "Close a socket" << std::endl;
    socket.close();
    return 0;
}
```

完整代码：[getiot/boost-courses](https://github.com/getiot/boost-courses/blob/main/asio/socket_options/set_double_buffer_size.cpp)



## 参考

- [asio C++ library](https://think-async.com/Asio/asio-1.24.0/doc/asio/reference/socket_base/receive_buffer_size.html)

