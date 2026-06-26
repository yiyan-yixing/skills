# Changelog

所有重要变更均记录于此。格式参考 [Keep a Changelog](https://keepachangelog.com/)。

## [0.6.0] - 2026-06-26

### Added

- **反馈闭环协议（Feedback Loop Protocol）** `agents/WORKFLOW.md` — 在级联协议的关键交接点加入双向反馈循环，防止方向跑偏和需求漂移
  - 3 条闭环：① CEO↔PM PRD 评审（CEO 走查 PM 的 PRD） ② PM↔Dev 实现走查（PM 走查 Dev 的代码） ③ QA↔Dev 质量回退（已有，强化）
  - 闭环门控：PRD 必须经 CEO 走查通过，代码必须经 PM 走查通过，才能继续下一阶段
  - 最多 2 轮回退：超过 2 轮上报用户
  - 走查记录格式：写入 `blackboard/walkthrough-{timestamp}.md`
  - CEO PRD 走查要点：方向一致性、优先级正确、无 scope creep、可执行性
  - PM 实现走查要点：验收覆盖、核心路径、无需求漂移、不做清单
  - QA 需求澄清：验收标准不明确时可调 PM 澄清（非 No-Go，是需求问题）
- **级联路由表更新** — PM→CEO 走查→继续级联，Dev→PM 走查→QA，QA→PM 需求澄清
- **@ceo 新增 PRD 走查段** — CEO 自动审 PM 的 PRD，通过/打回，含走查调用语法和走查规则
- **@pm 改级联路由 + 新增实现走查段** — PRD 完成后先交 CEO 走查；收到 Dev 代码后走查，通过→QA，打回→Dev
- **@dev 改级联路由** — 代码完成后先交 PM 走查（不再直交 QA），含 PM 走查调用语法
- **@qa 新增需求澄清段** — 验收标准不明确时可调 PM 澄清，含澄清调用语法和判断规则
- **auto-ship 更新** — Phase 1 后加 CEO PRD 走查子步骤，Phase 2 后加 PM 实现走查子步骤，走查打回最多 2 轮

## [0.5.0] - 2026-06-26

### Added

- **自动级联协议（Cascade Protocol）** `agents/WORKFLOW.md` — Agent 完成工作后自动派发下游 Agent，无需人工串联
  - 级联路由表：@ceo → @pm → @architect/@designer → @dev → @qa → @devops → @ops → @data → @pm（闭环）
  - 级联触发判断：交付型任务自动级联，单一动作不级联
  - 条件门控：涉及新模块走 @architect，涉及用户功能走 @designer
  - QA No-Go 回退循环：最多 2 轮，第 3 轮上报用户
  - 人工确认点：CEO 定方向后、QA 第 3 轮 No-Go、@data 效果报告后
- **9 个 Agent 新增级联段**：@ceo、@pm、@architect、@designer、@dev、@qa、@devops、@ops、@data 各自加入"自动级联（Cascade）"段，含下游路由、级联调用语法、交接物写入规则

## [0.4.0] - 2026-06-26

### Added

- **auto-ship 编排技能** `skills/auto-ship/SKILL.md` — 全自动产品交付流水线，一键串联 @pm → @dev → @qa → @devops，中间决策自动处理，只在最终审批门汇总品味决策
  - 6 条自动决策原则（完整优先、波及必治、务实选择、不造轮子、显式优于巧妙、行动优先）
  - 决策三级分类：机械决策（静默处理）、品味决策（汇总到审批门）、用户挑战（绝不自动）
  - "Only stop for / Never stop for" 清单
  - 4 阶段顺序流水线（@pm 需求定义 → @dev 代码实现 → @qa 质量把关 → @devops 部署上线）
  - QA→Dev 回退循环（最多 2 轮，第 3 轮提交用户决策）
  - 最终审批门（品味决策 + 用户挑战一次性汇总）
  - 跨会话记忆（决策日志 + 经验教训 + 时间线）
- **技能路由规则** `CLAUDE.md.template` — 添加 /auto-ship 为全自动产品交付的路由入口

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
