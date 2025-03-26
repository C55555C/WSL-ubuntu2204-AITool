#!/bin/bash
set -e

echo "🚀 正在克隆 wsl-ai-launcher 项目..."
rm -rf ~/wsl-ai-launcher
git clone https://github.com/C55555C/wsl-ai-launcher.git
cd wsl-ai-launcher

echo "🔧 正在设置脚本权限..."
chmod +x wsl-ai-launcher.sh

echo "📦 启动 WSL AI Launcher..."
./wsl-ai-launcher.sh
