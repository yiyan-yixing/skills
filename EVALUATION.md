# 一人公司 Agent 体系评估报告 v2

> 评估时间：2026-06-13 | 评估视角：CEO + 行业对标 + 实战验证
> 评估对象：10 角色 + 26 技能 + 三层记忆 + 共享白板 + 质疑协议 + DAG 流程 + 一键安装 + 交互式初始化
> 上次评估：v1（9 角色 + 25 技能，无记忆/白板/质疑/安装）

---

## 总体评价

**结论：从"管理框架"升级为"可运行的一人公司操作系统"，在独立开发者/一人公司领域处于领先水平，在多 Agent 编排领域接近行业第一梯队。**

v1 到 v2 的关键跃迁：

| 维度 | v1 评分 | v2 评分 | 变化 | 关键补强 |
|------|---------|---------|------|----------|
| 角色体系完整性 | 7/10 | **8/10** | +1 | +Architect 角色填补最大短板 |
| 协作流程设计 | 6/10 | **8/10** | +2 | DAG 条件分支 + 质疑协议 + 共享白板 |
| 记忆与学习 | 2/10 | **7/10** | +5 | 三层记忆 + CLAUDE.md @import + Auto Memory 互补 |
| 差异化竞争力 | 5/10 | **7/10** | +2 | Claude Code 原生格式 + 一人公司垂直场景 |
| 极速交付能力 | 6/10 | **7/10** | +1 | 3天 Demo 流程 + DevOps 流水线 + 一周迭代 |
| 安装与开箱体验 | 2/10 | **8/10** | +6 | install.sh + init.sh + 源码/运行时分离 |
| 效果评估 | 2/10 | **6/10** | +4 | 8 维度评估框架 + Sprint 归档 |
| **综合** | **4.5/10** | **7.6/10** | +3.1 | 从"框架文档"到"可运行系统" |

---

## 行业对标：与主流 Agent 框架的逐项对比

### 对标对象

| 框架 | 定位 | Stars | 核心能力 |
|------|------|-------|----------|
| **CrewAI** | 通用多 Agent 编排 | 30k+ | 角色+任务+流程，企业版有 RBAC/监控 |
| **AutoGen** (微软) | 多 Agent 对话研究 | 40k+ | 事件驱动，Group Chat，Docker 代码执行 |
| **MetaGPT** | AI 软件公司模拟 | 50k+ | SOP 流水线，PM/Architect/Engineer 角色 |
| **LangGraph** | 状态图编排 | 20k+ | DAG 状态图，持久化，Human-in-the-loop |
| **Letta/MemGPT** | 记忆优先的 Agent | 15k+ | 4 层记忆（block/shared/archival/context） |

### 逐项对比

| 维度 | 一人公司体系 | CrewAI | AutoGen | MetaGPT | LangGraph | Letta |
|------|-------------|--------|---------|---------|-----------|-------|
| **角色定义** | 10 角色全 Markdown frontmatter ✅ | Python class | Python class | Python class | 无内置 | 无内置 |
| **协作模式** | DAG 条件分支 + 质疑协议 ✅ | 串行/层级/混合 | 事件驱动 + Group Chat | SOP 流水线 | 状态图 | 无内置 |
| **记忆系统** | 3 层 (core/archival/recall) ✅ | 内置 memory | 无 | ProjectRepo | 短期+长期 | 4层(block/shared/archival/context) ✅✅ |
| **对抗/质疑** | challenge-protocol.md ✅ | Guardrails | 无 | 无 | 无 | 无 |
| **共享状态** | Blackboard 4 文件 ✅ | 无 | 无 | 无 | State graph | Shared memory |
| **评估体系** | 8 维度 eval ✅ | 无 | 无 | 无 | LangSmith 集成 | 无 |
| **安装体验** | install.sh + init.sh 一键 ✅ | pip install | pip install | pip install | pip install | pip install |
| **运行时格式** | Claude Code 原生 .claude/ ✅ | 自有 runtime | 自有 runtime | 自有 runtime | 自有 runtime | 自有 runtime |
| **可视化编排** | ❌ | ❌ | Studio (Web UI) | ❌ | LangGraph Studio | ❌ |
| **代码执行** | Bash tool | ❌ | Docker 执行器 | Python 执行 | ❌ | ❌ |
| **生产部署** | ❌ | 企业版 RBAC | 分布式 gRPC | ❌ | 可扩展运行时 | REST API server |
| **SOP 驱动** | WORKFLOW.md DAG ✅ | ❌ | ❌ | Code=SOP(Team) ✅ | ❌ | ❌ |

### 我们独有的优势（行业无人做到）

1. **质疑协议（Challenge Protocol）** — CrewAI/AutoGen/MetaGPT/LangGraph/Letta 都没有内置对抗审查机制。我们的 `challenge-protocol.md` 定义了触发条件、质疑流程、严重度分级。这是**反确认偏差的工程化实践**，在行业框架中独一无二。

2. **一人公司垂直场景** — 所有主流框架都是通用编排工具，没有人专门为"一人公司"设计角色、流程、KPI。我们的 10 角色是从创业实践提炼的，不是通用角色模板。

3. **安装→初始化→开工的完整用户旅程** — `install.sh` + `init.sh` 让用户 5 分钟从空目录到拥有自己的公司框架。其他框架需要写 Python 代码才能跑起来。

4. **时间盒 + 反模式** — 每个 Skill 都有时间限制和"不要这样做"清单。行业框架只管"能做什么"，我们管"不做什么"。

5. **Claude Code 原生格式** — `.claude/` 目录结构直接被 Claude Code 自动发现，不需要写任何胶水代码。其他框架都需要自己的 runtime。

### 我们的短板（行业已有我们缺失）

| 短板 | 谁做得好 | 差距 | 优先级 |
|------|----------|------|--------|
| **可视化编排** | LangGraph Studio, AutoGen Studio | 大 — 无法用 UI 看到和编排 DAG | P2 |
| **代码执行沙箱** | AutoGen Docker 执行器 | 中 — 当前靠 Claude Code Bash tool，无隔离 | P2 |
| **生产部署** | CrewAI 企业版, Letta REST API | 中 — 目前只适合开发态，没有服务化 | P3 |
| **记忆检索** | Letta passage-based embedding 检索 | 中 — 我们是文件直接读，没有向量检索 | P2 |
| **MCP/工具生态** | CrewAI triggers (Gmail/Slack/HubSpot) | 大 — 没有外部系统集成 | P1 |
| **记忆层级精细度** | Letta 4 层 + context hierarchy | 中 — Letta 的 context window 管理更精细 | P2 |

---

## 各维度详细评估

### 1. 角色体系完整性：8/10 ✅

| 检查项 | 状态 | 说明 |
|--------|------|------|
| 覆盖公司核心职能 | ✅ | CEO/PM/Designer/Architect/Dev/QA/DevOps/Ops/Data/Fin |
| 每个角色有 frontmatter | ✅ | name/description/tools/model/color/memory |
| 角色有明确 KPI | ✅ | 每个角色有核心使命 + 不做什么 |
| 角色间有清晰交接标准 | ✅ | WORKFLOW.md 定义 11 个交接点和验收条件 |
| 对抗视角角色分离 | ✅ | Dev≠QA, PM≠Data, CEO≠Data |

**扣分点**：缺少 HR/法务（一人公司初期可忽略，但融资时需要）

### 2. 协作流程设计：8/10 ✅

| 检查项 | 状态 | 说明 |
|--------|------|------|
| DAG 而非线性流水线 | ✅ | 支持 QA Go/No-Go 条件分支 |
| 质疑节点 | ✅ | 3 条质疑路径（PRD/技术方案/重大决策） |
| 紧急流程 | ✅ | P0 修复 <1h，方向大转，机会窗口 |
| 记忆读写权限 | ✅ | 每个 Agent 有明确的读写范围 |
| 一周迭代节奏 | ✅ | 周一规划→周三检查→周五复盘 |

**扣分点**：
- 质疑协议有定义但**没有自动化执行** — 依赖 Claude "自觉"触发，不像 CrewAI 的 Guardrails 是代码强制
- DAG 目前是 Markdown 描述，不是可执行图 — LangGraph 的 StateGraph 是代码级的

### 3. 记忆与学习：7/10 ✅

| 层级 | 能力 | 状态 |
|------|------|------|
| L1 静态 | 每次从零开始 | ✅ 已超越 |
| L2 项目记忆 | 记住技术栈、架构决策、上下文 | ✅ core/ 3 文件 + archival/ |
| L2.5 会话间记忆 | Auto Memory 自动学习 | ✅ Claude Code 原生支持 |
| L3 组织学习 | 从历史项目提炼模式 | ⚠️ archival 存档但无自动提炼 |
| L4 自进化 | Agent 根据效果数据优化行为 | ❌ |

**亮点**：三层记忆 (core/archival/recall) + CLAUDE.md @import + Auto Memory = **双轨记忆**：
- 显式记忆：core/ 手写，每 session 加载
- 隐式记忆：Auto Memory 自动积累

**扣分点**：
- archival/ 是被动存档，没有**自动提炼**（Letta 有 passage-based 向量检索）
- recall/ 层目前空置，依赖 Auto Memory 而非结构化会话摘要
- 没有 **context window 管理** — Letta 有显式的 context hierarchy 控制什么进入上下文

### 4. 差异化竞争力：7/10 ✅

| 差异点 | 行业对比 | 竞争壁垒 |
|--------|----------|----------|
| 一人公司垂直 | **唯一** | 高 — 没有竞品做这个垂直 |
| 质疑协议 | **唯一** | 高 — 行业框架没有对抗机制 |
| 时间盒+反模式 | **罕见** | 中 — 实践价值高但可复制 |
| Claude Code 原生格式 | **唯一** | 中 — 依赖 Claude Code 生态 |
| DAG 条件分支 | LangGraph 有 | 低 — 技术上不独特 |
| 三层记忆 | Letta 有 4 层 | 中 — 设计接近但实现更轻 |

**风险**：
- CrewAI 如果加质疑协议 → 壁垒降低
- 如果 Claude Code 改格式 → 全部重来
- 一人公司垂直场景如果被验证 → 大框架会抄

### 5. 安装与开箱体验：8/10 ✅

| 检查项 | 状态 | 说明 |
|--------|------|------|
| 一键安装 | ✅ | curl install.sh \| bash |
| 交互式初始化 | ✅ | 7 个问题写入公司信息 |
| 非交互模式 | ✅ | 环境变量预填，适合 CI |
| 源码/运行时分离 | ✅ | 仓库根目录 = 源码，.claude/ = 运行时 |
| 技能自动发现 | ✅ | npx skills add + Claude Code 自动发现 |
| 文档清晰度 | ✅ | README 30秒上手 + 用户旅程图 |

**扣分点**：
- `init.sh` 未在真实环境中端到端测试
- `curl | bash` 有安全顾虑（没有签名校验）
- 没有 uninstall/reinstall 流程

### 6. 效果评估：6/10 ⚠️

| 检查项 | 状态 | 说明 |
|--------|------|------|
| 评估维度定义 | ✅ | 8 维度（PRD质量/原型速度/代码质量/测试覆盖/部署速度/数据时效/质疑有效性/迭代速度） |
| 评估报告模板 | ✅ | Sprint-N 模板 |
| 产出归档结构 | ✅ | agent-outputs/sprint-N/ |
| 自动采集 | ❌ | 指标需人工提取 |
| 历史趋势对比 | ❌ | 没有跨 Sprint 自动对比 |
| LangSmith 级别可观测性 | ❌ | 无 tracing/debugging |

**本质问题**：评估体系是"好的设计文档"，但不是"可运行的评估引擎"。LangSmith 提供自动 tracing、状态转换可视化、运行时指标 — 我们需要手动填表。

---

## 能力成熟度模型（CMM）

```
Level 5: 自进化 — Agent 根据效果数据自动优化行为          ❌
Level 4: 量化闭环 — 效果数据自动采集→评估→改进             ❌（框架有，引擎无）
Level 3: 协作自治 — Agent 间主动质疑/委托/协作             ✅ 质疑协议（手动触发）
Level 2: 项目记忆 — 跨会话记住上下文和历史决策              ✅ 三层记忆 + Auto Memory
Level 1: 角色定义 — 每个角色有清晰的职责和边界              ✅ 10 角色全定义
Level 0: 静态脚本 — 固定流程，无状态                      ✅ 已超越
```

**当前水平：Level 2-3 之间**

- 记忆系统已到位（Level 2 ✅）
- 质疑协议定义了但需手动触发（Level 3 一半）
- 量化评估只有框架没有引擎（Level 4 缺口）

---

## 与 v1 评估的核心变化

| v1 短板 | v2 状态 | 解决方式 |
|---------|---------|----------|
| 缺少架构师角色 | ✅ 已补 | `architect.md` + `architect-tech-radar` 技能 |
| Agent 没有协作机制 | ✅ 已补 | DAG 条件分支 + 质疑协议 + 共享白板 |
| 没有记忆机制 | ✅ 已补 | 三层记忆 + CLAUDE.md @import + Auto Memory |
| 缺少用户验证闭环 | ⚠️ 部分 | @ops + @data 定义了，但缺 MCP 外部集成 |
| 没有效果评估 | ⚠️ 部分 | 8 维度框架有，自动采集引擎无 |

---

## 要达到"行业领先"还差什么

### P0：让已有设计真正"跑起来"

| 项 | 现状 | 目标 | 工作量 |
|----|------|------|--------|
| 质疑协议自动化 | Markdown 定义，需手动触发 | Agent 自动按条件触发质疑 | 3天 |
| 评估引擎 | 手动填表 | 从 blackboard/ 自动提取指标生成报告 | 2天 |
| init.sh 端到端测试 | 未测试 | 新目录→安装→初始化→@ceo 可用 | 1天 |

### P1：补上与行业第一梯队的差距

| 项 | 对标 | 差距 | 工作量 |
|----|------|------|--------|
| MCP 外部集成 | CrewAI triggers | 没有外部系统连接（Slack/Gmail/HubSpot） | 5天 |
| 向量记忆检索 | Letta passages | archival/ 是全文件读取，没有 embedding 检索 | 3天 |
| 可视化 DAG | LangGraph Studio | 无法图形化查看和编辑流程 | 5天 |

### P2：走向生产

| 项 | 对标 | 说明 |
|----|------|------|
| 服务化 | Letta REST API | 从 CLI 工具变成可部署的 Agent 服务 |
| 代码沙箱 | AutoGen Docker | Agent 执行代码的安全隔离 |
| 组织级部署 | CrewAI 企业版 | RBAC、团队管理、多项目 |

---

## 一句总结

> **v2 从"管理框架"进化为"一人公司操作系统" — 10 角色 + DAG + 三层记忆 + 质疑协议 + 一键安装，在独立开发者/一人公司垂直领域是行业唯一，在多 Agent 编排领域接近第一梯队。**
>
> **核心差距不再是"设计不够"，而是"引擎未就" — 设计文档写得好，但缺少自动化执行引擎。质疑协议需要代码强制、评估需要自动采集、记忆需要向量检索。**
>
> **下一步最值得投入的：把已有的优秀设计变成可自动运行的引擎。**

---

## 评估依据

- CrewAI: [docs.crewai.com](https://docs.crewai.com/) — Sequential/Hierarchical/Hybrid process, Memory+Knowledge, Guardrails, Triggers (Gmail/Slack/HubSpot)
- AutoGen: [microsoft.github.io/autogen](https://microsoft.github.io/autogen/) — Event-driven, Group Chat, Docker code executor, Studio UI, MCP workbench
- MetaGPT: [github.com/geekan/MetaGPT](https://github.com/geekan/MetaGPT) — SOP-driven, PM/Architect/Engineer roles, MGX (Feb 2025), AFlow (ICLR 2025 oral)
- LangGraph: [docs.langchain.com/langgraph](https://docs.langchain.com/langgraph/) — StateGraph DAG, persistence, human-in-the-loop, LangSmith tracing, LangGraph Studio
- Letta/MemGPT: [docs.letta.com](https://docs.letta.com/) — Memory-first, 4 tiers (blocks/shared/archival/context), composable memory, passage-based retrieval, REST API server
- Claude Code: [code.claude.com/docs](https://code.claude.com/docs/en/overview) — CLAUDE.md + Auto Memory, Skills, Hooks, Subagents with memory, Agent SDK, MCP, Routines
