#!/bin/bash
set -e

echo "🐳 安装 Docker..."
curl -fsSL https://get.docker.com | sh

echo "🔧 将当前用户添加到 docker 组"
sudo usermod -aG docker $USER

echo "🔁 启用 Docker 开机启动"
sudo systemctl enable docker

echo "✅ Docker 安装完成，请重新打开终端使组权限生效"
