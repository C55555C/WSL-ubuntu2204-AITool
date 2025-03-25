#!/bin/bash
set -e

echo "🌐 安装 Open WebUI（Docker 模式）"
docker run -d --name open-webui   -p 3000:8080   -v openwebui-data:/app/backend/data   --restart unless-stopped   ghcr.io/open-webui/open-webui:main

echo "✅ Open WebUI 运行中：访问 http://localhost:3000"
