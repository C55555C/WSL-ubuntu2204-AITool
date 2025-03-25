#!/bin/bash
source ../common.sh
clear
info "配置 systemd 启动 tailscaled"
sudo systemctl enable --now tailscaled
ok "已设置开机自启"
read -p "按回车键返回菜单..." _
bash ../../wsl-ultimate-deploy.sh
