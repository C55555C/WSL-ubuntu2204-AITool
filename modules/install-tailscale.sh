#!/bin/bash
set -e

echo "🚀 安装 Tailscale..."
read -p "确认要安装 Tailscale 吗？(y/n): " confirm
if [[ "$confirm" != "y" ]]; then
  echo "❎ 已取消安装"
  exit 0
fi

curl -fsSL https://tailscale.com/install.sh | sh

echo "✅ Tailscale 安装完成！请执行:"
echo "sudo tailscale up"
echo "或者配合 auth-key 直接登陆："
echo "sudo tailscale up --auth-key=tskey-xxx"

read -p "按回车返回..."
