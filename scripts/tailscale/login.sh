#!/bin/bash
source ../common.sh
clear
info "Tailscale 登录模块"
sudo tailscaled &
sleep 2
sudo tailscale up
ok "已触发登录流程"
read -p "按回车键返回菜单..." _
bash ../../wsl-ultimate-deploy.sh
