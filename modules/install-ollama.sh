#!/bin/bash
set -e

echo "🦣 安装 Ollama (Native CLI)..."
read -p "确认要安装 Ollama 实体版？(y/n): " confirm
if [[ "$confirm" != "y" ]]; then
  echo "❎ 已取消安装"
  exit 0
fi

if command -v ollama >/dev/null 2>&1; then
  echo "✅ Ollama 已安装，跳过安装步骤"
else
  curl -fsSL https://ollama.com/install.sh | sh
fi

# Systemd auto start
echo "⚙️ 配置 systemd 自启服务..."
cat <<EOF | sudo tee /etc/systemd/system/ollama.service > /dev/null
[Unit]
Description=Ollama Service
After=network.target

[Service]
ExecStart=/usr/local/bin/ollama serve
Restart=always

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reexec
sudo systemctl enable ollama
sudo systemctl restart ollama

sleep 2
if curl -s http://localhost:11434 > /dev/null; then
  echo "✅ Ollama 服务已启动！"
else
  echo "⚠️ Ollama 服务启动失败"
fi

read -p "按回车返回..."
