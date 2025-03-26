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

# 切换到 server 分支，适配 Docker 服务部署结构
if git show-ref --verify --quiet refs/remotes/origin/server; then
  git checkout server
else
  echo "❌ 当前仓库不包含 'server' 分支，请确认项目结构或更换部署方式。"
  exit 1
fi

# 确保 .env 存在
if [ ! -f ".env" ]; then
  if [ -f ".env.example" ]; then
    cp .env.example .env
    echo "📄 已复制 .env 配置文件"
  else
    echo "❌ 缺少 .env.example 文件，无法继续"
    exit 1
  fi
fi

# 启动服务
echo "🔧 正在启动 Docker Compose 服务..."
docker compose up -d

# 检查服务状态
sleep 3
if curl -s http://localhost:3001 >/dev/null; then
  echo "\n✅ 安装完成！你现在可以访问以下地址完成首次初始化配置："
  echo "🌐 http://localhost:3001"
  echo "📂 项目路径: $INSTALL_DIR"
else
  echo "⚠️ 服务未响应，请稍后重试或检查日志：docker logs \$(docker ps -qf \"name=anything\")"
fi

read -p "按回车继续..."
