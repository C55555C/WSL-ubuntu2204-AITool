#!/bin/bash
source ../common.sh
clear
info "安装 Open WebUI"
docker run -d --name open-webui \
  -p 3000:8080 \
  -v openwebui-data:/app/backend/data \
  --restart unless-stopped \
  ghcr.io/open-webui/open-webui:main
ok "Open WebUI 安装完成"
read -p "按回车键返回菜单..." _
bash ../../wsl-ultimate-deploy.sh
