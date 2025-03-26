#!/bin/bash
set -e

echo "🐳 安装 Docker + NVIDIA 支持..."

# === 0. 系统判断 ===
. /etc/os-release
version="${ID}${VERSION_ID}"
echo "👥 当前系统版本: $version"

case "$version" in
  ubuntu18.04|ubuntu20.04|ubuntu22.04|ubuntu24.04)
    nvidia_base_version="ubuntu22.04"
    ;;
  *)
    echo "❌ 不支持的系统版本: $version"
    exit 1
    ;;
esac

# === 1. 基础依赖 ===
echo "📆 安装基础依赖..."
sudo apt update
sudo apt install -y \
  ca-certificates \
  curl \
  gnupg \
  lsb-release \
  software-properties-common

# === 2. Docker 安装 ===
echo "🔑 配置 Docker APT keyring..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "📅 添加 Docker 源..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "📆 安装 Docker 引擎..."
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# === 3. NVIDIA Container Toolkit ===
echo "🔑 添加 NVIDIA GPG key..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | \
  sudo gpg --dearmor -o /etc/apt/keyrings/nvidia.gpg

echo "📅 添加 NVIDIA 源 (${nvidia_base_version})..."
curl -s -L https://nvidia.github.io/libnvidia-container/stable/${nvidia_base_version}/libnvidia-container.list | \
  sed 's#deb https://#deb [signed-by=/etc/apt/keyrings/nvidia.gpg] https://#' | \
  sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

echo "📆 安装 NVIDIA Container Toolkit..."
sudo apt update
sudo apt install -y nvidia-container-toolkit

echo "⚙️ 配置 Docker 使用 NVIDIA 运行时..."
sudo nvidia-ctk runtime configure --runtime=docker

echo "🔁 重启 Docker 服务..."
sudo systemctl restart docker || true

echo "👤 将当前用户加入 docker 组..."
sudo usermod -aG docker $USER

echo "✅ 安装完成！请执行 'newgrp docker' 或重新登录终端以生效组权限。
