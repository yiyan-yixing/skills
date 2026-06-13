#!/bin/bash
# 一人公司 Agent 体系一键安装脚本
# 用法: curl -fsSL https://raw.githubusercontent.com/yiyan-yixing/skills/main/install.sh | bash
# 或者: git clone https://github.com/yiyan-yixing/skills.git && cd skills && bash install.sh

set -e

REPO_URL="https://github.com/yiyan-yixing/skills.git"
CLONE_DIR=$(mktemp -d)
TARGET_DIR="${1:-.}"
SKIP_INIT="${SKIP_INIT:-}"
# --init flag: 安装后自动初始化
if echo "$@" | grep -q '\-\-init'; then
  SKIP_INIT=""
  shift 2>/dev/null || true
elif echo "$@" | grep -q '\-\-skip-init'; then
  SKIP_INIT="1"
  shift 2>/dev/null || true
fi

echo "🏢 一人公司 Agent 体系安装"
echo "============================"
echo ""

# Step 1: 克隆仓库
echo "📦 [1/4] 克隆仓库..."
if [ -d "skills/.git" ] || [ -f "skills/README.md" ]; then
  echo "   检测到本地已有 skills 仓库，使用本地文件"
  CLONE_DIR="$(pwd)/skills"
else
  git clone --depth 1 "$REPO_URL" "$CLONE_DIR" --quiet
  echo "   克隆完成"
fi

# Step 2: 安装 Skills（通过 npx skills）
echo "🎯 [2/4] 安装 Skills 到 .claude/skills/..."
cd "$TARGET_DIR"
npx skills add "$REPO_URL" --agent claude-code -y 2>&1 | tail -5
echo "   Skills 安装完成"

# Step 3: 安装 Agents
echo "👥 [3/4] 安装 Agents 到 .claude/agents/..."
mkdir -p .claude/agents
for agent_file in "$CLONE_DIR"/agents/*.md; do
  if [ -f "$agent_file" ]; then
    cp "$agent_file" .claude/agents/
    echo "   ✅ $(basename "$agent_file")"
  fi
done

# Step 4: 安装记忆系统 + 白板 + 评估 + CLAUDE.md
echo "🧠 [4/4] 安装记忆系统 + 白板 + 评估体系..."

# 记忆系统
mkdir -p .claude/memory/core .claude/memory/archival/decisions .claude/memory/archival/lessons .claude/memory/archival/user-research .claude/memory/recall/sessions
if [ -d "$CLONE_DIR/.claude/memory" ]; then
  cp -r "$CLONE_DIR"/.claude/memory/core/* .claude/memory/core/ 2>/dev/null || true
  cp -r "$CLONE_DIR"/.claude/memory/archival/* .claude/memory/archival/ 2>/dev/null || true
  echo "   ✅ 记忆系统 (core + archival + recall)"
else
  # 使用仓库根目录的 .claude/memory
  if [ -d "$CLONE_DIR/skills/.claude/memory" ]; then
    cp -r "$CLONE_DIR"/skills/.claude/memory/core/* .claude/memory/core/ 2>/dev/null || true
    cp -r "$CLONE_DIR"/skills/.claude/memory/archival/* .claude/memory/archival/ 2>/dev/null || true
    echo "   ✅ 记忆系统 (core + archival + recall)"
  else
    echo "   ⚠️  源仓库中未找到 memory 目录，跳过"
  fi
fi

# 共享白板
mkdir -p .claude/blackboard
if [ -d "$CLONE_DIR/.claude/blackboard" ]; then
  cp -r "$CLONE_DIR"/.claude/blackboard/* .claude/blackboard/ 2>/dev/null || true
  echo "   ✅ 共享白板 (4 个文件)"
elif [ -d "$CLONE_DIR/skills/.claude/blackboard" ]; then
  cp -r "$CLONE_DIR"/skills/.claude/blackboard/* .claude/blackboard/ 2>/dev/null || true
  echo "   ✅ 共享白板 (4 个文件)"
fi

# 评估体系
mkdir -p .claude/evals/benchmarks .claude/evals/agent-outputs
if [ -d "$CLONE_DIR/.claude/evals" ]; then
  cp -r "$CLONE_DIR"/.claude/evals/* .claude/evals/ 2>/dev/null || true
  echo "   ✅ 评估体系"
elif [ -d "$CLONE_DIR/skills/.claude/evals" ]; then
  cp -r "$CLONE_DIR"/skills/.claude/evals/* .claude/evals/ 2>/dev/null || true
  echo "   ✅ 评估体系"
fi

# CLAUDE.md
if [ -f "$CLONE_DIR/.claude/CLAUDE.md" ]; then
  cp "$CLONE_DIR"/.claude/CLAUDE.md .claude/CLAUDE.md
  echo "   ✅ CLAUDE.md (记忆入口)"
elif [ -f "$CLONE_DIR/skills/.claude/CLAUDE.md" ]; then
  cp "$CLONE_DIR"/skills/.claude/CLAUDE.md .claude/CLAUDE.md
  echo "   ✅ CLAUDE.md (记忆入口)"
fi

# Step 5: 安装 init.sh
echo "🚀 [5/5] 安装初始化脚本..."
if [ -f "$CLONE_DIR/init.sh" ]; then
  cp "$CLONE_DIR/init.sh" .claude/init.sh
  chmod +x .claude/init.sh
  echo "   ✅ init.sh (交互式初始化)"
elif [ -f "$CLONE_DIR/skills/init.sh" ]; then
  cp "$CLONE_DIR/skills/init.sh" .claude/init.sh
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

# Step 6: 自动初始化（非 --skip-init 时）
if [ -z "$SKIP_INIT" ] && [ -f ".claude/init.sh" ]; then
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "⚡ 现在运行初始化，设置你的公司信息"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""
  bash .claude/init.sh
else
  echo "下一步："
  echo "  1. 运行 bash .claude/init.sh 初始化你的公司信息"
  echo "  2. 打开 Claude Code，输入 @ceo 开始使用"
  echo "  3. 编辑 .claude/memory/core/project-context.md 填入你的公司信息"
  echo "  4. 编辑 .claude/memory/core/tech-stack.md 填入你的技术栈"
fi
