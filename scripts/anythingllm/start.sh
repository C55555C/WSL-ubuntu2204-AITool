#!/bin/bash
source ../common.sh
clear
info "启动 AnythingLLM（Docker 模式）"
cd anything-llm && docker compose up -d
ok "服务已启动"
read -p "按回车键返回菜单..." _
bash ../../wsl-ultimate-deploy.sh
