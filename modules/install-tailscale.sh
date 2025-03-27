#!/bin/bash
set -e

echo "🚀 安装 Tailscale (Docker 网络模式)"
read -p "确认要安装 Tailscale 并选择是否登陆吗？(y/n): " confirm
if [[ "$confirm" != "y" ]]; then
  echo "❎ 已取消安装"
  exit 0
fi

read -p "🆔 为此 Tailscale 实例命名容器（默认：tailscale）： " container_name
TS_CONTAINER_NAME=${container_name:-tailscale}

read -p "🔑 是否立即登陆 Tailscale？(y/n): " login_now
if [[ "$login_now" == "y" ]]; then
  read -p "🌐 输入 auth-key：" TS_AUTHKEY
  read -p "👤 设置机器名：" TS_HOSTNAME
else
  TS_AUTHKEY=""
  TS_HOSTNAME=""
fi

read -p "🔹 设置 SOCKS5 代理端口（默认 1077）：" input_port
TS_SOCKS_PORT=${input_port:-1077}

echo "📁 创建 tailscale 数据目录..."
mkdir -p ~/tailscale-docker/$TS_CONTAINER_NAME/data

if docker ps -a --format '{{.Names}}' | grep -qw "$TS_CONTAINER_NAME"; then
  echo "⚠️ 容器 [$TS_CONTAINER_NAME] 已存在，跳过创建"
else
  echo "🛠️ 启动 Tailscale 容器 [$TS_CONTAINER_NAME]..."
  docker run -d \
    --name "$TS_CONTAINER_NAME" \
    --restart unless-stopped \
    --network=host \
    --cap-add=NET_ADMIN \
    -v ~/tailscale-docker/$TS_CONTAINER_NAME/data:/var/lib/tailscale \
    tailscale/tailscale \
    tailscaled --tun=userspace-networking --socks5-server=localhost:$TS_SOCKS_PORT
  sleep 2
fi

if [[ -n "$TS_AUTHKEY" && -n "$TS_HOSTNAME" ]]; then
  echo "🔐 登陆 Tailscale 网络..."
  docker exec -it "$TS_CONTAINER_NAME" tailscale up --authkey="$TS_AUTHKEY" --hostname="$TS_HOSTNAME"
else
  echo "⚠️ 未执行 login，可后续手动登陆："
  echo "docker exec -it $TS_CONTAINER_NAME tailscale up --authkey=xxx --hostname=yourhost"
fi

echo ""
echo "🔹 当前 tailscale 状态："
docker exec -it "$TS_CONTAINER_NAME" tailscale status

echo ""
echo "🌐 SOCKS5 代理 (127.0.0.1:$TS_SOCKS_PORT) 已启动！"
echo "✅ 清楚测试: curl --socks5 localhost:$TS_SOCKS_PORT https://ifconfig.me"
read -p "按回车返回..."
