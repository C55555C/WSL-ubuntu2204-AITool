#!/bin/bash
set -e

echo "📚 安装 AnythingLLM (Docker 服务版)..."
read -p "确认要安装 AnythingLLM 服务版？(y/n): " confirm
if [[ "$confirm" != "y" ]]; then
  echo "❎ 已取消安装"
  exit 0
fi

APP_DIR="$HOME/anything-llm"
echo "📂 安装目录: $APP_DIR"

git clone https://github.com/Mintplex-Labs/anything-llm.git "$APP_DIR"
cd "$APP_DIR"

if [ -f ".env.example" ]; then
  echo "📁 创建 .env 配置文件..."
  cp .env.example .env
else
  echo "⚠️ 未找到 .env.example, 可能版本更新或后续手动创建"
fi

echo "⚡️ 运行 Docker 安装脚本..."
bash install.sh || echo "⚠️ install.sh 执行失败，请确保安装 Docker"

read -p "按回车返回..."
