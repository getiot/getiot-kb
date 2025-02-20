---
sidebar_position: 32
---

# Git 相关名词解释



- **Git**：分布式版本控制系统，用于跟踪代码变更，支持多人协作开发。最早由 Linux 内核发起人 Linus Torvalds 于 2005 年开发，最初目的是为了更好地管理 Linux 内核开发而设计，如今被广泛使用，成为最流行的代码版本管理工具。
- **仓库**（Repository）：存储项目历史记录和元数据的目录，分本地仓库和远程仓库。
- **提交**（Commit）：保存当前代码变更到本地仓库，命令：`git commit -m "描述"`。
- **分支**（Branch）：独立开发线，默认主分支为 `main` 或 `master`，创建命令：`git branch <分支名>`。
- **分支切换**（Checkout）：切换到指定分支。命令：`git checkout`。
- **分支删除**（Delete）：删除本地或远程分支。命令：`git branch -d` 或 `git push origin --delete`。
- **合并**（Merge）：将分支代码整合到另一分支，命令：`git merge <分支名>`。
- **冲突**（Conflict）：多人修改同一文件导致合并时内容冲突，需手动编辑解决。
- **推送**（Push）：将本地提交上传到远程仓库，命令：`git push origin <分支名>`。
- **拉取**（Pull）：从远程仓库下载并合并最新代码，命令：`git pull origin <分支名>`。
- **克隆**（Clone）：复制远程仓库到本地，命令：`git clone <仓库URL>`。
- **暂存区**（Staging Area）：提交前临时保存修改的区域，添加文件命令：`git add <文件名>`。
- **工作目录**（Working Directory）：本地修改文件的目录，未提交的改动存储在此。
- **HEAD**：指向当前分支最新提交的指针，代表工作目录的当前状态。
- **Origin**：默认远程仓库别名，对应克隆时的原始 URL，可自定义名称。
- **日志**（Log）：查看提交历史记录。命令：`git log`。
- **状态**（Status）：查看当前工作区和暂存区的状态。命令：`git status`。
- **标签**（Tag）：标记特定提交（如版本号），命令：`git tag -a v1.0 -m "版本说明"`。
- **重置**（Reset）：回退到指定提交，分软重置（保留修改）和硬重置（彻底删除），命令：`git reset --hard <commit-id>`。
- **回退**（Revert）：撤销之前的提交，生成新的提交记录。命令：`git revert`。
- **变基**（Rebase）：将分支提交历史移动到另一分支起点，命令：`git rebase <目标分支>`。
- **贮藏**（Stash）：临时保存未提交的修改，命令：`git stash`（恢复命令：`git stash pop`）。
- **远程仓库**（Remote）：托管在服务器（如 GitHub）的仓库，添加命令：`git remote add origin <URL>`。
- **Fetch**：从远程仓库获取最新提交但不合并，命令：`git fetch`。
- **Cherry-pick**：选择特定提交应用到当前分支，命令：`git cherry-pick <commit-id>`。
- **钩子**（Hooks）：自动化脚本，触发于特定事件（如提交前），位置：`.git/hooks/`。
- **GitHub**：全球最大的 Git 仓库托管平台，支持代码协作、Issue 跟踪和 Pull Request（PR）。GitHub 创立于2008年，2018年被微软以75亿美元价格收购。
- **GitLab**：类似 GitHub 的代码托管平台，支持 CI/CD 和私有化部署。
- **CI/CD**：持续集成（Continuous Integration）和持续交付/部署（Continuous Delivery/Deployment）的缩写，是一种软件开发实践，旨在通过自动化的方式快速、高质量地交付软件。
- **PR**（Pull Request）/ **MR**（Merge Request）：拉取请求/合并请求，请求将分支合并到主分支的协作流程，通常会触发讨论与审查的协作机制。
- **Fork**：在托管平台（如 GitHub）上复制他人仓库到个人账户，用于独立开发或贡献改进。
- **开源软件**（Open Source Software）：全称“开放源代码软件”，是指源代码公开并可自由使用、修改、分发的软件，遵循开源协议。
- **开源协议**（License）：定义使用规则的法律文件，常见的开源许可证主要有 Apache、MIT、BSD、GPL、LGPL、MPL、SSPL 等，可以大致分为宽松自由软件许可协议（Permissive free software licence）和著作权许可证（copyleft license）。例如 GPL 要求衍生代码也必须开源，而 MIT 则宽松很多，允许商用且无限制。
- **贡献者协议**（CLA）：开源项目要求贡献者签署的法律文件，明确代码版权归属。
- **社会化编程**：通过代码托管平台（如 GitHub）公开协作的开发模式，强调透明、互动与共享。
- **Star/Watch**：用户收藏（Star）或订阅（Watch）仓库，表达关注或跟踪更新。
- **Issue**：任务管理工具，用于报告缺陷、提议功能或讨论技术问题。
- **Followers/Following**：开发者关注他人动态，形成技术社交网络。
- **代码审查**（Code Review）：通过 PR 的评论和修改建议提升代码质量，促进知识共享。
- **开源治理**（Governance）：定义项目决策机制（如 BDFL、社区投票），维护开源项目的可持续发展。
- **.gitignore**：配置文件，指定哪些文件/目录不被 Git 追踪。
- **快照**（Snapshot）：Git存储文件完整状态的方式，每次提交生成新快照。
- **差异**（Diff）：文件修改内容的对比，查看命令：`git diff`。
- **上游**（Upstream）：远程仓库的默认跟踪分支，设置命令：`git push -u origin <分支名>`。
- **子模块**（Submodule）：将其他仓库作为当前项目的子目录，命令：`git submodule add <URL>`。
- **Reflog**：记录所有分支和 HEAD 变更的日志，用于恢复误删提交，命令：`git reflog`。
- **Blame**：查看文件每行代码的最后修改信息，命令：`git blame <文件名>`。
- **裸仓库**（Bare Repository）：不包含工作目录的仓库，仅用于远程协作。
- **冲突标记**（Conflict Markers）：合并冲突时文件中的 `<<<<<<<`、`=======`、`>>>>>>>` 标识符。
- **Squash**：合并多个提交为一个，常用于整理提交历史，命令：`git rebase -i HEAD~n`。
- **强制推送**（Force Push）：强制覆盖远程仓库的更改，需谨慎使用。命令：`git push -f`。
