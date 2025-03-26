#!/bin/bash

# 用于远程启动 WSL AI 管理工具： bash <(curl -sL https://yourdomain.com/wsl-ai-launcher.sh)
# 或 GitHub 原始链接：https://raw.githubusercontent.com/C55555C/wsl-ai-launcher/main/wsl-ai-launcher.sh

REPO_DIR="$HOME/wsl-ai-launcher"
REPO_URL="https://github.com/C55555C/wsl-ai-launcher.git"

# 克隆或更新项目
if [ ! -d "$REPO_DIR/.git" ]; then
  echo "📁 正在克隆 WSL AI Launcher 项目..."
  git clone "$REPO_URL" "$REPO_DIR"
else
  echo "🔄 更新本地仓库..."
  cd "$REPO_DIR"
  git pull
fi

# 执行主启动菜单
cd "$REPO_DIR"
chmod +x wsl-ai-launcher.sh
exec ./wsl-ai-launcher.sh
