#!/bin/bash
set -e

INSTALL_DIR="$HOME/anything-llm"
REPO_URL="https://github.com/Mintplex-Labs/anything-llm.git"

echo "🧠 安装 AnythingLLM (Docker 服务版) 到: $INSTALL_DIR"
read -p "⚠️ 是否继续安装？(y/n): " confirm
if [[ "$confirm" != "y" ]]; then
  echo "❎ 已取消安装"
  exit 0
fi

if ! command -v git >/dev/null 2>&1; then
  echo "📦 安装 git..."
  sudo apt update && sudo apt install -y git
fi

if [ -d "$INSTALL_DIR" ]; then
  echo "📁 目录已存在：$INSTALL_DIR，跳过 clone"
else
  git clone "$REPO_URL" "$INSTALL_DIR"
fi

cd "$INSTALL_DIR"

echo "🔧 正在启动 Docker Compose 服务..."
docker compose up -d

echo ""
echo "✅ 安装完成！你现在可以访问以下地址完成首次初始化配置："
echo "🌐 http://localhost:3001"
echo "📂 项目路径: $INSTALL_DIR"
read -p "按回车继续..."
