#!/bin/bash
set -e

echo "🌐 安装 Tailscale..."
curl -fsSL https://tailscale.com/install.sh | sh

echo "🔁 启用 systemd 支持（适用于 WSL）"
sudo mkdir -p /etc/systemd/system/tailscaled.service.d
echo -e "[Service]\nExecStartPost=/usr/sbin/tailscale up" | sudo tee /etc/systemd/system/tailscaled.service.d/override.conf > /dev/null

echo "🚀 启动 tailscaled 并启用开机自启"
sudo systemctl enable --now tailscaled

echo "📡 Tailscale IP:"
tailscale ip -4
