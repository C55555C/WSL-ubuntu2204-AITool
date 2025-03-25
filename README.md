# 🧠 WSL AI 部署工具（简体中文）

本工具为 Windows + WSL Ubuntu 用户设计的一站式 AI 服务部署终端，包括：
- Tailscale 网络穿透支持
- Ollama 本地大模型部署（支持 GPU）
- AnythingLLM 本地知识库助手（基于 Docker）
- Open WebUI 可视化前端（支持多模型适配）

## 📦 使用方式

```bash
cd wsl-ultimate-deploy
bash wsl-ultimate-deploy.sh
```

## 📚 模块说明
- Tailscale：安装、登录、systemd 启动、保活、状态检查
- Ollama：安装、拉模型、运行、状态、GPU 启动
- AnythingLLM：Docker 部署 + 启动
- Open WebUI：Docker 部署 + 启动

---
# 🧠 WSL AI Deployment Toolkit (English)

A modular AI deployment terminal script for WSL Ubuntu users on Windows. Supports:

- Tailscale for P2P and remote access
- Ollama for local LLMs with GPU support
- AnythingLLM for local knowledge base with Docker
- Open WebUI as a visual LLM frontend

## 📦 How to Use

```bash
cd wsl-ultimate-deploy
bash wsl-ultimate-deploy.sh
```

## 📚 Modules Overview
- Tailscale: install, login, keepalive, systemd, status
- Ollama: install, pull model, serve, GPU mode
- AnythingLLM: Docker install + run
- Open WebUI: Docker install + run
