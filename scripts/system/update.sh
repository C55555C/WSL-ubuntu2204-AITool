#!/bin/bash
source ../common.sh
clear
info "SYSTEM - Update"
echo "执行 system 模块中 update 功能..."
read -p "按回车键返回菜单..." _
bash ../../wsl-ultimate-deploy.sh
