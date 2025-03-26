#!/bin/bash
set -e

DATA_DIR="$HOME/openwebui-data"

echo "🌐 开始部署 Open WebUI 接口面板"
read -p "确认要安装 Open WebUI 应用？(y/n): " confirm
if [[ "$confirm" != "y" ]]; then
  echo "❎ 已取消 Open WebUI 安装"
  exit 0
fi

if ! command -v curl >/dev/null 2>&1; then
  echo "📦 安装 curl..."
  sudo apt update && sudo apt install -y curl
fi

if ! command -v docker >/dev/null 2>&1; then
  echo "🚧 安装 Docker..."
  curl -fsSL https://get.docker.com | sh
  sudo usermod -aG docker $USER
  echo "✅ Docker 已安装，请重新登录后再运行本脚本"
  exit 0
fi

echo "📁 创建数据目录: $DATA_DIR"
mkdir -p "$DATA_DIR"

echo "🚮 清理旧容器..."
docker rm -f openwebui 2>/dev/null || true

echo "🔽 拉取 Open WebUI 最新 Docker 镜像..."
docker pull ghcr.io/open-webui/open-webui:main

echo "🚀 启动 Open WebUI 容器..."
docker run -d \
  --name openwebui \
  -p 3000:8080 \
  -v "$DATA_DIR:/app/backend/data" \
  --restart unless-stopped \
  ghcr.io/open-webui/open-webui:main

echo ""
echo "📄 Open WebUI 已部署！"
echo "🌐 访问地址: http://localhost:3000"
echo "📂 数据目录: $DATA_DIR"
echo "🪠 默认连接本地 Ollama (章约端口 11434)"
read -p "\n按回车继续..."
