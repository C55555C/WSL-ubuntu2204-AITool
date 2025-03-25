#!/bin/bash
source ../common.sh
clear
info "WSL 保活机制设置"
echo 'pgrep tailscaled > /dev/null || (sudo tailscaled &)' >> ~/.bashrc
ok "已写入 .bashrc 保活逻辑"
read -p "按回车键返回菜单..." _
bash ../../wsl-ultimate-deploy.sh
