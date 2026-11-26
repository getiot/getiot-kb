---
sidebar_position: 19
sidebar_label: Alembic 数据库迁移
slug: /fastapi-database-alembic
title: FastAPI 使用 Alembic 完成数据库迁移：初始化、生成与升级
description: 学习如何在 FastAPI 项目中使用 Alembic 管理数据库结构变更：从初始化迁移环境、配置 env.py 读取 SQLModel 模型，到自动生成迁移脚本、执行升级与回滚，并了解 SQLite 下 batch 模式的注意事项，适合已经用 SQLModel 建表、需要长期维护数据库结构的读者。
authors: [luhuadong]
draft: true
---

# FastAPI 使用 Alembic 完成数据库迁移：初始化、生成与升级

:::note 草稿
本文为草稿，内容和命令尚待完善与验证。
:::

在上一篇中，你已经用 SQLModel 定义了数据模型，并让 FastAPI 连接数据库。但项目上线后，数据表往往需要修改：新增字段、修改字段类型、增加索引。如果直接在线上数据库里手动执行 `ALTER TABLE`，很容易出错，也很难追溯和回滚。

Alembic 就是为解决这个问题设计的。它是 SQLAlchemy 作者维护的数据库迁移工具，把每一次表结构变更保存成一个版本化的脚本，你可以像管理代码一样管理数据库结构。

本文将介绍：

- Alembic 解决什么问题，以及它和 `create_all()` 的区别
- 在 FastAPI 项目中初始化 Alembic
- 配置 `env.py`，让 Alembic 读取 SQLModel 的模型
- 自动生成迁移脚本、升级与回滚
- SQLite 下的常见问题

## 为什么需要数据库迁移

在上一篇中，我们使用 `SQLModel.metadata.create_all(engine)` 自动建表。它只会在表不存在时创建，**不会修改已有的表**。

比如你给 `User` 模型新增了一个 `email` 字段，`create_all()` 不会给已经存在的 `user` 表加上这一列。这时就需要迁移工具来完成结构变更。

:::tip
开发初期，删库重建很方便。但只要数据库里已经有真实数据，就应该使用迁移，而不是删除表。
:::

## 前置准备

本文假设你已经完成以下内容：

- 已安装 Python，并创建了虚拟环境
- 已安装 FastAPI 和 SQLModel，项目中有一个可运行的数据模型
- 了解基本的命令行操作

<!-- TODO: 补充测试环境，例如 Python、FastAPI、SQLModel、Alembic 的版本号，并标注已验证。 -->

## 第一步：安装 Alembic

在项目的虚拟环境中执行：

```bash
pip install alembic
```

安装完成后，可以检查版本：

```bash
alembic --version
```

:::warning 需要验证
请补充你实际使用的 Alembic 版本，并确认命令输出与本文一致。
:::

## 第二步：初始化迁移环境

在项目根目录执行：

```bash
alembic init alembic
```

执行后，项目中会多出两样东西：

- `alembic.ini`：Alembic 的配置文件，里面有数据库连接地址。
- `alembic/` 目录：保存迁移环境代码，其中 `env.py` 是核心文件，`versions/` 用来存放每一次迁移脚本。

<!-- TODO: 补充目录结构示意图，并说明每个文件的作用。 -->

## 第三步：配置数据库地址

打开 `alembic.ini`，找到 `sqlalchemy.url`，改成你的数据库连接地址，例如 SQLite：

```ini
sqlalchemy.url = sqlite:///./app.db
```

:::warning 注意
数据库密码等敏感信息不要直接写进 `alembic.ini` 并提交到版本库。更稳妥的做法是从环境变量读取，这一点留待正式版补充。
:::

## 第四步：让 Alembic 读取 SQLModel 模型

Alembic 需要知道你的模型结构，才能比较「代码里的模型」和「数据库里的表」之间的差异。

打开 `alembic/env.py`，找到 `target_metadata`，把它改成 SQLModel 的 `metadata`，并导入所有模型：

```python
from sqlmodel import SQLModel

# 导入所有模型，确保它们已注册到 SQLModel.metadata
from app.models import *  # noqa: F401,F403

target_metadata = SQLModel.metadata
```

:::tip
如果某个模型没有被导入，Alembic 就不会为它生成建表或改表的代码。
:::

## 第五步：生成第一个迁移脚本

假设你已经定义了 `User` 模型，执行：

```bash
alembic revision --autogenerate -m "create user table"
```

Alembic 会比较模型和数据库的差异，并在 `alembic/versions/` 下生成一个迁移脚本，文件名类似 `xxxx_create_user_table.py`。

:::warning 必须检查生成的脚本
自动生成并不是百分之百准确。它可能漏掉某些变更，例如字段重命名、部分默认值变化，也可能生成不符合预期的操作。执行前请务必打开脚本，逐行检查 `upgrade()` 和 `downgrade()` 的内容。
:::

## 第六步：执行升级

确认脚本没有问题后，执行：

```bash
alembic upgrade head
```

`head` 表示最新的迁移版本。执行成功后，数据库里就会出现对应的表。

<!-- TODO: 补充预期输出示例，并用 sqlite3 或 DB Browser 验证表结构。 -->

## 第七步：修改模型并再次迁移

假设你给 `User` 增加了一个 `email` 字段：

1. 修改模型代码。
2. 生成新的迁移脚本：

   ```bash
   alembic revision --autogenerate -m "add email to user"
   ```

3. 检查脚本，然后执行升级：

   ```bash
   alembic upgrade head
   ```

每一次变更都会形成一个新版本，历史记录会保存在 `versions/` 目录中。

## 常用命令速查

| 命令 | 作用 |
| --- | --- |
| `alembic current` | 查看数据库当前所在的版本 |
| `alembic history` | 查看所有迁移历史 |
| `alembic upgrade head` | 升级到最新版本 |
| `alembic downgrade -1` | 回滚一个版本 |

:::danger 回滚的风险
回滚会执行脚本里的 `downgrade()`，可能删除列或表中的数据。在生产环境执行前，请先备份数据库。
:::

## SQLite 下的注意事项

SQLite 对 `ALTER TABLE` 的支持有限，修改列的操作常常会失败。Alembic 提供了 batch 模式来解决这个问题，在 `env.py` 的 `context.configure()` 中加入 `render_as_batch=True`：

```python
context.configure(
    connection=connection,
    target_metadata=target_metadata,
    render_as_batch=True,
)
```

<!-- TODO: 在 SQLite 下实际验证 render_as_batch 的效果，并给出失败与修复的对比示例。 -->

## 常见错误与排查

<!-- TODO: 补充常见错误，例如：
- `Target database is not up to date`
- 模型未被导入导致 autogenerate 没有检测到变化
- 迁移脚本与数据库版本不一致（alembic_version 表）
-->

## 小结

<!-- TODO: 总结 Alembic 的完整流程：初始化 → 配置 → 生成 → 检查 → 升级 → 回滚。 -->

## 相关阅读

- 上一篇：[FastAPI 连接数据库：SQLModel 快速入门](fastapi-database-sqlmodel.md)
- 官方文档：[Alembic 官方文档](https://alembic.sqlalchemy.org/)

:::note 需要验证
本草稿中的命令、配置项与输出示例，发布前需要在实际项目中逐一运行验证，并确认与 Alembic、SQLModel 的当前版本一致。
:::
