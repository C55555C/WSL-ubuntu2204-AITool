#!/bin/bash
source ../common.sh
clear
info "Tailscale 安装模块"
echo "1. 官方安装"
echo "2. APT 安装（备用）"
echo "3. Docker 安装（低优先）"
echo "0. 返回主菜单"
read -p "请选择操作: " opt
case $opt in
  1) curl -fsSL https://tailscale.com/install.sh | sh ;;
  2) sudo apt update && sudo apt install -y tailscale ;;
  3) echo "Docker 模式暂不推荐，跳过" ;;
  0) bash ../../wsl-ultimate-deploy.sh ;;
  *) error "无效选项";;
esac
