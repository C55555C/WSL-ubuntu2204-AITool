#!/bin/bash
set -e

IMAGE_NAME="mintplexlabs/anythingllm"
CONTAINER_NAME="anything-llm"
HOST_PORT=3001

echo "🧠 使用 Docker 安装 AnythingLLM: $IMAGE_NAME"
read -p "⚠️ 是否继续安装？(y/n): " confirm
if [[ "$confirm" != "y" ]]; then
  echo "❎ 已取消安装"
  exit 0
fi

# 检查 Docker 是否安装
if ! command -v docker >/dev/null 2>&1; then
  echo "📦 未检测到 Docker，正在安装..."
  curl -fsSL https://get.docker.com | sh
  sudo usermod -aG docker "$USER"
  echo "✅ Docker 已安装，请重新登录终端以应用权限。"
  exit 0
fi

echo "📦 拉取最新的 AnythingLLM 镜像..."
docker pull "$IMAGE_NAME"

# 创建默认挂载目录
DATA_DIR="$HOME/anything-llm-data"
mkdir -p "$DATA_DIR"

# 启动容器（使用挂载卷保存数据）
echo "🚀 启动 Docker 容器: $CONTAINER_NAME"
docker run -d \
  --name "$CONTAINER_NAME" \
  -p "$HOST_PORT":3001 \
  -v "$DATA_DIR":/app/server/storage \
  "$IMAGE_NAME"

# 等待容器启动
sleep 3
if curl -s "http://localhost:$HOST_PORT" >/dev/null; then
  echo -e "\n✅ 安装完成！你现在可以访问以下地址完成首次初始化配置："
  echo "🌐 http://localhost:$HOST_PORT"
  echo "📦 数据路径: $DATA_DIR"
else
  echo "⚠️ 服务未响应，请稍后重试或检查日志：docker logs $CONTAINER_NAME"
fi

read -p "按回车继续..."
