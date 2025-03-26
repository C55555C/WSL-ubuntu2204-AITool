#!/bin/bash
set -e

INSTALL_DIR="/usr/local/bin"
SERVICE_FILE="/etc/systemd/system/ollama.service"

echo "🧃 正在部署 Ollama 本地大模型服务"
read -p "⚠️ 确认要安装 Ollama 吗？(y/n): " confirm
if [[ "$confirm" != "y" ]]; then
  echo "❎ 已取消 Ollama 安装"
  exit 0
fi

echo "💡 请选择安装方式："
echo " 1. 原生模式（默认，支持 systemd）"
echo " 2. Docker 模式（使用 ollama/ollama 镜像）"
read -p "请输入选项 [1/2]（默认 1）: " mode_choice

if [[ "$mode_choice" == "2" ]]; then
  USE_DOCKER="docker"
else
  USE_DOCKER="false"
fi

echo "📦 检查 curl..."
sudo apt update
sudo apt install -y curl

if [ "$USE_DOCKER" != "docker" ]; then
  echo "🔽 安装原生 Ollama CLI..."
  if ! command -v ollama >/dev/null 2>&1; then
    curl -fsSL https://ollama.com/install.sh | sh
  else
    echo "✅ Ollama 已安装"
  fi

  echo "⚙️ 配置 systemd 服务..."
  sudo tee "$SERVICE_FILE" > /dev/null <<EOF
[Unit]
Description=Ollama Service
After=network.target

[Service]
ExecStart=$INSTALL_DIR/ollama serve
Restart=always
User=$USER
WorkingDirectory=$HOME

[Install]
WantedBy=multi-user.target
EOF

  echo "🔁 启用 systemd 服务..."
  sudo systemctl daemon-reexec || true
  sudo systemctl daemon-reload
  sudo systemctl enable --now ollama

  echo "⏳ 等待 ollama 启动..."
  sleep 2
  curl -s http://localhost:11434/api/tags >/dev/null && echo "✅ Ollama 服务已启动" || echo "⚠️ 服务启动中..."

else
  echo "🚧 检查 Docker..."
  if ! command -v docker >/dev/null 2>&1; then
    echo "❌ 未检测到 Docker"
    exit 1
  fi

  echo "📦 拉取 Ollama Docker 镜像..."
  docker pull ollama/ollama

  echo "🚀 启动 Docker 容器..."
  docker run -d \
    --name ollama-docker \
    --restart unless-stopped \
    -p 11434:11434 \
    --gpus all \
    -v ollama-data:/root/.ollama \
    ollama/ollama

  echo "⏳ 等待 Docker 服务启动..."
  sleep 3
  curl -s http://localhost:11434/api/tags >/dev/null && echo "✅ Ollama Docker 服务已启动" || echo "⚠️ 服务启动中..."
fi

echo ""
echo "📂 环境完成！"
echo "🔹 可用命令：ollama pull llama3"
echo "🌐 连接地址：http://localhost:11434"
echo "🪠 远程 API 可接入 AnythingLLM 使用"
read -p "\n按回车继续..."
