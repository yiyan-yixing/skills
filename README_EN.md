# skills

中文 | **[English](./README_EN.md)**

> Claude Code Skill Collection — One-Person Company 10 Agent Roles + 26 Curated Skills + 3-Layer Memory + Shared Blackboard + Challenge Protocol, standard `.claude/` format.

## 30-Second Quickstart

```bash
# 1. Create a new project
mkdir my-ai-product && cd my-ai-product

# 2. One-click install + auto-init (answer a few questions, make it yours)
curl -fsSL https://raw.githubusercontent.com/yiyan-yixing/skills/main/install.sh | bash

# 3. Start Claude Code — your company is ready
claude
@ceo Help me do quarterly planning
```

> 🎯 After installation, you'll have: 10 Agent roles, 26 skills, 3-layer memory system, shared blackboard, challenge protocol — a complete one-person company framework, ready to work.

### User Journey

```
┌──────────────────────────────────────────────────────────────────┐
│  mkdir my-project && cd my-project                               │
│                                                                  │
│  ┌───────────┐    ┌──────────────┐    ┌────────────────────────┐ │
│  │   Install  │──→│  Initialize  │──→│     Get to Work!      │ │
│  │ install.sh│    │  init.sh     │    │  @ceo quarterly plan  │ │
│  │           │    │              │    │  @pm define 1st need  │ │
│  │  Blank     │    │  Company name│    │  @designer 3-day Demo │ │
│  │  10 roles │    │  Direction   │    │  @dev build it        │ │
│  │  26 skills│    │  Users, stack│    │  @data collect data   │ │
│  │  Memory   │    │              │    │  @pm decide & iterate │ │
│  └───────────┘    └──────────────┘    └────────────────────────┘ │
│                                                                  │
│  install.sh structure    init.sh personalize    Claude Code work │
│  (3 minutes)            (2 minutes)            (instant)         │
└──────────────────────────────────────────────────────────────────┘
```

### Repo Directory Structure (Source)

```
skills/                         # Repo root
├── skills/                     #   Skills (standard SKILL.md format)
│   ├── ceo-weekly-review/      #     CEO weekly review
│   ├── pm-prd-writing/         #     Product PRD
│   ├── designer-rapid-prototype/ #   Rapid prototype
│   ├── devops-fast-pipeline/   #     Fast CI/CD pipeline
│   ├── architect-tech-radar/   #     Tech radar ✨
│   └── ...                     #     26 skills total
│
├── agents/                     #   Agent subagents (invoke via @role)
│   ├── ceo.md                  #     CEO
│   ├── pm.md                   #     Product Manager
│   ├── designer.md             #     Product Designer
│   ├── architect.md            #     Tech Architect ✨
│   ├── dev.md                  #     Developer
│   ├── qa.md                   #     QA
│   ├── devops.md               #     DevOps / Toolchain
│   ├── ops.md                  #     Operations
│   ├── data.md                 #     Data Analyst
│   ├── fin.md                  #     Finance
│   ├── WORKFLOW.md             #     Product loop DAG ✨
│   └── challenge-protocol.md   #     Challenge protocol ✨
│
├── memory/                     #   3-layer memory system ✨
│   ├── core/                   #     Always-loaded (per session)
│   │   ├── tech-stack.md       #       Tech stack
│   │   ├── architecture.md     #       Architecture decisions
│   │   └── project-context.md  #       Project context
│   ├── archival/               #     Long-term (on-demand)
│   │   ├── decisions/          #       Decision archive
│   │   ├── lessons/            #       Lessons learned
│   │   └── user-research/      #       User research
│   └── recall/                 #     Historical (auto-accumulated)
│
├── blackboard/                 #   Shared blackboard ✨
│   ├── current-sprint.md       #     Current sprint status
│   ├── open-questions.md       #     Open questions
│   ├── challenges.md           #     Challenge records
│   └── decisions-log.md        #     Decision log
│
├── evals/                      #   Evaluation system ✨
│   └── README.md               #     8-dimension eval framework
│
├── CLAUDE.md.template          #   Memory entry template ✨
├── install.sh                  #   One-click install script
└── init.sh                     #   Interactive init script
```

### Installed Project Structure

```
your-project/
└── .claude/                    # Auto-discovered by Claude Code
    ├── skills/                 #   26 Skills
    ├── agents/                 #   10 Agents + WORKFLOW + Challenge Protocol
    ├── memory/                 #   3-layer memory
    │   ├── core/               #     (init.sh writes your company info)
    │   ├── archival/           #     Decision archive, lessons
    │   └── recall/             #     Session history
    ├── blackboard/             #   Shared blackboard
    ├── evals/                  #   Evaluation system
    ├── CLAUDE.md               #   Memory entry (@import core)
    └── init.sh                 #   Init script
```

---

## Installation

### One-Click Install (Recommended)

Install Skills + Agents + Memory + Blackboard + Eval + CLAUDE.md + **Auto-init**:

```bash
curl -fsSL https://raw.githubusercontent.com/yiyan-yixing/skills/main/install.sh | bash
```

Or clone and install locally:

```bash
git clone https://github.com/yiyan-yixing/skills.git
cd skills && bash install.sh /path/to/your/project
```

#### Install Parameters

| Parameter | Description |
|-----------|-------------|
| `--init` | Auto-run init after install (answer a few questions, make the framework yours) |
| `--skip-init` | Install only, skip init (run `bash .claude/init.sh` later) |
| No flag | **Default**: auto-init after install (same as `--init`) |

```bash
# Install only, init later
bash install.sh /path/to/project --skip-init

# Non-interactive init (for CI/automation)
COMPANY_NAME="MyCompany" DIRECTION="AI Agent" TARGET_USER="Operations teams" \
  HYPOTHESIS="Market needs AI automation" ADVANTAGE="AI Agent expertise" \
  PRODUCT_POSITIONING="AI ops automation SaaS" \
  bash .claude/init.sh
```

### Install Skills Only

> ⚠️ `npx skills add` only installs the skills/ directory — **not** agents, memory, blackboard, or evals.
> For the complete system, use the one-click install script above.

```bash
npx skills add https://github.com/yiyan-yixing/skills.git --agent claude-code -y
```

### Install a Single Skill

```bash
npx skills add https://github.com/yiyan-yixing/skills.git -s frontend-design --agent claude-code -y
```

Multiple skills:

```bash
npx skills add https://github.com/yiyan-yixing/skills.git -s frontend-design -s skill-creator --agent claude-code -y
```

### Parameter Reference

| Parameter | Description |
|-----------|-------------|
| `add <repo-url>` | Git repo URL for skill source |
| `-s <skill-name>` | Install specific skill; repeat for multiple; omit for all |
| `-a, --agent claude-code` | Target agent type, installs to `.claude/skills/` |
| `-y` | Skip confirmation prompts |
| `--copy` | Copy files instead of symlinks |
| `--all` | Same as `--skill '*' --agent '*' -y` |

### Update

```bash
npx skills update -y
```

### List Installed

```bash
npx skills list              # Project-level
npx skills list -g           # Global
npx skills list -a claude-code   # Filter by Agent
```

### Remove

```bash
npx skills remove <skill-name>
```

---

## Agent Roles (10)

Invoke via `@role_name`. Each role has full responsibilities, KPIs, decision authority, and available skills.

```
┌─────────────────────────────────────────────────────────┐
│                       CEO · 10%                         │
│    Strategy · Key Decisions · Oversight · Values         │
├──────────┬──────────┬──────────┬──────────┬─────────────┤
│ PM       │ Designer │ Dev      │ Ops      │ Data        │
│ · 15%    │ · 15%    │ · 25%    │ · 10%    │ · 10%      │
│ Needs    │ Rapid    │ Build    │ Growth   │ Metrics     │
│ Priority │ UI/UX    │ Quality  │ Reach    │ Analysis    │
├──────────┼──────────┤          │          │             │
│ DevOps   │ QA       │          │          │             │
│ · 10%    │ · 5%     │          │          │             │
│ Toolchain│ Quality  │          │          │             │
│ Deploy   │ Gatekeep │          │          │             │
├──────────┴──────────┤          │          │             │
│ Finance · 5%        │          │          │             │
│ Cashflow · Audit    │          │          │             │
└─────────────────────┴──────────┴──────────┴─────────────┘
```

| Role | Invoke | Mission | Time | Skills |
|------|--------|---------|------|--------|
| **CEO** | `@ceo` | Strategy, key decisions, oversight | 10% | Weekly review, decision framework, quarterly planning, vision check |
| **PM** | `@pm` | Build what users actually need | 15% | Feature prioritization, PRD, MVP scoping, feedback loop |
| **Designer** | `@designer` | Turn ideas into tangible interfaces fast | 15% | Rapid prototype, frontend design |
| **Architect** | `@architect` | Make correct tech choices, prevent architecture debt | 5% | Architecture decision records, tech radar |
| **Dev** | `@dev` | Ship high-quality, sustainable code | 20% | Self code review, bug triage, release checklist |
| **DevOps** | `@devops` | Extremely fast dev toolchain | 10% | Fast CI/CD pipeline |
| **QA** | `@qa` | Never let bugs reach production | 5% | Test case design, edge testing, regression |
| **Ops** | `@ops` | Get the product in front of the right people | 10% | Content calendar, social publishing, growth experiments |
| **Data** | `@data` | Data-driven decisions, always | 10% | Metrics setup, effect analysis |
| **Finance** | `@fin` | Guard the cashflow lifeline | 5% | Weekly bookkeeping, cashflow tracking, expense review |

Usage examples:

```
@ceo Help me do a weekly review
@pm Prioritize this week's features using ICE scoring
@designer Build a Demo in 3 days
@dev Implement user login
@qa Test login edge cases
@devops Set up CI/CD pipeline
@ops Plan next week's content calendar
@data Set up data collection
@fin What subscriptions can we cut this month?
```

### Product Loop

```
@pm define needs → @designer prototype → @dev build → @qa test
  → @devops deploy → @ops reach users → @data collect results → @pm iterate
                                                                        ↓
                           @ceo strategic alignment ← @data report ←──┘
```

See `agents/WORKFLOW.md` for details.

---

## Skills Overview (26)

### 🏢 One-Person Company Role Skills (21)

| Role | Skill | Trigger | Timebox |
|------|-------|---------|---------|
| **CEO** | `ceo-weekly-review` | Weekly | 45min |
| | `ceo-decision-framework` | Facing a decision | 20min |
| | `ceo-quarterly-planning` | Quarterly | 4h |
| | `ceo-vision-check` | Monthly | 30min |
| **PM** | `pm-feature-prioritization` | Weekly | 30min |
| | `pm-prd-writing` | Before development | 45min |
| | `pm-mvp-scoping` | Starting a new product | 60min |
| | `pm-user-feedback-loop` | When feedback arrives | 15min |
| **Designer** | `designer-rapid-prototype` | When building a Demo | 3 days |
| **Dev** | `dev-code-review-self` | Every commit | 10min |
| | `dev-debug-triage` | Bug found | 15min |
| | `dev-release-checklist` | Pre-release | 20min |
| **Architect** | `dev-architecture-decision` | Tech selection | 30min |
| | `architect-tech-radar` | Monthly | 15min |
| **DevOps** | `devops-fast-pipeline` | Setting up pipeline | 60min |
| **Ops** | `ops-content-calendar` | Weekly | 30min |
| | `ops-social-publish` | Daily | 15min |
| | `ops-growth-experiment` | Bi-weekly | 30min |
| **Data** | `data-metrics-setup` | Pre/At launch | 60min |
| | `data-effect-analysis` | 7 days post-launch | 30min |
| **Finance** | `fin-weekly-bookkeeping` | Weekly | 20min |
| | `fin-cashflow-tracking` | Monthly | 30min |
| | `fin-expense-review` | Monthly | 20min |

### 🎨 General Skills (2)

| Skill | Description |
|-------|-------------|
| `frontend-design` | Create high-quality, well-designed frontend interfaces |
| `skill-creator` | Create skills from scratch, iterate, benchmark |

### 🏃 Iteration Skill (1)

| Skill | Description |
|-------|-------------|
| `sprint-one-week` | One-week sprint: Mon plan → Wed check → Fri retro |

---

## Rapid Demo Process (3 Days)

> AI Agent track rule: No Demo, no conversation.

```
Day 1: @pm define scenario + @architect confirm feasibility + @designer key flows → PRD + prototype + architecture
Day 2: @dev rapid implementation + @designer UI review → Working Demo
Day 3: @devops one-click deploy + @ops push to 10 people + @data start collecting → Feedback + data
```

---

## Usage

### Skills (skills/)

Skills are **auto-triggered** by Claude Code — when your conversation matches a skill's `description` or `when_to_use`, Claude loads and executes it automatically. You can also explicitly trigger by mentioning the skill name:

```
Help me do a weekly review
Create a new skill with skill-creator
Build a Demo quickly
```

### Agent Subagents (agents/)

Invoke a role's subagent via `@role_name` — it will execute tasks from that role's perspective, authority, and KPIs:

```
@ceo Help me do a weekly review
@pm Prioritize this week's features
@designer Build a Demo in 3 days
@dev Implement user login
@qa Test login edge cases
@architect Do a tech selection review
@devops Set up CI/CD pipeline
@ops Plan next week's content calendar
@data Set up data collection
@fin What subscriptions can we cut?
```

---

## Design Principles

- **Standard Format**: All skills and roles use Claude Code native format, ready to use
- **Role Separation**: Dev and QA use different roles, preventing confirmation bias
- **Loop-Driven**: Design→Build→Deploy→Users→Data→Decisions, every step has an owner
- **Extreme Speed**: 3-day Demo, 10-minute deploy, one-week iteration
- **Timebox-Driven**: Every skill has a time limit, preventing perfectionism
- **Measurable**: KPIs and success criteria are concrete numbers, not "feels okay"
- **Anti-Self-Deception**: Each role lists common mistakes and anti-patterns; challenge protocol lets Agents challenge each other
- **Sharpen Tools First**: DevOps role is dedicated to making the dev toolchain extremely fast

---

## 3-Layer Memory System

| Layer | Path | Loading | Content |
|-------|------|---------|---------|
| **Core (Always)** | `.claude/memory/core/` | CLAUDE.md @import, auto-loaded per session | Tech stack, architecture decisions, project context |
| **Archival (Long-term)** | `.claude/memory/archival/` | Agent reads on-demand | Decision archive, lessons learned, user research |
| **Recall (Historical)** | `.claude/memory/recall/` | Auto Memory / session summaries | Historical conversations, auto-learning |

## Shared Blackboard

| File | Purpose | Maintainer |
|------|---------|------------|
| `.claude/blackboard/current-sprint.md` | Current sprint goals, tasks, progress | @pm |
| `.claude/blackboard/open-questions.md` | Open questions | Any Agent |
| `.claude/blackboard/challenges.md` | Challenge records | Coordinator |
| `.claude/blackboard/decisions-log.md` | Decision log index | @ceo / @architect |

## Challenge Protocol

PM writes PRD → Dev challenges tech feasibility + Data challenges metric measurability
Dev proposes tech solution → Architect challenges architectural soundness
CEO makes major decision → Data challenges data support

See `agents/challenge-protocol.md` for details.

## License

CC BY-SA 4.0 — Feel free to adapt, please attribute
