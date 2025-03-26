#!/bin/bash
set -e

PROJECT_DIR="$HOME/wsl-ai-launcher"
REPO_URL="https://github.com/C55555C/wsl-ai-launcher.git"

echo "🔄 WSL AI 管理工具 - 一键更新"

if [ ! -d "$PROJECT_DIR/.git" ]; then
  echo "📁 项目目录不存在，正在克隆..."
  git clone "$REPO_URL" "$PROJECT_DIR"
else
  echo "📁 项目目录存在，尝试拉取最新代码..."
  cd "$PROJECT_DIR"

  CURRENT_BRANCH=$(git symbolic-ref --short HEAD)
  REMOTE_BRANCHES=$(git branch -r)

  if echo "$REMOTE_BRANCHES" | grep -q "origin/$CURRENT_BRANCH"; then
    git branch --set-upstream-to=origin/$CURRENT_BRANCH $CURRENT_BRANCH
    git pull
  else
    echo "⚠️ 本地分支 [$CURRENT_BRANCH] 没有对应远程分支，切换回主分支 main"
    git checkout main
    git pull origin main
  fi
fi

echo ""
echo "🚀 启动 WSL AI 管理工具..."
cd "$PROJECT_DIR"
chmod +x wsl-ai-launcher.sh
./wsl-ai-launcher.sh
