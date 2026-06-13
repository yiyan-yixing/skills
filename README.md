# skills

> Claude Code 技能集合 — 一人公司 10 角色代理 + 26 个精选技能 + 三层记忆 + 协作白板 + 质疑协议，标准 `.claude/` 格式。

## 30 秒上手

```bash
# 1. 创建新项目
mkdir my-ai-product && cd my-ai-product

# 2. 一键安装 + 自动初始化（回答几个问题，框架就是你的了）
curl -fsSL https://raw.githubusercontent.com/yiyan-yixing/skills/main/install.sh | bash

# 3. 启动 Claude Code，你的公司已就绪
claude
@ceo 帮我做一个季度规划
```

> 🎯 安装完成后，你将拥有：10 个 Agent 角色、26 个技能、三层记忆系统、共享白板、质疑协议 — 一家完整的一人公司框架，随时开工。

### 用户旅程

```
┌──────────────────────────────────────────────────────────────────┐
│  mkdir my-project && cd my-project                               │
│                                                                  │
│  ┌───────────┐    ┌──────────────┐    ┌────────────────────────┐ │
│  │  安装框架  │──→│  初始化公司   │──→│     开工！             │ │
│  │ install.sh│    │  init.sh     │    │  @ceo 做季度规划       │ │
│  │           │    │              │    │  @pm 定义第一个需求    │ │
│  │ 拿到空壳  │    │  填入公司名   │    │  @designer 3天出Demo  │ │
│  │ 10角色    │    │  方向、用户   │    │  @dev 开发            │ │
│  │ 26技能    │    │  假设、技术栈 │    │  @data 收集效果数据   │ │
│  │ 记忆系统  │    │              │    │  @pm 决策迭代          │ │
│  └───────────┘    └──────────────┘    └────────────────────────┘ │
│                                                                  │
│  install.sh 安装结构    init.sh 个性化       Claude Code 开工    │
│  (3 分钟)              (2 分钟)             (立刻)              │
└──────────────────────────────────────────────────────────────────┘
```

### 安装后的目录结构

```
skills/
├── skills/                    # 技能（标准 SKILL.md 格式）
│   ├── ceo-weekly-review/     #   CEO 周回顾
│   ├── pm-prd-writing/        #   产品 PRD
│   ├── designer-rapid-prototype/ # 设计师快速原型
│   ├── devops-fast-pipeline/  #   极速交付流水线
│   ├── architect-tech-radar/  #   架构师技术雷达 ✨
│   └── ...                    #   共 26 个技能
│
├── agents/                    # 角色子代理（通过 @角色名 调用）
│   ├── ceo.md                 #   CEO / 首席执行官
│   ├── pm.md                  #   产品经理
│   ├── designer.md            #   产品设计师
│   ├── architect.md           #   技术架构师 ✨
│   ├── dev.md                 #   开发者
│   ├── qa.md                  #   测试
│   ├── devops.md              #   开发工具链 / DevOps
│   ├── ops.md                 #   运营
│   ├── data.md                #   数据分析师
│   ├── fin.md                 #   财务
│   ├── WORKFLOW.md            #   产品闭环 DAG 流程 ✨
│   └── challenge-protocol.md  #   质疑协议 ✨
│
└── .claude/                   # Claude Code 运行时结构
    ├── CLAUDE.md              #   主入口，@import core 记忆 ✨
    ├── memory/                #   三层记忆系统 ✨
    │   ├── core/              #     常驻记忆（每 session 加载）
    │   ├── archival/          #     长期记忆（按需读取）
    │   └── recall/            #     历史会话（按需检索）
    ├── blackboard/            #   Agent 共享白板 ✨
    │   ├── current-sprint.md  #     当前迭代状态
    │   ├── open-questions.md  #     待解决问题
    │   ├── challenges.md      #     质疑记录
    │   └── decisions-log.md   #     决策日志
    └── evals/                 #   效果评估体系 ✨
```

---

## 安装

### 一键安装（推荐）

安装 Skills + Agents + 记忆系统 + 白板 + 评估体系 + CLAUDE.md + **自动初始化**：

```bash
curl -fsSL https://raw.githubusercontent.com/yiyan-yixing/skills/main/install.sh | bash
```

或克隆后本地安装：

```bash
git clone https://github.com/yiyan-yixing/skills.git
cd skills && bash install.sh /path/to/your/project
```

#### 安装参数

| 参数 | 说明 |
|------|------|
| `--init` | 安装后自动运行初始化（回答几个问题，一键把框架变成你的公司） |
| `--skip-init` | 只安装框架，跳过初始化（稍后手动运行 `bash .claude/init.sh`） |
| 无参数 | **默认行为**：安装后自动初始化（同 `--init`） |

```bash
# 只装框架，稍后手动初始化
bash install.sh /path/to/project --skip-init

# 非交互模式初始化（适合 CI/自动化）
COMPANY_NAME="我的公司" DIRECTION="AI Agent" TARGET_USER="运营人员" \
  HYPOTHESIS="市场需要AI自动化运营" ADVANTAGE="AI Agent技术" \
  PRODUCT_POSITIONING="AI运营自动化SaaS" \
  bash .claude/init.sh
```

### 仅安装 Skills

> ⚠️ `npx skills add` 只安装 skills/ 目录，**不会安装** agents/、记忆系统、白板、评估体系。
> 如果需要完整体系，请使用上面的一键安装脚本。

```bash
npx skills add https://github.com/yiyan-yixing/skills.git --agent claude-code -y
```

### 仅安装单个技能

```bash
npx skills add https://github.com/yiyan-yixing/skills.git -s frontend-design --agent claude-code -y
```

也支持同时安装多个技能：

```bash
npx skills add https://github.com/yiyan-yixing/skills.git -s frontend-design -s skill-creator --agent claude-code -y
```

### 参数说明

| 参数 | 说明 |
|------|------|
| `add <repo-url>` | 后接 Git 仓库地址，指定技能来源 |
| `-s <skill-name>` | 安装指定技能，可多次使用；不带则安装全部 |
| `-a, --agent claude-code` | 指定目标 Agent 类型，安装到 `.claude/skills/` 目录 |
| `-y` | 跳过确认提示，非交互式安装 |
| `--copy` | 复制文件而非创建符号链接 |
| `--all` | 等同于 `--skill '*' --agent '*' -y`，安装全部到全部 Agent |

### 更新

```bash
npx skills update -y
```

### 查看已安装

```bash
npx skills list              # 项目级
npx skills list -g           # 全局
npx skills list -a claude-code   # 按 Agent 筛选
```

### 移除

```bash
npx skills remove <skill-name>
```

### 安装完成后

```
your-project/
└── .claude/
    ├── skills/                 ← 技能（Claude Code 自动发现）
    │   ├── ceo-weekly-review/
    │   ├── designer-rapid-prototype/
    │   ├── devops-fast-pipeline/
    │   ├── data-metrics-setup/
    │   └── ...
    │
    └── agents/                 ← 角色子代理（通过 @角色名 调用）
        ├── ceo.md
        ├── pm.md
        ├── designer.md
        ├── dev.md
        ├── qa.md
        ├── devops.md
        ├── ops.md
        ├── data.md
        ├── fin.md
        └── WORKFLOW.md         ← 产品闭环协作流程
    
    └── init.sh                 ← 交互式初始化脚本（设置公司信息）
```

> Claude Code 自动发现 `.claude/skills/` 和 `.claude/agents/`，无需额外配置。

---

## 角色子代理（10 个）

通过 `@角色名` 调用，每个角色拥有完整的职责、KPI、决策权限和可用技能。

```
┌─────────────────────────────────────────────────────────┐
│                       CEO · 10%                         │
│    战略方向 · 重大决策 · 全局监控 · 价值观守门           │
├──────────┬──────────┬──────────┬──────────┬─────────────┤
│ 产品经理  │ 设计师   │ 开发者   │ 运营     │ 数据分析师  │
│ · 15%    │ · 15%    │ · 25%   │ · 10%   │ · 10%       │
│ 需求定义 │ 快速原型 │ 技术实现 │ 内容增长 │ 数据驱动    │
│ 优先级   │ UI/UX   │ 架构质量 │ 用户连接 │ 效果分析    │
├──────────┼──────────┤          │          │             │
│ DevOps   │ 测试     │          │          │             │
│ · 10%    │ · 5%    │          │          │             │
│ 工具链   │ 质量把关 │          │          │             │
│ 极速部署 │ 缺陷拦截 │          │          │             │
├──────────┴──────────┤          │          │             │
│ 财务 · 5%           │          │          │             │
│ 现金流 · 支出审查   │          │          │             │
└─────────────────────┴──────────┴──────────┴─────────────┘
```

| 角色 | 调用 | 核心使命 | 时间占比 | 可用技能 |
|------|------|----------|----------|----------|
| **CEO** | `@ceo` | 战略方向、重大决策、全局监控 | 10% | 周回顾、决策框架、季度规划、愿景校准 |
| **产品经理** | `@pm` | 做用户真正需要的产品 | 15% | 需求排序、PRD、MVP 范围、反馈闭环 |
| **设计师** | `@designer` | 用最短时间把想法变成可感知的界面 | 15% | 快速原型、前端设计 |
| **架构师** | `@architect` | 做正确的技术选型，防止架构债务 | 5% | 架构决策记录、技术雷达 |
| **开发者** | `@dev` | 高质量可持续地交付代码 | 20% | 代码自审、Bug 诊断、发布检查 |
| **DevOps** | `@devops` | 极致快速的开发工具链 | 10% | 极速交付流水线 |
| **测试** | `@qa` | 不让 bug 流入生产环境 | 5% | 用例设计、边界测试、回归验证 |
| **运营** | `@ops` | 让产品被需要的人看到 | 10% | 内容日历、社交发布、增长实验 |
| **数据** | `@data` | 用数据驱动每一个决策 | 10% | 指标搭建、效果分析 |
| **财务** | `@fin` | 守住现金流生命线 | 5% | 周记账、现金流追踪、支出审查 |

使用示例：

```
@ceo 帮我做本周回顾
@pm 用 ICE 评分排一下这周的需求
@designer 3天出一个Demo
@dev 实现用户登录功能
@qa 测试一下登录功能的各种边界情况
@devops 搭建CI/CD流水线
@ops 规划下周的内容日历
@data 搭建数据采集体系
@fin 本月支出有什么可以砍的
```

### 产品闭环流程

```
@pm 定义需求 → @designer 出原型 → @dev 开发 → @qa 测试
  → @devops 部署 → @ops 推送用户 → @data 收集效果 → @pm 决策迭代
                                                                ↓
                           @ceo 战略校准 ← @data 效果报告 ←─────┘
```

详见 `agents/WORKFLOW.md`。

---

## 技能一览（26 个）

### 🏢 一人公司角色技能（21 个）

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
| **设计师** | `designer-rapid-prototype` | 出 Demo 时 | 3天 |
| **开发者** | `dev-code-review-self` | 每次 commit | 10min |
| | `dev-debug-triage` | 发现 bug 时 | 15min |
| | `dev-release-checklist` | 准备发布时 | 20min |
| **架构师** | `dev-architecture-decision` | 技术选型时 | 30min |
| | `architect-tech-radar` | 每月 | 15min |
| **DevOps** | `devops-fast-pipeline` | 搭建流水线时 | 60min |
| **运营** | `ops-content-calendar` | 每周 | 30min |
| | `ops-social-publish` | 每天 | 15min |
| | `ops-growth-experiment` | 每两周 | 30min |
| **数据** | `data-metrics-setup` | 上线前/上线时 | 60min |
| | `data-effect-analysis` | 上线后 7 天 | 30min |
| **财务** | `fin-weekly-bookkeeping` | 每周 | 20min |
| | `fin-cashflow-tracking` | 每月 | 30min |
| | `fin-expense-review` | 每月 | 20min |

### 🎨 通用技能（2 个）

| 技能 | 说明 |
|------|------|
| `frontend-design` | 创建高质量、有设计感的前端界面 |
| `skill-creator` | 从零创建技能、迭代优化、性能评测 |

### 🏃 迭代技能（1 个）

| 技能 | 说明 |
|------|------|
| `sprint-one-week` | 一周一迭代流程：周一规划 → 周三检查 → 周五复盘 |

---

## 快速出 Demo 流程（3 天）

> AI Agent 赛道铁律：没有 Demo 就没有对话。

```
Day 1: @pm 定场景 + @architect 确认可行性 + @designer 画关键流程 → PRD + 交互原型 + 架构方案
Day 2: @dev 快速实现 + @designer UI 走查 → 可运行 Demo
Day 3: @devops 一键部署 + @ops 推给 10 人看 + @data 开始采集 → 反馈+数据
```

---

## 使用方法

### 技能（skills/）

技能通过 Claude Code **自动触发** — 当你的对话匹配到技能的 `description` 或 `when_to_use` 时，Claude 会自动加载并执行。也可以在对话中直接提及技能名称显式触发：

```
帮我做一下周回顾
用 skill-creator 创建一个新技能
快速出一个Demo
```

### 角色子代理（agents/）

通过 `@角色名` 调用对应角色的子代理，它会以该角色的视角、权限和 KPI 执行任务：

```
@ceo 帮我做本周回顾
@pm 排一下这周的需求优先级
@designer 3天出一个Demo
@dev 实现用户登录功能
@qa 测试登录的各种边界情况
@architect 做技术选型评审
@devops 搭建CI/CD流水线
@ops 规划下周内容日历
@data 搭建数据采集体系
@fin 看看本月能不能砍掉一些订阅
```

---

## 设计原则

- **标准格式**：所有技能和角色统一使用 Claude Code 原生格式，开箱即用
- **角色分离**：开发和测试用不同角色，避免确认偏差
- **闭环驱动**：设计→开发→部署→用户→数据→决策，每个环节都有角色负责
- **极速交付**：3 天出 Demo、10 分钟部署上线、一周一个迭代
- **时间盒驱动**：一人公司技能每个都有时间限制，防止完美主义
- **可量化**：KPI 和成功标准都是具体数字，不是"感觉还行"
- **防自欺**：每个角色列出常见错误和反模式；质疑协议让 Agent 互相挑战
- **工欲善其事**：DevOps 角色专门负责"先利其器"，让开发工具链极致快速

---

## 三层记忆系统

| 层级 | 路径 | 加载方式 | 内容 |
|------|------|----------|------|
| **Core（常驻）** | `.claude/memory/core/` | CLAUDE.md @import，每 session 自动加载 | 技术栈、架构决策、项目上下文 |
| **Archival（长期）** | `.claude/memory/archival/` | Agent 需要时用 Read 读取 | 决策归档、经验教训、用户调研 |
| **Recall（历史）** | `.claude/memory/recall/` | Auto Memory / 会话摘要 | 历史对话、自动学习 |

## 共享白板

| 文件 | 用途 | 维护者 |
|------|------|--------|
| `.claude/blackboard/current-sprint.md` | 当前迭代目标、任务分配、进度 | @pm |
| `.claude/blackboard/open-questions.md` | 待解决问题 | 任何 Agent |
| `.claude/blackboard/challenges.md` | 质疑记录 | 协调者 |
| `.claude/blackboard/decisions-log.md` | 决策日志索引 | @ceo / @architect |

## 质疑协议

PM 出 PRD → Dev 质疑技术可行性 + Data 质疑指标可量化
Dev 出技术方案 → Architect 质疑架构合理性
CEO 做重大决策 → Data 质疑数据支撑

详见 `agents/challenge-protocol.md`。

## License

CC BY-SA 4.0 — 欢迎借鉴，请注明出处
