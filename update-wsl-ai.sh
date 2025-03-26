#!/bin/bash
set -e

PROJECT_DIR="$HOME/wsl-ai-launcher"
REPO_URL="https://github.com/C55555C/wsl-ai-launcher.git"

echo "🔄 WSL AI 管理工具 - 一键更新"

# Step 1: 如果不存在，先 clone
if [ ! -d "$PROJECT_DIR/.git" ]; then
  echo "📁 项目目录不存在，正在克隆..."
  git clone "$REPO_URL" "$PROJECT_DIR"
fi

cd "$PROJECT_DIR"

# Step 2: 检查当前分支
CURRENT_BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null || echo "main")
echo "🔎 当前分支: $CURRENT_BRANCH"

# Step 3: 设置 upstream（如未设置）
UPSTREAM=$(git rev-parse --abbrev-ref --symbolic-full-name "@{u}" 2>/dev/null || true)
if [ -z "$UPSTREAM" ]; then
  echo "🔧 设置远程跟踪: origin/$CURRENT_BRANCH"
  git branch --set-upstream-to=origin/$CURRENT_BRANCH "$CURRENT_BRANCH"
fi

# Step 4: 如果存在本地改动，先 stash
if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "📥 检测到本地改动，自动保存到 stash..."
  git stash push -m "Auto stash before update"
fi

# Step 5: 拉取远程更新
echo "⬇️ 正在拉取远程代码..."
git pull

# Step 6: 恢复本地修改（如果存在 stash）
if git stash list | grep -q "Auto stash before update"; then
  echo "♻️ 正在恢复之前的修改..."
  git stash pop || echo "⚠️ 自动恢复时出现冲突，请手动处理"
fi

# Step 7: 启动主程序
echo ""
echo "🚀 启动 WSL AI 管理工具..."
chmod +x wsl-ai-launcher.sh
./wsl-ai-launcher.sh
