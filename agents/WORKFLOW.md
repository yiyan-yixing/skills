# 一人公司 Agent 协作流程

> 10 个角色，1 条产品闭环 DAG，极致快速地从想法到数据验证。
> 支持：条件分支、质疑协议、共享记忆、DAG 编排、反馈闭环。
> **v2 更新：所有核心工作必须走 subagent，禁止 Agent 自己执行分析/审查/撰写。**
> **v3 更新：级联协议叠加反馈闭环协议——关键交接点自动走查，防止方向跑偏和需求漂移。**

---

## ⚠️ 全局 Subagent 强制规则

> **铁律：每个 Agent 的核心分析/审查/撰写工作，必须通过 Agent 工具派发子任务执行。Agent 自己只做决策和综合。**

### 通用执法条款

1. 🚫 **禁止自执行**：任何 Agent 不得自己执行需独立视角的工作（审查、诊断、分析、撰写）
2. ✅ **允许自做**：轻量读取、方向决策、综合判断、最终裁定
3. 🔍 **可追溯**：每个 Agent 产出必须能追溯到子任务结果

### Subagent Type 速查表

| subagent_type | 适用场景 | 说明 |
|---------------|---------|------|
| `general-purpose` | 分析、撰写、设计、规划 | 通用子任务，最常用 |
| `Explore` | 代码扫描、仓库诊断、进度盘点 | 只读搜索，适合系统性扫描 |
| `Plan` | 实现方案规划、部署方案设计 | 规划专用，产出步骤计划 |
| `Dev` | CI/CD 搭建、代码实现执行 | 开发专用，可写代码 |
| `QA` | 测试执行、回归验证 | 测试专用 |
| `Architect` | 架构评审、技术选型 | 架构专用 |

---

## 产品闭环 DAG（含 Subagent 映射）

```
@ceo 定方向 → @pm 定义需求
                ├── [subagent: general-purpose] 需求优先级排序 (ICE)
                ├── [subagent: general-purpose] PRD 撰写
                │
                └── ⚡ CEO 走查 PRD ←→ PM 修改（≤2轮）     ← 反馈闭环①
                      │
                      ├── @architect 架构评审 ← 条件：涉及新模块/新依赖/新技术选型
                      │     └── [subagent: general-purpose] 架构方案评审
                      ├── @data 指标评审 ← 条件：涉及用户可见功能
                      │     └── [subagent: general-purpose] 指标体系设计
                      │
                      └── @designer 出原型
                            ├── [subagent: general-purpose] 快速原型设计
                            ├── @dev 实现
                            │     ├── [subagent: Plan] 实现方案规划
                            │     ├── [subagent: general-purpose] 代码审查
                            │     │
                            │     └── ⚡ PM 走查实现 ←→ Dev 修改（≤2轮）  ← 反馈闭环②
                            │           │
                            │           └── @qa 测试
                            │                 ├── [subagent: general-purpose] 测试用例设计
                            │                 ├── [subagent: general-purpose] 回归验证
                            │                 ├── @devops 部署 ← 条件：QA 说 Go
                            │                 │     └── [subagent: Dev] CI/CD 流水线搭建
                            │                 ├── @dev 修复 ← 条件：QA 说 No-Go（≤2轮） ← 反馈闭环③
                            │                 │     └── [subagent: general-purpose] 问题诊断 (P0-P3)
                            │                 │           └── @qa 回归测试 ← 条件：修复了 P0/P1 bug
                            │                 └── @pm 需求澄清 ← 条件：验收标准不明确
                            │
                            └── @ops 推送用户
                                  ├── [subagent: general-purpose] 内容日历规划
                                  ├── [subagent: general-purpose] 增长实验设计
                                  └── @data 收集效果（7天）
                                        └── [subagent: general-purpose] 效果分析报告
                                              └── @pm 决策迭代
                                                    ├── 继续 → 下一迭代
                                                    ├── 调整 → 改进后下一迭代
                                                    └── 砍掉 → @ceo 切方向 → 回到 @pm 重新定义
                                                          └── [subagent: general-purpose] 战略决策分析
```

### 质疑节点（按 challenge-protocol.md）

```
@pm 出 PRD ──→ @dev 质疑技术可行性 ──→ 通过/修改/打回
            ──→ @data 质疑指标可量化 ──→ 通过/修改/打回

@dev 出技术方案 ──→ @architect 质疑架构合理性 ──→ 通过/修改/打回
                  └── [subagent: general-purpose] 独立架构评审

@ceo 做重大决策 ──→ @data 质疑数据支撑 ──→ 通过/修改/打回
                  └── [subagent: general-purpose] 独立战略分析
```

---

## 角色职责速查

| 角色 | 调用 | 做什么 | 不做什么 | 强制 subagent 场景 |
|------|------|--------|----------|-------------------|
| **CEO** | `@ceo` | 定方向、做决策、监控全局 | 不陷入执行细节 | 战略分析、周回顾、季度规划 |
| **PM** | `@pm` | 定义需求、排优先级、写 PRD | 不自己当用户 | PRD撰写、ICE排序、反馈整理 |
| **Designer** | `@designer` | 快速原型、UI/UX、视觉冲击 | 不追求完美拖延交付 | 原型设计、UI走查、设计系统 |
| **Architect** | `@architect` | 技术选型、架构设计、ADR | 不过度设计 | 架构评审、技术债扫描、选型对比 |
| **Dev** | `@dev` | 写代码、修 bug、执行架构 | 不自己选型/自己测自己的代码 | 代码审查、问题诊断、ADR记录 |
| **QA** | `@qa` | 测试、找 bug、发布阻断 | 不证明代码没问题 | 用例设计、回归验证、发布回归 |
| **DevOps** | `@devops` | CI/CD、部署、监控、工具链 | 不自建不需要的基础设施 | CI/CD搭建、成本审计、监控配置 |
| **Ops** | `@ops` | 推广、内容、增长 | 不追热点偏离定位 | 日历规划、增长实验、内容创作 |
| **Data** | `@data` | 埋点、分析、效果报告 | 不堆数据不说结论 | 指标设计、效果分析、A/B分析 |
| **Fin** | `@fin` | 记账、现金流、支出审查 | 不混个人和公司支出 | 记账、现金流预测、支出审查 |
| **Legal** | `@legal` | 法律风险、合规、隐私政策 | 过度合规 | 风险评估、许可证扫描、隐私政策 |
| **PMO** | `@pmo` | Sprint规划、进度、阻塞预警 | 不决定做什么产品 | Sprint规划、进度盘点、半成品清理 |
| **OS Ops** | `@os-ops` | GitHub运营、Star增长 | 不刷数据 | 仓库诊断、增长策略、Release撰写 |

---

## 快速出 Demo 流程（3 天）

> AI Agent 赛道的铁律：没有 Demo 就没有对话。

```
Day 1:
  @pm 定场景 ─── [subagent: general-purpose] PRD撰写
  @architect 确认可行性 ─── [subagent: general-purpose] 架构评审
  @designer 画关键流程 ─── [subagent: general-purpose] 原型设计

  输入：市场假设 + 技术可行性
  输出：1 页 PRD + 交互原型 + 架构方案

Day 2:
  @dev 快速实现 ─── [subagent: Plan] 实现方案规划 → 自己写代码
  @designer UI 走查 ─── [subagent: general-purpose] UI走查
  @qa 快速冒烟测试 ─── [subagent: general-purpose] 测试用例设计+执行

  输入：PRD + 交互原型 + 架构方案
  输出：可运行 Demo + 冒烟测试通过

Day 3:
  @devops 一键部署 ─── [subagent: Dev] CI/CD搭建
  @ops 推给 10 人看 ─── [subagent: general-purpose] 内容日历+发布
  @data 开始采集 ─── [subagent: general-purpose] 指标体系设计

  输入：可运行 Demo
  输出：在线 Demo + 2min 视频 + 10 份反馈 + 数据采集启动
```

### 交接标准

| 交接 | 从 → 到 | 交接物 | 验收条件 |
|------|---------|--------|----------|
| PM → CEO | PRD → 走查 | PRD + CEO 原始方向 | CEO 确认 PRD 符合方向 |
| CEO → PM | 走查通过 → 继续级联 | 走查记录 | PM 继续级联下游 |
| CEO → PM | 走查打回 → 修改 PRD | 打回原因 + 修改要求 | PM 修改后重新走查（≤2轮） |
| PM → Architect | 需求 → 技术评审 | PRD + 用户故事 | Architect 确认可行 |
| PM → Designer | 需求 → 原型 | PRD + 验收标准 | Designer 确认能出原型 |
| Architect → Dev | 架构 → 实现 | ADR + 架构图 + 接口规范 | Dev 确认能实现 |
| Designer → Dev | 原型 → 代码 | 交互原型 + 设计标注 | Dev 确认与架构一致 |
| Dev → PM | 代码 → 走查 | 代码 + 变更文件 + 自审报告 | PM 确认实现符合 PRD |
| PM → Dev | 走查打回 → 修改代码 | 打回原因 + 修改要求 | Dev 修改后重新走查（≤2轮） |
| PM → QA | 走查通过 → 测试 | 代码 + 走查记录 | QA 执行质量把关 |
| QA → DevOps | 测试通过 → 部署 | Go 判定 + 测试报告 | QA 说 Go 才能部署 |
| QA → Dev | 测试不通过 → 修复 | No-Go + bug 报告 | P0/P1 必须修复（≤2轮） |
| QA → PM | 验收标准不明确 → 澄清 | 澄清请求 + 具体问题 | PM 更新验收标准后 QA 重测 |
| DevOps → Ops | 部署上线 → 推广 | 在线 URL + 健康检查 | 站点可访问 |
| Ops → Data | 用户来了 → 采集数据 | 推广渠道数据 | 埋点数据开始流入 |
| Data → PM | 数据 → 决策 | 效果分析报告 | 报告有"所以呢"结论 |
| Data → CEO | 数据 → 校准 | 关键指标红/黄/绿 | CEO 根据数据做战略判断 |

---

## 一周一迭代节奏

```
周一（20min）         周三（10min）         周五（20min）
┌──────────┐        ┌──────────┐        ┌──────────────┐
│ 规划本周  │──────→│ 中期检查  │──────→│ 复盘+下周预划 │
│ @pm 主导  │       │ @pm 主导  │       │ @data+@pm 主导│
│ [subagent]│       │          │       │ [subagent]   │
│ Sprint规划│       │ @dev 反馈 │       │ 效果分析报告  │
│ @architect│       │          │       │ @ceo 校准    │
│ 可行确认  │       │          │       │ [subagent]   │
│ [subagent]│       │          │       │ 战略决策分析  │
│ 架构评审  │       │          │       │              │
└──────────┘        └──────────┘        └──────────────┘
```

### 周一规划

- @pm 从 OKR 提取本周目标 → [subagent: general-purpose] Sprint 规划
- @architect 确认技术可行性 → [subagent: general-purpose] 架构评审
- @designer + @dev 确认工作量
- @devops 确认部署通道畅通
- @data 确认数据采集就绪 → [subagent: general-purpose] 指标设计
- 质疑：@dev 对 PRD 做技术可行性评审

### 周三检查

- @pm 检查进度
- @dev 反馈技术障碍
- 偏航 → 当天调整，不等到周五

### 周五复盘

- @data 出数据快报 → [subagent: general-purpose] 效果分析
- @pm 判断假设是否成立
- @architect 评估技术债 → [subagent: Explore] 技术债扫描
- @ceo 做战略校准 → [subagent: general-purpose] 战略分析
- 定下周方向
- 写入 `.claude/blackboard/current-sprint.md`

---

## 角色协作矩阵

| | PM | Architect | Designer | Dev | QA | DevOps | Ops | Data | CEO | Fin | Legal | PMO | OS Ops |
|--|----|-----------|----------|-----|----|----|-----|------|-----|-----|-------|-----|--------|
| **PM** | — | 给 PRD 评审 | 给 PRD | 给需求 | 给验收标准 | — | 给推广素材 | 给指标定义 | 汇报进度 | — | — | 给 Sprint | — |
| **Architect** | 给可行性结论 | — | — | 给架构+ADR | — | 给部署架构 | — | — | 给技术风险 | — | 给许可证 | — | — |
| **Designer** | 确认需求 | — | — | 给原型 | — | — | 给截图视频 | — | — | — | — | — | — |
| **Dev** | 确认可行 | 确认架构 | 确认设计 | — | 给代码 | 给部署包 | — | 给埋点 | — | — | — | 给进度 | 给版本 |
| **QA** | 给测试结果 | — | — | 给 bug 报告 | — | 给 Go 判定 | — | — | — | — | — | 给阻塞 | — |
| **DevOps** | — | 确认部署架构 | — | 部署服务 | — | — | 给在线 URL | 给采集通道 | — | 给成本数据 | — | — | — |
| **Ops** | 给用户反馈 | — | — | — | — | — | — | 给流量数据 | — | — | — | — | 协同分发 |
| **Data** | 给效果报告 | — | — | — | — | — | 给增长数据 | — | 给指标报告 | — | — | — | — |
| **CEO** | 给方向 | 给技术方向 | — | — | — | — | — | 给决策 | — | 给预算 | — | 给 OKR | — |
| **Fin** | — | — | — | — | — | 给支出审批 | — | — | 给现金流 | — | — | — | — |
| **Legal** | — | — | — | — | — | — | — | — | — | — | — | — | — |
| **PMO** | — | — | — | — | — | — | — | — | 升级阻塞 | — | — | — | — |
| **OS Ops** | — | — | 给素材需求 | — | — | — | 协同分发 | — | — | — | — | — | — |

---

## 记忆读写规则

| Agent | 可写 | 可读 |
|-------|------|------|
| @ceo | blackboard/decisions-log.md, blackboard/open-questions.md | 所有 |
| @pm | blackboard/current-sprint.md | 所有 |
| @architect | memory/core/architecture.md, memory/core/tech-stack.md, archival/decisions/ | 所有 |
| @dev | — | memory/core/, archival/decisions/ |
| @designer | — | memory/core/ |
| @qa | blackboard/challenges.md | memory/core/ |
| @devops | memory/core/tech-stack.md（部署工具部分） | memory/core/ |
| @ops | — | memory/core/ |
| @data | memory/archival/user-research/, blackboard/current-sprint.md（数据部分） | 所有 |
| @fin | — | memory/core/ |
| @legal | — | memory/core/ |
| @pmo | blackboard/current-sprint.md | 所有 |
| @os-ops | — | memory/core/ |

---

## 自动级联协议（Cascade Protocol）

> 每个 Agent 完成自己的工作后，自动判断是否需要派发下游 Agent，无需人工串联。
> 用户说"@ceo 做一个功能"→ CEO 自动推给 PM → PM 自动推给 Dev → ... → 全程自动直到任务完成。

### 核心规则

1. **完成即交接** — Agent 完成自己的核心工作后，必须检查是否有下游需要执行
2. **按 DAG 路由** — 下游 Agent 由本文件的路由表决定，不由 Agent 个人偏好决定
3. **条件门控** — DAG 中的条件分支（如"涉及新模块才走 @architect"）必须先判断再派发
4. **No-Go 回退** — QA No-Go 自动回退 @dev，最多 2 轮，第 3 轮上报用户
5. **终局报告** — 到达 DAG 末端（@devops 部署完成 / @data 效果分析完成）后，输出完整任务报告

### 级联触发判断

| 任务意图 | 级联？ | 说明 |
|---------|--------|------|
| 包含"上线""交付""全流程""并测试""并部署""走完流程""发货" | ✅ 级联 | 完整交付意图 |
| 单一动作（"写个 PRD""review 一下""看看架构"） | ❌ 不级联 | 只做当前角色 |
| 用户明确说"只做这一步" | ❌ 不级联 | 用户主动限制 |
| @ceo 交付型任务（"做一个XX功能""开发XX"） | ✅ 级联 | CEO 入口默认推全流程 |
| @ceo 管理型任务（"周回顾""季度规划""方向对不对"） | ❌ 不级联 | 非交付任务 |

### 级联路由表

> ⚠️ 带走查门控的路由：PM→CEO→继续级联，Dev→PM→QA。详见"反馈闭环协议"。

| 当前 Agent | 完成条件 | 下游 Agent | 交接物 | 条件 |
|-----------|---------|-----------|--------|------|
| @ceo | 战略方向已定 | @pm | 方向决策 + 优先级 | 交付型任务 |
| @ceo | PRD 走查通过 | @pm（继续级联） | 走查通过 + 要点 | PM 继续派发 architect/designer/dev |
| @ceo | PRD 走查打回 | @pm | 打回原因 + 修改要求 | PM 修改后重新走查（≤2轮） |
| @ceo | 管理工作完成 | 无 | — | 非交付型 |
| @pm | PRD 已写入 blackboard | @ceo | PRD 路径 | 级联交付型：CEO 走查 PRD |
| @pm | 实现走查通过 | @qa | 代码 + 走查记录 | PM 走查通过后级联 QA |
| @pm | 实现走查打回 | @dev | 打回原因 + 修改要求 | Dev 修改后重新走查（≤2轮） |
| @architect | 架构评审通过 | @dev | ADR + 架构图 + 接口规范 | 评审通过 |
| @architect | 架构评审否决 | @pm | 否决理由 + 替代建议 | 回退 PM 调整需求 |
| @designer | 原型完成 | @dev | 交互原型 + 设计标注 | 原型确认 |
| @dev | 代码完成 + 自审通过 | @pm | 代码 + 变更文件 + 自审报告 | PM 走查实现（不再直交 QA） |
| @qa | Go 判定 | @devops | Go 判定 + 测试报告 | QA 说 Go |
| @qa | No-Go（P0/P1 bug） | @dev | No-Go + bug 报告 | 回退修复（最多 2 轮） |
| @qa | No-Go + 验收标准不明确 | @pm | 澄清请求 + 具体问题 | PM 澄清后 QA 重测 |
| @qa | No-Go（第 3 轮） | 无，上报用户 | 完整 QA 历史 | BLOCKED |
| @devops | 部署成功 | @ops | 在线 URL + 健康检查 | 站点可访问 |
| @ops | 推广上线 | @data | 推广渠道 + 埋点要求 | 推广内容已发布 |
| @data | 效果分析完成 | @pm | 效果报告 | 有"所以呢"结论 → PM 决策迭代 |

### 交接物写入规则

每个 Agent 完成工作后，必须将交接物写入 `.claude/blackboard/` 的对应文件：

```markdown
# [本Agent] → [下游Agent] 交接
级联追踪：cascade-{timestamp}
任务来源：[上游Agent 或 用户]
任务摘要：[一句话]
本阶段产出：[摘要]
交接物路径：[blackboard 中的文件路径]
下游输入要求：[下游需要什么]
```

### 级联中的人工确认点

级联过程中 **只在以下节点停下来问用户**：
1. **@ceo 定方向后** → 确认方向（CEO 任务的第一个门控）
2. **CEO PRD 走查 2 轮打回** → PRD 方向分歧，需用户裁定
3. **PM 实现走查 2 轮打回** → 需求与实现严重分歧，需用户裁定
4. **@qa 第 3 轮 No-Go** → 提交用户决策
5. **@pm 收到 @data 效果报告后** → 继续迭代/调整/砍掉

其他所有交接 **自动执行，不停不问**。

### 终局报告

到达 DAG 末端时，输出完整任务报告：

```
🏁 级联流水线完成
级联追踪：cascade-{ID}
完整路径：@ceo → @pm → [CEO走查PRD] → @architect/@designer → @dev → [PM走查实现] → @qa → @devops
闭环记录：CEO走查[N轮] | PM走查[N轮] | QA回退[N轮]

📦 各阶段产出：
  @ceo: [方向决策]
  @pm: [PRD 摘要]
  @ceo: [PRD 走查：通过/打回N轮]
  @dev: [实现摘要]
  @pm: [实现走查：通过/打回N轮]
  @qa: [Go 判定]
  @devops: [部署结果 + URL]

📁 所有文件：.claude/blackboard/cascade-{ID}-*.md
📁 走查记录：.claude/blackboard/walkthrough-*.md
```

---

## 反馈闭环协议（Feedback Loop Protocol）

> 级联协议让工作自动向前流动，闭环协议确保关键交接不跑偏。
> 闭环是级联的"门控"——在闭环节点，必须走查通过才能继续级联。

### 核心规则

1. **关键门控必须闭环** — PRD 和代码实现是两个最高风险的交接点，必须有上游验证
2. **最多 2 轮回退** — 超过 2 轮说明问题在更深处，上报用户
3. **走查不是质疑** — 走查（walkthrough）是"实现是否符合需求"的快速确认，不是质疑协议的对抗性审查
4. **闭环结果写入 blackboard** — 每轮走查记录批准/打回，与级联追踪 ID 关联
5. **超限上报** — 2 轮走查未通过 → 写入 blackboard/challenges.md 并上报用户

### 三条闭环

| 闭环 | 触发 | 走查者 | 被走查者 | 走查内容 | 最大轮数 | 超限处理 |
|------|------|--------|----------|----------|----------|----------|
| ① PRD 评审 | PM 完成 PRD | @ceo | @pm | PRD 是否符合战略方向、优先级对不对 | 2 | 上报用户 |
| ② 实现走查 | Dev 完成代码 | @pm | @dev | 代码是否实现 PRD 验收标准 | 2 | 上报用户 |
| ③ 质量回退 | QA No-Go | @qa | @dev | P0/P1 bug 修复验证 | 2 | 上报用户（已有） |

### 闭环与级联的交互

```
CEO → PM [写PRD] → ⚡ CEO 走查 PRD ← 反馈闭环①
                         ├── 通过 → PM 继续级联到 Architect/Designer/Dev
                         └── 打回 → PM 修改 → CEO 再走查（≤2 轮）
                                       └── 2 轮打回 → 上报用户

Architect/Designer → Dev [完成代码] → ⚡ PM 走查实现 ← 反馈闭环②
                                          ├── 通过 → PM 级联到 QA
                                          └── 打回 → Dev 修改 → PM 再走查（≤2 轮）
                                                        └── 2 轮打回 → 上报用户

Dev → QA [测试] ← 反馈闭环③
       ├── Go → DevOps
       ├── No-Go → Dev 修复 → QA 重测（≤2 轮）
       │              └── 2 轮未修好 → 上报用户
       └── No-Go + 验收标准不明确 → PM 澄清 → QA 重测
```

### 走查记录格式

每轮走查写入 `.claude/blackboard/walkthrough-{timestamp}.md`：

```markdown
# 走查记录
闭环类型：PRD评审 / 实现走查 / 质量回退
走查者：@ceo / @pm / @qa
被走查者：@pm / @dev
轮次：1/2
级联追踪：cascade-{ID}

## 结果：通过 / 打回

## 走查要点
- [逐项检查的要点和判定]

## 打回原因（如打回）
- [具体原因]

## 修改要求（如打回）
- [具体修改要求，被走查者必须逐条响应]
```

### PRD 走查要点（CEO 执行）

| # | 检查项 | 判定标准 |
|---|--------|----------|
| 1 | 方向一致性 | PRD 目标与 CEO 定的战略方向是否一致 |
| 2 | 优先级正确 | 高优先级功能是否与公司当前阶段匹配 |
| 3 | 无 scope creep | 不做清单中的功能是否真的没做，有没有偷偷加需求 |
| 4 | 可执行性 | PRD 写法是否清晰可执行（不是小说） |

### 实现走查要点（PM 执行）

| # | 检查项 | 判定标准 |
|---|--------|----------|
| 1 | 验收覆盖 | PRD 中每条验收标准是否都有对应实现 |
| 2 | 核心路径 | 用户故事的核心路径是否跑通 |
| 3 | 无需求漂移 | 实现有没有悄悄改需求（偏离 PRD） |
| 4 | 不做清单 | 不做清单中的功能是否真的没做 |

---

## 紧急流程

### P0 Bug 修复

```
@qa 发现 P0 → [subagent: general-purpose] 诊断分级
  → @dev 立即修复
  → @qa 回归验证 [subagent: general-purpose]
  → @devops 热部署 [subagent: Dev]
全程 < 1 小时
```

### 方向大转

```
@data 报告假设不成立 [subagent: general-purpose] 效果分析
  → @pm 提出新假设 [subagent: general-purpose] PRD撰写
  → @architect 评估技术可行性 [subagent: general-purpose] 架构评审
  → @ceo 批准 [subagent: general-purpose] 战略决策分析
  → 下一周立刻切方向
不犹豫，不停滞
```

### 机会窗口

```
外部出现大机会 → @ceo 判断是否值得切 [subagent: general-purpose] 战略分析
  → @architect 评估技术可行性 [subagent: general-purpose] 架构评审
  → @pm 评估需求 [subagent: general-purpose] MVP范围界定
  → 如果 3 天能出 Demo → 立刻启动快速出 Demo 流程
```
