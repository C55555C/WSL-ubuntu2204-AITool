#!/bin/bash
set -e

echo "🔌 安装 Open WebUI..."
read -p "确认要安装 Open WebUI 服务版？(y/n): " confirm
if [[ "$confirm" != "y" ]]; then
  echo "❎ 已取消安装"
  exit 0
fi

echo "📆 拉取 Open WebUI Docker 最新镜像..."
docker pull ghcr.io/open-webui/open-webui:main

echo "🔧 启动 Open WebUI 完成，默认端口为 3000"
echo "请执行以下命令启动："
echo "docker run -d --name openwebui -p 3000:3000 -v openwebui-data:/app/backend/data ghcr.io/open-webui/open-webui:main"
echo "请通过浏览器访问 http://localhost:3000 或对应网络 IP"

read -p "按回车返回..."
