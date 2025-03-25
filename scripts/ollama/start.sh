#!/bin/bash
source ../common.sh
clear
info "启动 Ollama 服务"
ollama serve &
ok "服务已启动（后台）"
read -p "按回车键返回菜单..." _
bash ../../wsl-ultimate-deploy.sh
