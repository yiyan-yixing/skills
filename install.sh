#!/bin/bash
# 一人公司 Agent 体系一键安装脚本
# 用法: curl -fsSL https://raw.githubusercontent.com/yiyan-yixing/skills/main/install.sh | bash
# 或者: git clone https://github.com/yiyan-yixing/skills.git && cd skills && bash install.sh /path/to/project
# 或者: bash install.sh /path/to/project --skip-init

set -e

REPO_URL="https://github.com/yiyan-yixing/skills.git"
CLONE_DIR=$(mktemp -d)
TARGET_DIR="."
SKIP_INIT=""

# ─── 解析参数 ───
while [[ $# -gt 0 ]]; do
  case "$1" in
    --skip-init) SKIP_INIT="1"; shift ;;
    --init) SKIP_INIT=""; shift ;;
    -*) echo "未知参数: $1"; shift ;;
    *) TARGET_DIR="$1"; shift ;;
  esac
done

echo "🏢 一人公司 Agent 体系安装"
echo "============================"
echo ""

# ─── Step 1: 克隆仓库 ───
echo "📦 [1/5] 克隆仓库..."
if [ -d "skills/.git" ] || [ -f "skills/README.md" ]; then
  echo "   检测到本地已有 skills 仓库，使用本地文件"
  CLONE_DIR="$(pwd)/skills"
else
  git clone --depth 1 "$REPO_URL" "$CLONE_DIR" --quiet
  echo "   克隆完成"
fi

# ─── Step 2: 安装 Skills（通过 npx skills） ───
echo "🎯 [2/5] 安装 Skills 到 .claude/skills/..."
cd "$TARGET_DIR"
npx skills add "$REPO_URL" --agent claude-code -y 2>&1 | tail -5
echo "   Skills 安装完成"

# ─── Step 3: 安装 Agents ───
echo "👥 [3/5] 安装 Agents 到 .claude/agents/..."
mkdir -p .claude/agents
for agent_file in "$CLONE_DIR"/agents/*.md; do
  if [ -f "$agent_file" ]; then
    cp "$agent_file" .claude/agents/
    echo "   ✅ $(basename "$agent_file")"
  fi
done

# ─── Step 4: 安装记忆系统 + 白板 + 评估 + CLAUDE.md ───
echo "🧠 [4/5] 安装记忆系统 + 白板 + 评估体系..."

# 记忆系统（源: memory/ → 目标: .claude/memory/）
mkdir -p .claude/memory/core .claude/memory/archival/decisions .claude/memory/archival/lessons .claude/memory/archival/user-research .claude/memory/recall/sessions
if [ -d "$CLONE_DIR/memory/core" ]; then
  cp "$CLONE_DIR"/memory/core/* .claude/memory/core/ 2>/dev/null || true
  cp "$CLONE_DIR"/memory/archival/decisions/* .claude/memory/archival/decisions/ 2>/dev/null || true
  cp "$CLONE_DIR"/memory/archival/lessons/* .claude/memory/archival/lessons/ 2>/dev/null || true
  cp "$CLONE_DIR"/memory/archival/user-research/* .claude/memory/archival/user-research/ 2>/dev/null || true
  echo "   ✅ 记忆系统 (core + archival + recall)"
else
  echo "   ⚠️  源仓库中未找到 memory/ 目录，跳过"
fi

# 共享白板（源: blackboard/ → 目标: .claude/blackboard/）
mkdir -p .claude/blackboard
if [ -d "$CLONE_DIR/blackboard" ]; then
  cp "$CLONE_DIR"/blackboard/* .claude/blackboard/ 2>/dev/null || true
  echo "   ✅ 共享白板 (4 个文件)"
else
  echo "   ⚠️  源仓库中未找到 blackboard/ 目录，跳过"
fi

# 评估体系（源: evals/ → 目标: .claude/evals/）
mkdir -p .claude/evals/benchmarks .claude/evals/agent-outputs
if [ -d "$CLONE_DIR/evals" ]; then
  cp "$CLONE_DIR"/evals/* .claude/evals/ 2>/dev/null || true
  echo "   ✅ 评估体系"
else
  echo "   ⚠️  源仓库中未找到 evals/ 目录，跳过"
fi

# CLAUDE.md（源: CLAUDE.md.template → 目标: .claude/CLAUDE.md）
if [ -f "$CLONE_DIR/CLAUDE.md.template" ]; then
  cp "$CLONE_DIR"/CLAUDE.md.template .claude/CLAUDE.md
  echo "   ✅ CLAUDE.md (记忆入口)"
fi

# ─── Step 5: 安装 init.sh ───
echo "🚀 [5/5] 安装初始化脚本..."
if [ -f "$CLONE_DIR/init.sh" ]; then
  cp "$CLONE_DIR"/init.sh .claude/init.sh
  chmod +x .claude/init.sh
  echo "   ✅ init.sh (交互式初始化)"
fi

# 清理临时目录
if [ "$CLONE_DIR" != "$(pwd)/skills" ]; then
  rm -rf "$CLONE_DIR"
fi

echo ""
echo "🎉 安装完成！"
echo ""
echo "已安装内容："
echo "  .claude/skills/        — 26 个 Skills"
echo "  .claude/agents/        — 10 个 Agent + WORKFLOW + 质疑协议"
echo "  .claude/memory/        — 三层记忆系统 (core + archival + recall)"
echo "  .claude/blackboard/    — 共享白板 (4 个文件)"
echo "  .claude/evals/         — 效果评估体系"
echo "  .claude/CLAUDE.md      — 记忆入口 (@import core)"
echo "  .claude/init.sh        — 交互式初始化脚本"
echo ""

# ─── Step 6: 自动初始化（非 --skip-init 时） ───
if [ -z "$SKIP_INIT" ] && [ -f ".claude/init.sh" ]; then
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "⚡ 现在运行初始化，设置你的公司信息"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""
  bash .claude/init.sh
else
  echo "下一步："
  echo "  1. 运行 bash .claude/init.sh 初始化你的公司信息"
  echo "  2. 启动 Claude Code，输入 @ceo 开始使用"
fi
