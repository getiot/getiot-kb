---
sidebar_position: 0
slug: /calling-lua-from-c
---

# C 语言调用 Lua

Lua 很适合嵌入到 C / C++ 程序中。你可以让 C 程序负责底层能力，例如设备访问、网络、图形渲染；再让 Lua 负责配置、业务逻辑或脚本扩展。

这一节带你写一个最小 C 程序：创建 Lua 虚拟机，加载标准库，执行 Lua 脚本，然后关闭虚拟机。

## 准备环境

在 Ubuntu / Debian 上，你通常需要安装 Lua 开发头文件和编译工具：

```bash
sudo apt install build-essential lua5.4 liblua5.4-dev pkg-config
```

不同系统上的包名可能不同。如果 `pkg-config --libs lua5.4` 找不到结果，请检查发行版提供的 Lua 开发包名称。

## 第一个嵌入式程序

创建 `main.c`：

```c showLineNumbers title="main.c"
#include <stdio.h>

#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>

int main(void)
{
    lua_State *L = luaL_newstate();
    if (L == NULL) {
        fprintf(stderr, "cannot create Lua state\n");
        return 1;
    }

    luaL_openlibs(L);

    if (luaL_dostring(L, "print('Hello from Lua')") != LUA_OK) {
        fprintf(stderr, "lua error: %s\n", lua_tostring(L, -1));
        lua_close(L);
        return 1;
    }

    lua_close(L);
    return 0;
}
```

编译：

```bash
cc main.c -o call_lua $(pkg-config --cflags --libs lua5.4)
```

运行：

```bash
./call_lua
```

输出：

```text
Hello from Lua
```

## 执行 Lua 文件

创建 `script.lua`：

```lua showLineNumbers title="script.lua"
print("script is running")
```

修改 C 程序中的执行部分：

```c
if (luaL_dofile(L, "script.lua") != LUA_OK) {
    fprintf(stderr, "lua error: %s\n", lua_tostring(L, -1));
    lua_close(L);
    return 1;
}
```

`luaL_dofile()` 会加载并执行 Lua 文件。执行失败时，错误信息会留在 Lua stack 顶部。

## C 调用 Lua 函数

创建 `script.lua`：

```lua showLineNumbers title="script.lua"
function add(a, b)
   return a + b
end
```

C 程序：

```c showLineNumbers title="call-function.c"
#include <stdio.h>

#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>

int main(void)
{
    lua_State *L = luaL_newstate();
    luaL_openlibs(L);

    if (luaL_dofile(L, "script.lua") != LUA_OK) {
        fprintf(stderr, "%s\n", lua_tostring(L, -1));
        lua_close(L);
        return 1;
    }

    lua_getglobal(L, "add");
    lua_pushinteger(L, 3);
    lua_pushinteger(L, 5);

    if (lua_pcall(L, 2, 1, 0) != LUA_OK) {
        fprintf(stderr, "%s\n", lua_tostring(L, -1));
        lua_close(L);
        return 1;
    }

    lua_Integer result = lua_tointeger(L, -1);
    lua_pop(L, 1);

    printf("result: %lld\n", (long long)result);

    lua_close(L);
    return 0;
}
```

编译：

```bash
cc call-function.c -o call_function $(pkg-config --cflags --libs lua5.4)
```

运行：

```bash
./call_function
```

输出：

```text
result: 8
```

## Lua stack 的基本直觉

Lua C API 围绕一个虚拟 stack 工作：

- C 通过 `lua_push*()` 把值压入 stack。
- C 通过 `lua_getglobal()`、`lua_getfield()` 等函数取 Lua 侧值。
- C 通过 `lua_pcall()` 调用 Lua 函数。
- C 通过 `lua_to*()` 从 stack 读取返回值。
- 读完后要用 `lua_pop()` 清理不再需要的值。

初学 C API 时，最常见错误就是 stack 上的参数数量、返回值数量和索引搞错。

## Lua 调用 C 函数

你也可以把 C 函数注册给 Lua 调用：

```c showLineNumbers title="register-function.c"
#include <stdio.h>

#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>

static int c_add(lua_State *L)
{
    lua_Integer a = luaL_checkinteger(L, 1);
    lua_Integer b = luaL_checkinteger(L, 2);

    lua_pushinteger(L, a + b);
    return 1;
}

int main(void)
{
    lua_State *L = luaL_newstate();
    luaL_openlibs(L);

    lua_register(L, "c_add", c_add);

    if (luaL_dostring(L, "print(c_add(10, 20))") != LUA_OK) {
        fprintf(stderr, "%s\n", lua_tostring(L, -1));
    }

    lua_close(L);
    return 0;
}
```

输出：

```text
30
```

`c_add()` 返回 `1`，表示它向 Lua 返回了一个值。

## 小结

你需要掌握：

- `luaL_newstate()` 创建 Lua state。
- `luaL_openlibs()` 打开标准库。
- `luaL_dostring()` 执行字符串代码。
- `luaL_dofile()` 执行 Lua 文件。
- `lua_pcall()` 用于安全调用 Lua 函数。
- Lua C API 通过 stack 交换参数和返回值。
- C 函数返回给 Lua 的值数量由 C 函数的返回值指定。
