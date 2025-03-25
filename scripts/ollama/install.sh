#!/bin/bash
source ../common.sh
clear
info "安装 Ollama"
curl -fsSL https://ollama.com/install.sh | sh
ok "Ollama 安装完成"
read -p "按回车键返回菜单..." _
bash ../../wsl-ultimate-deploy.sh
