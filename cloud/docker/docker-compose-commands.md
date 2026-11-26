---
sidebar_position: 8
sidebar_label: docker compose 常用命令
slug: /docker-compose-commands
---

# docker compose 常用命令详解

自 Docker 20.10 版本起，官方推荐使用无中划线的 `docker compose` 命令，取代早期的 `docker-compose`。新版命令统一纳入 Docker CLI，更加一致、现代化。

本文将为你全面介绍 `docker compose` 的常用子命令及其参数，帮助你高效管理多容器应用。



## 基本格式

```bash
docker compose [子命令] [选项] [参数]
```

例如：

```bash
docker compose up -d
```



## 常用子命令详解

### 1. `up` 启动服务

启动并运行 `docker-compose.yml` 中定义的所有服务。

```bash
docker compose up
```

常用参数：

| 参数               | 说明                      |
| ------------------ | ------------------------- |
| `-d`               | 后台运行（detached mode） |
| `--build`          | 在启动前强制构建服务镜像  |
| `--force-recreate` | 即使未改动也重新创建容器  |
| `--no-deps`        | 启动时不启动依赖服务      |

**示例：**

```
docker compose up -d
docker compose up --build
```



### 2. `down` 停止并移除容器、网络、卷等

```bash
docker compose down
```

常用参数：

| 参数               | 说明                              |
| ------------------ | --------------------------------- |
| `-v`               | 删除挂载的卷                      |
| `--rmi all`        | 删除所有镜像                      |
| `--remove-orphans` | 删除未在 Compose 文件中定义的容器 |

**示例：**

```bash
docker compose down -v
docker compose down --rmi all --remove-orphans
```



### 3. `ps` 查看服务状态

列出当前项目的容器状态。

```bash
docker compose ps
```

常用参数：

| 参数         | 说明                       |
| ------------ | -------------------------- |
| `-a`         | 显示所有容器（包括停止的） |
| `--services` | 仅显示服务名               |
| `--quiet`    | 仅显示容器 ID              |

**示例：**

```bash
docker compose ps
docker compose ps --services
```



### 4. `exec` 在容器中执行命令

```bash
docker compose exec <服务名> <命令>
```

常用参数：

| 参数 | 说明                     |
| ---- | ------------------------ |
| `-u` | 指定用户名或 UID         |
| `-T` | 不分配 TTY（适用于管道） |

**示例：**

进入服务容器：

```bash
docker compose exec backend bash
```

执行迁移命令：

```bash
docker compose exec backend alembic upgrade head
```



### 5. `logs` 查看服务日志

```bash
docker compose logs
```

常用参数：

| 参数       | 说明                         |
| ---------- | ---------------------------- |
| `-f`       | 实时滚动日志（类似 tail -f） |
| `--tail N` | 只显示最后 N 行              |

**示例：**

```bash
docker compose logs -f
docker compose logs -f backend
```



### 6. `restart` 重启服务

```bash
docker compose restart [服务名]
```

不加服务名表示重启所有服务。

**示例：**

```
docker compose restart
docker compose restart backend
```



### 7. `build` 构建服务镜像

```bash
docker compose build [服务名]
```

常用参数：

| 参数         | 说明             |
| ------------ | ---------------- |
| `--no-cache` | 构建时不使用缓存 |
| `--pull`     | 拉取最新基础镜像 |

**示例：**

```
docker compose build
docker compose build backend
docker compose build --no-cache
```



### 8. `stop` 和 `start`

分别用于**停止**和**启动**已存在的容器，不会删除它们。

```bash
docker compose stop [服务名]
docker compose start [服务名]
```

**示例：**

```bash
docker compose stop backend
docker compose start backend
```



### 9. `run` 临时运行一个服务容器

不影响主容器，用于一次性任务（如初始化、迁移等）。

```bash
docker compose run <服务名> <命令>
```

常用参数：

| 参数        | 说明                    |
| ----------- | ----------------------- |
| `--rm`      | 容器退出后自动删除      |
| `--no-deps` | 不启动依赖服务          |
| `-T`        | 不分配 TTY（适用于 CI） |

**示例：**

```bash
docker compose run --rm backend python manage.py migrate
```



### 10. `config` 检查 Compose 文件是否正确

```bash
docker compose config
```

显示合并后的配置，可用于调试。



## 小结

`docker compose` 是开发和部署多容器应用的重要工具，掌握这些命令将大大提升你的容器化工作效率。在开发过程中，建议将常用命令整理成脚本或 Makefile，提高重复操作的效率。

如果你正在开发基于微服务的项目或使用数据库等后端服务，不妨多尝试 Compose 提供的组合操作。
