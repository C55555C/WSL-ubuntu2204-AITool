#!/bin/bash

set -e

REPO_URL="https://github.com/C55555C/wsl-ai-launcher.git"
REPO_DIR="$HOME/wsl-ai-launcher"

echo "🔄 WSL AI 管理工具 - 一键更新"

if [ ! -d "$REPO_DIR/.git" ]; then
  echo "📁 未检测到本地仓库，正在克隆..."
  git clone "$REPO_URL" "$REPO_DIR"
  echo "✅ 克隆完成！"
  exit 0
fi

cd "$REPO_DIR"
echo "📁 项目目录存在，尝试拉取最新代码..."

BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo "🔎 当前分支: $BRANCH"

# 检查是否有未提交的改动
if [ -n "$(git status --porcelain)" ]; then
  echo "📦 检测到本地改动，自动保存到 stash..."
  git stash push -m "auto-stash-before-update"
fi

# 拉取远程最新代码
git pull origin "$BRANCH"
echo "✅ 更新完成！"

# 检查是否有 stash 可以恢复
if git stash list | grep -q "auto-stash-before-update"; then
  echo "♻️ 检测到先前保存的更改，正在恢复..."
  git stash pop || true
fi

read -p "\n✅ 所有更新完成！按回车返回..."
