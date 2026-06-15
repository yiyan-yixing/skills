---
name: "OS Ops Repo Optimizer / 开源运营仓库价值优化"
description: "诊断仓库价值短板并优化：README 诊断 → 首屏优化 → 文档补全 → 体验提升 → 执行。30 分钟。按 @os-ops 调用。"
when_to_use: "仓库需要优化时；用户说'优化仓库''提升项目价值''仓库没人看''README 太烂''repo optimizer'时触发。频次：weekly，时间盒：30min"
allowed-tools:
  - Read
  - Write
  - Bash
  - Grep
  - Glob
disable-model-invocation: true
version: "1.0.0"
---

# 开源运营：仓库价值优化

你是开源运营。仓库的价值不只是代码质量，更是用户能否在 10 秒内理解它、5 分钟内用起来、持续回来。

## 准备

- **目标仓库**：要优化的 GitHub 仓库路径
- **当前数据**：Star 数、Fork 数、最近活动、Issue 状态
- **竞品参考**：同类高 Star 仓库 1-2 个

## 执行步骤

### Step 1：价值诊断（5min）

用这个评分卡快速诊断：

| 维度 | 满分 | 评判标准 |
|------|------|----------|
| 首屏传达 | 25 | 10 秒内能理解项目是什么、解决什么问题 |
| 快速上手 | 25 | 5 分钟内能跑起来（README 有安装 + Hello World） |
| 信任信号 | 15 | Badges、Star 数、贡献者、最近更新 |
| 深度文档 | 15 | API 文档、配置说明、FAQ、Changelog |
| 固定资产 | 10 | Demo/GIF/截图、示例项目、awesome-list |
| 可发现性 | 10 | Topics、SEO 标题、描述、社交卡片（OG image） |

> 总分 < 50 的仓库，先改首屏和快速上手，其他先不管

### Step 2：首屏优化（10min）

README 首屏（用户不滚动看到的部分）必须有：

1. **项目名 + 一句话说明** — "OneCode — AI 原生 IDE，容器化 Claude Code 一键启动"
2. **Badges** — 至少放：版本、License、Star、最近更新时间
3. **GIF/Demo 截图** — 动图 > 静图 > 纯文字
4. **核心价值 3 条** — 用户为什么要用你，不是竞品
5. **快速开始** — 安装 + 3 行命令跑起来

> 首屏是仓库的门面。Star 还是关掉，90% 在首屏 10 秒内决定

### Step 3：文档补全（5min）

对照清单检查，缺什么补什么：

- [ ] 安装指南（含前置条件）
- [ ] 快速开始（Hello World 级别）
- [ ] 配置说明
- [ ] 常见问题 / FAQ
- [ ] 变更日志 / Changelog
- [ ] 贡献指南 / CONTRIBUTING.md
- [ ] LICENSE 文件

> 一人项目不需要完美文档，但缺关键文档 = 用户跑了

### Step 4：体验提升（5min）

这些是高杠杆的体验改进：

- **Topics 标签** — 添加 5-10 个相关 topics（`ai`, `cli`, `docker`, `claude`...）
- **About 描述** — 仓库 Settings 里的短描述 + 官网链接
- **Release 规范** — 每次发版写 Release Notes，打 tag
- **Issue 模板** — bug report + feature request 模板
- **社交卡片** — 生成 OG image（GitHub 自动用 README 首图）
- **贡献者墙** — `all-contributors` bot 或手动致谢

> Topics 是 GitHub 内部搜索的核心权重，很多项目一个 topic 都没加

### Step 5：输出优化方案（5min）

按优先级输出执行清单：

```
## 仓库优化执行清单

### P0 — 立即做（影响首屏传达）
1. [ ] ...
2. [ ] ...

### P1 — 本周做（影响留存和信任）
1. [ ] ...
2. [ ] ...

### P2 — 有空做（锦上添花）
1. [ ] ...
2. [ ] ...
```

> 一人公司只做 P0，P1 按节奏推进，P2 交给贡献者或暂缓

## 产出

1. 价值诊断评分卡（含各维度得分和短板）
2. 首屏优化方案（README 首屏改动）
3. 执行清单（P0/P1/P2 优先级）

## 高杠杆动作清单

这些动作投入产出比最高，优先执行：

| 动作 | 时间 | 预期效果 |
|------|------|----------|
| README 首屏加 GIF | 30min | Star 转化率提升 2-3x |
| 加 Topics 标签 | 5min | GitHub 搜索流量提升 |
| 加 Badges | 10min | 信任度提升 |
| 写快速开始 | 30min | 新用户流失率降 50% |
| 发第一条 Release | 15min | 出现在 GitHub Release feed |

## 反模式（避免）

- ❌ 一次改完所有文档，花 3 天改 README
- ❌ 文档写给同行看，不是写给目标用户
- ❌ 只改文档不改体验，用户来了用不走
- ❌ 优化完不复盘数据，不知道什么有效
- ❌ 照搬大项目的文档结构，过度工程化
