# skills

> Claude Code 技能集合 — 一人公司 6 角色代理 + 20 个精选技能，标准 `.claude/` 格式。

## 目录结构

```
skills/
├── skills/                    # 技能（标准 SKILL.md 格式）
│   ├── ceo-weekly-review/     #   CEO 周回顾
│   ├── pm-prd-writing/        #   产品 PRD
│   ├── dev-code-review-self/  #   代码自审
│   ├── frontend-design/       #   前端设计
│   └── ...                    #   共 20 个技能
│
└── agents/                    # 角色子代理（通过 @角色名 调用）
    ├── ceo.md                 #   CEO / 首席执行官
    ├── pm.md                  #   产品经理
    ├── dev.md                 #   开发者
    ├── qa.md                  #   测试
    ├── ops.md                 #   运营
    └── fin.md                 #   财务
```

---

## 安装

### 安装全部

```bash
npx skills install https://github.com/yiyan-yixing/skills.git --agent claude-code
```

会将 `skills/` 和 `agents/` 全部安装到当前目录的 `.claude/` 下。

### 安装单个技能

```bash
npx skills install https://github.com/yiyan-yixing/skills.git -s frontend-design --agent claude-code
```

也支持同时安装多个技能：

```bash
npx skills install https://github.com/yiyan-yixing/skills.git -s frontend-design -s skill-creator --agent claude-code
```

### 参数说明

| 参数 | 说明 |
|------|------|
| `install <repo-url>` | 后接 Git 仓库地址，指定技能来源 |
| `-s <skill-name>` | 安装指定技能，可多次使用；不带则安装全部 |
| `--agent claude-code` | 指定目标 Agent 类型，决定安装到哪个目录 |

### 安装完成后

```
your-project/
└── .claude/
    ├── skills/                 ← 技能（Claude Code 自动发现）
    │   ├── ceo-weekly-review/
    │   │   └── SKILL.md
    │   ├── frontend-design/
    │   │   └── SKILL.md
    │   └── ...
    │
    └── agents/                 ← 角色子代理（通过 @角色名 调用）
        ├── ceo.md
        ├── pm.md
        ├── dev.md
        ├── qa.md
        ├── ops.md
        └── fin.md
```

> Claude Code 自动发现 `.claude/skills/` 和 `.claude/agents/`，无需额外配置。

---

## 角色子代理（6 个）

通过 `@角色名` 调用，每个角色拥有完整的职责、KPI、决策权限和可用技能。

```
┌───────────────────────────────────────────────────────┐
│                      CEO · 15%                        │
│   战略方向 · 重大决策 · 全局监控 · 价值观守门          │
├───────────┬───────────┬───────────┬───────────────────┤
│ 产品经理   │ 开发者     │ 运营       │ 财务              │
│ · 20%     │ · 35%     │ · 15%     │ · 10%             │
│ 需求定义   │ 技术实现   │ 内容增长   │ 现金流            │
│ 优先级排序 │ 架构质量   │ 用户连接   │ 合规记账          │
├───────────┼───────────┤           │                   │
│           │ 测试 · 5% │           │                   │
│           │ 质量把关   │           │                   │
│           │ 缺陷拦截   │           │                   │
└───────────┴───────────┴───────────┴───────────────────┘
```

| 角色 | 调用 | 核心使命 | 时间占比 | 可用技能 |
|------|------|----------|----------|----------|
| **CEO** | `@ceo` | 战略方向、重大决策、全局监控 | 15% | 周回顾、决策框架、季度规划、愿景校准 |
| **产品经理** | `@pm` | 做用户真正需要的产品 | 20% | 需求排序、PRD、MVP 范围、反馈闭环 |
| **开发者** | `@dev` | 高质量可持续地交付代码 | 35% | 代码自审、架构决策、Bug 诊断、发布检查 |
| **测试** | `@qa` | 不让 bug 流入生产环境 | 5% | 用例设计、边界测试、回归验证 |
| **运营** | `@ops` | 让产品被需要的人看到 | 15% | 内容日历、社交发布、增长实验 |
| **财务** | `@fin` | 守住现金流生命线 | 10% | 周记账、现金流追踪、支出审查 |

使用示例：

```
@ceo 帮我做本周回顾
@pm 用 ICE 评分排一下这周的需求
@dev 实现用户登录功能
@qa 测试一下登录功能的各种边界情况
@ops 规划下周的内容日历
@fin 本月支出有什么可以砍的
```

### 角色协作关系

```
@pm 定义需求 → @dev 编码实现 → @qa 测试验证 → @ceo 发布决策
                    ↑               │
                    └─── bug 打回 ──┘
```

---

## 技能一览（20 个）

### 🏢 一人公司角色技能（18 个）

| 角色 | 技能 | 触发时机 | 时间盒 |
|------|------|----------|--------|
| **CEO** | `ceo-weekly-review` | 每周 | 45min |
| | `ceo-decision-framework` | 面临选择时 | 20min |
| | `ceo-quarterly-planning` | 每季度 | 4h |
| | `ceo-vision-check` | 每月 | 30min |
| **产品经理** | `pm-feature-prioritization` | 每周 | 30min |
| | `pm-prd-writing` | 开发前 | 45min |
| | `pm-mvp-scoping` | 启动新产品时 | 60min |
| | `pm-user-feedback-loop` | 收到反馈时 | 15min |
| **开发者** | `dev-code-review-self` | 每次 commit | 10min |
| | `dev-architecture-decision` | 技术选型时 | 30min |
| | `dev-debug-triage` | 发现 bug 时 | 15min |
| | `dev-release-checklist` | 准备发布时 | 20min |
| **运营** | `ops-content-calendar` | 每周 | 30min |
| | `ops-social-publish` | 每天 | 15min |
| | `ops-growth-experiment` | 每两周 | 30min |
| **财务** | `fin-weekly-bookkeeping` | 每周 | 20min |
| | `fin-cashflow-tracking` | 每月 | 30min |
| | `fin-expense-review` | 每月 | 20min |

### 🎨 通用技能（2 个）

| 技能 | 说明 |
|------|------|
| `frontend-design` | 创建高质量、有设计感的前端界面 |
| `skill-creator` | 从零创建技能、迭代优化、性能评测 |

---

## 使用方法

### 技能（skills/）

技能通过 Claude Code **自动触发** — 当你的对话匹配到技能的 `description` 或 `when_to_use` 时，Claude 会自动加载并执行。也可以在对话中直接提及技能名称显式触发：

```
帮我做一下周回顾
用 skill-creator 创建一个新技能
```

### 角色子代理（agents/）

通过 `@角色名` 调用对应角色的子代理，它会以该角色的视角、权限和 KPI 执行任务：

```
@ceo 帮我做本周回顾
@pm 排一下这周的需求优先级
@dev 实现用户登录功能
@qa 测试登录的各种边界情况
@ops 规划下周内容日历
@fin 看看本月能不能砍掉一些订阅
```

---

## 设计原则

- **标准格式**：所有技能和角色统一使用 Claude Code 原生格式，开箱即用
- **角色分离**：开发和测试用不同角色，避免确认偏差
- **时间盒驱动**：一人公司技能每个都有时间限制，防止完美主义
- **可量化**：KPI 和成功标准都是具体数字，不是"感觉还行"
- **防自欺**：每个角色列出常见错误和反模式
- **精简至上**：只保留常用技能，20 个足够覆盖日常场景

## License

CC BY-SA 4.0 — 欢迎借鉴，请注明出处
