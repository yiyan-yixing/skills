# Changelog

所有重要变更均记录于此。格式参考 [Keep a Changelog](https://keepachangelog.com/)。

## [0.3.0] - 2026-06-13

### Added

- **交互式初始化脚本** `init.sh` — 7 个问题一键写入公司信息到记忆系统
- **安装参数** `--init` / `--skip-init` — 控制安装后是否自动初始化
- **源码/运行时分离** — blackboard/evals/memory/CLAUDE.md.template 从 `.claude/` 移至仓库根目录
- **非交互模式初始化** — 环境变量预填，适合 CI/自动化

### Changed

- `install.sh` 简化路径逻辑，从根目录读取源文件，不再 fallback 查找 `.claude/` 子目录
- `README.md` 新增 30 秒上手、用户旅程图、仓库/安装后双目录结构、安装参数说明
- `.gitignore` 扩展：skills-lock.json、node_modules/、OS/编辑器临时文件

### Removed

- `.claude/` 目录从仓库中移除（全部源码已在根目录）
- `P0-IMPLEMENTATION-EVAL.md`（P0 实施已完成，评估结论合入 EVALUATION.md v2）

---

## [0.2.0] - 2026-06-13

### Added

- **Architect 角色** `agents/architect.md` — 技术架构师，负责技术选型、ADR、架构债务监控
- **Designer 角色** `agents/designer.md` — 产品设计师，3 天出 Demo 流程
- **Data 角色** `agents/data.md` — 数据分析师，指标搭建 + 效果分析
- **DevOps 角色** `agents/devops.md` — 开发工具链，"工欲善其事必先利其器"
- **DAG 协作流程** `agents/WORKFLOW.md` — 从线性流水线升级为条件分支 DAG + 11 个交接标准
- **质疑协议** `agents/challenge-protocol.md` — 触发条件、质疑流程、严重度分级
- **5 个新技能**：designer-rapid-prototype、data-metrics-setup、data-effect-analysis、devops-fast-pipeline、sprint-one-week
- **三层记忆系统** `.claude/memory/` — core（常驻）/archival（长期）/recall（历史）
- **共享白板** `.claude/blackboard/` — current-sprint、open-questions、challenges、decisions-log
- **效果评估体系** `.claude/evals/` — 8 维度评估框架 + Sprint 归档
- **CLAUDE.md 记忆入口** — @import core 三文件
- **一键安装脚本** `install.sh` — curl | bash 安装全部内容
- **EVALUATION.md v1** — 行业对标评估报告

---

## [0.1.0] - 2026-06-13

### Added

- **6 个 Agent 角色**：CEO、PM、Dev、QA、Ops、Fin
- **20 个 Skills**：覆盖各角色日常技能
- **README.md** — 安装说明、角色一览、技能一览
- **.gitignore** — 忽略 .claude/ 目录
- **首次提交推送** 到 github-yiyan-yixing/skills
