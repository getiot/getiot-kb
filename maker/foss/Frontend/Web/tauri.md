---
sidebar_position: 5
sidebar_label: Tauri
slug: /tauri
---

# Tauri 桌面应用开发框架

**Tauri** 是一个开源的跨平台应用开发框架，允许开发者使用 Web 技术（如 HTML、CSS、JavaScript）构建用户界面，并结合 Rust 编写高性能的后端逻辑。Tauri 的目标是提供一个更轻量级、更安全的替代方案，以构建小巧、快速且安全的跨平台应用程序。



## 主要特点

- **跨平台支持**：Tauri 支持在 Linux、macOS、Windows、Android 和 iOS 上构建应用程序。
- **前端框架无关**：开发者可以使用任何编译为 HTML、CSS 和 JavaScript 的前端框架，如 React、Vue、Svelte 等。
- **小巧的应用体积**：由于利用操作系统的原生 WebView，Tauri 应用的体积通常小于 600KB，远小于 Electron 应用。
- **高性能和安全性**：Tauri 使用 Rust 编写后端，提供内存安全和线程安全，增强应用的性能和安全性。
- **插件系统**：Tauri 提供插件机制，允许开发者扩展框架的功能，满足特定需求。
- **系统集成能力**：Tauri 提供对系统功能的访问，如文件系统、通知、剪贴板等，增强应用的原生体验。



## 应用场景

- **跨平台桌面应用**：需要在多个桌面平台上运行的应用程序，如笔记应用、任务管理器等。
- **资源受限环境**：在对应用体积和性能有严格要求的场景，如老旧设备或嵌入式系统。
- **安全性要求高的应用**：需要高安全性的应用程序，如密码管理器、加密通信工具等。
- **希望复用 Web 技术栈的项目**：已有 Web 应用，想要快速构建对应的桌面版本。



## 使用示例

Tauri 允许使用 Web 技术构建桌面应用，前端使用 HTML/CSS/JavaScript，后端使用 Rust。下面是一个简单的示例，展示如何在前端调用 Rust 后端函数。

前端 HTML 代码：

```html showLineNumbers title="index.html"
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Tauri 示例</title>
  </head>
  <body>
    <input id="name" placeholder="输入你的名字" />
    <button onclick="greet()">问候</button>
    <p id="greeting"></p>

    <script>
      const { invoke } = window.__TAURI__.tauri;

      async function greet() {
        const name = document.getElementById("name").value;
        const greeting = await invoke("greet", { name });
        document.getElementById("greeting").textContent = greeting;
      }
    </script>
  </body>
</html>
```

后端 Rust 代码：

```rust showLineNumbers title="src-tauri/src/main.rs"
#[tauri::command]
fn greet(name: &str) -> String {
  format!("你好，{}！", name)
}

fn main() {
  tauri::Builder::default()
    .invoke_handler(tauri::generate_handler![greet])
    .run(tauri::generate_context!())
    .expect("error while running tauri application");
}
```

在这个示例中，前端通过 `invoke` 方法调用 Rust 后端的 `greet` 函数，实现前后端的通信。



## 相关链接

- 官方网站：[https://tauri.app](https://tauri.app)
- GitHub 仓库：[https://github.com/tauri-apps/tauri](https://github.com/tauri-apps/tauri)
- Tauri 文档中心：[https://tauri.app/start/](https://tauri.app/start/)
