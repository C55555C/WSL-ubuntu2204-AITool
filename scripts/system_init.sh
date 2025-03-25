#!/bin/bash
set -e
read -p "请输入主机名（如 ubuntu-llm）: " HOSTNAME

echo "🔧 设置主机名为: $HOSTNAME"
sudo hostnamectl set-hostname "$HOSTNAME"

echo "🧩 修复 /etc/hosts 配置"
sudo sed -i "/127.0.1.1/d" /etc/hosts
echo "127.0.1.1 $HOSTNAME" | sudo tee -a /etc/hosts

echo "🗝️ 设置 root 密码"
sudo passwd

echo "📦 更新系统中..."
sudo apt update && sudo apt upgrade -y

echo "🧰 安装常用工具..."
sudo apt install -y curl wget git vim net-tools unzip htop lsb-release
