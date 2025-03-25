#!/bin/bash
set -e

echo "🧠 安装 Ollama..."
curl -fsSL https://ollama.com/install.sh | sh

echo "🚀 启动 Ollama 后台服务"
ollama serve &

read -p "是否立即下载 llama3 模型？[Y/n]: " yn
if [[ "$yn" != "n" && "$yn" != "N" ]]; then
  ollama pull llama3
fi
