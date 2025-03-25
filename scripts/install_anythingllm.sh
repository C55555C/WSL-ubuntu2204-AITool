#!/bin/bash
set -e

echo "🧠 安装 AnythingLLM（Docker 模式）"
git clone https://github.com/Mintplex-Labs/anything-llm.git
cd anything-llm

echo "📦 安装依赖并启动"
cp .env.example .env
docker compose up -d
