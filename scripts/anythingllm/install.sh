#!/bin/bash
source ../common.sh
clear
info "克隆并安装 AnythingLLM"
git clone https://github.com/Mintplex-Labs/anything-llm.git
cd anything-llm && cp .env.example .env
ok "完成克隆和配置 .env"
read -p "按回车键返回菜单..." _
bash ../../wsl-ultimate-deploy.sh
