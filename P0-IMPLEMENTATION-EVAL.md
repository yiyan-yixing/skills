# P0 实现方案评估：Agent 协作机制 + 项目记忆系统

> 评估时间：2026-06-13 | 评估目标：在现有 .claude/ 架构上实现协作和记忆
> 调研对象：Claude Code Subagents、CrewAI、AutoGen、MetaGPT、Letta/MemGPT、LangGraph

---

## 一、行业方案调研

### 1. Claude Code 原生能力（我们当前的平台）

**已具备：**
- Subagent 系统：`.claude/agents/` 定义 Agent，支持自定义 system prompt、工具限制、模型选择
- Agent tool：主对话可派生子 Agent，子 Agent 在独立 context 中执行并返回结果
- Agent Teams：多个会话并行，可互相通信
- Auto Memory：`~/.claude/projects/<project>/memory/` 自动记忆，跨 session 持久化
- CLAUDE.md：项目级指令持久化，所有 session 启动时加载
- Workflow：`Workflow` tool 支持多 Agent 编排（pipeline/parallel/phase）
- `memory` frontmatter：子 Agent 可配置 `memory: user/project/local` 实现跨 session 记忆

**缺失：**
- Agent 之间**无法主动发起对话**（只能单向派发→返回）
- 没有**辩论/质疑**机制
- 没有**共享工作记忆**（多 Agent 同时读写的白板）
- 记忆系统是**被动的**（只有写入和读取，没有自动归纳/遗忘/优先级）

**结论：Claude Code 的能力比我们当前用到的深得多。我们目前只用了浅层（.md 文件定义角色），没有利用 Subagent 系统、Auto Memory、Agent Teams、Workflow 等原生能力。**

### 2. CrewAI

**核心能力：**
- Sequential / Hierarchical / Hybrid 流程
- Agent 之间委托任务（delegate）
- 内置 Memory（短期+长期+实体记忆）
- Guardrails（护栏机制）
- Flows 编排（start/listen/router 模式）

**对我们的启示：**
- 委托（delegation）是关键——Agent A 可以把任务交给 Agent B，B 完成后返回
- Guardrails 可以约束 Agent 行为边界
- Flows 的 listen/router 模式比我们的串行流水线灵活得多

**局限：**
- 是 Python SDK，需要写代码编排，不是 .md 声明式
- 不直接集成 Claude Code 生态

### 3. AutoGen（微软）

**核心能力：**
- 多 Agent 对话（GroupChat）
- Agent 可以主动选择下一个说话的 Agent
- 支持人类在环（Human-in-the-loop）
- 代码执行 Agent

**对我们的启示：**
- GroupChat 模式——多个 Agent 围绕同一问题轮流发言，这才是真正的"协作"
- 动态路由——Agent 自己决定下一步找谁，不是预定义流水线

**局限：**
- 同样是 Python SDK
- 对话式协作容易跑偏（需要好的 facilitator）

### 4. MetaGPT

**核心能力：**
- 直接模拟软件公司：PM → Architect → PM → Engineer
- SOP（标准操作流程）驱动
- 一句话输入 → 输出完整软件工程文档+代码

**对我们的启示：**
- 架构师角色单独分出来——验证了我们的"缺少架构师"判断
- SOP 驱动的思路和我们的 Skills + 流程类似，但 MetaGPT 是代码级编排

**局限：**
- 过于刚性——SOP 预定义好就不好改
- 输出质量高度依赖 prompt 工程
- 不支持动态调整流程

### 5. Letta/MemGPT

**核心能力：**
- 三层记忆：Core Memory（上下文内）、Archival Memory（长期存储）、Recall Memory（历史对话检索）
- Memory Blocks：可独立管理、可跨 Agent 共享
- Context Hierarchy：记忆内容有优先级分层
- Memory-first 设计：记忆是基础能力不是附加能力

**对我们的启示：**
- 三层记忆架构是最成熟的设计
- 共享记忆（Shared Memory）是实现 Agent 协作的关键——多 Agent 读写同一块记忆
- 记忆需要**优先级和遗忘机制**——不能什么都记，也不能什么都不忘

**局限：**
- 独立系统，不直接和 Claude Code 集成
- 需要自己搭服务端

### 6. LangGraph

**核心能力：**
- 图结构编排 Agent 流程
- State 管理——多 Agent 共享状态
- 条件分支、循环、并行
- 可视化流程

**对我们的启示：**
- State 是多 Agent 协作的基础——共享状态 > 消息传递
- 条件分支——根据结果动态决定下一步
- 我们现在的 WORKFLOW.md 是线性图，应该是 DAG（有向无环图）

---

## 二、三种实现路径评估

### 路径 A：纯 Claude Code 原生能力（最轻量）

**思路：** 不引入任何外部框架，充分利用 Claude Code 已有的 Subagent、Auto Memory、Agent Teams、Workflow。

**具体做法：**

| 能力 | 实现方式 |
|------|----------|
| Agent 协作 | 把每个角色注册为 `.claude/agents/` 下的 Subagent，主对话作为"协调者"派发任务 |
| 质疑/辩论 | 在协调者的 prompt 中定义"挑战协议"——PM 提出需求后，主动派 Dev Agent 做技术评审，派 Data Agent 做指标评审 |
| 项目记忆 | 利用 Auto Memory（`~/.claude/projects/<project>/memory/`）+ CLAUDE.md 存储技术栈、架构决策 |
| 共享记忆 | 在项目 CLAUDE.md 中维护"项目上下文"段落，所有 Agent 共享 |
| 流程编排 | 用 Workflow tool 的 pipeline/parallel/phase 编排 |

**优点：**
- 零额外依赖，直接在 Claude Code 里跑
- 和现有 .claude/ 架构完全兼容
- 上手成本最低

**缺点：**
- 协作是"协调者中转"模式，不是 Agent 间直接对话
- Auto Memory 是被动的，没有自动归纳和优先级
- 共享记忆靠 CLAUDE.md，全量加载，不能按需加载
- 辩论机制靠 prompt 驱动，不稳定

**评估：** ⭐⭐⭐⭐ 推荐作为第一步。先把 Claude Code 原生能力用足，再考虑引入外部系统。

---

### 路径 B：Claude Code + 自建轻量协作层（中等）

**思路：** 在路径 A 基础上，自建一个轻量的协作协议和记忆系统，作为 `.claude/` 下的扩展。

**具体做法：**

| 能力 | 实现方式 |
|------|----------|
| Agent 间消息 | 在项目目录维护 `.claude/blackboard/` 共享白板，Agent 用 Write/Read 写读 |
| 质疑/辩论 | 定义 `challenge-protocol.md`，协调者按协议派挑战 Agent |
| 三层记忆 | 自建 `.claude/memory/` 目录结构：`core/`（常驻）+ `archival/`（长期）+ `recall/`（按需） |
| 记忆管理 | 在 CLAUDE.md 中加载 core 记忆，archival/recall 用 Agent 按需读取 |
| 流程编排 | 定义 `WORKFLOW.md` 为 DAG 结构（不只是线性），支持条件分支 |
| 效果评估 | 定义 eval 目录，每次迭代产出 benchmark.json |

**目录结构：**

```
.claude/
├── agents/              # 9 个角色 Agent 定义
│   ├── ceo.md
│   ├── pm.md
│   ├── designer.md
│   ├── dev.md
│   ├── architect.md     # 新增：架构师
│   ├── qa.md
│   ├── devops.md
│   ├── ops.md
│   ├── data.md
│   ├── fin.md
│   ├── WORKFLOW.md      # DAG 流程定义
│   └── challenge-protocol.md  # 质疑协议
│
├── memory/              # 三层记忆系统
│   ├── core/            # 常驻记忆（每个 session 加载）
│   │   ├── tech-stack.md       # 技术栈
│   │   ├── architecture.md     # 架构决策记录
│   │   └── project-context.md  # 项目上下文
│   ├── archival/        # 长期记忆（按需读取）
│   │   ├── decisions/          # 所有决策记录
│   │   ├── lessons/            # 经验教训
│   │   └── user-research/      # 用户调研
│   └── recall/          # 历史对话（按需检索）
│       └── sessions/           # 历史会话摘要
│
├── blackboard/          # 共享白板（Agent 间协作）
│   ├── current-sprint.md       # 当前迭代目标
│   ├── open-questions.md       # 待解决问题
│   ├── challenges.md           # 挑战/质疑记录
│   └── decisions-log.md        # 决策日志
│
├── skills/              # 25+ Skills
│
├── evals/               # 效果评估
│   ├── benchmarks/              # 性能基准
│   └── agent-outputs/            # Agent 输出存档
│
└── CLAUDE.md            # 主入口，@import core 记忆
```

**优点：**
- 完全在 .claude/ 生态内，不需要额外服务
- 实现了三层记忆 + 共享白板 + 质疑协议
- 可以渐进式实现——先做记忆，再做协作，最后做评估

**缺点：**
- 需要设计和维护协作协议
- 白板是文件系统级别的，不如内存级状态管理高效
- 记忆管理靠 prompt 驱动，不够自动化

**评估：** ⭐⭐⭐⭐⭐ 推荐作为主要路径。在 Claude Code 原生能力上做最小扩展，实现最大收益。

---

### 路径 C：引入外部框架（最重量）

**思路：** 引入 CrewAI / AutoGen / LangGraph 等成熟框架，用 Python 编排 Agent 协作。

**优点：**
- 成熟的协作和编排能力
- 有社区支持和持续更新
- 记忆管理更自动化

**缺点：**
- 和 Claude Code 生态割裂——两套系统
- 需要维护 Python 服务端
- 一人公司维护成本太高
- 调试复杂——出错要跨两个系统排查

**评估：** ⭐⭐ 不推荐一人公司使用。框架依赖 + 服务端维护 = 本末倒置。

---

## 三、推荐路径：B（Claude Code + 自建轻量协作层）

### 实施优先级

| 阶段 | 做什么 | 预期效果 | 耗时 |
|------|--------|----------|------|
| **Phase 1** | 三层记忆系统 | Agent 有项目记忆，不再每次从零开始 | 2h |
| **Phase 2** | 共享白板 | Agent 之间可以读写共享状态 | 1h |
| **Phase 3** | 质疑协议 | Agent 可以主动挑战其他 Agent 的产出 | 1h |
| **Phase 4** | 架构师 Agent | 独立的架构决策角色 | 30min |
| **Phase 5** | DAG 流程 | WORKFLOW 从线性升级为有条件分支的 DAG | 1h |
| **Phase 6** | 效果评估 | Agent 输出可量化评估 | 2h |

### Phase 1：三层记忆系统（最优先）

**为什么最先做：**
- 记忆是所有其他能力的基础——没有记忆，协作没意义（每次都不认识彼此）
- 实现最简单——目录结构 + CLAUDE.md import
- 收益立竿见影——Agent 立刻知道项目的技术栈和历史决策

**实现方式：**

```
core/ 记忆 → 通过 CLAUDE.md 的 @import 加载到每个 session
  @.claude/memory/core/tech-stack.md
  @.claude/memory/core/architecture.md
  @.claude/memory/core/project-context.md

archival/ 记忆 → Agent 需要时用 Read 工具读取
  @data 可以读取 user-research/ 了解历史用户调研
  @dev 可以读取 decisions/ 了解历史架构决策

recall/ 记忆 → 通过 Auto Memory 或会话摘要自动积累
```

**记忆管理规则：**
- core/ 不超过 200 行（CLAUDE.md 的加载限制）
- archival/ 每个文件不超过 300 行（按需读取）
- 每月清理一次 archival/，过时信息归档或删除
- 决策记录格式：`D<编号> | <日期> | <决策内容> | <理由> | <当前状态>`

### Phase 2：共享白板

**实现方式：**
- `.claude/blackboard/` 目录下维护多个 .md 文件
- 每个 Agent 可以 Write 写入、Read 读取
- 协调者 Agent（主对话）负责清理和更新

**白板文件：**
- `current-sprint.md`：当前迭代目标、任务分配、进度
- `open-questions.md`：待解决问题列表
- `challenges.md`：质疑记录（谁质疑了什么、结论是什么）
- `decisions-log.md`：决策日志（合并 archival/decisions/ 的最新条目）

### Phase 3：质疑协议

**实现方式：**
在 `challenge-protocol.md` 中定义：

```
触发条件：
  - PM 提出 PRD → Dev 做技术可行性评审、Data 做指标可量化评审
  - Dev 提出技术方案 → Architect 做架构评审
  - CEO 做重大决策 → Data 出数据支撑报告

质疑流程：
  1. 协调者派质疑 Agent 独立审查
  2. 质疑 Agent 写入 challenges.md
  3. 原作者回应或修改
  4. 协调者判断：通过/修改/打回

质疑格式：
  | 质疑者 | 对象 | 问题 | 严重度 | 回应 | 结论 |
```

### Phase 4：架构师 Agent

新增 `architect.md`：
- 核心使命：做正确的技术选型，防止架构债务
- 职责：架构设计、技术选型评审、接口规范、技术债监控
- 可用技能：dev-architecture-decision（从 Dev 迁移过来）
- 新增技能：`architect-tech-radar` — 技术雷达，跟踪技术生态变化

### Phase 5：DAG 流程

把 WORKFLOW.md 从线性升级为 DAG：

```
@pm 定义需求
  ├── @architect 做架构评审 ← 条件：涉及新模块/新依赖
  ├── @data 做指标评审 ← 条件：涉及用户可见功能
  └── @designer 出原型
        ├── @dev 实现
        │     └── @qa 测试
        │           ├── @devops 部署 ← 条件：QA 说 Go
        │           └── @dev 修复 ← 条件：QA 说 No-Go
        └── @ops 推送用户
              └── @data 收集效果
                    └── @pm 决策迭代
```

### Phase 6：效果评估

在 `.claude/evals/` 下：
- 每次 Agent 产出存档到 `agent-outputs/`
- 定义关键评估指标（PRD 质量、代码质量、测试覆盖率等）
- 迭代间对比，看 Agent 产出是否在改善

---

## 四、风险和缓解

| 风险 | 影响 | 缓解措施 |
|------|------|----------|
| CLAUDE.md 太长导致 Agent 遵循度下降 | core/ 记忆被忽略 | 严格控制在 200 行内，只放最关键信息 |
| 白板文件冲突（多 Agent 同时写入） | 数据覆盖 | 协调者统一管理写入，Agent 只写入自己的段落 |
| 质疑协议不稳定（靠 prompt 驱动） | 有时质疑有时不质疑 | 在协调者 prompt 中明确写死触发规则 |
| 记忆膨胀（什么都记） | core/ 超限 | 每月清理，archival/ 只记决策和教训，不记过程 |
| 过度工程化 | 一人公司精力浪费 | Phase 1-3 先做，Phase 4-6 按需启动 |

---

## 五、和行业领先水平的对标（实施后）

| 维度 | 当前 | 实施后 | 行业领先 | 差距 |
|------|------|--------|----------|------|
| Agent 协作 | 无 | 质疑协议+白板 | CrewAI 委托+辩论 | 🟡 缩小到中等 |
| Agent 记忆 | 无 | 三层记忆系统 | MemGPT 全自动 | 🟡 缩小到中等 |
| 角色完整性 | 9 角色 | 10 角色（+架构师） | MetaGPT 4 角色 | ✅ 超过 |
| 流程编排 | 线性 | DAG+条件分支 | LangGraph 可视化 | 🟡 缩小到中等 |
| 评估体系 | 无 | Agent 输出评估 | LangSmith 全面 eval | 🔴 仍差距大 |
| 工具链集成 | Claude Code 原生 | 深度利用原生能力 | 任意框架集成 | ✅ 差距小 |

**结论：实施路径 B 后，在 Claude Code 生态内可以达到行业上游偏上的水平。最大的持续差距在评估体系——这需要 LangSmith 级别的投入，一人公司短期内不现实。**
